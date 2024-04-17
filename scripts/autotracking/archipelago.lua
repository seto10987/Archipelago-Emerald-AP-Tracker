ScriptHost:LoadScript("scripts/autotracking/flag_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/setting_mapping.lua")

CUR_INDEX = -1
PLAYER_ID = -1
TEAM_NUMBER = 0

EVENT_ID = ""
KEY_ITEMS_ID = ""
LEGENDARY_ID = ""

function resetItems()
	for _, value in pairs(ITEM_MAPPING) do
		if value[1] then
			local object = Tracker:FindObjectForCode(value[1])
			if object then
				object.Active = false
			end
		end
	end
end

function resetLocations()
	for _, value in pairs(LOCATION_MAPPING) do
		if value[1] then
			local object = Tracker:FindObjectForCode(value[1])
			if object then
        if value[1]:sub(1,1) == "@" then
				  object.AvailableChestCount = object.ChestCount
        else
          object.Active = false
        end
			end
		end
	end
end

function onClear(slot_data)
	PLAYER_NUMBER = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
	CUR_INDEX = -1
	resetItems()
	resetLocations()
  if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
    dump_table(slot_data)
  end
	for key, value in pairs(slot_data) do
	  if key == "hm_requirements" then
      for hm, req in pairs(slot_data['hm_requirements']) do
        if hm == "HM02 Fly" then
          if type(req) ~= "table" then
            Tracker:FindObjectForCode("feather_badge_setting").CurrentStage = 1
          else
            Tracker:FindObjectForCode("feather_badge_setting").CurrentStage = 0
          end
        end
      end
	  elseif key == "remove_roadblocks" then
      for roadblock, code in pairs(ROADBLOCKS) do
        Tracker:FindObjectForCode(code).CurrentStage = tableContains(slot_data['remove_roadblocks'], roadblock) and 1 or 0
      end
	  elseif key == "allowed_legendary_hunt_encounters" then
      local allowed_legendaries = {}
      for _,legendary in pairs(slot_data['allowed_legendary_hunt_encounters']) do
        table.insert(allowed_legendaries, legendary)
      end
      LEGENDARIES_ALLOWED = allowed_legendaries
	  elseif SLOT_CODES[key] then
		  Tracker:FindObjectForCode(SLOT_CODES[key].code).CurrentStage = SLOT_CODES[key].mapping[value]
	  end
	end
	if PLAYER_NUMBER > -1 then
	  updateEvents(0)
	  updateLegendaries(0)
	  EVENT_ID = "pokemon_emerald_events_"..TEAM_NUMBER.."_"..PLAYER_NUMBER
	  KEY_ITEMS_ID = "pokemon_emerald_keys_"..TEAM_NUMBER.."_"..PLAYER_NUMBER
	  LEGENDARY_ID = "pokemon_emerald_legendaries_"..TEAM_NUMBER.."_"..PLAYER_NUMBER
	  Archipelago:SetNotify({EVENT_ID})
	  Archipelago:Get({EVENT_ID})
	  Archipelago:SetNotify({KEY_ITEMS_ID})
	  Archipelago:Get({KEY_ITEMS_ID})
	  Archipelago:SetNotify({LEGENDARY_ID})
	  Archipelago:Get({LEGENDARY_ID})
	end
end

function onItem(index, item_id, item_name, player_number)
	if index <= CUR_INDEX then
		return
	end
	CUR_INDEX = index;
	local value = ITEM_MAPPING[item_id]
	if not value then
		return
	end
  if not value[1] then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
      print(string.format("onItem: could not find code for id %s", item_id))
    end
    return
  end
	local object = Tracker:FindObjectForCode(value[1])
	if object then
		object.Active = true
  elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("onItem: could not find object for code %s", v[1]))
	end
end

function onLocation(location_id, location_name)
  local value = LOCATION_MAPPING[location_id]
  if not value then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
      print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    return
  end
  for _, code in pairs(value) do
    local object = Tracker:FindObjectForCode(code)
    if object then
      if code:sub(1, 1) == "@" then
        object.AvailableChestCount = object.AvailableChestCount - 1
      else
        object.Active = true
      end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", code))
    end
  end
end

function onNotify(key, value, old_value)
	if value ~= old_value then
		if key == EVENT_ID then
		  updateEvents(value)
		elseif key == KEY_ITEMS_ID then
		  updateKeyItems(value)
		elseif key == LEGENDARY_ID then
		  updateLegendaries(value)
		end
	end
end

function onNotifyLaunch(key, value)
	if key == EVENT_ID then
		updateEvents(value)
	elseif key == KEY_ITEMS_ID then
		updateKeyItems(value)
	elseif key == LEGENDARY_ID then
		updateLegendaries(value)
	end
end

function updateEvents(value)
  if value ~= nil then
    for _, event in pairs(EVENT_FLAG_MAPPING) do
      for _, code in pairs(event.codes) do
        if code.setting == nil or has(code.setting) then
          if code.code == "harbor_mail" then
            Tracker:FindObjectForCode(code.code).Active = Tracker:FindObjectForCode(code.code).Active or value & event.bitmask ~= 0
          else
            Tracker:FindObjectForCode(code.code).Active = value & event.bitmask ~= 0
          end
        end
      end
    end
  end
end

function updateKeyItems(value)
  if value ~= nil then
    for _, key_item in pairs(KEY_ITEM_FLAG_MAPPING) do
      if has(key_item.setting) then
        for _, code in pairs(key_item.codes) do
          Tracker:FindObjectForCode(code).Active = value & key_item.bitmask ~= 0
        end
      end
    end
  end
end

function updateLegendaries(value)
  if value ~= nil then
    local count = 0
    for _, legendary in pairs(LEGENDARY_FLAG_MAPPING) do
      if value & legendary.bitmask ~= 0 and tableContains(LEGENDARIES_ALLOWED, legendary.name) then
        count = count + 1
      end
      for _, location in pairs(legendary.locations) do
        local object = Tracker:FindObjectForCode(location)
        if object then
          if value & legendary.bitmask ~= 0 then
            object.AvailableChestCount = 0
          else
            object.AvailableChestCount = object.ChestCount
          end
        else
          print(string.format("Error in updateLegendaries: Could not find object for location %s", location))
        end
      end
    end
    Tracker:FindObjectForCode("legendary_hunt_count").CurrentStage = count
  end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
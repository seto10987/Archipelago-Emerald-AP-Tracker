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

OBTAINED_ITEMS = {}

-- For one reason or another, updating JsonItems is very slow. And it's single-threaded :P

JSONITEM_RESET = -1
JSONITEM_TEMP_STATES = {}
JSONITEM_TEMP_STATES_DEX = {}

JSONITEM_QUEUE = {}
JSONITEM_QUEUE_CURRENT_INDEX = 1
JSONITEM_DEX_QUEUE = {}
JSONITEM_DEX_QUEUE_CURRENT_INDEX = 1

FRAME_COUNT = 0

function onFrame(elapsed)
	FRAME_COUNT = (FRAME_COUNT + 1) % 256
	
	-- (onClear) Smarter reset and update of JsonItems
	if (FRAME_COUNT % 64) == 0 then
		if JSONITEM_RESET ~= -1 then
			JSONITEM_RESET = -1
			for code, value in pairs(JSONITEM_TEMP_STATES) do
				table.insert(JSONITEM_QUEUE, {code, value})
			end
			for code, value in pairs(JSONITEM_TEMP_STATES_DEX) do
				table.insert(JSONITEM_DEX_QUEUE, {code, value})
			end
		end
	end
	
	--[[
		Process the next thing in the JsonItem queue.
		Prioritize updating Key Items and Events over Dexsanity checks.
		Once every 8 frames seems to be enough breathing room.
	]]
	if (FRAME_COUNT % 8) == 0 then
		if JSONITEM_QUEUE[1] then
			Tracker.BulkUpdate = true
			local queue_entry = JSONITEM_QUEUE[JSONITEM_QUEUE_CURRENT_INDEX]
			if queue_entry then
				JSONITEM_QUEUE_CURRENT_INDEX = JSONITEM_QUEUE_CURRENT_INDEX + 1
				if queue_entry[1] and (queue_entry[2] ~= nil) then
					local obj = Tracker:FindObjectForCode(queue_entry[1])
					if obj then
						if obj.Active ~= queue_entry[2] then
							obj.Active = queue_entry[2]
						end
					elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
						print(string.format("JsonItem Queue: could not find object for code %s", code))
					end
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print("JsonItem Queue: data not formatted properly") -- code logic error
				end
			else -- end of the queue
				Tracker.BulkUpdate = false
				JSONITEM_QUEUE = {}
				JSONITEM_QUEUE_CURRENT_INDEX = 1
			end
		elseif JSONITEM_DEX_QUEUE[1] then
			local queue_entry = JSONITEM_DEX_QUEUE[JSONITEM_DEX_QUEUE_CURRENT_INDEX]
			if queue_entry then
				JSONITEM_DEX_QUEUE_CURRENT_INDEX = JSONITEM_DEX_QUEUE_CURRENT_INDEX + 1
				if queue_entry[1] and (queue_entry[2] ~= nil) then
					local obj = Tracker:FindObjectForCode(queue_entry[1])
					if obj then
						if obj.Active ~= queue_entry[2] then
							obj.Active = queue_entry[2]
						end
					elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
						print(string.format("JsonItem Queue: could not find object for code %s", code))
					end
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print("JsonItem Queue: data not formatted properly") -- code logic error
				end
			else -- end of the queue
				JSONITEM_DEX_QUEUE = {}
				JSONITEM_DEX_QUEUE_CURRENT_INDEX = 1
			end
		end
	end
end

function resetItems()
	JSONITEM_RESET = 1
	for _, value in pairs(ITEM_MAPPING) do
		if value[1] then
			JSONITEM_TEMP_STATES[value[1]] = false
		end
	end
end

function resetLocations()
  for _, value in pairs(LOCATION_MAPPING) do
    for _, code in pairs(value) do
      local object = Tracker:FindObjectForCode(code)
      if object then
        if code:sub(1,1) == "@" then
          object.AvailableChestCount = object.ChestCount
        else
          -- pokedex (386 JsonItems)
          JSONITEM_RESET = 1
          JSONITEM_TEMP_STATES_DEX[code] = false
        end
      end
    end
  end
end

function onClear(slot_data)
	PLAYER_NUMBER = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
	CUR_INDEX = -1
  OBTAINED_ITEMS = {}
	JSONITEM_RESET = 1
	FRAME_COUNT = 1
	JSONITEM_QUEUE = {}
	JSONITEM_DEX_QUEUE = {}
	JSONITEM_TEMP_STATES = {}
	JSONITEM_TEMP_STATES_DEX = {}
	resetItems()
	resetLocations()
  if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
    print(dump_table(slot_data))
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
      for legendary, code in pairs(LEGENDARY_HUNT) do
        Tracker:FindObjectForCode(code).Active = tableContains(slot_data['allowed_legendary_hunt_encounters'], legendary)
      end
	  elseif SLOT_CODES[key] then
		  Tracker:FindObjectForCode(SLOT_CODES[key].code).CurrentStage = SLOT_CODES[key].mapping[value]
	  end
	end
	if PLAYER_NUMBER > -1 then
	  updateEvents(0, true)
    updateKeyItems(0, true)
	  updateLegendaries(0, true)
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
		if JSONITEM_RESET ~= -1 then
			JSONITEM_TEMP_STATES[value[1]] = true
		else
			table.insert(JSONITEM_QUEUE, {value[1], true})
			table.insert(OBTAINED_ITEMS, value[1])
		end
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
        -- pokedex (386 JsonItems)
        if JSONITEM_RESET ~= -1 then
          JSONITEM_TEMP_STATES_DEX[code] = true
        else
          table.insert(JSONITEM_DEX_QUEUE, {code, true})
        end
      end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", code))
    end
  end
end

function onNotify(key, value, old_value)
	if value ~= old_value then
		if key == EVENT_ID then
		  updateEvents(value, false)
		elseif key == KEY_ITEMS_ID then
		  updateKeyItems(value, false)
		elseif key == LEGENDARY_ID then
		  updateLegendaries(value, false)
		end
	end
end

function onNotifyLaunch(key, value)
	if key == EVENT_ID then
		updateEvents(value, false)
	elseif key == KEY_ITEMS_ID then
		updateKeyItems(value, false)
	elseif key == LEGENDARY_ID then
		updateLegendaries(value, false)
	end
end

function updateEvents(value, reset)
  if value ~= nil then
    if reset then
      JSONITEM_RESET = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
      print(string.format("updateEvents: Value - %s", value))
    end
    for _, event in pairs(EVENT_FLAG_MAPPING) do
      local bitmask = 2 ^ event.bit
      event.status = value & bitmask
      for _, code in pairs(event.codes) do
        if code.setting == nil or has(code.setting) then
          if JSONITEM_RESET ~= -1 then
            JSONITEM_TEMP_STATES[code.code] = value & bitmask ~= 0
          else
            if code.code == "harbor_mail" then
              Tracker:FindObjectForCode(code.code).Active = Tracker:FindObjectForCode(code.code).Active or value & bitmask ~= 0
            else
              Tracker:FindObjectForCode(code.code).Active = value & bitmask ~= 0
            end
          end
        end
      end
    end
  end
end

function updateKeyItems(value, reset)
  if value ~= nil then
    if reset then
      JSONITEM_RESET = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
      print(string.format("updateKeyItems: Value - %s", value))
    end
    for _, key_item in pairs(KEY_ITEM_FLAG_MAPPING) do
      local bitmask = 2 ^ key_item.bit
      key_item.status = value & bitmask
      for _, code in pairs(key_item.codes) do
        if (code.setting == nil or has(code.setting)) and not tableContains(OBTAINED_ITEMS, code.code) then
          if JSONITEM_RESET ~= -1 then
            JSONITEM_TEMP_STATES[code.code] = value & bitmask ~= 0
          else
            Tracker:FindObjectForCode(code.code).Active = value & bitmask ~= 0
          end
        end
      end
    end
  end
end

function updateLegendaries(value, reset)
  if value ~= nil then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
      print(string.format("updateLegendaries: Value - %s", value))
    end
    local count = 0
    for _, legendary in pairs(LEGENDARY_FLAG_MAPPING) do
      local bitmask = 2 ^ legendary.bit
      if value & bitmask ~= 0 and has(LEGENDARY_HUNT[legendary.name]) then
        count = count + 1
      end
      if reset or (value & bitmask ~= legendary.status) then
        legendary.status = value & bitmask
        for _, location in pairs(legendary.locations) do
          local object = Tracker:FindObjectForCode(location)
          if object then
            if value & bitmask ~= 0 then
              object.AvailableChestCount = 0
            else
              object.AvailableChestCount = object.ChestCount
            end
          else
            print(string.format("Error in updateLegendaries: Could not find object for location %s", location))
          end
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
ScriptHost:AddOnFrameHandler("frame handler", onFrame)
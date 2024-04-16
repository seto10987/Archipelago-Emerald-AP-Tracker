--Items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/events.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/pokemon.json")
-- Logic
ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")
ScriptHost:LoadScript("scripts/locations.lua")

-- Maps
Tracker:AddMaps("maps/maps.json")
if PopVersion and PopVersion >= "0.23.0" then
	Tracker:AddLocations("locations/dungeons.json")
end

-- Layout
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/pokedex.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
	ScriptHost:LoadScript("scripts/autotracking.lua")
end

ScriptHost:LoadScript("scripts/autotracking/flag_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/setting_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/autotracking.lua")

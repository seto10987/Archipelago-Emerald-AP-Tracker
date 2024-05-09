BADGES = {"stone_badge","knuckle_badge","dynamo_badge","heat_badge","balance_badge","feather_badge","mind_badge","rain_badge"}

GYMS = {"defeat_roxanne","defeat_brawly","defeat_wattson","defeat_flannery","defeat_norman","defeat_winona","defeat_tate_and_liza","defeat_juan"}

-- Access Functions
function free_fly(location)
  return has("free_fly_"..location) and fly()
end

function cut()
  return has("hm01_cut") and has("stone_badge")
end

function fly()
  return has("hm02_fly") and (has("feather_badge_on") or has("feather_badge"))
end

function surf()
  return has("hm03_surf") and has("balance_badge")
end

function strength()
  return has("hm04_strength") and has("heat_badge")
end

function flash(dungeon)
  if has("flash_both") or has("flash_"..dungeon) or dungeon == "tomb" then
    return has("hm05_flash") and has("knuckle_badge")
  end
  return true
end

function rock_smash()
  return has("hm06_rock_smash") and has("dynamo_badge")
end

function waterfall()
  return has("hm07_waterfall") and has("rain_badge")
end

function dive()
  return has("hm08_dive") and has("mind_badge")
end

function bike()
  return has("acro_bike") or has("mach_bike")
end

function hidden()
  return has("itemfinder") or has("itemfinder_off")
end

function has_norman_req()
  local count = 0
  local req = Tracker:FindObjectForCode("norman_req_count").CurrentStage
  local req_item = {}
  if has("norman_req_badges") then
    req_item = BADGES
  elseif has("norman_req_gyms") then
    req_item = GYMS
  end
  for _, item in pairs(req_item) do
    if has(item) then
      count = count + 1
    end
  end
  return count >= req
end

function has_e4_req()
  local count = 0
  local req = Tracker:FindObjectForCode("e4_req_count").CurrentStage
  local req_item = {}
  if has("e4_req_badges") then
    req_item = BADGES
  elseif has("e4_req_gyms") then
    req_item = GYMS
  end
  for _, item in pairs(req_item) do
    if has(item) then
      count = count + 1
    end
  end
  return count >= req
end

function pass_route_110()
  return has("rt_110_grunts_on") or has("rescue_stern") or bike()
end

function pass_cable_car()
  return has("rt_112_grunts_on") or has("magma_steals_meteorite")
end

function route_115_boulders()
  return has("route_115_boulders_off") or strength()
end

function pass_route_115()
  return (surf() and route_115_boulders()) or (has("route_115_bumpy_slope_on") and has("acro_bike"))
end

function pass_route_118()
  if has("route_118_rails_on") then
    return has("acro_bike")
  end
  return surf()
end

function pass_route_119()
  return has("rt_119_grunts_on") or has("defeat_shelly")
end

function pass_route_124(direction)
  if direction == "left" then
    return surf() and (has("wailmer_on") or has("defeat_matt"))
  end
  return surf()
end

function dewford_access()
  return has("talk_mr_stone") or surf()
end

function slateport_access()
  return free_fly("slateport")
  or surf()
  or (dewford_access() and has("deliver_letter"))
  or (free_fly("mauville") and pass_route_110())
  or (free_fly("verdanturf") and pass_route_110())
  or (rock_smash() and pass_route_110())
  or (free_fly("fortree") and (has("ss_ticket") or (pass_route_119() and pass_route_118() and pass_route_110())))
  or (free_fly("lilycove") and (has("ss_ticket") or (cut() and pass_route_119() and pass_route_118() and pass_route_110())))
end

function mauville_access()
  return free_fly("mauville")
  or free_fly("verdanturf")
  or rock_smash()
  or surf()
  or (slateport_access() and pass_route_110())
  or (free_fly("fortree") and pass_route_119() and pass_route_118())
  or (free_fly("lilycove") and cut() and pass_route_119() and pass_route_118())
end

function fallarbor_access()
  return free_fly("fallarbor")
  or free_fly("lavaridge")
  or pass_route_115()
  or rock_smash()
end

function mt_chimney_access()
  return (fallarbor_access() and pass_cable_car())
  or (free_fly("lavaridge") and has("acro_bike"))
end

function lavaridge_access()
  return free_fly("lavaridge")
  or (fallarbor_access() and pass_cable_car() and has("defeat_maxie_mt_chimney"))
end

function route_119_access()
  return (mauville_access() and pass_route_118())
  or (free_fly("fortree") and (pass_route_119() or surf()))
  or (free_fly("lilycove") and (surf() or (cut() and pass_route_119())))
  or (slateport_access() and has("ss_ticket") and (surf() or (cut() and pass_route_119())))
  or (free_fly("mossdeep") and pass_route_124())
  or (free_fly("sootopolis") and dive() and pass_route_124())
  or (free_fly("ever_grande") and pass_route_124())
end

function fortree_access()
  return free_fly("fortree")
  or (route_119_access() and pass_route_119())
  or (free_fly("lilycove") and cut())
  or (slateport_access() and has("ss_ticket") and cut())
  or (free_fly("mossdeep") and pass_route_124() and cut())
  or (free_fly("sootopolis") and dive() and pass_route_124() and cut())
  or (free_fly("ever_grande") and pass_route_124() and cut())
end

function lilycove_access()
  return free_fly("lilycove")
  or fortree_access()
  or (slateport_access() and has("ss_ticket"))
  or (free_fly("mossdeep") and pass_route_124())
  or (free_fly("sootopolis") and dive() and pass_route_124())
  or (free_fly("ever_grande") and pass_route_124())
end

function aqua_hideout_access()
  return lilycove_access() and surf() and (has("hideout_grunts_on") or has("aqua_steals_submarine"))
end

function route_124_access()
  return (lilycove_access() and pass_route_124("left"))
  or (free_fly("mossdeep") and surf())
  or (free_fly("sootopolis") and dive() and surf())
  or (free_fly("ever_grande") and surf())
end

function mossdeep_access()
  return free_fly("mossdeep") or route_124_access()
end

function sootopolis_access()
  return (free_fly("sootopolis") or route_124_access()) and dive()
end

function seafloor_cavern_access()
  return route_124_access() and dive() and (has("sea_floor_grunts_on") or has("steven_gives_dive")) and rock_smash() and strength()
end

function sealed_chamber_access()
  return route_124_access() and dive()
end

function desert_ruins_access()
  return fallarbor_access() and has("go_goggles")
end

function island_cave_access()
  return surf()
end

function ancient_tomb_access()
  return fortree_access()
end

function victory_road_access()
  return free_fly("ever_grande") or (route_124_access() and waterfall())
end

function e4_access()
  return victory_road_access() and rock_smash() and strength() and surf() and has_e4_req()
end

function battle_frontier_access()
  return (slateport_access() or lilycove_access()) and has("ss_ticket")
end

function terra_cave_access()
  return has("defeat_champion") and has("defeat_shelly")
end

function marine_cave_access()
  return dive() and has("defeat_champion") and has("defeat_shelly")
end

-- Visibility Functions
function goal_not(goal)
  return not has("goal_"..goal)
end

function safari_visibility()
  return has("safari_on") or goal_not("champion")
end

function legendary_hunt_defeat()
  return has("goal_legendary_hunt") and has("legendary_hunt_req_defeat")
end

function legendary_hunt_catch()
  return has("goal_legendary_hunt") and has("legendary_hunt_req_catch")
end
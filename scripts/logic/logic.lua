BADGES = {"stone_badge","knuckle_badge","dynamo_badge","heat_badge","balance_badge","feather_badge","mind_badge","rain_badge"}

LEGENDARIES_ALLOWED = {"Groudon","Kyogre","Rayquaza","Latias","Latios","Regirock","Regice","Registeel","Mew","Deoxys","Ho-oh","Lugia"}

-- Access Functions
function free_fly(location)
  if has("free_fly_"..location) then
    return fly()
  end
  return AccessibilityLevel.None
end

function cut()
  if has("hm01_cut") and has("stone_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function fly()
  if has("hm02_fly") and (has("feather_badge_on") or has("feather_badge")) then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function surf()
  if has("hm03_surf") and has("balance_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function strength()
  if has("hm04_strength") and has("heat_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function flash(dungeon)
  if has("flash_both") or has("flash_"..dungeon) then
    if has("hm05_flash") and has("knuckle_badge") then
      return AccessibilityLevel.Normal
    else
      return AccessibilityLevel.SequenceBreak
    end
  end
  return AccessibilityLevel.Normal
end

function flash_mandatory()
  if has("hm05_flash") and has("knuckle_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function rock_smash()
  if has("hm06_rock_smash") and has("dynamo_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function waterfall()
  if has("hm07_waterfall") and has("rain_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function dive()
  if has("hm08_dive") and has("mind_badge") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function bike()
  if has("acro_bike") or has("mach_bike") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.None
end

function hidden()
  if has("itemfinder") or has("itemfinder_off") then
    return AccessibilityLevel.Normal
  end
  return AccessibilityLevel.SequenceBreak
end

function defeat_roxanne()
  if has("defeat_roxanne") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Rustboro Gym/Defeat Roxanne")
  end
  return AccessibilityLevel.None
end

function talk_mr_stone()
  if has("talk_mr_stone") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Rustboro City/Talk to Mr. Stone")
  end
  return AccessibilityLevel.None
end

function defeat_brawly()
  if has("defeat_brawly") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Dewford Gym/Defeat Brawly")
  end
  return AccessibilityLevel.None
end

function deliver_letter()
  if has("deliver_letter") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Dungeons/Granite Cave/1F - Deliver Letter")
  end
  return AccessibilityLevel.None
end

function rescue_stern()
  if has("rescue_stern") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Slateport City/Rescue Captain Stern")
  end
  return AccessibilityLevel.None
end

function defeat_wattson()
  if has("defeat_wattson") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Mauville Gym/Defeat Wattson")
  end
  return AccessibilityLevel.None
end

function magma_steals_meteorite()
  if has("magma_steals_meteorite") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Dungeons/Meteor Falls/1F - Team Magma Steals Meteorite")
  end
  return AccessibilityLevel.None
end

function defeat_flannery()
  if has("defeat_flannery") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Lavaridge Gym/Defeat Flannery")
  end
  return AccessibilityLevel.None
end

function defeat_norman()
  if has("defeat_norman") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Petalburg Gym/Defeat Norman")
  end
  return AccessibilityLevel.None
end

function defeat_shelly()
  if has("defeat_shelly") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Routes/Weather Institute/2F - Defeat Shelly")
  end
  return AccessibilityLevel.None
end

function defeat_winona()
  if has("defeat_winona") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Fortree Gym/Defeat Winona")
  end
  return AccessibilityLevel.None
end

function release_groudon()
  if has("release_groudon") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Dungeons/Team Magma Hideout/Release Groudon")
  end
  return AccessibilityLevel.None
end

function aqua_steals_submarine()
  if has("aqua_steals_submarine") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Slateport City/Team Aqua Steals Submarine")
  end
  return AccessibilityLevel.None
end

function defeat_matt()
  if has("defeat_matt") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Dungeons/Team Aqua Hideout/B2F - Defeat Matt")
  end
  return AccessibilityLevel.None
end

function defeat_tate_and_liza()
  if has("defeat_tate_and_liza") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Mossdeep Gym/Defeat Tate & Liza")
  end
  return AccessibilityLevel.None
end

function defeat_maxie()
  if has("defeat_maxie") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Space Center/Defeat Maxie")
  end
  return AccessibilityLevel.None
end

function steven_gives_dive()
  if has("steven_gives_dive") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Mossdeep City/Steven Gives Dive")
  end
  return AccessibilityLevel.None
end

function release_kyogre()
  if has("release_kyogre") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Dungeons/Seafloor Cavern/Room 9 - Release Kyogre")
  end
  return AccessibilityLevel.None
end

function defeat_juan()
  if has("defeat_juan") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Sootopolis Gym/Defeat Juan")
  end
  return AccessibilityLevel.None
end

function defeat_champion()
  if has("defeat_champion") then
    return AccessibilityLevel.Normal
  elseif has("events_completed_on") then
    return get_access_level("@Cities/Ever Grande City/Defeat Champion")
  end
  return AccessibilityLevel.None
end

function has_norman_req()
  local req = Tracker:FindObjectForCode("norman_req_count").CurrentStage
  local access = AccessibilityLevel.None
  if has("norman_req_badges") then
    local count = 0
    for _,badge in pairs(BADGES) do
      if has(badge) then
        count = count + 1
      end
    end
    if count >= req then
      access = AccessibilityLevel.Normal
    end
  elseif has("norman_req_gyms") then
    local normal_access_count = 0
    local seq_break_access_count = 0
    local gyms_access = {}
    gyms_access[0] = defeat_roxanne()
    gyms_access[1] = defeat_brawly()
    gyms_access[2] = defeat_wattson()
    gyms_access[3] = defeat_flannery()
    gyms_access[4] = defeat_winona()
    gyms_access[5] = defeat_tate_and_liza()
    gyms_access[6] = defeat_juan()
    for _,gym_access in pairs(gyms_access) do
      if gym_access == AccessibilityLevel.Normal then
        normal_access_count = normal_access_count + 1
      elseif gym_access == AccessibilityLevel.SequenceBreak then
        seq_break_access_count = seq_break_access_count + 1
      end
    end
    if normal_access_count >= req then
      access = AccessibilityLevel.Normal
    elseif normal_access_count + seq_break_access_count >= req then
      access = AccessibilityLevel.SequenceBreak
    end
  end
  return access
end

function has_e4_req()
  local req = Tracker:FindObjectForCode("e4_req_count").CurrentStage
  local access = AccessibilityLevel.None
  if has("e4_req_badges") then
    local count = 0
    for _,badge in pairs(BADGES) do
      if has(badge) then
        count = count + 1
      end
    end
    if count >= req then
      access = AccessibilityLevel.Normal
    end
  elseif has("e4_req_gyms") then
    local normal_access_count = 0
    local seq_break_access_count = 0
    local gyms_access = {}
    gyms_access[0] = defeat_roxanne()
    gyms_access[1] = defeat_brawly()
    gyms_access[2] = defeat_wattson()
    gyms_access[3] = defeat_flannery()
    gyms_access[4] = defeat_norman()
    gyms_access[5] = defeat_winona()
    gyms_access[6] = defeat_tate_and_liza()
    gyms_access[7] = defeat_juan()
    for _,gym_access in pairs(gyms_access) do
      if gym_access == AccessibilityLevel.Normal then
        normal_access_count = normal_access_count + 1
      elseif gym_access == AccessibilityLevel.SequenceBreak then
        seq_break_access_count = seq_break_access_count + 1
      end
    end
    if normal_access_count >= req then
      access = AccessibilityLevel.Normal
    elseif normal_access_count + seq_break_access_count >= req then
      access = AccessibilityLevel.SequenceBreak
    end
  end
  return access
end

function pass_route_110(start_location)
  if has("rt_110_grunts_on") then
    return AccessibilityLevel.Normal
  end
  if start_location == "slateport" then
    return or_access(rescue_stern(), bike())
  elseif start_location == "mauville" then
    return bike()
  end
  return AccessibilityLevel.None
end

function route_115_boulders()
  if has("route_115_boulders_on") then
    return strength()
  end
  return AccessibilityLevel.Normal
end

function pass_route_115()
  if has("route_115_bumpy_slope_on") and has("acro_bike") then
    return AccessibilityLevel.Normal
  end
  return and_access(surf(), route_115_boulders())
end

function pass_route_118()
  if has("route_118_rails_on") then
    if has("acro_bike") then
      return AccessibilityLevel.Normal
    end
  else
    return surf()
  end
  return AccessibilityLevel.None
end

function pass_route_119(start_location)
  if has("rt_119_grunts_on") then
    return AccessibilityLevel.Normal
  end
  if start_location == "route 119" then
    return defeat_shelly()
  end
  return AccessibilityLevel.None
end

function pass_route_124(start_location)
  if has("wailmer_on") then
    return AccessibilityLevel.Normal
  end
  if start_location == "lilycove" then
    return defeat_matt()
  end
  return AccessibilityLevel.None
end

function dewford_access()
  return or_access(talk_mr_stone(), surf())
end

function slateport_access()
  -- Path from Dewford
  local dewford_to_slateport = and_access(dewford_access(), deliver_letter())
  -- Path from Mauville
  local free_fly_mauville = or_access(free_fly("mauville"), free_fly("verdanturf"))
  local lilycove_to_fortree = and_access(free_fly("lilycove"), cut())
  local fortree_access = or_access(free_fly("fortree"), lilycove_to_fortree)
  local fortree_to_mauville = and_access(fortree_access, pass_route_119("fortree"), pass_route_118())
  local mauville_access = or_access(free_fly_mauville, rock_smash(), fortree_to_mauville)
  local mauville_to_slateport = and_access(mauville_access, pass_route_110("mauville"))
  -- Path from Ferry
  local ss_ticket = has("ss_ticket") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local free_fly_fortree_or_lilycove = or_access(free_fly("fortree"), free_fly("lilycove"))
  local ferry_to_slateport = and_access(free_fly_fortree_or_lilycove, ss_ticket)
  -- Path to Slateport
  return or_access(free_fly("slateport"), surf(), dewford_to_slateport, mauville_to_slateport, ferry_to_slateport)
end

function mauville_access()
  -- Path from Slateport
  local slateport_to_mauville = and_access(slateport_access(), pass_route_110("slateport"))
  -- Path from Fortree
  local lilycove_to_fortree = and_access(free_fly("lilycove"), cut())
  local fortree_access = or_access(free_fly("fortree"), lilycove_to_fortree)
  local fortree_to_mauville = and_access(fortree_access, pass_route_119("fortree"), pass_route_118())
  -- Path to Mauville
  return or_access(free_fly("mauville"), free_fly("verdanturf"), rock_smash(), surf(), slateport_to_mauville, fortree_to_mauville)
end

function fallarbor_access()
  return or_access(free_fly("fallarbor"), free_fly("lavaridge"), pass_route_115(), rock_smash())
end

function mt_chimney_access()
  -- Path from Fallarbor
  local fallarbor_to_mt_chimney = and_access(fallarbor_access(), magma_steals_meteorite())
  -- Path from Lavaridge
  local acro_bike = has("acro_bike") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local lavaridge_to_mt_chimney = and_access(free_fly("lavaridge"), acro_bike)
  -- Path to Mt. Chimney
  return or_access(fallarbor_to_mt_chimney, lavaridge_to_mt_chimney)
end

function lavaridge_access()
  -- Path from Fallarbor
  local fallarbor_to_lavaridge = and_access(fallarbor_access(), magma_steals_meteorite())
  -- Path to Lavaridge
  return or_access(free_fly("lavaridge"), fallarbor_to_lavaridge)
end

function route_119_access()
  -- Path from Mauville
  local mauville_to_route_119 = and_access(mauville_access(), pass_route_118())
  -- Path from Fortree/Lilycove
  local ss_ticket = has("ss_ticket") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local ferry_to_lilycove = and_access(slateport_access(), ss_ticket)
  local free_fly_to_mossdeep_or_evergrande = or_access(free_fly("mossdeep"), free_fly("ever_grande"))
  local mossdeep_to_lilycove = and_access(free_fly_to_mossdeep_or_evergrande, surf(), pass_route_124("mossdeep"))
  local sootopolis_to_lilycove = and_access(free_fly("sootopolis"), surf(), dive(), pass_route_124("mossdeep"))
  local lilycove_access = or_access(free_fly("lilycove"), free_fly("fortree"), ferry_to_lilycove, mossdeep_to_lilycove, sootopolis_to_lilycove)
  local lilycove_to_fortree = and_access(free_fly("lilycove"), cut())
  local fortree_access = or_access(free_fly("fortree"), lilycove_to_fortree)
  local fortree_to_route_119 = and_access(fortree_access, pass_route_119("fortree"))
  local lilycove_to_route_119 = and_access(lilycove_access, surf())
  -- Path to Route 119
  return or_access(mauville_to_route_119, fortree_to_route_119, lilycove_to_route_119)
end

function fortree_access()
  -- Path from Route 119
  local route_119_to_fortree = and_access(route_119_access(), pass_route_119("route 119"))
  --Path from Lilycove
  local ss_ticket = has("ss_ticket") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local ferry_to_lilycove = and_access(slateport_access(), ss_ticket)
  local free_fly_to_mossdeep_or_evergrande = or_access(free_fly("mossdeep"), free_fly("ever_grande"))
  local mossdeep_to_lilycove = and_access(free_fly_mossdeep, surf(), pass_route_124("mossdeep"))
  local sootopolis_to_lilycove = and_access(free_fly("sootopolis"), surf(), dive(), pass_route_124("mossdeep"))
  local lilycove_access = or_access(free_fly("lilycove"), ferry_to_lilycove, mossdeep_to_lilycove, sootopolis_to_lilycove)
  local lilycove_to_fortree = and_access(lilycove_access, cut())
  -- Path to Fortree
  return or_access(free_fly("fortree"), route_119_to_fortree, lilycove_to_fortree)
end

function lilycove_access()
  -- Path from Ferry
  local ss_ticket = has("ss_ticket") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local ferry_to_lilycove = and_access(slateport_access(), ss_ticket)
  -- Path from Mossdeep/Ever Grande
  local free_fly_to_mossdeep_or_evergrande = or_access(free_fly("mossdeep"), free_fly("ever_grande"))
  local mossdeep_to_lilycove = and_access(free_fly_to_mossdeep_or_evergrande, surf(), pass_route_124("mossdeep"))
  -- Path from Sootopolis
  local sootopolis_to_lilycove = and_access(free_fly("sootopolis"), surf(), dive(), pass_route_124("mossdeep"))
  -- Path to Lilycove
  return or_access(free_fly("lilycove"), fortree_access(), ferry_to_lilycove, mossdeep_to_lilycove, sootopolis_to_lilycove)
end

function aqua_hideout_access()
  local hideout_grunts_on = has("hideout_grunts_on") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local pass_grunts = or_access(aqua_steals_submarine(), hideout_grunts_on)
  return and_access(lilycove_access(), surf(), pass_grunts)
end

function route_124_access()
  -- Path from Lilycove
  local lilycove_to_route_124 = and_access(lilycove_access(), surf(), pass_route_124("lilycove"))
  -- Path from Mossdeep
  local free_fly_mossdeep = or_access(free_fly("mossdeep"), free_fly("ever_grande"))
  local mossdeep_to_route_124 = and_access(free_fly_mossdeep, surf())
  -- Path from Sootopolis
  local sootopolis_to_route_124 = and_access(free_fly("sootopolis"), surf(), dive())
  -- Path to Route 124
  return or_access(lilycove_to_route_124, mossdeep_to_route_124, sootopolis_to_route_124)
end

function mossdeep_access()
  return or_access(free_fly("mossdeep"), route_124_access())
end

function sootopolis_access()
  -- Path from Route 124
  local route_124_to_sootopolis = and_access(route_124_access(), dive())
  -- Path to Sootopolis
  return or_access(free_fly("sootopolis"), route_124_to_sootopolis)
end

function seafloor_cavern_access()
  local sea_floor_grunts_on = has("sea_floor_grunts_on") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local pass_grunts = or_access(steven_gives_dive(), sea_floor_grunts_on)
  return and_access(route_124_access(), dive(), pass_grunts, rock_smash(), strength())
end

function sealed_chamber_access()
  return and_access(route_124_access(), dive(), get_access_level("@Cities/Fortree City/Dig Move Tutor"))
end

function desert_ruins_access()
  local go_goggles = has("go_goggles") and AccessibilityLevel.Normal or AccessibilityLevel.None
  return and_access(fallarbor_access(), go_goggles, get_access_level("@Dungeons/Sealed Chamber/Undo Regi Seal"))
end

function island_cave_access()
  return and_access(surf(), get_access_level("@Dungeons/Sealed Chamber/Undo Regi Seal"))
end

function ancient_tomb_access()
  return and_access(fortree_access(), get_access_level("@Dungeons/Sealed Chamber/Undo Regi Seal"))
end

function victory_road_access()
  -- Path from Route 124
  local route_124_to_victory_road = and_access(route_124_access(), waterfall())
  -- Path to Victory Road
  return or_access(free_fly("ever_grande"), route_124_to_victory_road)
end

function e4_access()
  return and_access(victory_road_access(), flash("road"), rock_smash(), strength(), surf(), has_e4_req())
end

function battle_frontier_access()
  local ss_ticket = has("ss_ticket") and AccessibilityLevel.Normal or AccessibilityLevel.None
  local ferry_access = or_access(slateport_access(), lilycove_access())
  return and_access(ferry_access, ss_ticket)
end

function terra_cave_access()
  return and_access(defeat_champion(), defeat_shelly())
end

function marine_cave_access()
  return and_access(dive(), defeat_champion(), defeat_shelly())
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

function legendary_hunt(legendary)
  return tableContains(LEGENDARIES_ALLOWED, legendary)
end
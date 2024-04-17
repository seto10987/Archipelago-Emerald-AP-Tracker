ACCESS_LEVEL =
{
  [0] = AccessibilityLevel.None,
  [1] = AccessibilityLevel.Partial,
  [3] = AccessibilityLevel.Inspect,
  [5] = AccessibilityLevel.SequenceBreak,
  [6] = AccessibilityLevel.Normal,
  [7] = AccessibilityLevel.Cleared,
  [AccessibilityLevel.None] = 0,
  [AccessibilityLevel.Partial] = 1,
  [AccessibilityLevel.Inspect] = 3,
  [AccessibilityLevel.SequenceBreak] = 5,
  [AccessibilityLevel.Normal] = 6,
  [AccessibilityLevel.Cleared] = 7
}

function has(item, amount)
	local count = Tracker:ProviderCountForCode(item)
	amount = tonumber(amount)
	if not amount then
		return count > 0
	else
		return count >= amount
	end
end

function get_access_level(name)
  local location = Tracker:FindObjectForCode(name)
  print(location)
  local access = AccessibilityLevel.None
  if location then
    access = location.AccessibilityLevel
    if access == AccessibilityLevel.Cleared then
      access = AccessibilityLevel.Normal
    elseif access == AccessibilityLevel.Inspect then
      access = AccessibilityLevel.None
    end
  else
    print(string.format("Error in get_access_level: Couldn't find location %s", name))
  end
  return access
end

function or_access(...)
  local max_level = 0
  for _, level in pairs({...}) do
    if level == AccessibilityLevel.Normal then
      return AccessibilityLevel.Normal
    end
    if ACCESS_LEVEL[level] > max_level then
      max_level = ACCESS_LEVEL[level]
    end
  end
  return ACCESS_LEVEL[max_level]
end

function and_access(...)
  local min_level = 6
  for _, level in pairs({...}) do
    if level == AccessibilityLevel.None then
      return AccessibilityLevel.None
    end
    if ACCESS_LEVEL[level] < min_level then
      min_level = ACCESS_LEVEL[level]
    end
  end
  return ACCESS_LEVEL[min_level]
end

function resetItems()
  for _, value in pairs(ITEM_MAPPING) do
    local object = Tracker:FindObjectForCode(value)
    if object then
      object.Active = false
    end
  end
end

function resetLocations()
  for _, value in pairs(LOCATION_MAPPING) do
    local object = Tracker:FindObjectForCode(value)
    if value then
              object.AvailableChestCount = object.ChestCount
            else
              object.Active = false
            end
        end
    end
end
end

function tableContains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

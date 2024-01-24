local windowId = {}
for index, value in ipairs(windowTable) do
	if not table.contains(windowId, value.openWindow) then
		table.insert(windowId, value.openWindow)
	end
	
	if not table.contains(windowId, value.closedWindow) then
		table.insert(windowId, value.closedWindow)
	end
end

local windows = Action()

function windows.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = item:getPosition():getTile()
	local house = tile:getHouse()
	if house and player:getPosition():getTile():getHouse() ~= house then
		return false
	end
	
	for index, value in ipairs(windowTable) do -- opening windows
		if item.itemid == value.closedWindow then
			item:transform(value.openWindow)
			if house then
				player:addAchievementProgress("Let the Sunshine In", 100)
			end
			return true
		end
	end
	
	for index, value in ipairs(windowTable) do -- closing windows
		if item.itemid == value.openWindow then
			item:transform(value.closedWindow)
			if house then
				player:addAchievementProgress("Do Not Disturb", 100)
			end
			return true
		end
	end
	
	return false
end

for index, value in ipairs(windowId) do
	windows:id(value)
end

windows:register()

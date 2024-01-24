local config = {
	{weight = 1618, name = "Crystal Backpack"},
	{weight = 1519, name = "Violet Crystal Shard", count = 5},
	{weight = 1512, name = "Blue Crystal Splinter", count = 10},
	{weight = 1505, name = "Glowing Mushroom"},
	{weight = 1491, name = "Blue Gem"},
	{weight = 1385, name = "Blue Crystal Shard", count = 10},
	{weight = 537, name = "Crystal Mace"},
	{weight = 304, name = "Crystalline Armor"},
	{weight = 127, name = "Crystalline Sword"}
}

local muckRemover = Action()

function muckRemover.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 18396 then
		return false
	end

	local reward = weightedRandomSelect(config)
	local itemid,count = reward.itemid, reward.count
	createItem(target, itemid,count,true, CONST_ME_GREEN_RINGS)
	item:remove(1)
	player:addAchievementProgress("Goo Goo Dancer", 100)
	return true
end

muckRemover:id(18395)
muckRemover:register()

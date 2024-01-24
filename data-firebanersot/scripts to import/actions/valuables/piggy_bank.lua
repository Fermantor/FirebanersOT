local config = {
	{weight = 2000, name = "gold coin", param = {effect = CONST_ME_BLOCKHIT}},
	{weight = 8000, name = "platinum coin", param = {effect = CONST_ME_SOUND_YELLOW}}
}

local piggyBank = Action()

function piggyBank.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local reward = weightedRandomSelect(config)
	createItem(item, reward.itemid, 1, false, reward.param.effect)
	if reward.itemid == 2148 then
		item:transform(2115)
		player:addAchievementProgress('Allowance Collector', 50)
	end
	return true
end

piggyBank:id(2114)
piggyBank:register()

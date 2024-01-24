local partyCake = Action()

function partyCake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	createItem(item, 6279, 1, true, CONST_ME_POFF)
	player:say(player:getName().." blew out the candle.")
	player:addAchievementProgress("Make a Wish", 5)
	return true
end

partyCake:id(6280)
partyCake:register()

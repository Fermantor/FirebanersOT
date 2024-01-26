local config = {
	{weight = 9000},
	{weight = 1000, name = "golden fir cone"}
}

local cupOfMoltenGold = Action()

function cupOfMoltenGold.onUse(player, item, fromPosition, target, toPosition)

	if table.contains({2700,21428},target.itemid) then
		local reward = weightedRandomSelect(config).itemid
		if reward ~= 0 then
			createItem(item, reward)
		else
			item:remove(1)
			if target.itemid == 2700 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Drizzling all over a fir cone you picked from the tree, the molten gold only covers about half of it - not enough.")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Drizzling all over the fir cone, the molten gold only covers about half of it - not enough.")
			end
		end
	end
	return true
end

cupOfMoltenGold:id(13941)
cupOfMoltenGold:register()

local roastedMeat = Action()

function roastedMeat.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 1423 then -- campfire
		createItem(item, 24843)
		toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
	end
	return true
end

roastedMeat:id(24842)
roastedMeat:register()
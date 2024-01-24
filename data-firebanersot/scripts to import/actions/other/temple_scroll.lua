local templeScroll = Action()

function templeScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPzLocked() and not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		if player:getPosition():getTile():hasFlag(TILESTATE_NOLOGOUT) then
			player:sendCancelMessage("You can't teleport here.")
		else
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:teleportTo(getTownTemplePosition(player:getTown():getId()))
			item:remove()
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		Position(fromPosition):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

templeScroll:id(29019)
templeScroll:register()

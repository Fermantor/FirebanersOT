local spiderWebs = {7538,7539}

local fireBug = Action()
function fireBug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local random = math.random(100)
	
	if target.itemid == 5466 then
		toPosition:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		target:transform(5465)
		target:decay()
	elseif table.contains(spiderWebs, target.itemid) then
		toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
		target:transform(target.itemid+6)
		target:decay()
	else
		return false
	end
	
	if random <= 5 then --explode 5% chance
		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say('It seems the fire bug blew up.', TALKTYPE_MONSTER_SAY)
		item:remove(1)
	end
	return true
end

fireBug:id(5468)
fireBug:register()
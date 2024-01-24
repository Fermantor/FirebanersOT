local effects = {CONST_ME_FIREWORK_YELLOW,CONST_ME_FIREWORK_BLUE,CONST_ME_FIREWORK_RED}

local fireworksRocket = Action()

function fireworksRocket.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local effect,position = effects[math.random(#effects)], item:getPosition()
	if fromPosition.x ~= CONTAINER_POSITION then
		player:addAchievementProgress('Fireworks in the Sky', 250)
	else
		player:addAchievementProgress('Rocket in Pocket', 3)
		effect = CONST_ME_EXPLOSIONAREA
		player:say("Ouch! Rather place it on the ground next time.", TALKTYPE_MONSTER_SAY)
	end
	position:sendMagicEffect(effect)
	item:remove()
	return true
end

fireworksRocket:id(6576)
fireworksRocket:register()

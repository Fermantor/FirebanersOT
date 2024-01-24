local toolGear = Action()

function toolGear.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local jammed = math.random(100)
	if jammed == 1 then
		item:transform(item.itemid+1)
		player:say("Oh no! Your tool is jammed and can't be used for a minute.", TALKTYPE_MONSTER_SAY)
		item:decay()
		player:addAchievementProgress("Bad Timing", 10)
		return true
	end
	return onUseRope(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseShovel(player, item, fromPosition, target, toPosition, isHotkey)
		or onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseMachete(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseCrowbar(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseSpoon(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseScythe(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseKitchenKnife(player, item, fromPosition, target, toPosition, isHotkey)
end

toolGear:id(10511, 10513, 10515)
toolGear:register()

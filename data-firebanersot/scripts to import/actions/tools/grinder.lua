local grinder = Action()

function grinder.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if(target.itemid == 23942)then
		return onGrindItem(player, item, fromPosition, target, toPosition, isHotkey)
	end
end

grinder:id(7759,18416)
grinder:register()

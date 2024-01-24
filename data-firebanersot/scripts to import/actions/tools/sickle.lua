local sickle = Action()

function sickle.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseSickle(player, item, fromPosition, target, toPosition, isHotkey)
end

sickle:id(2405,2418)
sickle:register()

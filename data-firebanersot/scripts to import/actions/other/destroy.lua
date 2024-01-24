local destroy = Action()

function destroy.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onDestroyItem(player, item, fromPosition, target, toPosition, isHotkey)
end

for i = 1, #weaponsTable do
	destroy:id(weaponsTable[i])
end

destroy:register()

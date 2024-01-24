local hammer = Action()

function hammer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end
	return true
end

hammer:id(2557)
hammer:register()

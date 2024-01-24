local distillingMachines = {5469,5470}

local sugarCane = Action()

function sugarCane.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 2694 then
		createItem(target, 13939)
		item:remove(1)
	elseif table.contains(distillingMachines, target.itemid) then
		player:addAchievementProgress("Homebrewed",50)
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
		target:transform(target.itemid+44)
		target:decay()
		item:remove(1)
	else
		return false
	end
	return true
end

sugarCane:id(5467)
sugarCane:register()

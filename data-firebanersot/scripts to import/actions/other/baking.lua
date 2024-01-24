local liquidContainers = {1775, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015, 2023, 2031, 2032, 2033}
local millstones = {1381, 1382, 1383, 1384}
local doughs = {2693, 6277, 8846, 8848}
local oven = {1786, 1788, 1790, 1792}
local cooked = {
	[2693] = 2689,
	[6277] = 6278,
	[8846] = 8847
}

local baking = Action()

function baking.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetType = ItemType(target.itemid)
	if item.itemid == 2694 then -- wheat
		if table.contains(millstones, target.itemid) then -- target is millstone
			createItem(item, 2692)
		elseif target.itemid == 5467 then -- bunch of sugar cane
			createItem(target, 13939)
			item:remove(1)
		else
			return false
		end
	elseif item.itemid == 2692 and targetType:isFluidContainer() then -- flour & fluid container
		if target.type == 1 then -- contains water
			createItem(item, 2693)
			target:transform(target.itemid,0)
		elseif target.type == 6 then -- contains milk
			createItem(item, 6277)
			target:transform(target.itemid,0)
		else
			return false
		end
	elseif item.itemid == 6277 then -- lump of cake dough
		if target.itemid == 6574 then -- bar of chocolate
			createItem(item, 8846)
			target:remove(1)
		elseif target.itemid == 2561 then -- baking tray
			target:transform(8848)
			item:remove(1)
		end
	end
	if table.contains(oven, target.itemid) and table.contains(doughs, item.itemid) then -- ovens
		if item.itemid == 8848 then -- cookie tray
			createItem(item, 2687,12,false)
			item:transform(2561)
			player:addAchievementProgress("Cookie Monster", 20)
		else
			if item.itemid == 6277 then
				player:addAchievementProgress("The Cake's the Truth", 30)
			elseif item.itemid == 8846 then
				player:addAchievementProgress("Sweet Tooth", 10)
				if player:getStorageValue(Storage.chocolateCakeBaked) ~= 1 then
					player:addAchievementProgress("Piece of Cake", 2)
					player:setStorageValue(Storage.chocolateCakeBaked,1)
				end
			end
			createItem(item, cooked[item.itemid])
		end
	end
	return true
end

baking:id(2692, 2693, 2694, 6277, 8846, 8848)
baking:register()

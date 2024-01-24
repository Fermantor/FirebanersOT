local config = {
	[9808] = { -- heavily rusted armor (common)
		{weight = 3031, name = "chain armor"},
		{weight = 3007},
		{weight = 2478, name = "scale armor"},
		{weight = 1288, name = "brass armor"},
		{weight = 195, name = "plate armor"}
	},
	[9809] = { -- rusted armor (semi-rare)
		{weight = 3596},
		{weight = 1916, name = "scale armor"},
		{weight = 1549, name = "chain armor"},
		{weight = 1435, name = "brass armor"},
		{weight = 927, name = "plate armor"},
		{weight = 297, name = "knight armor"},
		{weight = 236, name = "paladin armor"},
		{weight = 44, name = "crown armor"}
	},
	[9810] = { -- slightly rusted armor (rare)
		{weight = 3119},
		{weight = 3071, name = "brass armor"},
		{weight = 1852, name = "plate armor"},
		{weight = 1763, name = "knight armor"},
		{weight = 183, name = "crown armor"},
		{weight = 12, name = "golden armor"}
	},
	[9820] = { -- heavily rusted helmet
		{weight = 100}
	},
	[9821] = { -- rusted helmet
		{weight = 3230},
		{weight = 2200, name = "brass helmet"},
		{weight = 1870, name = "studded helmet"},
		{weight = 1490, name = "iron helmet"},
		{weight = 1010, name = "steel helmet"},
		{weight = 190, name = "crown helmet"},
		{weight = 10, name = "crusader helmet"}
	},
	[9822] = { -- slightly rusted helmet
		{weight = 3143, name = "iron helmet"},
		{weight = 2973, name = "steel helmet"},
		{weight = 2695},
		{weight = 972, name = "crown helmet"},
		{weight = 210, name = "crusader helmet"},
		{weight = 7, name = "royal helmet"}
	},
	[9811] = { -- heavily rusted legs
		{weight = 3257, name = "chain legs"},
		{weight = 3051},
		{weight = 2385, name = "studded legs"},
		{weight = 1174, name = "brass legs"},
		{weight = 133, name = "plate legs"}
	},
	[9812] = { -- rusted legs
		{weight = 4037},
		{weight = 1925, name = "studded legs"},
		{weight = 1863, name = "chain legs"},
		{weight = 1056, name = "plate legs"},
		{weight = 932, name = "brass legs"},
		{weight = 186, name = "knight legs"}
	},
	[9813] = { -- slightly rusted legs
		{weight = 3097},
		{weight = 2940, name = "brass legs"},
		{weight = 2825, name = "plate legs"},
		{weight = 950, name = "knight legs"},
		{weight = 181, name = "crown legs"},
		{weight = 6, name = "golden legs"}
	},
	[9814] = { -- heavily rusted shield
		{weight = 100}
	},
	[9815] = { -- rusted shield
		{weight = 100}
	},
	[9816] = { -- slightly rusted shield
		{weight = 3137, name = "plate shield"},
		{weight = 2887, name = "ancient shield"},
		{weight = 2807},
		{weight = 929, name = "norse shield"},
		{weight = 230, name = "crown shield"},
		{weight = 10, name = "vampire shield"}
	},
	[9817] = { -- heavily rusted boots
		{weight = 100}
	},
	[9818] = { -- rusted boots
		{weight = 100}
	},
	[9819] = { -- slightly rusted boots
		{weight = 100}
	}
}

local rustRemover = Action()

function rustRemover.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetItem = config[target.itemid]
	if not targetItem then
		return true
	end

	local unrusted = weightedRandomSelect(targetItem)
	local itemid = unrusted.itemid
	local effect = CONST_ME_MAGIC_GREEN
	local position = target:getPosition()
	if itemid == 0 then
		player:say("The item was already damaged so badly that it broke when you tried to clean it.")
		effect = CONST_ME_BLOCKHIT
		target:remove(1)
	else
		if itemid == 2466 and player:getStorageValue(Storage.GoldenArmorUnrusted) ~= 1 then
			player:setStorageValue(Storage.GoldenArmorUnrusted,1)
			player:addAchievementProgress("Lucky Devil",2)
		end
		target:transform(itemid)
		player:addAchievementProgress("Polisher",1000)
	end
	position:sendMagicEffect(effect)
	item:remove(1)
end

rustRemover:id(9930)
rustRemover:register()

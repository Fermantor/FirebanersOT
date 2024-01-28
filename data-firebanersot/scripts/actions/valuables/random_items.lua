local config = {
	[13670] = { -- belonging of a deceased
		chances = {
			{weight = 2, name = "flask of warrior's sweat"},
			{weight = 2, name = "broken amulet"},
			{weight = 2, name = "nose ring"},
			{weight = 2, name = "boots of haste"},
			{weight = 31, name = "slug drug"},
			{weight = 39, name = "fish fin"},
			{weight = 44, name = "doll"},
			{weight = 44, name = "iron ore"},
			{weight = 50, name = "book of prayers"},
			{weight = 66, name = "spider silk"},
			{weight = 66, name = "piggy bank"},
			{weight = 68, name = "plague mask"},
			{weight = 74, name = "white pearl"},
			{weight = 85, name = "plague bell"},
			{weight = 92, name = "garlic necklace"},
			{weight = 131, name = "scarf"},
			{weight = 208}, -- nothing
			{weight = 302, name = "honeycomb"},
			{weight = 361, name = "spider fangs"},
			{weight = 365, name = "bunch of troll hair"},
			{weight = 394, name = "knife"},
			{weight = 407, name = "turtle shell"},
			{weight = 415, name = "bat wing"},
			{weight = 468, name = "chicken feather"},
			{weight = 483, name = "egg"},
			{weight = 503, name = "worm", count = 4},
			{weight = 518, name = "white mushroom"},
			{weight = 579, name = "gold coin", count = 6},
			{weight = 1388, name = "dirty cape"},
			{weight = 1393, name = "broken piggy bank"},
			{weight = 1430, name = "worn leather boots"}
		},
		effect = CONST_ME_POFF
	},
	[15572] = { -- gooey mass
		chances = {
			{weight = 2094, name = "platinum coin", count = 2},
			{weight = 2055, name = "larvae", count = 10},
			{weight = 1911, name = "great health potion", count = 2},
			{weight = 1892, name = "great mana potion", count = 2},
			{weight = 1853, name = "black pearl", count = 2},
			{weight = 98, name = "gold ingot"},
			{weight = 46, name = "four-leaf clover"},
			{weight = 13, name = "hive scythe"}
		},
		effect = CONST_ME_HITBYPOISON
	},
	[15698] = { -- gnomish supply package
		chances = {
			{weight = 1438, name = "white mushroom", count = 20},
			{weight = 1016, name = "muchroom pie"},
			{weight = 805, name = "envenomed arrow", count = 15},
			{weight = 798, name = "crystalline arrow", count = 15},
			{weight = 779, name = "teleport crystal"},
			{weight = 607, name = "strong health potion", count = 2},
			{weight = 581, name = "strong mana potion", count = 2},
			{weight = 544, name = "health potion", count = 4},
			{weight = 501, name = "mana potion", count = 4},
			{weight = 449, name = "great mana potion"},
			{weight = 412, name = "great health potion"},
			{weight = 340, name = "bullseye potion"},
			{weight = 317, name = "berserk potion"},
			{weight = 313, name = "red piece of cloth"},
			{weight = 304, name = "platinum coin", count = 5},
			{weight = 300, name = "mastermind potion"},
			{weight = 125, name = "pet pig"},
			{weight = 112, name = "gnomish voucher type ca2"},
			{weight = 96, name = "gnomish voucher type ma2"},
			{weight = 53, name = "crystal coin"},
			{weight = 33, name = "red gem"},
			{weight = 33, name = "yellow gem"},
			{weight = 30, name = "red teleport crystal"},
			{weight = 7, name = "blue gem"},
			{weight = 7, name = "green gem"}
		},
		effect = CONST_ME_CRAPS
	},
	[25419] = { -- shaggy ogre bag
		chances = {
			{weight = 2865, name = "roasted meat", count = 5},
			{weight = 1310, name = "ogre nose ring"},
			{weight = 1022, name = "ogre ear stud"},
			{weight = 948, name = "shamanic talisman"},
			{weight = 639, name = "opal", count = 2},
			{weight = 575, name = "tribal mask"},
			{weight = 543, name = "skull fetish"},
			{weight = 437, name = "onyx chip", count = 3},
			{weight = 319, name = "tusk shield"},
			{weight = 309, name = "bast skirt"},
			{weight = 277, name = "furry club"},
			{weight = 256, name = "feather headdress"},
			{weight = 138, name = "shamanic mask"},
			{weight = 128, name = "ogre choppa"},
			{weight = 85, name = "titan axe"},
			{weight = 64, name = "ogre klubba"},
			{weight = 43, name = "spiked squelcher"},
			{weight = 32, name = "mysterious voodoo skull"},
			{weight = 11, name = "ogre scepta"},
		},
		effect = CONST_ME_CRAPS
	},
	[26165] = { -- mysterious remains
		chances = {
			{weight = 971, name = "gnomish supply package"},
			{weight = 900, name = "war horn"},
			{weight = 800, name = "yellow gem"},
			{weight = 657, name = "iron ore"},
			{weight = 557, name = "piggy bank"},
			{weight = 557, name = "garlic necklace"},
			{weight = 543, name = "red dragon scale"},
			{weight = 471, name = "stealth ring"},
			{weight = 471, name = "bag of apple slices"},
			{weight = 443, name = "folded void carpet"},
			{weight = 414, name = "blue surprise bag"},
			{weight = 400, name = "tusk"},
			{weight = 386, name = "magic light wand"},
			{weight = 371, name = "violet gem"},
			{weight = 371, name = "rift tapestry"},
			{weight = 343, name = "gold ingot"},
			{weight = 343, name = "folded rift carpet"},
			{weight = 343, name = "scarf"},
			{weight = 286, name = "shaggy ogre bag"},
			{weight = 286, name = "spider silk"},
			{weight = 71, name = "slightly rusted legs"},
			{weight = 14, name = "huge chunk of crude iron"}
		},
		effect = CONST_ME_CRAPS
	},
	[32014] = { -- surprise jar
		chances = {
			{weight = 4272, name = "blue gem"}, -- blue gem 42.72%
			{weight = 2559, name = "silver token"}, -- silver token 25.59%
			{weight = 1370, name = "violet gem"}, -- violet gem 13.70%
			{weight = 923, name = "gold token"}, -- gold token 9.23%
			{weight = 875, name = "suspicious device"} -- suspicious device 8.75%
		},
		effect = CONST_ME_ENERGYAREA
	},
	[23574] = { -- glooth bag
		chances = {
			{weight = 1875, name = "glooth spear", count = 2},
			{weight = 1543, name = "glooth amulet"},
			{weight = 1515, name = "glooth club"},
			{weight = 1464, name = "glooth axe"},
			{weight = 1432, name = "glooth blade"},
			{weight = 633, name = "glooth backpack"},
			{weight = 513, name = "glooth sandwich", count = 10},
			{weight = 494, name = "bowl of glooth soup", count = 10},
			{weight = 453, name = "glooth steak", count = 10},
			{weight = 55, name = "control unit"},  
		},
		effect = CONST_ME_HITBYPOISON
	},
	[5957] = { -- lottery ticket
		chances = {
			{weight = 99, param = {text = "Sorry, but you drew a blank.", achievProgress = "Jinx", progress = 500}},
			{weight = 1, name = "winning lottery ticket", param = {text = "Congratulations! You won a prize!", effect = CONST_ME_SOUND_YELLOW}}
		},
		effect = CONST_ME_POFF
	},
	[11339] = { -- Clay Lump
		chances = {
			{weight = 6400, param = {text = "Aw man. That did not work out too well."}},
			{weight = 2500, name = "rough clay statue", param = {desc = "It was made by |PLAYERNAME|, whose potter skills could use some serious improvement."}},
			{weight = 1000, name = "clay statue", param = {desc = "It was made by |PLAYERNAME| and is clearly a little figurine of.. hm, one does not recognise that yet."}},
			{weight = 100, name = "pretty clay statue", param = {desc = "This little figurine of Brog, the raging Titan, was skillfully made by |PLAYERNAME|.", achiev = "Clay Fighter", achievProgress = "Clay to Fame", progress = 3}}
		},
		effect = CONST_ME_POFF
	},
	[6570] = { -- surprise bag (blue)
		chances = {
			{weight = 1090, name = "party trumpet"},
			{weight = 1030, name = "red balloons"},
			{weight = 1010, name = "candy", count = 3},
			{weight = 990, name = "party cake"},
			{weight = 990, name = "fireworks rocket"},
			{weight = 910, name = "cream cake"},
			{weight = 860, name = "piggy bank"},
			{weight = 820, name = "party hat"},
			{weight = 820, name = "green balloons"},
			{weight = 790, name = "bar of chocolate"},
			{weight = 690, name = "cookie", count = 10}
		},
		effect = CONST_ME_GIFT_WRAPS
	},
	[6571] = { -- surprise bag (red)
		chances = {
			{weight = 4760, name = "fireworks rocket"},
			{weight = 2081, name = "cream cake"},
			{weight = 1134, name = "bar of chocolate"},
			{weight = 1032, name = "party hat"},
			{weight = 512, name = "piggy bank"},
			{weight = 173, name = "violet gem"},
			{weight = 158, name = "soul orb"},
			{weight = 35, name = "red gem"},
			{weight = 22, name = "teddy bear"},
			{weight = 19, name = "panda teddy"},
			{weight = 18, name = "demon shield"},
			{weight = 15, name = "boots of haste"},
			{weight = 15, name = "dragon scale mail"},
			{weight = 12, name = "royal helmet"},
			{weight = 9, name = "amulet of loss"},
			{weight = 6, name = "stuffed dragon"}
		},
		effect = CONST_ME_GIFT_WRAPS
	},
	
}

local randomItems = Action()

function randomItems.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useId = config[item.itemid]
	if not useId then
		return false
	end
	-- for i = 1,101 do
	local reward = weightedRandomSelect(useId.chances)
	local itemid,count = reward.itemid, reward.count
	local position = item:getPosition()
	if item.itemid == 13670 then
		local itemType = ItemType(itemid)
		player:say('You found ' .. (count > 1 and count or (itemType:getArticle() ~= '' and itemType:getArticle() or '')) .. ' ' .. (count > 1 and itemType:getPluralName() or itemid == 0 and 'nothing useful' or itemType:getName()) .. ' in the bag.', TALKTYPE_MONSTER_SAY)
	end
	local effect = useId.effect
	local params = reward.param
	if itemid ~= 0 then
		if params and params.desc then
			item:transform(reward.itemid)
			item:setDescription(reward.param.desc:gsub('|PLAYERNAME|', player:getName()))
		else
			createItem(item, itemid,count,false)
			--item:remove(1)
		end
	else
		item:remove(1)
	end
	if params then
		if params.effect then
			effect = params.effect
		end
		if params.achiev then
			player:addAchievement(params.achiev)
		end
		if params.achievProgress then
			player:addAchievementProgress(params.achievProgress, params.progress)
		end
		if params.text then
			player:say(params.text, TALKTYPE_MONSTER_SAY)
		end
	end
	position:sendMagicEffect(effect)
	player:say("You have found " .. ItemType(itemid):getName())
	return true
	-- end
end

for itemid, var in pairs(config) do
	randomItems:id(itemid)
end
randomItems:register()

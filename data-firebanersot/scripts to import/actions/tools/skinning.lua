---- if you want protected corpses (10 second protection after monster being killed) to be skinned/dusted, delete '--#' in the appropriate lines; be careful, it may cause abuses ----
local config = {
	[5908] = {
		-- corpses
		-- Minotaurs
		[3090] = {value = 500, newItem = 5878, after = 2831}, -- minotaur
		[5969] = {value = 500, newItem = 5878, after = 2831, freshKilled = true},	-- minotaur, after being killed
		[2871] = {value = 500, newItem = 5878, after = 2872}, -- minotaur archer
		[5982] = {value = 500, newItem = 5878, after = 2872, freshKilled = true}, -- minotaur archer, after being killed
		[2866] = {value = 500, newItem = 5878, after = 2867}, -- minotaur mage
		[5981] = {value = 500, newItem = 5878, after = 2867, freshKilled = true}, -- minotaur mage, after being killed
		[2876] = {value = 500, newItem = 5878, after = 2877}, -- minotaur guard/invader
		[5983] = {value = 500, newItem = 5878, after = 2877, freshKilled = true}, -- minotaur guard/invader, after being killed
		[23463] = {value = 1000, newItem = 5878, after = 23464}, -- mooh'tah warrior
		[23462] = {value = 1000, newItem = 5878, after = 23464, freshKilled = true}, -- mooh'tah warrior, after being killed
		[23467] = {value = 1000, newItem = 5878, after = 23468}, -- minotaur hunter
		[23466] = {value = 1000, newItem = 5878, after = 23468, freshKilled = true}, -- minotaur hunter, after being killed
		[23471] = {value = 1000, newItem = 5878, after = 23472}, -- worm priestess
		[23470] = {value = 1000, newItem = 5878, after = 23472, freshKilled = true}, -- worm priestess, after being killed
		[23371] = {value = 1000, newItem = 5878, after = 23373}, -- minotaur amazon
		[23372] = {value = 1000, newItem = 5878, after = 23373, freshKilled = true}, -- minotaur amazon, after being killed
		[23375] = {value = 1000, newItem = 5878, after = 23377}, -- execowtioner
		[23376] = {value = 1000, newItem = 5878, after = 23377, freshKilled = true}, -- execowtioner, after being killed
		[23367] = {value = 1000, newItem = 5878, after = 23369}, -- moohtant
		[23368] = {value = 1000, newItem = 5878, after = 23369, freshKilled = true}, -- moohtant, after being killed

		-- Low Class Lizards
		[4259] = {value = 500, newItem = 5876, after = 4260}, -- lizard sentinel
		[6040] = {value = 500, newItem = 5876, after = 4260, freshKilled = true}, -- lizard sentinel, after being killed
		[4262] = {value = 500, newItem = 5876, after = 4263}, -- lizard snakecharmer
		[6041] = {value = 500, newItem = 5876, after = 4263, freshKilled = true}, -- lizard snakecharmer, after being killed
		[4256] = {value = 500, newItem = 5876, after = 4257}, -- lizard templar
		[4251] = {value = 500, newItem = 5876, after = 4257, freshKilled = true}, -- lizard templar, after being killed

		-- High Class Lizards
		[11285] = {value = 1000, newItem = 5876, after = 11286}, -- lizard chosen,
		[11288] = {value = 1000, newItem = 5876, after = 11286, freshKilled = true}, -- lizard chosen, after being killed
		[11277] = {value = 1000, newItem = 5876, after = 11278}, -- lizard dragon priest
		[11280] = {value = 1000, newItem = 5876, after = 11278, freshKilled = true}, -- lizard dragon priest, after being killed
		[11269] = {value = 1000, newItem = 5876, after = 11270}, -- lizard high guard
		[11272] = {value = 1000, newItem = 5876, after = 11270, freshKilled = true}, -- lizard high guard, after being killed
		[11281] = {value = 1000, newItem = 5876, after = 11282}, -- lizard zaogun
		[11284] = {value = 1000, newItem = 5876, after = 11282, freshKilled = true}, -- lizard zaogun, after being killed

		-- Dragons
		[2844] = {value = 500, newItem = 5877, after = 2845},
		[5973] = {value = 500, newItem = 5877, after = 2845, freshKilled = true}, -- after being killed

		-- Dragon Lords
		[2881] = {value = 1000, newItem = 5948, after = 2882},
		[5984] = {value = 1000, newItem = 5948, after = 2882, freshKilled = true}, -- after being killed

		-- Behemoths
		[2931] = {value = 1000, newItem = 5893, after = 2932},
		[5999] = {value = 1000, newItem = 5893, after = 2932, freshKilled = true}, -- after being killed

		-- Bone Beasts
		[3031] = {value = 500, newItem = 5925, after = 3032},
		[6030] = {value = 500, newItem = 5925, after = 3032, freshKilled = true}, -- after being killed

		-- Clomp - raw meat
		[25399] = {value = 5000, newItem = 24842, after = 25400},
		[25398] = {value = 5000, newItem = 24842, after = 25400, freshKilled = true}, -- after being killed

		-- The Mutated Pumpkin
		-- [8961] = {
			-- {value = 5000, newItem = 7487 },
			-- {value = 10000, newItem = 7737 },
			-- {value = 20000, 6492 },
			-- {value = 30000, newItem = 8860 },
			-- {value = 45000, newItem = 2683 },
			-- {value = 60000, newItem = 2096 },
			-- {value = 90000, newItem = 9005, amount = 50 }
		-- },

		-- Marble
		[11343] = { 
			{weight = 6500, param = {text = "Your attempt at shaping that marble rock failed misserably."}},
			{weight = 2400, name = "rough marble statue", param = {desc = "This shoddy work was made by |PLAYERNAME|."}},
			{weight = 1000, name = "marble statue", param = {desc = "This little figurine made by |PLAYERNAME| has some room for improvement."}},
			{weight = 100, name = "beautiful marble statue", param = {desc = "This little figurine of Tibiasula was masterfully sculpted by |PLAYERNAME|.", achiev = "Marblelous", achievProgress = "Marble Madness", progress = 5}}
		},

		-- Ice Cube
		[7441] = {	-- first cut
			{weight = 7000, param = {text = "The attempt of sculpting failed miserably."}},
			{weight = 3000, id = 7442}
			},
		[7442] = {	-- second cut
			{weight = 8000, param = {text = "The attempt of sculpting failed miserably."}},
			{weight = 2000, id = 7444}
			},
		[7444] = {	-- third cut
			{weight = 9000, param = {text = "The attempt of sculpting failed miserably."}},
			{weight = 1000, id = 7445}
			},
		[7445] = {	-- fourth cut
			{weight = 9300, params = {text = "The attempt of sculpting failed miserably."}},
			{weight = 700, id = 7446, param = {achiev = "Ice Sculptor", achievProgress = "Cold as Ice", progress = 3}}
		},
		
		-- Watermelon Tourmaline
		[38613] = {
			{weight = 9400, id = 38614},
			{weight = 600, id = 38615, param = {effect = CONST_ME_PINK_FIREWORKS}}
		},
		achievement = "Skin-Deep"
	},
	[5942] = {
		-- Demon
		[2916] = {value = 1000, newItem = 5906, after = 2917},
		[5995] = {value = 1000, newItem = 5906, after = 2917, freshKilled = true}, -- after being killed

		-- Vampires
		[2956] = {value = 500, newItem = 5905, after = 2957}, -- vampire
		[6006] = {value = 500, newItem = 5905, after = 2957, freshKilled = true}, -- vampire, after being killed
		[9654] = {value = 500, newItem = 5905, after = 9658}, -- vampire bride
		[9660] = {value = 500, newItem = 5905, after = 9658, freshKilled = true}, -- vampire bride, after being killed
		[8937] = {value = 7000, newItem = 5905, after = 8939, freshKilled = true},	 -- vampire lord, after being killed (the count, diblis, etc)
		[8938] = {value = 7000, newItem = 5905, after = 8939}, -- vampire lord (the count, diblis, etc)
		[21275] = {value = 500, newItem= 5905, after = 21276}, -- vampire viscount
		[21278] = {value = 500, newItem= 5905, after = 21276, freshKilled = true}, -- vampire viscount, after being killed
		achievement = "Ashes to Dust"
	}
}

local skinning = Action()

function skinning.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local skin = config[item.itemid][target.itemid]

	if not skin then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local effect = CONST_ME_HITAREA
	-- non corpses (carving)
	if type(skin[1]) == 'table' then
		-- if target.itemid == 11343 then
		local reward = weightedRandomSelect(skin)
		local params = reward.param
		target:getPosition():sendMagicEffect(params and params.effect or effect)
		if reward.itemid ~= 0 then
			if ItemType(target:getId()):isStackable() then
				createItem(target, reward.itemid)
			else
				target:transform(reward.itemid)
			end
		else
			target:remove(1)
		end
		if params then
			if params.desc then
				target:setDescription(reward.param.desc:gsub('|PLAYERNAME|', player:getName()))
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
		return true
	end

	-- corpses
	if skin.freshKilled then
		player:say("You have to wait a bit, before you can skin this creature.", TALKTYPE_MONSTER_SAY)
	else
		local charmMType = player:getCharmMonsterType(CHARM_SCAVENGE)
		local chanceRange = 10000
		local scavenge = 0
		if charmMType then
			local charmCorpse = charmMType:getCorpseId()
			if table.contains({charmCorpse, ItemType(charmCorpse):getDecayId()}, target.itemid) then
				scavenge = GLOBAL_CHARM_SCAVENGE * 100
			end
		end

		local random = math.random(1, chanceRange)
		effect = CONST_ME_BLOCKHIT
		if random <= skin.value + scavenge then
			if item.itemid == 5942 then
				effect = CONST_ME_MAGIC_BLUE
			else
				effect = CONST_ME_MAGIC_GREEN
			end
			createItem(item, skin.newItem, 1, false)
			player:addAchievementProgress(config[item.itemid].achievement,500)
		end
		target:getPosition():sendMagicEffect(effect)
		target:transform(skin.after)
		return true
	end
end

skinning:id(5908, 5942)
skinning:register()

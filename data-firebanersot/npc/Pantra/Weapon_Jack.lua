local npcName = "Jack"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 114,
	lookBody = 88,
	lookLegs = 84,
	lookFeet = 115,
	lookAddons = 1,
}

npcConfig.sounds = {
	ticks = 5000,
	chance = 25,
	ids = {
		SOUND_EFFECT_TYPE_ACTION_HITING_FORGE,
		SOUND_EFFECT_TYPE_ACTION_WOOD_HIT,
		SOUND_EFFECT_TYPE_ACTION_CRATE_BREAK_MAGIC_DUST,
		SOUND_EFFECT_TYPE_ACTION_SWORD_DRAWN,
	},
}

npcConfig.voices = {
	interval = 10000,
	chance = 20,
	{ text = "Die besten Rüstungen auf ganz Pantra!" },
	{ text = "Hat jemand mein Doublet gesehen?" },
}

npcConfig.flags = {
	floorchange = false,
}

-- Npc shop
npcConfig.shop = {
	-- shields
	{ itemName = "wooden shield", clientId = 3412, buy = 13, sell = 5},
	{ itemName = "studded shield", clientId = 3426, buy = 50, sell = 16},
	{ itemName = "brass shield", clientId = 3411, buy = 65, sell = 25},
	{ itemName = "plate shield", clientId = 3410, sell = 45},
	{ itemName = "copper shield", clientId = 3430, sell = 50},
	{ itemName = "battle shield", clientId = 3413, sell = 95},
	-- axes
	{ itemName = "machete", clientId = 3308, buy = 50, sell = 6},
	{ itemName = "hand axe", clientId = 3268, buy = 20, sell = 4},
	{ itemName = "axe", clientId = 3274, buy = 50, sell = 7},
	{ itemName = "hatchet", clientId = 3276, buy = 100, sell = 25},
	{ itemName = "sickle", clientId = 3293, sell = 2},
	{ itemName = "orcish axe", clientId = 3316, sell = 350},
	-- swords
	{ itemName = "short sword", clientId = 3294, buy = 30, sell = 10},
	{ itemName = "sword", clientId = 3264, buy = 85, sell = 25},
	{ itemName = "carlin sword", clientId = 3283, buy = 473, sell = 118},
	{ itemName = "knife", clientId = 3291, sell = 1},
	{ itemName = "dagger", clientId = 3267, sell = 2},
	{ itemName = "rapier", clientId = 3272, sell = 7},
	{ itemName = "sabre", clientId = 3273, sell = 12},
	{ itemName = "katana", clientId = 3300, sell = 35},
	{ itemName = "longsword", clientId = 3285, sell = 51},
	-- clubs
	{ itemName = "scythe", clientId = 3453, buy = 50, sell = 10},
	{ itemName = "obsidian lance", clientId = 3313, sell = 500},
	{ itemName = "club", clientId = 3270, sell = 1},
	{ itemName = "studded club", clientId = 3336, sell = 10},
	{ itemName = "staff", clientId = 3289, sell = 20},
	{ itemName = "bone club", clientId = 3337, sell = 5},
	{ itemName = "mace", clientId = 3286, sell = 30},
	{ itemName = "taurus mace", clientId = 7425, sell = 500},
	--distance
	{ itemName = "spear", clientId = 3277, buy = 10, sell = 3},
}

-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- onAppear
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

-- onDisappear
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

-- onMove
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

-- onSay
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

-- onPlayerCloseChannel
npcType.onCloseChannel = function(npc, player)
	npcHandler:onCloseChannel(npc, player)
end

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, player)
	npcHandler:setMessage(MESSAGE_GREET, "Wilkommen junger Krieger |PLAYERNAME|! Auf meine Waffen ist im Kampf verlass.")
	return true
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end

	if MsgContains(msg, "canary") then
		if npcHandler:getTopic(playerId) == 0 then
			npcHandler:say({
				"The goal is for Canary to be an 'engine', that is, it will be \z
					a server with a 'clean' datapack, with as few things as possible, \z
					thus facilitating development and testing.",
				"See more on our {discord group}.",
			}, npc, player, 3000)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(msg, "discord group") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("This the our discord group link: {https://discordapp.com/invite/3NxYnyV}", npc, player)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

-- Set to local function "greetCallback"
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)

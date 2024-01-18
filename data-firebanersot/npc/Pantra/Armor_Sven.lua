local npcName = "Sven"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 268,
	lookHead = 79,
	lookBody = 82,
	lookLegs = 77,
	lookFeet = 8,
	lookAddons = 2,
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
	-- helmets
	{ itemName = "party hat", clientId = 6578, buy = 600},
	{ itemName = "chain helmet", clientId = 3352, buy = 52, sell = 17},
	{ itemName = "studded helmet", clientId = 3376, buy = 60, sell = 20},
	{ itemName = "leather helmet", clientId = 3355, buy = 12, sell = 4},
	{ itemName = "brass helmet", clientId = 3354, sell = 30},
	{ itemName = "legion helmet", clientId = 3374, sell = 222},
	{ itemName = "viking helmet", clientId = 3367, sell = 66},
	{ itemName = "steel helmet", clientId = 3351, sell = 293},
	-- armors
	{ itemName = "leather armor", clientId = 3361, buy = 25, sell = 12},
	{ itemName = "studded armor", clientId = 3378, buy = 90, sell = 25},
	{ itemName = "cape", clientId = 3565, buy = 9},
	{ itemName = "coat", clientId = 3562, buy = 8, sell = 1},
	{ itemName = "green tunic", clientId = 3563, buy = 25},
	{ itemName = "jacket", clientId = 3561, buy = 10, sell = 1},
	{ itemName = "doublet", clientId = 3379, buy = 16, sell = 3},
	{ itemName = "chain armor", clientId = 3358, sell = 70},
	{ itemName = "brass armor", clientId = 3359, sell = 150},
	{ itemName = "scale armor", clientId = 3377, sell = 75},
	{ itemName = "plate armor", clientId = 3357, sell = 400},
	{ itemName = "dragon scale mail", clientId = 3386, sell = 40000},
	{ itemName = "simple dress", clientId = 3568, sell = 50},
	-- legs
	{ itemName = "leather legs", clientId = 3559, buy = 9, sell = 3},
	{ itemName = "brass legs", clientId = 3372, sell = 49},
	{ itemName = "studded legs", clientId = 3362, sell = 15},
	{ itemName = "chain legs", clientId = 3558, sell = 25},
	{ itemName = "plate legs", clientId = 3557, sell = 115},
	-- boots
	{ itemName = "sandals", clientId = 3551, buy = 2},
	{ itemName = "leather boots", clientId = 3552, buy = 10, sell = 2},
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
	npcHandler:setMessage(MESSAGE_GREET, "Wilkommen auf Pantra |PLAYERNAME|, ich hoffe mein Equipment sagt dir zu.")
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

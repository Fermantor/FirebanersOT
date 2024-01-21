local npcName = "Benedikt"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 57,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
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
	{ text = "Wilkommen Neulinge, habt meinen Segen!" },
	{ text = "Hier muss niemand leiden, holt euch eure Heilung ab." },
}

npcConfig.flags = {
	floorchange = false,
}

-- Npc shop
npcConfig.shop = {
	{ itemName = "minotaur horn", clientId = 11472, sell = 30 },
	{ itemName = "minotau leather", clientId = 5878, sell = 50 },
	{ itemName = "piece of warrior armor", clientId = 11482, sell = 100 },
	{ itemName = "minotaur trophy", clientId = 7401, sell = 500 },
	-- { itemName = "", clientId = , buy = , sell =  },
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
	local playerHP = player:getHealth()/player:getMaxHealth()
	if playerHP < 0.25 then
		npcHandler:setMessage(MESSAGE_GREET, "|PLAYERNAME|! Du siehst schwer verletzt aus. Du brauchst dringend eine {Heilung}!")
	elseif playerHP < 0.5 then
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|. Du siehst verletzt aus. Du k�nntest bestimmt eine {Heilung} gebrauchen!")
	elseif playerHP < 0.75 then
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|. Du siehst ein wenig angeschlagen aus. Wenn Du m�chtest kann ich Dich {heilen}.")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|, und wilkommen auf Pantra. Wenn du {hilfe} bauchst, frag einfach nach.")
	end
	return true
end

keywordHandler:addKeyword({"minotaur leather"}, StdModule.say, {npcHandler = npcHandler, text = {
	"Minotaur Leathers sind ein hervorragendes Material f�r feste und starke Kleidung. Leider ist es sehr schwer einen Minotauren zu erlegen und ihm das Leather unbesch�digt zu entfernen. ...",
	"Mit einem {Obsidian Knife} w�rde es deutlich leichter gehen, allerdings sind die Materialien, die man daf�r braucht auf Pantra �u�erst schwer zu bekommen."}})
	keywordHandler:addKeyword({"obsidian knife"}, StdModule.say, {
		npcHandler = npcHandler, 
		text = {
			"Ein Obsidian Knife eignet sich hervorangend, um die Haut von get�teten Monstern zu entfernen. Es gelingt damit zwar nicht immer, aber doch deutlich h�ufiger, als dass man ein intaktes St�ck im Kadaver findet. ...",
			"Die Herstellung ist auch nicht das gro�e Problem, Jack ist dazu bestimmt in der Lage. Allerdings sind die Materialien, die es braucht hier auf Pantra nicht grade h�ufig zu finden, um es untertrieben auszudr�cken. ...",
			"Soweit ich wei�, ben�tigt es ein {Piece of Draconian Steel} und eine {Obsidian Lance}. Beides habe ich hier seit Jahren nicht gesehen.",
		},
	})
keywordHandler:addKeyword({"obsidian lance"}, StdModule.say, {npcHandler = npcHandler, text = {"Die Obsidian Lance ist aus einem besonders harten Stein gemacht. Nur die st�rksten Orcs tragen eine mit sich rum."}})
keywordHandler:addKeyword({"draconian steel"}, StdModule.say, {npcHandler = npcHandler, text = {
	"Draconian Steel ist ein besonderes Metall, das aus den Schilden von Drachen gewonnen wird. Ich glaube weit �stlich von hier lebt ein Drachenvernarrter, der diesen Stahl herstellen kann. ...",
	"Aber daf�r br�uchte er erstmal ein Dragon Shield. Und ich glaube nicht, dass jemand auf Pantra in der Lage ist, einen Drachen zu erlegen, geschweige denn mehrere."}})
	
	-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	-- npcHandler:setTopic(playerId, 1)
	-- npcHandler:getTopic(playerId)
	-- npcHandler:say("", npc, player)
	-- npcHandler:say({"",""}, npc, player, 4000)
	
	local playerHP = player:getHealth()/player:getMaxHealth()
	if MsgContains(msg, "heil") then
		local doHealing = false
		local conditionsToHeal = {
			CONDITION_POISON,
			CONDITION_FIRE,
			CONDITION_ENERGY,
			CONDITION_BLEEDING,
			CONDITION_PARALYZE,
			CONDITION_DROWN,
			CONDITION_FREEZING,
			CONDITION_CURSED
		}
		for i = 0, #conditionsToHeal-1 do
			if player:getCondition(conditionsToHeal[i]) then
				player:removeCondition(conditionsToHeal[i])
				doHealing = true
			end
		end
		if playerHP <= 0.75 then
			player:addHealth(player:getMaxHealth())
			doHealing = true
		end
		if doHealing then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:say({
				"Exura Sio \""..player:getName(),
				"So, nun siehst du wieder gesund aus. Brauchst du sonst noch {Hilfe}?"
			}, npc, player, 2000)
		else
			npcHandler:say("Es tut mir leid, aber du siehst nicht sonderlich verletzt aus. Ich spare mir mein Mana doch lieber f�r einen Ernstfall auf.", npc, player)
		end
	elseif MsgContains(msg, "elena") then
		if player:getStorageValue(Storage.Pantra.Outfits.Citizen.Backpack) ~= -1 then
		end
	end
	return true
end

-- Set to local function "greetCallback"
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
npcHandler:setMessage(MESSAGE_FAREWELL, "Sei gesegnet |PLAYERNAME|.")
-- Walkaway message
npcHandler:setMessage(MESSAGE_WALKAWAY, "Das ist nicht sehr nett, aber so sind Abenteurer wohl einfach...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)

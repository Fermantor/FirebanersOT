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
	{ text = "Ich bin fucked up." },
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
	local woodenShieldStorage = player:getStorageValue(Storage.Pantra.Town.Weapons.WoodenShield)
	if woodenShieldStorage == -1 and player:getLevel() <= 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Herzlich wilkommen auf Pantra |PLAYERNAME|. Du scheinst neu hier zu sein und siehst aus, als kï¿½nntest du etwas {Hilfe} gebrauchen.")
	elseif woodenShieldStorage == 1 and player:getLevel() <= 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen zurï¿½ck, |PLAYERNAME|. Immer noch kein Interesse an meinem {Wooden Shield}?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen junger Krieger |PLAYERNAME|! Auf meine Waffen ist im Kampf verlass.")
	end	
	return true
end

keywordHandler:addKeyword({"minotaur leather"}, StdModule.say, {npcHandler = npcHandler, text = {
	"Minotaur Leathers sind ein hervorragendes Material für feste und starke Kleidung. Leider ist es sehr schwer einen Minotauren zu erlegen und ihm das Leather unbeschädigt zu entfernen. ...",
	"Mit einem {Obsidian Knife} würde es deutlich leichter gehen, allerdings sind die Materialien, die man dafür braucht auf Pantra äußerst schwer zu bekommen."}})
keywordHandler:addKeyword({"obsidian knife"}, StdModule.say, {
	npcHandler = npcHandler, 
	text = {
		"Ein Obsidian Knife eignet sich hervorangend, um die Haut von getöteten Monstern zu entfernen. Es gelingt damit zwar nicht immer, aber doch deutlich häufiger, als dass man ein intaktes Stück im Kadaver findet. ...",
		"Die Herstellung ist auch nicht das große Problem, Jack ist dazu bestimmt in der Lage. Allerdings sind die Materialien, die es braucht hier auf Pantra nicht grade häufig zu finden, um es untertrieben auszudrücken. ...",
		"Soweit ich weiß, benötigt es ein {Piece of Draconian Steel} und eine {Obsidian Lance}. Beides habe ich hier seit Jahren nicht gesehen.",
	},
})
keywordHandler:addKeyword({"obsidian lance"}, StdModule.say, {npcHandler = npcHandler, text = {"Die Obsidian Lance ist aus einem besonders harten Stein gemacht. Nur die stärksten Orcs tragen eine mit sich rum."}})
keywordHandler:addKeyword({"draconian steel"}, StdModule.say, {npcHandler = npcHandler, text = {
	"Draconian Steel ist ein besonderes Metall, das aus den Schilden von Drachen gewonnen wird. Ich glaube weit östlich von hier lebt ein Drachenvernarrter, der diesen Stahl herstellen kann. ...",
	"Aber dafür bräuchte er erstmal ein Dragon Shield. Und ich glaube nicht, dass jemand auf Pantra in der Lage ist, einen Drachen zu erlegen, geschweige denn mehrere."}})

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local woodenShieldStorage = player:getStorageValue(Storage.Pantra.Town.Weapons.WoodenShield)
	if MsgContains(msg, "hilfe") or (MsgContains(msg, "wooden shield") and woodenShieldStorage == 1) then
		if woodenShieldStorage == -1 and player:getLevel() <= 5 then
			npcHandler:say({"Meine Waffen und Schilde sind die Besten auf ganz Pantra. Um dir einen Vorgeschmack meiner Ware zu geben wï¿½rde ich dir ein {Wooden Shield} schenken. Interesse?"}, npc, player)
			player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield, 1)
			npcHandler:setTopic(playerId, 1)
		elseif woodenShieldStorage == 1 and player:getLevel() <= 5 then
			npcHandler:say("Wie ich dir bereits angeboten habe, wï¿½rde ich dich mit einem gratis {Wooden Shield} ausstatten. Wie sieht's aus?", npc, player)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Wenn du Hilfe im Kampf brauchst und nach einem neuen Begleiter suchst bin ich der richtige Ansprechpartner. Frag mich einfach nach nem {Trade}", npc, player)
		end
	elseif msg == "yes" or msg == "ja" then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getSlotItem(CONST_SLOT_RIGHT) ~= nil then
				npcHandler:say("Nanu? Du scheinst ja bereits bestens ausgestattet zu sein. Tut mir leid, aber dann behalte ich dieses Schild lieber fï¿½r jemanden, der es wirklich braucht. Du kannst dich aber gerne in meinem {Sortiement} umsehen.", npc, player)
				player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield,2)
				npcHandler:setTopic(playerId, 0)
			elseif player:getFreeCapacity() < 4000 then
				npcHandler:say("Du scheinst schon zu vollgepackt sein. Rï¿½um ein bisschen in deinem Inventar auf und schaffe ein wenig Platz. Ich warte hier, keine Sorge.", npc, player)
				npcHandler:setTopic(playerId, 0)
			else
				player:addItem("wooden shield")
				player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield,2)
				npcHandler:say("Hier bitte schï¿½n. Es ist zwar kein {Blessed Shield}, aber immer noch besser als kein Schild. Schau gerne, ob ich noch mehr nï¿½tzliches in meinem {Sortiement} fï¿½r dich habe.", npc, player)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(msg, "wooden shield") then
		npcHandler:say("Ein Wooden Shield ist ein recht schwaches Schild, was sich sehr gut als Einsteigerschild eignet. Wenn du was besseres suchst, findet sich in meinem {Sortiement} bestimmt was.", npc, player)
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
npcHandler:setMessage(MESSAGE_WALKAWAY, "Jaja, sei bloï¿½ froh, dass diese Theke zwischen uns ist...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)

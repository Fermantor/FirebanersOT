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
	{ text = "Meine Waffen sind die besten f�r den Kampf!" },
	{ text = "Neulinge k�nnen sich hier gerne eine Warenprobe abholen" },
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
	local woodenShieldStorage = player:getStorageValue(Storage.Pantra.Town.Weapons.WoodenShield)
	if woodenShieldStorage == -1 and player:getLevel() <= 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Herzlich wilkommen auf Pantra |PLAYERNAME|. Du scheinst neu hier zu sein und siehst aus, als k�nntest du etwas {Hilfe} gebrauchen.")
	elseif woodenShieldStorage == 1 and player:getLevel() <= 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen zur�ck, |PLAYERNAME|. Immer noch kein Interesse an meinem {Wooden Shield}?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen junger Krieger |PLAYERNAME|! Auf meine Waffen ist im Kampf verlass.")
	end	
	return true
end

keywordHandler:addKeyword({"blessed shield"}, StdModule.say, {npcHandler = npcHandler, text = {
	"Das Blessed Shield ist ein legend�res Artefakt. Man sagt es wurde vor 1000 Jahren von den G�ttern erschaffen, um einen selbst vor den st�rksten Monstern und Demons zu sch�tzen. ...",
	"Viele haben �ber die Jahre versucht es zu kopieren, aber der von den G�ttern verzauberte Stahl ist einfach zu einzigartig und somit ist es niemandem gelungen. ...",
	"Das einzig existierende Blessed Shield wird von Generation zu Generation weitergegeben. Es war im Besitz vieler m�chtiger Krieger und K�nige. ...",
	"Der letzte Bekannte Besitzer war {K�nig Taibaner}, jedoch scheint er es jetzt nicht mehr zu haben, denn in seiner Waffenkammer ist es nicht mehr ausgestellt. ...",
	"Wer wei�, wer jetzt der Besitzer ist? Auf jeden Fall tr�gt dieser eines der m�chtigsten Artefakte und ist im Kampg nachezu unbesiegbar. ..."}})
	keywordHandler:addKeyword({"taibaner"}, StdModule.say, {npcHandler = npcHandler, text = {
	"K�nig Taibaner ist das Oberhaupt von Pulgra. Er hat die Stadt von den Trollen befreit und sie komplett neu aufgebaut. ...",
	"Er ist ein starker K�nig, aber auch sehr gro�z�gig. Er und seine Untertanen stehen in sehr nahem Kontakt zu uns und schicken uns regelm��ig verschiedenste Dinge."}})
	keywordHandler:addKeyword({"sortiement"}, StdModule.say, {npcHandler = npcHandler, text = "Schwerter, �xte und Clubs. Bei mir findest du alles. Sieh dir einfach meinen {Trade} an."})
	keywordHandler:addAliasKeyword({"ware"})
	keywordHandler:addAliasKeyword({"axe"})
	keywordHandler:addAliasKeyword({"club"})
	keywordHandler:addAliasKeyword({"sword"})

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local woodenShieldStorage = player:getStorageValue(Storage.Pantra.Town.Weapons.WoodenShield)
	if MsgContains(msg, "hilfe") or (MsgContains(msg, "wooden shield") and woodenShieldStorage == 1) then
		if woodenShieldStorage == -1 and player:getLevel() <= 5 then
			npcHandler:say({"Meine Waffen und Schilde sind die Besten auf ganz Pantra. Um dir einen Vorgeschmack meiner Ware zu geben w�rde ich dir ein {Wooden Shield} schenken. Interesse?"}, npc, player)
			player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield, 1)
			npcHandler:setTopic(playerId, 1)
		elseif woodenShieldStorage == 1 and player:getLevel() <= 5 then
			npcHandler:say("Wie ich dir bereits angeboten habe, w�rde ich dich mit einem gratis {Wooden Shield} ausstatten. Wie sieht's aus?", npc, player)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Wenn du Hilfe im Kampf brauchst und nach einem neuen Begleiter suchst bin ich der richtige Ansprechpartner. Frag mich einfach nach nem {Trade}", npc, player)
		end
	elseif msg == "yes" or msg == "ja" then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getSlotItem(CONST_SLOT_RIGHT) ~= nil then
				npcHandler:say("Nanu? Du scheinst ja bereits bestens ausgestattet zu sein. Tut mir leid, aber dann behalte ich dieses Schild lieber f�r jemanden, der es wirklich braucht. Du kannst dich aber gerne in meinem {Sortiement} umsehen.", npc, player)
				player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield,2)
				npcHandler:setTopic(playerId, 0)
			elseif player:getFreeCapacity() < 4000 then
				npcHandler:say("Du scheinst schon zu vollgepackt sein. R�um ein bisschen in deinem Inventar auf und schaffe ein wenig Platz. Ich warte hier, keine Sorge.", npc, player)
				npcHandler:setTopic(playerId, 0)
			else
				player:addItem("wooden shield")
				player:setStorageValue(Storage.Pantra.Town.Weapons.WoodenShield,2)
				npcHandler:say("Hier bitte sch�n. Es ist zwar kein {Blessed Shield}, aber immer noch besser als kein Schild. Schau gerne, ob ich noch mehr n�tzliches in meinem {Sortiement} f�r dich habe.", npc, player)
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
npcHandler:setMessage(MESSAGE_WALKAWAY, "Jaja, sei blo� froh, dass diese Theke zwischen uns ist...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)

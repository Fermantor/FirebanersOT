local npcName = "Elena"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 79,
	lookBody = 0,
	lookLegs = 115,
	lookFeet = 94,
	lookAddons = 3,
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
	{ itemName = "green backpack", clientId = 2865, buy = 20 },
	{ itemName = "green bag", clientId = 2857, buy = 5 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 10 },
	{ itemName = "shovel", clientId = 3457, buy = 50, sell = 10 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 10 },
	{ itemName = "candlestick", clientId = 2917, buy = 2 },
	{ itemName = "candelabrum", clientId = 2911, buy = 8 },
	{ itemName = "scythe", clientId = 3453, buy = 50 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 20 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "vial of milk", clientId = 2874, buy = 10, count = 9 },
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
npcHandler:setMessage(MESSAGE_GREET, "Grüß dich |PLAYERNAME|, ein guter Tag, um sich auszurüsten, findest du nicht?")

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
	

	if MsgContains(msg, "quest") or MsgContains(msg, "job") or MsgContains(msg, "aufgabe") or MsgContains(msg, "mission") then
		if player:getStorageValue(Storage.Pantra.Town.Elena.Main) == 1 then
			if player:getStorageValue(Storage.Pantra.Town.Elena.Chest) == 1 then
				if (player:getFreeCapacity() / 100) > 22.00 and player:getFreeBackpackSlots() >= 1 then
					npcHandler:setTopic(playerId, 0)
					player:addExperience(500,true)
					player:setStorageValue(Storage.Pantra.Town.Elena.Main, 2)
					local rewardBag = player:addItem(2857) -- green bag
					rewardBag:addItem(3031, 50) -- 50 gold coins
					rewardBag:addItem(3552, 1) -- leather boots
					npcHandler:say("So so, ein Leather Helmet. Gut, danke. Hier ist deine Belohnung.", npc, player)
				else
					npcHandler:setTopic(playerId, 0)
					npcHandler:say("Ein Leather Helmet also. Ich würde dir dafür gerne eine kleine Belohnung geben, aber du kannst grade nicht genug tragen. Komm wieder, wenn du Platz hast und 22.00 oz tragen kannst.", npc, player)
				end
			else
				npcHandler:setTopic(playerId, 0)
				npcHandler:say("Du sollst doch zur Truhe gehen, und gucken, was in ihr ist.", npc, player)
			end
		elseif player:getStorageValue(Storage.Pantra.Town.Elena.Main) == 2 then
			npcHandler:setTopic(playerId, 0)
			npcHandler:say("Tut mir leid, aber mehr Aufgaben habe ich im Moment nicht für dich.", npc, player)
		elseif player:getStorageValue(Storage.Pantra.Town.Elena.Main) == -1 and player:getStorageValue(Storage.Pantra.Town.Elena.Chest) == -1 then
			npcHandler:say("Ah, sehr mutig von dir mich danach zu fragen. Ich habe sogar eine Aufgabe für dich. Doch dafür musst du mindestens Level 2 und {bereit} sein.", npc, player)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(msg, "bereit") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getLevel() >= 2 then
				npcHandler:setTopic(playerId, 0)
				player:setStorageValue(Storage.Pantra.Town.Elena.Main, 1)
				npcHandler:say({
					"Sehr gut. Du siehst die Brücke dort, die du über die Treppe erreichst? Wenn du sie überquerst solltest du einen großen Felsen sehen. ...",
					"Wenn du von dort an in den Süden gehst solltest du eine Truhe finden. Sven hat dort drin etwas versteckt, was ich ihm sagen soll. ...",
					"Aber er weiß, dass ich meinen Stand hier nicht verlassen kann, weil mir sonst Katharina's Hühner ausbüchsen. Bitte geh für mich nachsehen und sag mir, was du gefunden hast. Danke!"
				}, npc, player, 4000)
			else
				npcHandler:setTopic(playerId, 0)
				npcHandler:say("Tut mir leid, aber du musst mindestens Level 2 sein, um die Brücke überqueren zu können. Komm einfach später wieder.", npc, player)
			end
		end
	end
	--[[
	if msgcontains(msg, 'addon') or msgcontains(msg, 'outfit') or msgcontains(msg, 'citizen') then
		if getPlayerStorageValue(cid, 5009) <= 0 then
			npcHandler:say('Ah, dir ist mein exklusives Outfit aufgefallen. Nun, das Backpack habe ich von {Benedikt} bekommen, aber den {Hut} habe ich selbst gemacht.', cid)
		else
			npcHandler:say('Ja, mein Backpack habe ich von dem weisen Mönch {Bendedikt} bekommen. Er ist ein wahrer Meister, bei der Verarbeitung von Minotaur Leathers.', cid)
		end
	elseif msgcontains(msg, 'hut') then
		if getPlayerStorageValue(cid, 5009) == -1 then
			npcHandler:say('Ja, bei dem Hut habe ich mich wirklich selbst übertroffen. Und wie ich in deinen gieringen Augen sehe, willst du unbedingt auch einen habe, stimmt\'s?', cid)
			talkState[talkUser] = 2
		end
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 2 then
			npcHandler:say('Ha wusst ich\'s doch. Allerdings wachsen Hüte nicht auf Bäumen und ich brauche ein paar Materialien. Für den Hut benötige ich einen {Legion Helmet}, für die Feder 100 {Chicken} {Feathers}, und damit alles gut hält noch 50 {Honeycombs}. Hast du trotzdem noch Interesse am Hut?', cid)
			talkState[talkUser] = 3
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Sehr gut, dann besorge mir zuerst einen {Legion Helmet}, damit ich mit der Arbeit beginnen kann.', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, 5009, 1)
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 2480, 1) == TRUE then
				npcHandler:say('Prima, ich werde sofort beginnen den Hut zu erstellen. Mach du dich nun auf die Suche nach 100 {Chicken} {Feathers}, und komme nicht wieder, ehe du sie nicht hast.', cid)
				setPlayerStorageValue(cid, 5009, 2)
				talkState[talkUser] = 0
			else
				npcHandler:say('Ähm, ich habe dich um einen Legion Helmet gebeten... wenn du nicht weißt, wie du einen findest, bist du auch nicht würdig den Hut zu tragen. Tritt mir nicht mehr unter die Augen, bis du ihn nicht hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			if getPlayerItemCount(cid, 5890) >= 100 then
				doPlayerRemoveItem(cid, 5890, 100)
				npcHandler:say('Perfekt, wir sind nah dran. Jetzt nur noch 50 {Honeycombs}, und dein Hut ist fertig. Beeilung!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5009, 3)
			else
				npcHandler:say('Es nützt mir nichts, wenn du mich besuchst. Bringe mir 100 Chicken Feathers, oder ich werde nie fertig.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 6 then
			if getPlayerItemCount(cid, 5902) >= 50 then
				doPlayerRemoveItem(cid, 5902, 50)
				npcHandler:say('Wunderbar, der Hut ist fertig. Wieder einmal eine Meisterleistung von mir. Hier hast du das Prachtexemplar!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5009, 4)
				doPlayerAddOutfit(cid,136,2)
				doPlayerAddOutfit(cid,128,2)
				doSendMagicEffect(getPlayerPosition(cid), 12)
			else
				npcHandler:say('Ohne Honeycombs kein Hut, also streng dich an!', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') then
		if talkState[talkUser] == 2 then
			npcHandler:say('Gut dann habe ich mich wohl geirrt, und du wirst nie so einen prächtigen Hut wie ich besitzen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Da habe ich Dich wohl falsch eingeschätzt, ich dachte du wärst dieser Aufgabe gewachsen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Und wofür kommst du dann zu mir? Besorg den Legion Helmet und verschwende nicht meine Zeit!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Bist wohl auch noch stolz drauf, dass du nicht mal ein paar Chicken töten kannst? Ich brauche 100 Chicken Feathers!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Was willst du dann bei mir?', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'legion helmet') then
		if getPlayerStorageValue(cid, 5009) == 1 then
			npcHandler:say('Ah, du kommst also mit dem Legion Helmet, um mit der Arbeit am Hut zu beginnen?', cid)
			talkState[talkUser] = 4
		else
			npcHandler:say('Legion Helmets sind sehr starke und robuste Stahl Helme, die man meistens in Drachen Körpern findet.', cid)
		end
	elseif msgcontains(msg, 'chicken feather') or msgcontains(msg, 'feather') then
		if getPlayerStorageValue(cid, 5009) == 2 then
			npcHandler:say('Bist du hier um mir die 100 Chicken Feathers zu bringen?', cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Chicken Feathers sind ein besonders weiches Material, dass du in Chickens finden kannst.', cid)
		end
	elseif msgcontains(msg, 'honeycomb') then
		if getPlayerStorageValue(cid, 5009) == 3 then
			npcHandler:say('Kommst du mit den lang ersehnten Honeycombs?', cid)
			talkState[talkUser] = 6
		else
			npcHandler:say('Honeycombs sind sehr klebrig aber von sehr großem Genus. Du findest sie in Wasps.', cid)
		end
	elseif msgcontains(msg, 'benedikt') then
		npcHandler:say('Benedikt ist ein Mönch, der zahlreiche Erfahrungen mit Minotauren gemacht hat und deren Leathers hervoragend verarbeiten kann.', cid)
	end
	]]
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

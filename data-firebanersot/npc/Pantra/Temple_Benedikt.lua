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
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|. Du siehst verletzt aus. Du könntest bestimmt eine {Heilung} gebrauchen!")
	elseif playerHP < 0.75 then
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|. Du siehst ein wenig angeschlagen aus. Wenn Du möchtest kann ich Dich {heilen}.")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|, und wilkommen auf Pantra. Wenn du {hilfe} bauchst, frag einfach nach.")
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
			npcHandler:say("Es tut mir leid, aber du siehst nicht sonderlich verletzt aus. Ich spare mir mein Mana doch lieber für einen Ernstfall auf.", npc, player)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(msg, "elena") then
		if player:getStorageValue(Storage.Pantra.Outfits.Citizen.Backpack) ~= -1 then
			npcHandler:say("Ah, hat sie wieder mit meiner Arbeit rumgeprahlt? Nun, mit den richtigen Materialien kann ich dir im Handumdrehen dein eigenes {Backpack} machen.", npc, player)
		else
			npcHandler:say("Elena ist eine fleißige Dame. Sie versorgt uns alle, mit den nötigen Tools, um in der freien Natur nicht hilflos zu sein.", npc, player)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(msg, "backpack") or MsgContains(msg, "addon") or MsgContains(msg, "outfit") then
		if player:getStorageValue(Storage.Pantra.Outfits.Citizen.Backpack) == -1 then
			npcHandler:say("Nun, ich als Meister der Minotauren kann aus ein paar {Minotaur Leathers} im Handumdrehen ein schönes Backpack machen. Bist du interessiert?", npc, player)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Pantra.Outfits.Citizen.Backpack) == 1 then
			npcHandler:say("Bist du hier, um mir die 100 Minotaur Leathers zu bringen?", npc, player)
			npcHandler:setTopic(playerId, 2)
		end
	elseif msg == "ja" or msg == "yes" then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Pantra.Outfits.Citizen.Backpack, 1)
			npcHandler:setTopic(playerId, 0)
			npcHandler:say({
			"Natürlich bist du! So ein Backpack sieht doch an jedem gut aus. Also, die Materialien die ich brauche sind einfach, wenn auch nicht ganz einfach zu bekommen. ...",
			"Wird reden von 100 {Minotaur Leathers}. Nicht mehr, aber auch nicht weniger. Es wird bestimmt eine Weile dauern, diese Menge zu sammeln, aber ich habe Zeit. ...",
			"Du findest Minotauren auf der dritten Insel, ganz im Osten von Pantra, tief im Untergrund. Sind sind stark und sie sind viele. Daher empfehle ich dir, dich nicht alleine auf den Weg zu machen. ...",
			"Ich wünsche dir viel Glück dabei und warte, dir dein Backpack knüpfen zu dürfen."
			}, npc, player, 4000)
		elseif npcHandler:getTopic(playerId) == 2 then
			local leathersInInventory = player:getItemCount(5878)
			local leathersInStash = player:getStashItemCount(5878)
			if leathersInInventory + leathersInStash >= 100 then
				if leathersInInventory >= 100 then
					player:removeItem(5878, 100)
				else
					player:sendTextMessage(MESSAGE_TRADE, string.format("Took %d items from your inventory and %d from your stash.", leathersInInventory, 100- leathersInInventory))
					player:removeStashItem(5878, 100 - leathersInInventory)
					player:removeItem(5878, leathersInInventory)
				end
				player:setStorageValue(Storage.Pantra.Outfits.Citizen.Backpack, 2)
				npcHandler:setTopic(playerId, 0)
				player:addOutfitAddon(136, 1)
				player:addOutfitAddon(128, 1)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				npcHandler:say("Wunderbar, das Backpack habe ich im Handumdrehen gemacht... und hier... und da... FERTIG! Ich hoffe, du findest Gefallen daran.", npc, player)
			else
				npcHandler:setTopic(playerId, 0)
				npcHandler:say("Es tut mir leid, aber ich brauche wirklich ganze 100 Minotaur Leathers. Ohne sie hält das Backpack nichts aus und würde nach kurzer Zeit reißen.", npc, player)
			end
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

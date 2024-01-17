local talkState = {}

local t = {
	  [5803] = {price = 0, price2 = 42000}, -- [Arbalest] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2453] = {price = 0, price2 = 42000}, -- [Arcane Staff] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7183] = {price = 0, price2 = 20000}, -- [Baby Seal Doll] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10532] = {price = 0, price2 = 20000}, -- [Bejeweled Ship's Telescope] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12649] = {price = 0, price2 = 60000}, -- [Blade of Corruption] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7416] = {price = 0, price2 = 30000}, -- [Bloody Edge] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7730] = {price = 0, price2 = 15000}, -- [Blue Legs] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2745] = {price = 0, price2 = 250}, -- [Blue Rose] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2407] = {price = 0, price2 = 6000}, -- [Bright Sword] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [6561] = {price = 0, price2 = 20000}, -- [Ceremonial Ankh] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10309] = {price = 0, price2 = 15000}, -- [Claw of The Noxious Spawn] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2184] = {price = 0, price2 = 10000}, -- [Crystal Wand] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2493] = {price = 0, price2 = 40000}, -- [Demon Helmet] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8867] = {price = 0, price2 = 50000}, -- [Dragon Robe] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2435] = {price = 0, price2 = 1500}, -- [Dwarven Axe] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2504] = {price = 0, price2 = 40000}, -- [Dwarven Legs] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10523] = {price = 0, price2 = 15000}, -- [Egg of The Many] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7453] = {price = 0, price2 = 55000}, -- [Executioner] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2361] = {price = 0, price2 = 20000}, -- [Frozen Starlight] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2130] = {price = 0, price2 = 2000}, -- [Golden Amulet] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10542] = {price = 0, price2 = 10000}, -- [Golden Fafnar Trophy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2418] = {price = 0, price2 = 1000}, -- [Golen Sickle] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8869] = {price = 0, price2 = 50000}, -- [Greenwood Coat] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7964] = {price = 0, price2 = 5000}, -- [Marlin Trophy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8849] = {price = 0, price2 = 10000}, -- [Modified Crossbow] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18396] = {price = 0, price2 = 500}, -- [Mucus Plug] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [5022] = {price = 0, price2 = 40}, -- [Orichalcum Pearl] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2524] = {price = 0, price2 = 1500}, -- [Ornamented Shield] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [5080] = {price = 0, price2 = 30000}, -- [Panda Teddy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18339] = {price = 0, price2 = 1500}, -- [Pet Pig] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [1982] = {price = 0, price2 = 2000}, -- [Purple Tome] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [1986] = {price = 0, price2 = 2000}, -- [Red Tome] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [7417] = {price = 0, price2 = 45000}, -- [Runed Sword] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10529] = {price = 0, price2 = 10000}, -- [Sea Serpent Trophy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8857] = {price = 0, price2 = 12000}, -- [Silkweaver Bow] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [10543] = {price = 0, price2 = 1000}, -- [Silver Fafnar Trophy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12563] = {price = 0, price2 = 5000}, -- [Silver Rune Emblem (Explosion)] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12561] = {price = 0, price2 = 5000}, -- [Silver Rune Emblem (Heavy Magic Missile)] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12565] = {price = 0, price2 = 5000}, -- [Silver Rune Emblem (Sudden Death)] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12559] = {price = 0, price2 = 5000}, -- [Silver Rune Emblem (Ultimate Healing)] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12635] = {price = 0, price2 = 7500}, -- [Souleater Trophy] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [2131] = {price = 0, price2 = 500}, -- [Star Amulet] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18500] = {price = 0, price2 = 4000}, -- [Statue of Abyssador] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18504] = {price = 0, price2 = 3000}, -- [Statue of Deathstrike] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [12663] = {price = 0, price2 = 1500}, -- [Statue of Devovorga] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18508] = {price = 0, price2 = 2000}, -- [Statue of Gnomevil] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [6566] = {price = 0, price2 = 6000}, -- [Stuffed Dragon] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [6528] = {price = 0, price2 = 42000}, -- [The Avenger] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8853] = {price = 0, price2 = 50000}, -- [The Ironworker] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [15621] = {price = 0, price2 = 4000}, -- [Trophy of Jaul] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [15619] = {price = 0, price2 = 3000}, -- [Trophy of Obujos] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [15620] = {price = 0, price2 = 2000}, -- [Trophy of Tanjis] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [6103] = {price = 0, price2 = 30000}, -- [Unholy Book] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [8883] = {price = 0, price2 = 50000} -- [Windborn Colossus Armor] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  }
	  
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
	local price = t[item].price*amount
	if inBackpacks then
		price = price + 20
	end
	if getPlayerMoney(cid) < price then
		selfSay("Es tut mir leid, aber Du hast nicht genug Geld.", cid)
	else
		if inBackpacks then
			local Backpack = doCreateItemEx(1988, 1)
			doAddContainerItem(Backpack, item, amount)
			doPlayerAddItemEx(cid, Backpack)
		else
			doPlayerAddItem(cid, item, amount)
		end
		doPlayerRemoveMoney(cid, price)
		doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für " .. price .. " Gold gekauft.")
	end
	return true
end

local onSell = function(cid, item, subType, amount)
	doPlayerRemoveItem(cid, item, amount)
	doPlayerAddMoney(cid, t[item].price2*amount)
	doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für	" .. t[item].price*amount .. " Gold verkauft.")
	--selfSay("Here your are!", cid)
	return true
end

local function getCount(string)
	local b, e = string:find('%d+')
	return b and e and tonumber(string:sub(b, e)) or -1
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                        npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)          npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                                                      npcHandler:onThink()                                            end


function creatureSayCallback(cid, type, msg)
	msg = msg:lower()
	if(not npcHandler:isFocused(cid)) then
		if msg == "hi" or msg == "hallo" or msg == "hello" then
			if getPlayerStorageValue(cid, 51234) == 2 then
				npcHandler:say("Hallo " ..getPlayerName(cid).. ". Du sehnst Dich wahrscheinlich danach die {Warzones} zu betreten. Aber vielleicht bist Du auch an anderen Seiten meines {Jobs} interessiert.", cid)
				talkState[cid] = 0
				npcHandler:addFocus(cid)
			else
				npcHandler:say("Du scheinst neu hier zu sein. Sprich am besten erstmal mit Gnomette!", cid)
			end
		else
			return false
		end
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local playerRuhm = getPlayerStorageValue(cid, 51240)
	local majorToken = getPlayerItemCount(cid, 18423)
	local minorToken = getPlayerItemCount(cid, 18422)
	local shopWindow = {}
        
	if msg == "job" or msg == "beruf" then
		npcHandler:say("Ich bin zuständig für unsere Kriegs {Missionen}, mit bewährten Kriegern zu {handeln} und um Kriegs {Helden} zu belohnen. Du musst Rang 4 haben, um die {Warzones} betreten zu können." ,cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "warzone") then
		npcHandler:say(
		{
			"Es gibt drei Warzones. In jeder Warzone wirst Du fürchterliche Feinde vorfinden. Am Ende trifst Du auf ihren fiesen Meister. Der Meister ist allerdings gut beschützt. ...",
			"Sprich am besten mit unseren Gnomischen Agenten vor Ort um genaueres über diesen Schutz zu erfahren. ...",
			"Oh und um die zweite Warzone zu betreten, musst Du die erste meistern. Und um die dritte zu betreten, musst Du die zweite meistern. ...",
			"Und Du kannst jede einzellne nur alle 20 Stunden einmal betreten. Deine normalen Teleport Kristalle werden bei diesen Teleportern nicht funktionieren. Du musst Missions Kristalle von Gnomally holen."
		}, cid)
		talkState[talkUser] = 0
	elseif msg == "trade" or msgcontains(msg, "handel") then
		if getPlayerStorageValue(cid, 51270) >= 20 then
			for var, ret in pairs(t) do
				table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
			end
			openShopWindow(cid, shopWindow, onBuy, onSell) 
			npcHandler:say('Dann lass uns traden, mein Freund.', cid)
			talkState[talkUser] = 0
		else
			npcHandler:say('Ich tausche nur mit Kriegern, die sich auf dem Schlachtfeld mehrfach als würdig erwiesen haben. Du solltest mehr Warzones erfolgreich bestreiten, bevor ich mit dir Trade!', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "hero") then
		npcHandler:say(
		{
			"Du kannst spezielle Beute aus dem Kampf eintauschen, um Zugang zu den Warzone Teleportern des ensprechenden Bosses zu erhalten, ohne einen Missions Kristall zu verbrauchen. ...",
			(getPlayerStorageValue(cid, 51257) == 1 and "Welchen willst Du einlösen: Deathstrike's {Snippet}, Gnomevil's {Hat}, oder Abyssador {Lash}?" or "Das ist allerdings nur möglich, wenn Du auch den Zugang zu den Warzones hast. Dafür musst Du aber Rang 4 sein und unsere Kriegs {Mission} beitreten.")
		}, cid)
		talkState[talkUser] = 0
		if getPlayerStorageValue(cid, 51257) == 1 then
			talkState[talkUser] = 1
		end
	elseif msgcontains(msg, "snippet") and talkState[talkUser] == 1 and getPlayerStorageValue(cid, 51257) == 1 then
		if getPlayerStorageValue(cid, 51260) == -1 then
			if doPlayerRemoveItem(cid, 18430, 1) then
				npcHandler:say('Als ein Held des Krieges hast Du nun die Erlaubnis, den Teleporter, der ersten Warzone gratis zu benutzen!', cid)
				setPlayerStorageValue(cid, 51260, 1)
			else
				npcHandler:say("Es tut mir leid, aber es scheint, als hättest Du keine Beute aus dem Krieg, die ich gegen den Zugang zu den War Teleportern eintauschen kann.", cid)
			end
		else
			npcHandler:say('Du hast diesen Zugang bereits.', cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, "hat") and talkState[talkUser] == 1 and getPlayerStorageValue(cid, 51257) == 1 then
		if getPlayerStorageValue(cid, 51261) == -1 then
			if doPlayerRemoveItem(cid, 18495, 1) then
				npcHandler:say('Als ein Held des Krieges hast Du nun die Erlaubnis, den Teleporter, der zweiten Warzone gratis zu benutzen!', cid)
				setPlayerStorageValue(cid, 51261, 1)
			else
				npcHandler:say("Es tut mir leid, aber es scheint, als hättest Du keine Beute aus dem Krieg, die ich gegen den Zugang zu den War Teleportern eintauschen kann.", cid)
			end
		else
			npcHandler:say('Du hast diesen Zugang bereits.', cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, "lash") and talkState[talkUser] == 1 and getPlayerStorageValue(cid, 51257) == 1 then
		if getPlayerStorageValue(cid, 51262) == -1 then
			if doPlayerRemoveItem(cid, 18496, 1) then
				npcHandler:say('Als ein Held des Krieges hast Du nun die Erlaubnis, den Teleporter, der dritten Warzone gratis zu benutzen!', cid)
				setPlayerStorageValue(cid, 51262, 1)
			else
				npcHandler:say("Es tut mir leid, aber es scheint, als hättest Du keine Beute aus dem Krieg, die ich gegen den Zugang zu den War Teleportern eintauschen kann.", cid)
			end
		else
			npcHandler:say('Du hast diesen Zugang bereits.', cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, "mission") then
		if getPlayerStorageValue(cid, 51257) == -1 then
			npcHandler:say("Nun gut, Du hast die Erlaubniss, die Warzones zu betreten. Aber sei gewarnt, das wird kein Spaziergang. Schließ Dich lieber mit ein paar Freunden zusammen. Ehrlich gesagt, trommel so viele zusammen, wie Du kannst... ja das klingt nach einer guten Idee.", cid)
			setPlayerStorageValue(cid, 51257, 1)
			setPlayerStorageValue(cid, 51263, 0)
		else
			npcHandler:say("Du bist bereits berechtig, die {Warzones} zu betreten. Es gibt nichts mehr, was ich für Dich tun kann. Besorge Dir einen Missions Kristall von Gnomally und finde eine paar Freunde, um es Dir gleich zu tun.", cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, "bye") then
		npcHandler:say("Bye.", cid)
		npcHandler:releaseFocus(cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

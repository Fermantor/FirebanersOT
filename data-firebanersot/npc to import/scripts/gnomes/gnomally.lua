local talkState = {}

local t = {
	  [18343] = {price = 50, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18313] = {price = 1000, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18219] = {price = 50, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18213] = {price = 50, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18213] = {price = 50, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18344] = {price = 150, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  [18328] = {price = 50, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
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
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if not npcHandler:isFocused(cid) then
		if msg == "hi" or msg == "hallo" or msg == "hello" then
			if getPlayerStorageValue(cid, 51234) == 2 then
				npcHandler:say("Oh, hallo! Ich bin der Gnome-Mensch Beziehungs Assistent. Ich tausche Deine Tokens gegen {Equipment}, versoge Dich mit Missions {Items} und rede mit Dir über Deine {Beziehung} zu uns Gnomen! Außerdem tausche ich Teile von {Statuen} ein.", cid)
				talkState[talkUser] = 0
				npcHandler:addFocus(cid)
			else
				npcHandler:say("Du scheinst neu hier zu sein. Sprich am besten erstmal mit Gnomette!", cid)
			end
			return true
		else
			return false
		end
	end
	local playerRuhm = getPlayerStorageValue(cid, 51240)
	local majorToken = getPlayerItemCount(cid, 18423)
	local minorToken = getPlayerItemCount(cid, 18422)
	local shopWindow = {}
    -- items: 
    -- MINOR TOKENS
    
	-- elseif getCount(msg) ~= -1 then
        
	if msg == "job" or msg == "beruf" then
		npcHandler:say("Ich bin der Gnome-Mensch Beziehungs Assistent. Ich tausche Deine {Tokens} gegen {Equipment}, versoge Dich mit Missions {Items} und rede mit Dir über Deine {Beziehung} zu uns Gnomen! Außerdem tausche ich Teile von {Statuen} ein.",cid)
		talkState[talkUser] = 0
	
	---------- JA ANFANG -------------
	
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 1 then
		for var, ret in pairs(t) do
			table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
		end
		openShopWindow(cid, shopWindow, onBuy, onSell) 
		npcHandler:say('Dann lass doch mal sehen, ob ich habe, was Du brauchst.', cid)
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 3 then
		npcHandler:say("Wie viele Tokens willst Du eintauschen?", cid)
		talkState[talkUser] = 5
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 6 then
		local minorNumber = getPlayerStorageValue(cid, 51239)
		if getPlayerItemCount(cid, 18422) >= minorNumber then
			doPlayerRemoveItem(cid, 18422, minorNumber)
			setPlayerStorageValue(cid, 51240, playerRuhm + minorNumber*5)
			npcHandler:say("Wie Du wünscht! Dein Ruhm ist nun ".. playerRuhm+minorNumber*5 .. ".", cid)
			if playerRuhm+minorNumber*5 >= 30 and getPlayerStorageValue(cid, 51235) == -1 then
				setPlayerStorageValue(cid, 51235, 1)
			end
			if playerRuhm+minorNumber*5 >= 120 and getPlayerStorageValue(cid, 51236) == -1 then
				setPlayerStorageValue(cid, 51236, 1)
			end
			if playerRuhm+minorNumber*5 >= 480 and getPlayerStorageValue(cid, 51237) == -1 then
				setPlayerStorageValue(cid, 51237, 1)
			end
			if playerRuhm+minorNumber*5 >= 1440 and getPlayerStorageValue(cid, 51238) == -1 then
				setPlayerStorageValue(cid, 51238, 1)
			end
			
		else
			npcHandler:say("Du hast nicht so viele Tokens!", cid)
		end
		setPlayerStorageValue(cid, 51239, -1)
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 7 then
		if getPlayerItemCount(cid, 18501) >= 1 and getPlayerItemCount(cid,18502) >= 1 and getPlayerItemCount(cid, 18503) >= 1 then
			doPlayerRemoveItem(cid, 18501, 1)
			doPlayerRemoveItem(cid, 18502, 1)
			doPlayerRemoveItem(cid, 18503, 1)
			doPlayerAddItem(cid, 18504, 1)
			npcHandler:say("Wie Du wünscht!", cid)
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 8 then
		if getPlayerItemCount(cid, 18505) >= 1 and getPlayerItemCount(cid,18506) >= 1 and getPlayerItemCount(cid, 18507) >= 1 then
			doPlayerRemoveItem(cid, 18505, 1)
			doPlayerRemoveItem(cid, 18506, 1)
			doPlayerRemoveItem(cid, 18507, 1)
			doPlayerAddItem(cid, 18508, 1)
			npcHandler:say("Wie Du wünscht!", cid)
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 9 then
		if getPlayerItemCount(cid, 18497) >= 1 and getPlayerItemCount(cid,18498) >= 1 and getPlayerItemCount(cid, 18499) >= 1 then
			doPlayerRemoveItem(cid, 18497, 1)
			doPlayerRemoveItem(cid, 18498, 1)
			doPlayerRemoveItem(cid, 18499, 1)
			doPlayerAddItem(cid, 18500, 1)
			npcHandler:say("Wie Du wünscht!", cid)
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 11 then
		if minorToken >= 2 then
			doPlayerRemoveItem(cid, 18422, 2)
			doPlayerAddItem(cid, 18215, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 12 then
		if minorToken >= 10 then
			doPlayerRemoveItem(cid, 18422, 10)
			doPlayerAddItem(cid, 18509, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 13 then
		if minorToken >= 8 then
			doPlayerRemoveItem(cid, 18422, 8)
			doPlayerAddItem(cid, 18395, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 14 then
		if minorToken >= 15 then
			doPlayerRemoveItem(cid, 18422, 15)
			doPlayerAddItem(cid, 18388, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 15 then
		if minorToken >= 15 then
			doPlayerRemoveItem(cid, 18422, 15)
			doPlayerAddItem(cid, 18393, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 16 then
		if minorToken >= 70 then
			doPlayerRemoveItem(cid, 18422, 70)
			doPlayerAddItem(cid, 18521, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 17 then
		if minorToken >= 70 then
			doPlayerRemoveItem(cid, 18422, 70)
			doPlayerAddItem(cid, 18518, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Minor Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 18 then -- Gill Gugel
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18398, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 19 then -- Gill Coat
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18399, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 20 then -- Gill Legs
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18400, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 21 then -- Spellbook of Vigilance
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18401, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 22 then -- Prismatic Helmet
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18403, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 23 then -- Prismatic Armor
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18404, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 24 then -- Prismatic Legs
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18405, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 25 then -- Prismatic Boots
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18406, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 26 then -- Prismatic Shield
		if majorToken >= 10 then
			doPlayerRemoveItem(cid, 18423, 10)
			doPlayerAddItem(cid, 18410, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 27 then -- Crystal Warlord Outfit
		if majorToken >= 20 then
			doPlayerRemoveItem(cid, 18423, 20)
			doPlayerAddItem(cid, 18520, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 28 then -- Soil Guardian Outfit
		if majorToken >= 20 then
			doPlayerRemoveItem(cid, 18423, 20)
			doPlayerAddItem(cid, 18517, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 29 then -- Iron Loadstone
		if majorToken >= 20 then
			doPlayerRemoveItem(cid, 18423, 20)
			doPlayerAddItem(cid, 18447, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
	elseif (msg == "yes" or msg == "ja") and talkState[talkUser] == 30 then -- Glow Wine
		if majorToken >= 20 then
			doPlayerRemoveItem(cid, 18423, 20)
			doPlayerAddItem(cid, 18448, 1)
			npcHandler:say("Hier, bitte sehr.", cid)
		else
			npcHandler:say("Es tut mir leid, aber Du hast nicht genug Major Tokens dabei.", cid)
		end
		talkState[talkUser] = 0
		
	------ JA ENDE --------
		
	elseif msgcontains(msg, "item") then
		npcHandler:say("Brauchst Du irgendwelche Missions Items?", cid)
		talkState[talkUser] = 1
	elseif msg == "beziehung" then
		npcHandler:say(
		{
			"Unser Verhältnis verbessert sich mit jeder Mission, die Du absolvierst. Ein weiterer Weg, um Dein Ansehen zu verbessern, ist Minor Tokens einzulösen. ...",
			"Dein Ruhm unter uns ist zur Zeit " .. playerRuhm .. ". Willst Du ihn verbessern indem Du Tokens aufopferst? Ein Token ist 5 Ruhm wert."
		},cid)
		talkState[talkUser] = 3
	elseif getCount(msg) ~= -1 and talkState[talkUser] == 5 then
		local minor = getCount(msg)
		if minor > getPlayerItemCount(cid, 18422) then
			npcHandler:say("Du hast nicht so viele Tokens!", cid)
			talkState[talkUser] = 0
		else
			npcHandler:say("Willst Du wirklich " ..minor.. " Minor Tokens für " ..minor*5 .. " Ruhm eintauschen?", cid)
			setPlayerStorageValue(cid, 51239, minor)
			talkState[talkUser] = 6
		end
	elseif msg == "equipment" then
		npcHandler:say("Du kannst verschiedene Dinge für Minor und Major Tokens kaufen. Also, an welchem Equipment bist Du interessiert, das für {Minor} oder das für {Major} Tokens?", cid)
		talkState[talkUser] = 2
	elseif msg == "minor" and talkState[talkUser] == 2 then
		npcHandler:say(
		{
			"Für zwei minor Tokens kannst Du ein Gnomish {Supply} Paket kaufen! Für acht Tokens bekommst Du einen {Muck} Remover! Für zehn Tokens gibt es einen {Mission} Crystal. Für 15 Tokens kannst Du eine Crystal {Lampe} oder ein Mushroom {Backpack} kaufen. ...",
			"Für 70 Tokens kann ich Dir einen Gutschein für entweder das {Soil Guardian Addon} oder das {Crystal Warlord Addon} geben."
		},cid)
		talkState[talkUser] = 0
	elseif msg == "major" and talkState[talkUser] == 2 then
		npcHandler:say(
		{
			"Für zehn Major Tokens kann ich Dir einen {Gill Gugel}, eine {Gill Coat}, {Gill Legs}, ein {Spellbook} of Vigilance, einen {Prismatic Helmet}, eine {Prismatic Armor}, {Prismatic Legs}, {Prismatic Boots} oder ein {Prismatic Shield} anbieten ...",
			"Für 20 Major Tokens kann ich Dir das Basis {Soil Guardian Outfit}, das Basis {Crystal Warlord Outfit}, einen {Iron Loadstone} oder {Glow Wine} anbieten."
		},cid)
		talkState[talkUser] = 0
	elseif msg == "statue" then
		npcHandler:say("Ah, Du hast ein paar Teile einer Statue und willst, dass ich sie zusammen bastel? Welche soll ich zusammenbauen: {Deathstrike}, {Gnomevil} oder {Abyssador}?", cid)
		talkState[talkUser] = 4
	elseif msg == "deathstrike"	and talkState[talkUser] == 4 then
		if getPlayerItemCount(cid, 18501) >= 1 and getPlayerItemCount(cid,18502) >= 1 and getPlayerItemCount(cid, 18503) >= 1 then
			npcHandler:say("Ah, sehr schön, Du hast alle Teile von Deathstrike's Statue gefunden. Willst Du, dass ich sie für Dich zusammensetze? {Ja} oder {Nein}?", cid)
			talkState[talkUser] = 7
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
			talkState[talkUser] = 0
		end
	elseif msg == "gnomevil" and talkState[talkUser] == 4 then
		if getPlayerItemCount(cid, 18505) >= 1 and getPlayerItemCount(cid,18506) >= 1 and getPlayerItemCount(cid, 18507) >= 1 then
			npcHandler:say("Ah, sehr schön, Du hast alle Teile von Gnomevil's Statue gefunden. Willst Du, dass ich sie für Dich zusammensetze? {Ja} oder {Nein}?", cid)
			talkState[talkUser] = 8
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
			talkState[talkUser] = 0
		end
	elseif msg == "abyssador" and talkState[talkUser] == 4 then
		if getPlayerItemCount(cid, 18497) >= 1 and getPlayerItemCount(cid,18498) >= 1 and getPlayerItemCount(cid, 18499) >= 1 then
			npcHandler:say("Ah, sehr schön, Du hast alle Teile von Abyssador's Statue gefunden. Willst Du, dass ich sie für Dich zusammensetze? {Ja} oder {Nein}?", cid)
			talkState[talkUser] = 9
		else
			npcHandler:say("Ohne die benötigten Teile kann ich die Statue nicht zusammenbauen. Bring mir die Teile und Du bekommst Deine Statue." ,cid)
			talkState[talkUser] = 0
		end
	elseif msg == "supply" then
		npcHandler:say("Willst Du ein Gnomish Supply Paket für zwei Tokens eintauschen?", cid)
		talkState[talkUser] = 11
	elseif msg == "mission" then
		npcHandler:say("Willst du einen Missions Crystal für zehn Tokens eintauschen? Er wird jedes mal benötigt, wenn Du eine der Warzones betreten willst, um ihre fürchterlichen Kreaturen zu duellieren und vielleicht sogar ihren bösen Meister.", cid)
		talkState[talkUser] = 12
	elseif msg == "muck" then
		npcHandler:say("Willst Du einen Muck Remover für acht Tokens eintauschen? Du brauchst ihn, um Gegenstände aus den dreckigen Objekten zu bekommen, die manchmal in Finsteren Ebenen gefunden werden.", cid)
		talkState[talkUser] = 13
	elseif msg == "lamp" then
		npcHandler:say("Willst Du eine Crystal Lampe für 15 Tokens eintauschen? Sie ist eine schöne Dekoration für jedes Haus.", cid)
		talkState[talkUser] = 14
	elseif msg == "backpack" then
		npcHandler:say("Willst Du eine Mushroom Backpack für 15 Tokens eintauschen? Es ist eine fantastisch aussehende Version eines gewöhnlichen Backpacks.", cid)
		talkState[talkUser] = 15
	elseif msg == "crystal warlord addon" then
		npcHandler:say("Willst Du einen Gutschein für das Crystal Warlord Addon für 70 Tokens eintauschen?", cid)
		talkState[talkUser] = 16
	elseif msg == "soil guardian addon" then
		npcHandler:say("Willst Du einen Gutschein für das Soil Guardian Addon für 70 Tokens eintauschen?", cid)
		talkState[talkUser] = 17
	elseif msg == "gill gugel" then
		npcHandler:say("Willst Du einen Gill Gugel für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 18
	elseif msg == "gill coat" then
		npcHandler:say("Willst Du einen Gill Coat für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 19
	elseif msg == "gill legs" then
		npcHandler:say("Willst Du Gill Legs für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 20
	elseif msg == "spellbook" then
		npcHandler:say("Willst Du einen Spellbook of Vigilance für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 21
	elseif msg == "prismatic helmet" then
		npcHandler:say("Willst Du einen Prismatic Helmet für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 22
	elseif msg == "prismatic armor" then
		npcHandler:say("Willst Du eine Prismatic Armor für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 23
	elseif msg == "prismatic legs" then
		npcHandler:say("Willst Du Prismatic Legs für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 24
	elseif msg == "prismatic boots" then
		npcHandler:say("Willst Du Prismatic Boots für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 25
	elseif msg == "prismatic shield" then
		npcHandler:say("Willst Du ein Prismatic Shield für 10 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 26
	elseif msg == "crystal warlord outfit" then
		npcHandler:say("Willst Du einen Gutschein für das Crystal Warlord Outfit für 20 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 27
	elseif msg == "soil guardian outfit" then
		npcHandler:say("Willst Du einen Gutschein für das Soil Guardian Outfit für 20 Major Tokens eintauschen?", cid)
		talkState[talkUser] = 28
	elseif msg == "iron loadstone" then
		npcHandler:say("Willst Du einen Iron Loadstone für 20 Major Tokens eintauschen? Man kann damit einen Ironblight tamen", cid)
		talkState[talkUser] = 29
	elseif msg == "glow wine" then
		npcHandler:say("Willst Du einen Glow Wine für 20 Major Tokens eintauschen? Man kann damit einen Magma Crawler tamen", cid)
		talkState[talkUser] = 30
	elseif talkState[talkUser] == 5 then
		npcHandler:say("Ich habe gefragt, wie viele Minor Tokens Du eintauschen willst?", cid)
		talkState[talkUser] = 5
	elseif talkState[talkUser] ~= 0 then
		npcHandler:say("Wie Du meinst.", cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "bye") then
		npcHandler:say("Bye.", cid)
		npcHandler:releaseFocus(cid)
	end
	
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

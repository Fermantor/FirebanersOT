local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local FoodValue = 51234
local t = {
	  [18457] = {price = 150, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
	  }
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
	if getPlayerMoney(cid) < t[item].price*amount then
		selfSay("Es tut mir leid, aber Du hast nicht genug Geld.", cid)
	else
		doPlayerAddItem(cid, item, amount)
		doPlayerRemoveMoney(cid, t[item].price*amount)
		doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für " .. t[item].price*amount .. " Gold gekauft.")
	end
	return true
end

npcHandler:setCallback(CALLBACK_FAREWELL, creatureFarewell)
npcHandler:setCallback(CALLBACK_CREATURE_DISAPPEAR, creatureFarewell)
npcHandler:addModule(FocusModule:new())

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

function xelvarTrade(cid, message, keywords, parameters, node)
	local shopWindow = {}
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if getPlayerStorageValue(cid, 51234) == -1 then
		npcHandler:say('Einen Handel? Aber warum denn?', cid)
	else
		for var, ret in pairs(t) do
			table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
		end
		openShopWindow(cid, shopWindow, onBuy, onSell) 
		npcHandler:say('Hier ist mein Angebot. Es ist nicht groß, aber es erfüllt seinen Zweck.', cid)
	end
	return true
end

function xelvarJoin(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	if getPlayerLevel(cid) >= 80 then
		if getPlayerStorageValue(cid, 51234) == -1 then
			npcHandler:say(
			{
				'Ich bin froh das zu hören. In gedenken an unsere eigene Legion, haben wir den Gnomen vorgeschlagen, Helden wie dich auszubilden, für eine neue Art von Armee. Sie gaben mir diese komischen Kristalle, damit Leute in ihr Reich reisen können. ...',
				'Ich erteile dir hiermit die Erlaubnis, die Basis Teleporter der Gnome zu benutzen. Ich gebe dir zusätzlich vier teleport Kristalle. Einer wird jedes mal verbraucht, wenn du einen Teleporter benutzt. ...',
				'Du kannst jederzeit neue bei mir kaufen. Frag mich einfach nach einem {trade}. Gnomette in der Teleportkammer verkauft sie ebenso. ...',
				'Der Teleporter hier, bringt dich zu einem, der größeren gnomischen Außenposten. ...',
				'Dort wirst du Gnomerik treffen, den Leiter für Rekrutierungen. Falls du dich verläufst, wird dir Gnomette behilflich sein. ...',
				'Viel Glück und mach deiner Rasse daunten keine Schande! Bedenke, dass du ein Repräsentant der großen Leute bist.'
			}, cid)
			doPlayerAddItem(cid, 18457, 4)
			setPlayerStorageValue(cid, 51234, 1)
		else
			npcHandler:say('Du bist uns schon beigetreten!', cid)
		end
	else
		npcHandler:say(
		{
			'Es tut mir leid, aber du bist noch zu unerfahren, um den Gnomen jetzt hilfreich zu sein. ...',
			'Erlebe noch ein paar Arbenteuer und komm dann später zu mir zurück. Es wird sicher nicht mehr lange dauern, bis du ein annehmbarer Rekrut bist. Wenn du Level 80, oder höher bist.'
		}, cid)
	end
end

local node1 = keywordHandler:addKeyword({'join'}, xelvarJoin, {npcHandler = npcHandler, onlyFocus = true, reset = true})
npcHandler:addModule(FocusModule:new())

local node2 = keywordHandler:addKeyword({'trade'}, xelvarTrade, {npcHandler = npcHandler, onlyFocus = true})





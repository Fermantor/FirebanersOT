local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	local shopWindow = {}
	local t = {
          [2195] = {price = 15, price2 = 10}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
          [2493] = {price = 25, price2 = 0},
          [2361] = {price = 30, price2 = 0},
          [8851] = {price = 20, price2 = 0},
          [8925] = {price = 30, price2 = 0},
          [2640] = {price = 50, price2 = 0},
          [2494] = {price = 100, price2 = 0},
          [9932] = {price = 50, price2 = 0},
          [2472] = {price = 70, price2 = 0},
          [8931] = {price = 100, price2 = 0}
          }
	local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		if getPlayerMoney(cid) < t[item].price*amount then
			selfSay("Sorry, du hast nicht genug Geld.", cid)
		else
			doPlayerAddItem(cid, item, amount)
			doPlayerRemoveMoney(cid, t[item].price*amount)
			doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für " .. t[item].price*amount .. " Gold gekauft.")
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
	
	
	if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
		for var, ret in pairs(t) do
			table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
		end
		openShopWindow(cid, shopWindow, onBuy, onSell) 
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
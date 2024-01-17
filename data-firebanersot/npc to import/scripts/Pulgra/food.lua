local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addBuyableItem({'meat'}, 2666, 5, 1,'meat')
shopModule:addBuyableItem({'ham'}, 2671, 8, 1, 'ham')
shopModule:addBuyableItem({'dragon ham'}, 2672, 25, 1, 'dragon ham')

shopModule:addSellableItem({'meat'}, 2666, 2, 'meat')
shopModule:addSellableItem({'dragon ham'}, 2672, 10, 'dragon ham')
shopModule:addSellableItem({'ham'}, 2671, 4, 'ham')

local voices = {
	{text = "Essen. Essen! ESSEN!"},
	{text = "Feinstes Fleisch. Nur die erlesenste Ware!"},
	{text = "Frisches Dragon Ham von heute erlegten Drachen!"},
	{text = "Vegetarier haben hier nichts verloren."}
}

npcHandler:addModule(VoiceModule:new(voices))

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Mein job ist es, dafür zu sorgen, dass in Pulgra niemand verhungert. Das ist simpel, aber nicht unwichtig. Falls du Fleisch brauchst, frag mich nach einem {trade}.',cid)
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

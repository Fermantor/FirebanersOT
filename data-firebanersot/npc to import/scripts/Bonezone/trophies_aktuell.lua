local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_GREET, 'Lust auf eine Trophäe, oder lieber eine verkaufen, |PLAYERNAME|?')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Trophäen sind mein Spezialgebiet.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Dann kriegste eben keine.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Komm wieder, |PLAYERNAME|.')

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'behemoth trophy'}, 7396, 20000,'behemoth trophy')
shopModule:addSellableItem({'bonebeast trophy'}, 11161, 6000,'bonebeast trophy')
shopModule:addSellableItem({'cyclops trophy'}, 7398, 500,'cyclops trophy')
shopModule:addSellableItem({'deer trophy'}, 7397, 3000,'deer trophy')
shopModule:addSellableItem({'demon trophy'}, 7393, 40000,'demon trophy')
shopModule:addSellableItem({'disgusting trophy'}, 11338, 3000,'disgusting trophy')
shopModule:addSellableItem({'dragon lord trophy'}, 7399, 10000,'dragon lord trophy')
shopModule:addSellableItem({'lion trophy'}, 7400, 3000,'lion trophy')
shopModule:addSellableItem({'lizard trophy'}, 11336, 8000,'lizard trophy')
shopModule:addSellableItem({'minotaur trophy'}, 7401, 500,'minotaur trophy')
shopModule:addSellableItem({'wolf trophy'}, 7394, 3000,'wolf trophy')
shopModule:addSellableItem({'orc trophy'}, 7395, 1000,'orc trophy')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Trophäen! TROPHÄEN! Das ist mein Beruf! Ich kaufe aber nur welche. Sie sind mir viel zu wertvoll, als das ich sie wieder weggeben möchte, meine kleinen Babys.',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Direkt nebenan in dem hohen Haus lebt Xantharus. Er verkauft schon sein Leben lang Vials.', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

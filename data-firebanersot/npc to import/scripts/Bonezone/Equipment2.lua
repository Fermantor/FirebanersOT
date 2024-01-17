local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'baking tray'}, 2561, 20, 1,'baking tray')
shopModule:addBuyableItem({'kitchen knife'}, 2566, 10, 1,'kitchen knife')
shopModule:addBuyableItem({'cleaver'}, 2568, 30, 1,'cleaver')

shopModule:addBuyableItem({'pan'}, 2563, 20, 1,'pan')
shopModule:addBuyableItem({'plate'}, 2035, 6, 1,'plate')
shopModule:addBuyableItem({'spoon'}, 2565, 10, 1,'spoon')
shopModule:addBuyableItem({'wooden spoon'}, 2567, 5, 1,'wooden spoon')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Joa, ich verkauf dir alles, was du zum Kochen so brauchst. Allerdings stellt mein Mann {Torix} die Sachen her, davon hab ich nämlich keine Ahnung.',cid)
	end
	if msgcontains(msg, 'auswahl') then
		npcHandler:say('Ja, das macht dich neugierig, nicht? Frag doch einfach nach nem {trade} um dir meine Auswahl anzusehen.',cid)
	end
	if msgcontains(msg, 'Torix') then
		npcHandler:say('Seit 22 Jahren gebe ich mich mit ihm schon ab. Aber naja, ich will mich nicht beklagen. Er hat ein schönes Vermögen. Geh ihn doch mal besuchen und frag ihn nach einer {mission}.',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Xantharus in Little Cotton, hier unter Bonezone, verkauft Vials. Bitte sehr.', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

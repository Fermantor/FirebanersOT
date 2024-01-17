local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Willst du ein Pl�uschen halten? Dann geh zu Elyee, der Potionsverk�uferin. Sie ist genau die richtige daf�r. Ich bin nur hier f�r den Versand. Der N�chste, bitte.',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Xantharus in Little Cotton. H�r auf meine Zeit zu verschwenden. Der N�chste!', cid)
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

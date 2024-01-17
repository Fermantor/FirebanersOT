local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_GREET, 'Hier solltest du dich besser nicht aufhalten, es ist viel zu {gefährlich}!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ganz recht so! Hau lieber ab, oder es wird dir noch übel ergehen.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Mach, dass du hier weg kommst!')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Mein Job ist jetzt nicht so wichtig. Sieh lieber zu, dass du so schnell wie möglich hier weg kommst. Hier ist es viel zu {gefährlich}!',cid)
	elseif msgcontains(msg, 'gefährlich') then
		npcHandler:say('Meine Güte, muss ich dir das auch noch erklären? Du befindest dich hier in {Formak}, einem der gefährlichsten Orte auf ganz Fireban. Ich werde nicht zulassen, dass du das selbe Schicksal erleidest, wie viele andere vor dir. DIESER WEG IST GESPERRT!', cid)
	elseif msgcontains(msg, 'formak') then
		npcHandler:say('Je länger du dich hier mit mir unterhälst, desto wahrscheinlicher wirst du sterben. Formak ist die Höhle, in der du dich hier befindest. Doch du ahnst nicht, auf was für Kreaturen du hier treffen wirst. Also verschwinde lieber, ich werde dich nicht vorbeilassen!', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_GREET, 'Hier solltest du dich besser nicht aufhalten, es ist viel zu {gef�hrlich}!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ganz recht so! Hau lieber ab, oder es wird dir noch �bel ergehen.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Mach, dass du hier weg kommst!')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Mein Job ist jetzt nicht so wichtig. Sieh lieber zu, dass du so schnell wie m�glich hier weg kommst. Hier ist es viel zu {gef�hrlich}!',cid)
	elseif msgcontains(msg, 'gef�hrlich') then
		npcHandler:say('Meine G�te, muss ich dir das auch noch erkl�ren? Du befindest dich hier in {Formak}, einem der gef�hrlichsten Orte auf ganz Fireban. Ich werde nicht zulassen, dass du das selbe Schicksal erleidest, wie viele andere vor dir. DIESER WEG IST GESPERRT!', cid)
	elseif msgcontains(msg, 'formak') then
		npcHandler:say('Je l�nger du dich hier mit mir unterh�lst, desto wahrscheinlicher wirst du sterben. Formak ist die H�hle, in der du dich hier befindest. Doch du ahnst nicht, auf was f�r Kreaturen du hier treffen wirst. Also verschwinde lieber, ich werde dich nicht vorbeilassen!', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

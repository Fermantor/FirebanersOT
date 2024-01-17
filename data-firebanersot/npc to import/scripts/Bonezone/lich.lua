local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)                 npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                             npcHandler:onThink() end
 
function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) and npcHandler:isInRange(cid) and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'hallo')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) <= 1 then
			npcHandler:greet(cid)
			return TRUE
		else
			npcHandler:say('Auuuch ich habe Kräfte! Verschwinde, oder ich benuutze sie gegen dich!', cid)
			return false
		end	
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Duu fragst was mein Beruuf ist? Nuun, es gibt nicht mehr viele Krieger, die hier vorbeischauen. Deswegen ist mein Beruuf fast überflüssig, aber wie duu siehst befindet sich vor meinem Hügel die Höhle der Untoten, auch Skeleton Cave genannt. ...',
						'Nuun, ich bin der Wächter dieser Höhle, und entscheide über jene, welche es wert sind diesen Eingang zu benuutzen und sich den Weg zuu meiner ehrvollsten Königen zuu kämpfen, um mit ihr reden zuu können. ...',
						'Wenn duu bereit bist dich zuu beweisen und zu unterwerfen, dann könnte ich dir den Eingang gewähren und dir erlauben mal mit meiner Königin Hepzibah zuu reden, um sie nach einen Beitritt zuu fragen.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'skeleton cave') then
		npcHandler:say('In dieser Höhle haust meine Königin Hepzibah, doch sie ist nicht einfach zuu erreichen. Duu muusst bis auf die letzte Ebene, um zuu ihr zuu gelangen. Duu möchtest wahrscheinlich, dass ich dir den {Zuugang} zuu ihr gewähre.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'hepzibah') then
		npcHandler:say({'Meine Königin Hepzibah lebt ganz unten in der Skeleton Cave und sorgt sich um alle Kreaturen auf Fireban. Sie ist soo edel und anmuutig, dass sie jedem Besuucher die Sprache verschlägt, und das wort wörtlich. ...',
						'Es gibt keine andere Person, der ich dienen möchte. Man kommt eben nur mit Qualen und Leiden voran. Wenn du ebenfalls diese Meinung vertrittst, dann muusst duu dich uns anschließen. UNS, nicht Striphin und ihrem Naturpack.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say({'Sie ist die verdorbene Schwester meiner Königin Hepzibah, und versuucht, dass unwichtige Gleichgewicht der Natuur beisamen zuu halten. Ich verabscheue sie, seit sie sich mit meiner Königin zerstritten hat. ...',
						'Wenn duu dich ihr anschließt, bist duu für uns genauso ein Feind wie sie es ist.'},cid)
		talkState[talkUser] = 0
	elseif (msgcontains(msg, 'beitritt') or msgcontains(msg, 'zuugang') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschließen') or msgcontains(msg, 'join')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == -1 then
			if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin) ~= 2 then
				npcHandler:say({'Ahh, duu willst dich uns anschließen. Dann muuss ich dich aber warnen. In unserer Gemeinschaft gibt es kein verzeihen oder vergessen, Bestrafuung und Folter gelten hier als Züchtiguungsmittel. ...',
								'Also, möchtest duu, dass ich meiner Königin bescheid sage, dass duu dich mit ihr unterhalten darfst? Denn sobald duu schwörst ihr zuu dienen, gibt es keine andere Möglichkeit mehr.'},cid)
				talkState[talkUser] = 1
			else
				npcHandler:say('UUUNHEIL! Duu bist Teil von Striphins Armee. Avada Keda...', cid)
				talkState[talkUser] = 0
			end
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 1 then
			npcHandler:say('Wie gesagt, duu hast nuuun die Wahl: Entweder duuu schließt dich meiner Herrscherin Hepzibah an, welche dich bereits erwartet, oder duuu machssst dich zuuum Feind uund gehst auf Striphins Seite. Entscheide kluuuuug!', cid)
		else
			npcHandler:say('Was meinst duuu damit? Duuu bist doch bereits Teil unserer Armee. Oder hegst duuu etwa Misstrauen?', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Sehr guut! Also nuur um das nochmal klar zuu stellen. Bei mir verpflichtest duu dich noch zuu gar nichts, erst wenn duu dich mit meiner Königin unterhälst.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 1) -- 1. Tür
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionQuestLog, 1) -- Questlog Fraktionen
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah, 1) -- Questlog Hepzibah anschließen
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Mach dich nicht zuum Feind!', cid)
			talkState[talkUser] = 0
		end
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
--npcHandler:addModule(FocusModule:new())
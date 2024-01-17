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
			npcHandler:say('Auuuch ich habe Kr�fte! Verschwinde, oder ich benuutze sie gegen dich!', cid)
			return false
		end	
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Duu fragst was mein Beruuf ist? Nuun, es gibt nicht mehr viele Krieger, die hier vorbeischauen. Deswegen ist mein Beruuf fast �berfl�ssig, aber wie duu siehst befindet sich vor meinem H�gel die H�hle der Untoten, auch Skeleton Cave genannt. ...',
						'Nuun, ich bin der W�chter dieser H�hle, und entscheide �ber jene, welche es wert sind diesen Eingang zu benuutzen und sich den Weg zuu meiner ehrvollsten K�nigen zuu k�mpfen, um mit ihr reden zuu k�nnen. ...',
						'Wenn duu bereit bist dich zuu beweisen und zu unterwerfen, dann k�nnte ich dir den Eingang gew�hren und dir erlauben mal mit meiner K�nigin Hepzibah zuu reden, um sie nach einen Beitritt zuu fragen.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'skeleton cave') then
		npcHandler:say('In dieser H�hle haust meine K�nigin Hepzibah, doch sie ist nicht einfach zuu erreichen. Duu muusst bis auf die letzte Ebene, um zuu ihr zuu gelangen. Duu m�chtest wahrscheinlich, dass ich dir den {Zuugang} zuu ihr gew�hre.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'hepzibah') then
		npcHandler:say({'Meine K�nigin Hepzibah lebt ganz unten in der Skeleton Cave und sorgt sich um alle Kreaturen auf Fireban. Sie ist soo edel und anmuutig, dass sie jedem Besuucher die Sprache verschl�gt, und das wort w�rtlich. ...',
						'Es gibt keine andere Person, der ich dienen m�chte. Man kommt eben nur mit Qualen und Leiden voran. Wenn du ebenfalls diese Meinung vertrittst, dann muusst duu dich uns anschlie�en. UNS, nicht Striphin und ihrem Naturpack.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say({'Sie ist die verdorbene Schwester meiner K�nigin Hepzibah, und versuucht, dass unwichtige Gleichgewicht der Natuur beisamen zuu halten. Ich verabscheue sie, seit sie sich mit meiner K�nigin zerstritten hat. ...',
						'Wenn duu dich ihr anschlie�t, bist duu f�r uns genauso ein Feind wie sie es ist.'},cid)
		talkState[talkUser] = 0
	elseif (msgcontains(msg, 'beitritt') or msgcontains(msg, 'zuugang') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschlie�en') or msgcontains(msg, 'join')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == -1 then
			if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin) ~= 2 then
				npcHandler:say({'Ahh, duu willst dich uns anschlie�en. Dann muuss ich dich aber warnen. In unserer Gemeinschaft gibt es kein verzeihen oder vergessen, Bestrafuung und Folter gelten hier als Z�chtiguungsmittel. ...',
								'Also, m�chtest duu, dass ich meiner K�nigin bescheid sage, dass duu dich mit ihr unterhalten darfst? Denn sobald duu schw�rst ihr zuu dienen, gibt es keine andere M�glichkeit mehr.'},cid)
				talkState[talkUser] = 1
			else
				npcHandler:say('UUUNHEIL! Duu bist Teil von Striphins Armee. Avada Keda...', cid)
				talkState[talkUser] = 0
			end
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 1 then
			npcHandler:say('Wie gesagt, duu hast nuuun die Wahl: Entweder duuu schlie�t dich meiner Herrscherin Hepzibah an, welche dich bereits erwartet, oder duuu machssst dich zuuum Feind uund gehst auf Striphins Seite. Entscheide kluuuuug!', cid)
		else
			npcHandler:say('Was meinst duuu damit? Duuu bist doch bereits Teil unserer Armee. Oder hegst duuu etwa Misstrauen?', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Sehr guut! Also nuur um das nochmal klar zuu stellen. Bei mir verpflichtest duu dich noch zuu gar nichts, erst wenn duu dich mit meiner K�nigin unterh�lst.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 1) -- 1. T�r
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionQuestLog, 1) -- Questlog Fraktionen
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah, 1) -- Questlog Hepzibah anschlie�en
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
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local Skulls = {3,4,5}
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
	if msgcontains(msg, 'job') then
		npcHandler:say("Ich bin der Druide dieses Waldes, und hüte die Natur vor dem Bösen. Ich kaufe Tierprodukte, frage einfach nach einem {trade}. Zusätzlich gebe ich auch noch {tasks}.", cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'task') then
		if getPlayerStorageValue(cid, 20001) >= 85 then
			setPlayerStorageValue(cid, 20001, 1)
			talkState[talkUser] = 0
			doPlayerAddExp(cid, 750, false, true)
			npcHandler:say("Herrvorragend, du hast genug Bären getötet, hier ist deine Belohnung. Nun geh und suche Whinne in seinem Bau unter dem Bear Berg um ihn zu töten.", cid)
		elseif getPlayerStorageValue(cid, 20002) >= 110 then
			setPlayerStorageValue(cid, 20002, 1)
			talkState[talkUser] = 0
			doPlayerAddExp(cid, 1000, false, true)
			npcHandler:say("Herrvorrangend, du hast genug Wölfe getötet, hier ist deine Belohnung. Nun geh und suche Canire bei seinem Wolfsrudel, um ihn zu töten.", cid)
		elseif getPlayerStorageValue(cid, 20001) == 2 then
			setPlayerStorageValue(cid, 20001, 3)
			talkState[talkUser] = 0
			doPlayerAddExp(cid, 500, false, true)
			npcHandler:say("Wahnsinn, du hast es wirklich geschafft. Damit hast du dir den zweiten Teil der Belohnung verdient. Ich hoffe jetzt herrscht wieder ein Gleichgewicht in der Natur.", cid)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, 20002) == 2 then
			setPlayerStorageValue(cid, 20002, 3)
			talkState[talkUser] = 0
			doPlayerAddExp(cid, 750, false, true)
			npcHandler:say("Wahnsinn, du hast es wirklich geschafft. Damit hast du dir den zweiten Teil der Belohnung verdient. Ich hoffe jetzt herrscht wieder ein Gleichgewicht in der Natur.", cid)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say("Ich habe zwei verschiedene Tasks anzubieten. Einmal {Wolves} und einmal {Bears}.", cid)
			talkState[talkUser] = 1
		end
	elseif msgcontains(msg, 'bear') or msgcontains(msg, 'bears') or msgcontains(msg, 'bär') then
		if talkState[talkUser] == 1 and (getPlayerStorageValue(cid, 20001) <= 0 or getPlayerStorageValue(cid, 20001) == 3) then
			npcHandler:say("Bären ja? Es gibt einen kleinen Berg, nord-westlich von hier. Du musst 75 von ihnen töten. Interesse?", cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 1 and getPlayerStorageValue(cid, 20001) >= 10 then
			npcHandler:say('Du hast die Bären Task bereits gestartet und schon ' .. getPlayerStorageValue(cid, 20001) - 10 .. '/75 getötet. Oder willst du deine Task {abbrechen}?.', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] == 1 and getPlayerStorageValue(cid, 20001) == 1 then
			npcHandler:say('Du hast die Bären Task bereits gestartet musst nur noch den Boss töten. Oder willst du deine Task {abbrechen}?.', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Du möchtest also die Bären Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 7
		else
			npcHandler:say('Bären sind eigentlich friedliche Wesen, die sich auf einen Berg nord-westlich von hier verzogen haben.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'wolf') or msgcontains(msg, 'wolves') then
		if talkState[talkUser] == 1 and (getPlayerStorageValue(cid, 20002) <= 0 or getPlayerStorageValue(cid, 20002) == 3) then
			npcHandler:say('Wölfe, lästige kleine Biester. Jage 100 von ihnen und besiege ihren Boss, okay?', cid)
			talkState[talkUser] = 3
		elseif talkState[talkUser] == 1 and getPlayerStorageValue(cid, 20002) >= 10 then
			npcHandler:say('Du hast die Wolf Task bereits gestartet und schon ' .. getPlayerStorageValue(cid, 20002) - 10 .. '/100 getötet. Oder willst du deine Task {abbrechen}?', cid)
			talkState[talkUser] = 5
		elseif talkState[talkUser] == 1 and getPlayerStorageValue(cid, 20002) == 1 then
			npcHandler:say('Du hast die Wolf Task bereits gestartet musst nur noch den Boss töten. Oder willst du deine Task {abbrechen}?.', cid)
			talkState[talkUser] = 5
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Du möchtest also die Wolf Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 8
		else
			npcHandler:say('Wölfe, lästige kleine Biester. Sie laufen überall um Pantra herum und leben meistens in Rudeln.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 2 and (getPlayerStorageValue(cid, 20001) <= 0 or getPlayerStorageValue(cid, 20001) == 3) then
			setPlayerStorageValue(cid, 20001, 10)
			talkState[talkUser] = 0
			npcHandler:say('Okay, sehr gut. Nun geh und töte so viele Bären, wie du nur kannst. Komm wieder, wenn du es geschaft hast, oder die Task {abbrechen} willst.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 and (getPlayerStorageValue(cid, 20002) <= 0 or getPlayerStorageValue(cid, 20002) == 3) then
			setPlayerStorageValue(cid, 20002, 10)
			talkState[talkUser] = 0
			npcHandler:say('Okay, sehr gut. Nun geh und töte so viele Wölfe, wie du nur kannst. Komm wieder, wenn du es geschaft hast, oder die Task {abbrechen} willst.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Du möchtest also die Bären Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 7
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Du möchtest also die Wolf Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 8
		elseif talkState[talkUser] == 7 then
			setPlayerStorageValue(cid, 20001, -1)
			talkState[talkUser] = 0
			npcHandler:say('Nun, so sei es, die Task ist nicht länger von Bedeutung für dich. Du kannst sie aber jederzeit wieder starten. Komm einfach vorbei und frage mich nach einer {Task}.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 8 then
			setPlayerStorageValue(cid, 20002, -1)
			talkState[talkUser] = 0
			npcHandler:say('Nun, so sei es, die Task ist nicht länger von Bedeutung für dich. Du kannst sie aber jederzeit wieder starten. Komm einfach vorbei und frage mich nach einer {Task}.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 2 and getPlayerStorageValue(cid, 20001) <= 0 then
			talkState[talkUser] = 0
			npcHandler:say('Nun gut dann nicht. Verschwende dann aber auch bitte nicht meine Zeit, auf Wiedersehen.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			talkState[talkUser] = 0
			npcHandler:say('Nun gut dann nicht. Verschwende dann aber auch bitte nicht meine Zeit, auf Wiedersehen.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Gut, kann ich sonst noch etwas für dich tun?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Gut, kann ich sonst noch etwas für dich tun?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			talkState[talkUser] = 0
			npcHandler:say('Kluge Entscheidung. Und ich dachte schon...', cid)
		elseif talkState[talkUser] == 8 then
			talkState[talkUser] = 0
			npcHandler:say('Kluge Entscheidung. Und ich dachte schon...', cid)
		end
	elseif msgcontains(msg, 'abbrechen') then
		if (getPlayerStorageValue(cid, 20001) >= 1 and getPlayerStorageValue(cid, 20001) ~= 3) and (getPlayerStorageValue(cid, 20002) >= 1 and getPlayerStorageValue(cid, 20002) ~= 3) then
			npcHandler:say('Du hast sowohl die {Bären}, als auch die {Wolf} task gestartet. Welche willst du abbrechen?', cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, 20001) >= 1 and getPlayerStorageValue(cid, 20001) ~= 3 then
			npcHandler:say('Du möchtest also die Bären Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 7
		elseif getPlayerStorageValue(cid, 20002) >= 1 and getPlayerStorageValue(cid, 20002) ~= 3 then
			npcHandler:say('Du möchtest also die Wolf Task abbrechen, ja? Bist du dir da wirklich sicher?', cid)
			talkState[talkUser] = 8
		else
			npcHandler:say('Entschuldigung, aber was genau willst du abbrechen?', cid)
			talkState[talkUser] = 0
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

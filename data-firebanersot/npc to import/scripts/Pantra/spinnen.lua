local story = {}
 
local function cancelStory(cid)
	if not(story[cid]) then return true end
	for _, eventId in pairs(story[cid]) do
		stopEvent(eventId)
	end
	story[cid] = {}
end
 
function creatureFarewell(cid)
	if not(isPlayer(cid)) then return true end
	cancelStory(cid)
	return true
end

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
	cancelStory(cid)
	if msgcontains(msg, 'job') or msgcontains(msg, 'help') then
		npcHandler:say('Ich bin Nora Pox und habe mich wegen meiner Liebe zu Spinnen hier auf diesen Berg zurück gezogen. Ich sammel alles was mit {Spinnen} zu tun hat. Sag bescheid, wenn du an einem {trade} interessiert bist.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'spider') or msgcontains(msg, 'spinne') then
		npcHandler:say('Ja ich liebe einfach Spinnen. Ich kaufe alles was mit ihnen zu tun hat. Und wenn dir langweilig ist, kannst du auch einen {task} für mich erledigen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'task') then
		if getPlayerStorageValue(cid, 20000) == -1 or getPlayerStorageValue(cid, 20000) == 3 then
			npcHandler:say('Ich kann dir einen Task mit meinen lieblings Monstern anbieten. Hast du Interesse?', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, 20000) <= 159 and getPlayerStorageValue(cid, 20000) >= 10 then
			npcHandler:say('Du hast bereits die Spinnen task angefangen. Wenn du aber keine lust mehr hast, kannst du sie auch {abbrechen}.', cid)
		elseif getPlayerStorageValue(cid, 20000) == 1 then
			npcHandler:say('Du hast bereits die Spinnen task angefangen. Wenn du aber keine lust mehr hast, kannst du sie auch {abbrechen}.', cid)
		elseif getPlayerStorageValue(cid, 20000) >= 160 then
			local Text1 ='Ah, du hast also 150 Spinnen getötet, großartig. Hier ist ein Teil der Belohnung ...'
			local Text2 = 'Wenn du bereit bist, suche nun die Spinnen Königin auf und erledige sie. Sie befindet sich tief unter dem Spinnen Berg.'
			story[cid] = selfStory({Text1, Text2}, cid, 8000)
			setPlayerStorageValue(cid, 20000, 1)
			doPlayerAddItem(cid, 2152, 5)
			doPlayerAddExp(cid, 200, false, true)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, 20000) == 2 then
			npcHandler:say('Du hast es wirklich geschafft, die Spinnenkönigin zu besiegen, wow. Hier ist der zweite Teil deiner Belohnung. Wenn du willst, kannst du die {task} erneut starten.', cid)
			setPlayerStorageValue(cid, 20000, 3)
			doPlayerAddItem(cid, 2152, 5)
			doPlayerAddExp(cid, 500, false, true)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Also, wenn du 150 Spinnen jeder Art erledigst, bekommst du eine Belohnung von mir. Einverstanden?', cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Nun gut, dann geh los und sag bescheid, wenn du fertig bist. Du kannst deine Beute dann ja direkt bei mir lassen... *kicher*', cid)
			setPlayerStorageValue(cid, 20000, 10)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Nun gut, deine Entscheidung. Wenn du die {task} trotzdem nochmal starten willst, sag bescheid.', cid)
			setPlayerStorageValue(cid, 20000, -1)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Tja es kann sich halt nicht jeder dafür begeistern...', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann nicht.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Kluge Entscheidung.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'abbrechen') then
		if (getPlayerStorageValue(cid, 20000) <= 159 and getPlayerStorageValue(cid, 20000) >= 10) or getPlayerStorageValue(cid, 20000) == 1 then
			npcHandler:say('Willst du deine aktuelle task abbrechen? Dann werden alle Kills die du bisher erreicht hast gelöscht!', cid)
			talkState[talkUser] = 3
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

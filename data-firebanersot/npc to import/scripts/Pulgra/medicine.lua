local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

npcHandler:setMessage(MESSAGE_GREET, 'Hallo Reisender, bist du gekommen um unseren Kranken zu helfen? Wir brauchen dringend {Medicine Pouch\'s} ')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'medicine') then
		npcHandler:say('Hast du eine Medicine Pouch für mich?', cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'fisch') or msgcontains(msg, 'lieferung') or msgcontains(msg, 'fritz') then
		if getPlayerStorageValue(cid, 2605) == 1 and getPlayerStorageValue(cid, 2602) == 1 then
			if getPlayerItemCount(cid, 10028) >= 1 then
				npcHandler:say('Oh, das ist aber sehr nett von dir. Da kommt man wenigstens auch mal auf andere Gedanken, wenn man dieses leckere Knabberzeug isst.' , cid)
				setPlayerStorageValue(cid, 2605, 2)
				if getPlayerStorageValue(cid, 2603) == 2 and getPlayerStorageValue(cid, 2604) == 2 and getPlayerStorageValue(cid, 2605) == 2 and getPlayerStorageValue(cid, 2606) == 2 then
					setPlayerStorageValue(cid, 2602, 2)
					doPlayerRemoveItem(cid, 10028, 1)
				end
			else
				npcHandler:say('Es ist nett das Fritz dich schickt, aber ich glaube du hast die Ware vergessen...' , cid)
			end
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			if doPlayerRemoveItem(cid, 13506, 1) == TRUE then
				doPlayerAddItem(cid, 13670, 1)
				npcHandler:say('Großartig! Vielen dank für deine Hilfe. Ich kann dir nicht viel geben, aber vielleicht kannst du das hier gebrauchen. Hast du noch mehr?', cid)
			else
				npcHandler:say('Du hast keine, Lügner! Findest du das etwa witzig?', cid)
			end
		end
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Okay, dann bleiben meine Leute krank...', cid)
			talkState[talkUser] = 0
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())




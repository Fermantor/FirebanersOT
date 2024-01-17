local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

npcHandler:setMessage(MESSAGE_GREET, 'Ey, das Boot da hinten gehört mir, |PLAYERNAME|! Nicht anfassen!')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Was willst du von mir?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Fass ja nicht mein Boot an, sonst zieh ich dir mit der Reitpeitsche eins über.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Jaja, mach das du weg kommst, |PLAYERNAME|.')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') then
		npcHandler:say('', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'boot') or msgcontains(msg, 'boat') then
		npcHandler:say('', cid)
	elseif msgcontains(msg, 'quest') then
		npcHandler:say('', cid)
		
		
		
	elseif msgcontains(msg, 'passage') or msgcontains(msg, 'sail') or msgcontains(msg, 'travel') or msgcontains(msg, 'überfahrt') then
		if getGlobalStorageValue(feverishFactoryStatus) == 1 then
			npcHandler:say('Willst du für 50 Gold zur {Feverish Factory}?', cid)
			talkState[talkUser] = 1
		else
			if getGlobalStorageValue(feverishFactorySlimeCount) >= feverishFactorySlimeKillsNeeded then	
				npcHandler:say('Für heute wurden genug {Giftmonster} getötet. Morgen ist die Insel bereisbar.', cid)
			else
				-- npcHandler:say('Die Strahlung der Fabrik ist heute zu hoch und noch zu gefährlich. Es müssen mehr {Giftmonster} getötet werden!', cid)
				npcHandler:say('Es wurden bereits '.. getGlobalStorageValue(feverishFactorySlimeCount) .. ' Giftmonster getötet.', cid)
			end
		end
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			if doPlayerRemoveMoney(cid, 50) == TRUE then
				doSendMagicEffect(getPlayerPosition(cid), 10)
				doTeleportThing(cid, {x=2580,y=1766,z=7})
				doSendMagicEffect(getPlayerPosition(cid), 10)
				npcHandler:say('Alles klar, aber sei vorsichtig. Es ist echt gefährlich!', cid)
			else
				npcHandler:say('Dein Geld reicht leider nicht aus.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Versteh ich gut. Es ist auch sehr gefährlich!', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
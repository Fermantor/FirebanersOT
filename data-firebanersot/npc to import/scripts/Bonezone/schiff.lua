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

	if msgcontains(msg, 'job') then
		npcHandler:say('{Reisen}, das ist mein Job. Eine Schifffahrt gefälligst?', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'reise') or msgcontains(msg, 'reisen') or msgcontains(msg, 'passage') or msgcontains(msg, 'sail') or msgcontains(msg, 'travel') then
		npcHandler:say('Momentan reise ich nur nach {Pulgra}. Aber bald wird es auch mehr Urlaubsziele geben.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Willst du für 180 Gold nach Pulgra reisen?', cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			if getPlayerPremiumDays(cid) >= 1 then
				if doPlayerRemoveMoney(cid, 180) == TRUE then
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=2069,y=2086,z=6})
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					setPlayerStorageValue(cid, 54321, 0)
					npcHandler:say('Backbord! Steuerbord! AUF GEHT\'S!', cid)
				else
					npcHandler:say('Du benötigst mehr Geld zum {Reisen}.', cid)
				end
			else
				npcHandler:say('Es tut mir leid, aber reisen mit dem Schiff, können ausschließlich Premium Spieler.', cid)
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Deine Entscheidung. Auch wenn ich sie merkwürdig finde.', cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
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
	local Konto = getPlayerAccountBalance(cid)
	if msgcontains(msg, 'job') then
		npcHandler:say('Ich der Capitän von Pulgra. Ich {reise} mit meinem Schiff durch ganz Fireban.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'reise') or msgcontains(msg, 'sail') then
		npcHandler:say('Zur Zeit, segel ich nur nach {Bonezone}.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'om\'wathor') then
		npcHandler:say('Die Hinfahrt ist im Moment nicht sicher. Ein Sturm zieht im Süden auf, wie der Himmel uns verrät. Nur die Segelfahrt ostwärts in Richtung {Bonezone} birgt fast nie Gefahren.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') or msgcontains(msg, 'bone') then
		npcHandler:say('Willst du für 180 Gold zur Bonezone reisen?', cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			if getPlayerPremiumDays(cid) >= 1 then
				if doPlayerRemoveMoney(cid, 180) == TRUE then
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=2785,y=1690,z=6})
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					npcHandler:say('Anker lichten, wir stechen in See!', cid)
					setPlayerStorageValue(cid, 54321, 1)
					talkState[talkUser] = 0
				elseif Konto >= 180 + 18 then
					npcHandler:say('Du hast nicht genug Geld dabei, allerdings kann ich die Kosten + 10% Aufpreis von deinem Bank Konto abbuchen, okay?', cid)
					talkState[talkUser] = 11
				else
					npcHandler:say('Du hast weder genug Geld dabei, noch auf deiner Bank.', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Es tut mir leid, aber reisen mit dem Schiff, können ausschließlich Premium Spieler.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 11 then
			if getPlayerPremiumDays(cid) >= 1 then
				if Konto >= 180 + 18 then
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=2785,y=1690,z=6})
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					doPlayerSetBalance(cid, Konto-198)
					npcHandler:say('Anker lichten, wir stechen in See!', cid)
					setPlayerStorageValue(cid, 54321, 1)
					talkState[talkUser] = 0
				else
					npcHandler:say('Es tut mir leid, aber auf deinem Konto ist nicht genug Geld.', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Es tut mir leid, aber reisen mit dem Schiff, können ausschließlich Premium Spieler.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dann bleib lieber hier, du Landratte.', cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
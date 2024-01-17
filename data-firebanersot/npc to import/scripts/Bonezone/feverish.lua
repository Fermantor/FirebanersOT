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
		npcHandler:say('Dort dr�ben liegt die {Feverish Factory}, und da bring ich die Leute mit meiner F�hre hin. Willst du eine {�berfahrt}?', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'feverish factory') then
		npcHandler:say('Die Fabrik ist verseucht, da sie fr�her einfach vom Rest der Insel weggeschnitten wurde. Die Strahlung setzt heutzutage der Stadt Bonezone immernoch sehr zu, weswegen ich auch nicht empfehle, dich dort hin�ber zu begeben.', cid)
	elseif msgcontains(msg, 'giftmonster') then
		npcHandler:say('Ahh, also die Fabrik entsendet Strahlung, welche durch giftige Gase in der Luft �bertragen werden. Diese Gase werden von bestimmten Monstern freigegeben. Die genauen Monster sind: {Slimes}, {Blobs}, {Bog Raider} und {Defiler}.', cid)
	elseif msgcontains(msg, 'passage') or msgcontains(msg, 'sail') or msgcontains(msg, 'travel') or msgcontains(msg, '�berfahrt') then
		if getGlobalStorageValue(feverishFactoryStatus) == 1 then
			npcHandler:say('Willst du f�r 50 Gold zur {Feverish Factory}?', cid)
			talkState[talkUser] = 1
		else
			if getGlobalStorageValue(feverishFactorySlimeCount) >= feverishFactorySlimeKillsNeeded then	
				npcHandler:say('F�r heute wurden genug {Giftmonster} get�tet. Morgen ist die Insel bereisbar.', cid)
			else
				-- npcHandler:say('Die Strahlung der Fabrik ist heute zu hoch und noch zu gef�hrlich. Es m�ssen mehr {Giftmonster} get�tet werden!', cid)
				npcHandler:say('Es wurden bereits '.. getGlobalStorageValue(feverishFactorySlimeCount) .. ' Giftmonster get�tet.', cid)
			end
		end
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			if doPlayerRemoveMoney(cid, 50) == TRUE then
				doSendMagicEffect(getPlayerPosition(cid), 10)
				doTeleportThing(cid, {x=2580,y=1766,z=7})
				doSendMagicEffect(getPlayerPosition(cid), 10)
				npcHandler:say('Alles klar, aber sei vorsichtig. Es ist echt gef�hrlich!', cid)
			else
				npcHandler:say('Dein Geld reicht leider nicht aus.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Versteh ich gut. Es ist auch sehr gef�hrlich!', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
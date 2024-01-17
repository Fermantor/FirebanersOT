local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'Quara Tentacle'}, 12443, 140,'Quara Tentacle')
shopModule:addSellableItem({'Quara Eye'}, 12444, 350,'Quara Eye')
shopModule:addSellableItem({'Mantassin Tail'}, 12445, 280,'Mantassin Tail')
shopModule:addSellableItem({'Quara Pincers'}, 12446, 410,'Quara Pincers')
shopModule:addSellableItem({'Quara Bone'}, 12447, 500,'Quara Bone')
shopModule:addSellableItem({'Fish Fin'}, 5895, 150,'Fish Fin')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Meine Aufgabe ist es die Leute sicher auf die {Protection Hills} zu bringen. Meistens gelingt mir das auch, hehehe!', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'protection hills') or msgcontains(msg, 'protection hill') then
		npcHandler:say('Die Protection Hills sind die Berge, welche sich östlich von hier befinden. Sie liegen so nah am Dschungel, weswegen sie auch sehr bewachsen sind. Frag mich doch nach einer {Fahrt}, dann siehst du es selber, hehe!', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fahrt') or msgcontains(msg, 'passage') or msgcontains(msg, 'sail') or msgcontains(msg, 'travel') then
		npcHandler:say('Soll ich dir für 20 Gold mein Überfahrtsboot ausleihen, damit du zu den {Protection Hills} segeln kannst?', cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'helmet of the deep') or msgcontains(msg, 'leihen') then
		if getPlayerStorageValue(cid, 5461) == -1 then
			npcHandler:say('Willst du dir einen Helmet of the Deep für 5000 Gold leihen? Du kannst immer nur einen besitzen, hehe.', cid)
			talkState[talkUser] = 2
		else
			npcHandler:say('Bist du hier, um deinen Helmet of the Deep für 5000 Gold zurück zu tauschen, haha?', cid)
			talkState[talkUser] = 3
		end
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			if getPlayerPremiumDays(cid) >= 1 then
				if doPlayerRemoveMoney(cid, 20) == TRUE then
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=2827,y=1689,z=7})
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
					npcHandler:say('Na dann mal los. Viel Spaß, hehe!', cid)
				else
					npcHandler:say('Es tut mir leid, aber dein Geld reicht nicht aus, hehe!', cid)
				end
			else
				npcHandler:say('Ich fahre aber nur Premium Spieler, hehe!', cid)
			end
		elseif talkState[talkUser] == 2 then
			if doPlayerRemoveMoney(cid, 5000) == TRUE then
				doPlayerAddItem(cid, 5461, 1)
				npcHandler:say('Hier ist dein Helmet of the Deep. Denk dran ihn bei Zeiten wieder zurück zu bringen, da du keinen neuen bekommst, wenn du diesen verlierst, hihi!', cid)
				setPlayerStorageValue(cid, 5461, 1)
				talkState[talkUser] = 0
			else
				npcHandler:say('Es scheint, als ob du nicht genug Geld hättest, hehe!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 3 then
			if doPlayerRemoveItem(cid, 5461, 1) == TRUE then
				doPlayerAddMoney(cid, 5000)
				setPlayerStorageValue(cid, 5461, -1)
				npcHandler:say('Vielen dank, hier sind deine 5000 Gold, komm jeder Zeit wieder vorbei, und frage nach dem Helm, wenn du ihn dir wieder leihen willst, haha', cid)
				talkState[talkUser] = 0
			else
				npcHandler:say('Es scheint, als ob du deinen Helm nicht dabei hast, hehe!', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] >= 1 then
			npcHandler:say('Dann eben nicht, hehe!', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
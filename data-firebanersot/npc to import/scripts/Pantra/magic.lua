local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)
	if getGlobalStorageValue(13050) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, 'Guten Tag, |PLAYERNAME|. Ich hoffe doch, du bist nicht vergiftet. Wenn doch kannst du dir bei mir einen Gegengifttrank kaufen.')
	else
		npcHandler:setMessage(MESSAGE_GREET, 'Guten Tag, |PLAYERNAME|, könntest du mir einen dringenden {Gefallen} tun?')
	end
	npcHandler:onCreatureSay(cid, type, msg)	
end

function onThink()							npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local vials = getPlayerItemCount(cid, 7636)
	if msgcontains(msg, 'vial') then
		if vials >= 1 then
			npcHandler:say('Willst du mir alle deine Vials für ' .. vials*5 .. ' Gold verkaufen?', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du hast keine Vials!', cid)
		end
	elseif msgcontains(msg, 'schalter') then
		npcHandler:say('Ah, dir ist der Schalter in der Ecke aufgefallen. Ja ich hüte ein Siegel der Macht Pantras. Aber ich denke mal nicht, dass jemand einen Nutzen davon hat, wenn ich den Schalter {umlege}.', cid)
		talkState[talkUser] = 3
	elseif msgcontains(msg, 'umlegen') or msgcontains(msg, 'umlege') then
		if talkState[talkUser] == 3 and getGlobalStorageValue(13012) ~= 1 then
			npcHandler:say('Du möchtest, dass ich den Schalter umlege? Nun dafür brauch ich aber eine Gegenleistung. Das Gift einer Tarantula ist sehr selten und von großem Nutzen. Bringe mir eine Vial davon und ich lege den Schalter um.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'tarantula') or msgcontains(msg, 'gift') then
		if getGlobalStorageValue(13012) ~= 1 then
			npcHandler:say('Du bringst mir also wirklich eine Vial mit Tarantula Gift?', cid)
			talkState[talkUser] = 4
		end
	elseif msgcontains(msg, 'ticket') or msgcontains(msg, 'lotto') then
		npcHandler:say('Ja mein Lotto System ist das beste in ganz Pantra. Für {100 Potions}, bekommst du ein Lotto Ticket von mir. Vieleicht hast du Glück und hast einen {Gewinn}', cid)
	elseif msgcontains(msg, '100 potions') then
		npcHandler:say('Bringst du mir 100 leere Potions für ein Lotto Ticket?', cid)
		talkState[talkUser] = 5
	elseif msgcontains(msg, 'winning') or msgcontains(msg, 'gewinn') then
		npcHandler:say('Du hast echt gewonnen, und willst dir jetzt deinen Preis abholen?', cid)
		talkState[talkUser] = 6
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Hier sind deine ' .. vials*5 .. ' Gold.', cid)
			doPlayerAddItem(cid, 2148, vials*5)
			doPlayerRemoveItem(cid, 7636, vials)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Fantastisch! Geh die Treppe hoch und zahle der Leiche Blutzoll. Passe jedoch auf, das du nicht zu verwundet bist. Das könnte übel enden.', cid)
			setGlobalStorageValue(13050,0)
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 7477, 1) then
				npcHandler:say('Wunderbar! Ich danke dir vielmals. Ich werde meinen Teil auch einhalten, schau...', cid)
				doTransformItem(13012, 1946)
				--doSendAnimatedText({x=567,y=266,z=3}, "Click", 198)
				setGlobalStorageValue(13012, 1)
				doSetItemActionId(getThingfromPos({ x = 563, y = 231, z = 9, stackpos = 1}).uid, 23012)
			else
				npcHandler:say('Mach dich doch nicht lächerlich...', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			if getPlayerItemCount(cid, 7636) >= 100 then
				doPlayerRemoveItem(cid, 7636, 100)
				npcHandler:say('Wunderbar, hier ist dein Los.', cid)
				doPlayerAddItem(cid, 5957)
			else
				npcHandler:say('Du musst mir 100 Potions der gleichen Sorte bringen.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 6 then
			if getPlayerStorageValue(cid, 20010) ~= 1 then
				if getPlayerItemCount(cid, 5958) >= 1 then
					doPlayerRemoveItem(cid, 5958, 1)
					npcHandler:say('Hier bitte sehr, dein brand neuer Potion Gürtel.', cid)
					doPlayerAddOutfit(cid, 138, 1)
					doPlayerAddOutfit(cid, 133, 1)
					talkState[talkUser] = 0
					setPlayerStorageValue(cid, 20010, 1)
				else
					npcHandler:say('Bitte, du verschwendest meine Zeit.', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Sei doch nicht albern, du hast deinen Preis doch schon abgeholt', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dann halt nicht.',cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'gefallen') then
		if getGlobalStorageValue(13050) ~= 1 then
			npcHandler:say('Ich habe meinem Gott geschworen, ihm jeden Tag einen Blutzoll zu zahlen. Leider komme ich heute nicht dazu. Würdest du diese Aufagbe für mich erledigen?', cid)
			talkState[talkUser] =  2
		elseif getPlayerStorageValue(cid, 13050) == 1 then
			npcHandler:say('Vielen Dank für deine Hilfe. Nimm dir als Belohnung etwas aus der Kiste dort drüben.', cid)
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

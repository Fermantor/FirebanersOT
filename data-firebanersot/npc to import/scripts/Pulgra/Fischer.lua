local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'green perch'}, 7159, 200)
shopModule:addSellableItem({'rainbow trout'}, 7158, 300)
shopModule:addSellableItem({'northern pike'}, 2669, 1000)



function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'job') or msgcontains(msg, 'fische') then
		npcHandler:say('Ich bin Fischer von Beurf, schwer zu erkennen was? Ich beliefere ganz Pulgra und Umgebung mit meiner Ware. Wenn du Lust hast, kannst du ein paar {Aufgaben} für mich erledigen.',cid)
	elseif msgcontains(msg, 'task') or msgcontains(msg, 'aufgabe') then
		if getPlayerStorageValue(cid, 2600) == -1 then
			npcHandler:say('Nun, wenn du Dir ein wenig Geld dazu verdienen willst, bist du bei mir richtig. Ich habe viel zu tun und kann Hilfe immer gebrauchen. Wir können gleich loslegen, wenn du magst?',cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, 2600) == 1 then
			npcHandler:say('Ich hatte dich gebeten mir 10 frische Fische zu fangen, sie müssen also von dir selbst geangelt sein.',cid)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, 2600) == 2 then
			if getPlayerItemCount(cid, ITEM_FISH) >= 10 then
				doPlayerRemoveItem(cid, ITEM_FISH, 10)
				setPlayerStorageValue(cid, 2600, 3)
				doPlayerAddMoney(cid, 400)
				npcHandler:say('Wow, vielen Dank. Frische Ware für meine Kunden. Nimm diese kleine Entlohnung. Ich hab noch weitere {Aufgaben} für dich, falls du Zeit hast, schau mal wieder vorbei.',cid)
			else
				npcHandler:say('Ich sehe, du hast zwar geangelt, aber du hast die Fische wohl nicht dabei. Hoffentlich hast du sie nicht alle gegessen *hihihi*',cid)
			end
		elseif getPlayerStorageValue(cid, 2600) == 3 then
			npcHandler:say('Ah, dir hat die Arbeit gefallen, wie ich sehe. Nun gut, als nächstes müsstest du einen Kurrierdienst für mich machen, bist du einverstanden?',cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, 2602) == 2 then
			npcHandler:say('', cid)
			
		
		
		
		end	
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Sehr gut. Zuerst müssen wir meinen Vorrat an Fischen wieder etwas auffrischen. Hier sind 10 Würmer, und eine Angel findest du in der Kiste dort. Geh nun und angle 10 frische Fische.',cid)
			setPlayerStorageValue(cid, 2600, 1)
			setPlayerStorageValue(cid, 2601, 0)
			doPlayerAddItem(cid, ITEM_WORM, 10)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			setPlayerStorageValue(cid, 2602, 1)
			setPlayerStorageValue(cid, 2603, 1) -- Gronta
			setPlayerStorageValue(cid, 2604, 1) -- Brodrosch
			setPlayerStorageValue(cid, 2605, 1) -- Leona
			setPlayerStorageValue(cid, 2606, 1) -- Maria
			doPlayerAddItem(cid, 10028, 1)
			npcHandler:say(
			{
				'Wunderbar, ich wusste, dass ich auf dich zählen kann. Also ich bin der einzige Hersteller von Fish Flakes weit und breit, weswegen ich viele Kunden habe. ...',
				'Ich möchte, dass du meine Fish Flakes an meine Kunden bringst, bezahlt haben sie natürlich alle schon. ...',
				'Der Druide Gronta im Nord-Westen von Pulgra, es ist ein kleiner Fußmarsch bis dahin, der Geomancer Brodrosch, er lebt in einem Schrein in den Dwarf Minen ...',
				'Leona, unsere Pflegerin auf der Insel der Kranken, nimm dazu einfach das erste Boot an meinem Pier und zu guter letzt der lieben Maria, unserem Juwelier.'
			},cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

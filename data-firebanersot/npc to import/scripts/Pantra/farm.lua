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

npcHandler:setMessage(MESSAGE_GREET, 'Herzlich willkommen auf meiner kleinen Farm |PLAYERNAME|. Wie kann mein {job} dir weiter helfen?')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	cancelStory(cid)
	if msgcontains(msg, 'job') then
		npcHandler:say('Ich bin Katharina, die Farmerin von Pantra. Wenn du ein paar Lebensmittel kaufen, oder verkaufen willst, frag mich nach einem {trade}.', cid)
	elseif msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, 5001) < 1 then
			npcHandler:say('Sehr eifrig, was? Das gef�llt mir. Tats�chlich gibt es etwas, dass du f�r mich tun kannst. Es geht um diese verflixten {Ratten}!', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, 5001) == 1 then
			npcHandler:say('Ah, hast du den K�se bei dir?', cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, 5001) == 2 then
			npcHandler:say('Gut, dass du mich fragst, ich habe eine Dringende bitte an dich. W�rst du bereit mir zu helfen?', cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, 5001) == 3 then
			npcHandler:say('Ah, warst du in der Crystal Cave und hast meinen Schl�ssel dabei?', cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, 5001) == 4 then
			npcHandler:say('Die Wasserpfeife in meinem Zimmer scheint irgendwie verstopft zu sein, k�nntest du kurz nach oben gehen, und dir das mal anschauen?', cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, 5001) == 8 then
			npcHandler:say('WAS? EINE RATTE? Ihhhhh! Ich danke dir 1000 mal, dass du f�r mich da hoch gegangen bist, ich glaube ich w�re beim Anblick erstarrt. Daf�r hast du dir echt eine {Belohnung} verdient.', cid)
			setPlayerStorageValue(cid, 5001, 9)
		end
	elseif msgcontains(msg, 'ratten') or msgcontains(msg, 'rat') or msgcontains(msg, 'ratte') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Ja genau, Ratten! Diese Viecher machen mir das Leben schwer und fressen meine ganze Ernte. W�rdest du mir helfen sie mir vom Leib zu halten?', cid)
			talkState[talkUser] = 2
		else
			npcHandler:say('Ratten... Ratten... RATTEN! Ich hasse diese Tiere!', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 2 then
			story[cid] = selfStory({"Hervoragend! Also pass auf. In der Kanalisation von Pantra hab ich vor ein paar Tagen ein St�ck K�se deponiert ...", "Dieser sollte jetzt sch�n verschimmelt und ungeniesbar sein, besorg mir diesen K�se und ich bin die Ratten endlich los."}, cid, 8000)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, 5001, 1)
			setPlayerStorageValue(cid, 5003, 1)
		elseif talkState[talkUser] == 3 then
			if doPlayerRemoveItem(cid, 2235, 1) == TRUE then
				npcHandler:say('Uaaah, wie eklig. Naja es ist ja auch f�r die Ratten, hehe. Ich habe dir sehr zu danken. Hier hast du ein bisschen besseren K�se.', cid)
				doPlayerAddItem(cid, 2696, 5)
				setPlayerStorageValue(cid, 5001, 2)
				setPlayerStorageValue(cid, 5003, -1)
				doPlayerAddExp(cid,200, false, true)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du solltest den K�se aus der Kanalisation holen!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 4 then
			npcHandler:say(
			{
				'Wenige wissen, dass ich neben den Lebensmitteln auch noch Crystalle z�chte. Ich besitze sogar eine ganze H�le voll mit ihnen. ...',
				'Jedoch war ich ein bisschen schusselig und hab den Schl�ssel zu meiner Haust�re in der H�le vergessen. K�nntest du bitte dort hin gehen, und ihn holen, und mir bringen? ...',
				'Die Crystal Cave ist unter dem Swamp Berg, und wird von einem gro�en Crystal blockiert. Benutze einfach eine Pick auf ihn, und du kannst hinein.'
			},cid)
			setPlayerStorageValue(cid, 5001, 3)
			setPlayerStorageValue(cid, 5005, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			if doPlayerRemoveItem(cid, 2088, 1) == TRUE then
				npcHandler:say('Einfach ausgezeichnet, das ist mein Schl�ssel. Ich habe dir erneut sehr zu danken. Es ist zwar nicht viel, aber bitte nimm dieses Gold.', cid)
				doPlayerAddItem(cid, 2148, 70)
				setPlayerStorageValue(cid, 5001, 4)
				setPlayerStorageValue(cid, 5005, -1)
				doPlayerAddExp(cid,300, false, true)
				talkState[talkUser] = 0
			else
				npcHandler:say('Ich wei� nicht, was du meinst, aber meinen Schl�ssel hast du nicht.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Vielen Dank, hier ist der Schl�ssel. Bitte gehe nach oben, und gucke, ob du die Pfeife wieder frei bekommst.', cid)
			setPlayerStorageValue(cid, 5001, 5)
			local Key = doCreateItemEx(2088, 1)
			doSetItemActionId(Key, 1007)
			doPlayerAddItemEx(cid, Key, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			if doPlayerRemoveItem(cid, 13506, 1) == TRUE then
				doPlayerAddItem(cid, 13670, 1)
				npcHandler:say('Gro�artig! Vielen dank f�r deine Hilfe. Ich kann dir nicht viel geben, aber vielleicht kannst du das hier gebrauchen. Hast du noch mehr?', cid)
			else
				npcHandler:say('Du hast keine, L�gner! Findest du das etwa witzig?', cid)
			end
		end
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 7 then
			npcHandler:say('Okay, dann bleiben meine Leute krank...', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'belohnung') and getPlayerStorageValue(cid, 5001) == 9 then
		npcHandler:say('Die Belohnung hast du dir wirklich verdient, du warst mir eine gro�e Hilfe. Nimm diese Edelsteine und wenn du m�chtest, kann du mit meinem kleinen Boot zur Lost Island reisen.', cid)
		setPlayerStorageValue(cid, 5001, 10)
		doPlayerAddExp(cid,500, false, true)
		doPlayerAddItem(cid, 2149, 5)
	elseif msgcontains(msg, 'medicine') then
		npcHandler:say('Hast du eine medicine pouch f�r mich?', cid)
		talkState[talkUser] = 7
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, creatureFarewell)
npcHandler:setCallback(CALLBACK_CREATURE_DISAPPEAR, creatureFarewell)
npcHandler:addModule(FocusModule:new())

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
	if msgcontains(msg, 'quest') or msgcontains(msg, 'job') or msgcontains(msg, 'aufgabe') or msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, 2461) == 1 then
			if getPlayerStorageValue(cid, 1516) == 1 then
				npcHandler:say('So so, ein Leather Helmet. Gut, danke. Hier ist deine Belohnung.', cid)
				doPlayerAddExp(cid,200, false, true)
				local Bag = doCreateItemEx(1987,1)
				doAddContainerItem(Bag, 2148, 30)
				doAddContainerItem(Bag, 2643, 1)
				doPlayerAddItemEx(cid, Bag, 1)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 2461, 2)
			else
				npcHandler:say('Du sollst doch zur Truhe gehen, und gucken, was in ihr ist.', cid)
				talkState[talkUser] = 0
			end	
		elseif getPlayerStorageValue(cid, 2461) == 2 then
			npcHandler:say('Tut mir leid, aber mehr Aufgaben habe ich nicht für dich.', cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, 1516) == -1 and getPlayerStorageValue(cid, 2461) == -1 then
			npcHandler:say('Ah, sehr mutig von dir, mich danach zu fragen, ich habe sogar eine Aufgabe für dich. Doch dafür musst du mindestens Level 2 und {bereit} sein.', cid)
			talkState[talkUser] = 1
		end
	elseif msgcontains(msg, 'bereit') then
		if getPlayerLevel(cid) >= 2 then
			if talkState[talkUser] == 1 then
				npcHandler:say('Gut, begehe die Brücke westlich von hier und schaue hinter den großen Felsen in die Truhe, zeige mir,\n was in ihr ist und du kriegst eine Belohnung.', cid)
				setPlayerStorageValue(cid, 1516, 1)
				setPlayerStorageValue(cid, 2461, 0)
			else
				npcHandler:say('Entschuldige, aber zu was bist du bereit?', cid)
			end
		else
			npcHandler:say('Tut mir leid, aber du scheinst noch nicht die nötige Stärke erlangt zu haben. Trainiere weiter.', cid)
		end
	elseif msgcontains(msg, 'addon') or msgcontains(msg, 'outfit') or msgcontains(msg, 'citizen') then
		if getPlayerStorageValue(cid, 5009) <= 0 then
			npcHandler:say('Ah, dir ist mein exklusives Outfit aufgefallen. Nun, das Backpack habe ich von {Benedikt} bekommen, aber den {Hut} habe ich selbst gemacht.', cid)
		else
			npcHandler:say('Ja, mein Backpack habe ich von dem weisen Mönch {Bendedikt} bekommen. Er ist ein wahrer Meister, bei der Verarbeitung von Minotaur Leathers.', cid)
		end
	elseif msgcontains(msg, 'hut') then
		if getPlayerStorageValue(cid, 5009) == -1 then
			npcHandler:say('Ja, bei dem Hut habe ich mich wirklich selbst übertroffen. Und wie ich in deinen gieringen Augen sehe, willst du unbedingt auch einen habe, stimmt\'s?', cid)
			talkState[talkUser] = 2
		end
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 2 then
			npcHandler:say('Ha wusst ich\'s doch. Allerdings wachsen Hüte nicht auf Bäumen und ich brauche ein paar Materialien. Für den Hut benötige ich einen {Legion Helmet}, für die Feder 100 {Chicken} {Feathers}, und damit alles gut hält noch 50 {Honeycombs}. Hast du trotzdem noch Interesse am Hut?', cid)
			talkState[talkUser] = 3
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Sehr gut, dann besorge mir zuerst einen {Legion Helmet}, damit ich mit der Arbeit beginnen kann.', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, 5009, 1)
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 2480, 1) == TRUE then
				npcHandler:say('Prima, ich werde sofort beginnen den Hut zu erstellen. Mach du dich nun auf die Suche nach 100 {Chicken} {Feathers}, und komme nicht wieder, ehe du sie nicht hast.', cid)
				setPlayerStorageValue(cid, 5009, 2)
				talkState[talkUser] = 0
			else
				npcHandler:say('Ähm, ich habe dich um einen Legion Helmet gebeten... wenn du nicht weißt, wie du einen findest, bist du auch nicht würdig den Hut zu tragen. Tritt mir nicht mehr unter die Augen, bis du ihn nicht hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			if getPlayerItemCount(cid, 5890) >= 100 then
				doPlayerRemoveItem(cid, 5890, 100)
				npcHandler:say('Perfekt, wir sind nah dran. Jetzt nur noch 50 {Honeycombs}, und dein Hut ist fertig. Beeilung!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5009, 3)
			else
				npcHandler:say('Es nützt mir nichts, wenn du mich besuchst. Bringe mir 100 Chicken Feathers, oder ich werde nie fertig.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 6 then
			if getPlayerItemCount(cid, 5902) >= 50 then
				doPlayerRemoveItem(cid, 5902, 50)
				npcHandler:say('Wunderbar, der Hut ist fertig. Wieder einmal eine Meisterleistung von mir. Hier hast du das Prachtexemplar!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5009, 4)
				doPlayerAddOutfit(cid,136,2)
				doPlayerAddOutfit(cid,128,2)
				doSendMagicEffect(getPlayerPosition(cid), 12)
			else
				npcHandler:say('Ohne Honeycombs kein Hut, also streng dich an!', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') then
		if talkState[talkUser] == 2 then
			npcHandler:say('Gut dann habe ich mich wohl geirrt, und du wirst nie so einen prächtigen Hut wie ich besitzen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Da habe ich Dich wohl falsch eingeschätzt, ich dachte du wärst dieser Aufgabe gewachsen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Und wofür kommst du dann zu mir? Besorg den Legion Helmet und verschwende nicht meine Zeit!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Bist wohl auch noch stolz drauf, dass du nicht mal ein paar Chicken töten kannst? Ich brauche 100 Chicken Feathers!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Was willst du dann bei mir?', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'legion helmet') then
		if getPlayerStorageValue(cid, 5009) == 1 then
			npcHandler:say('Ah, du kommst also mit dem Legion Helmet, um mit der Arbeit am Hut zu beginnen?', cid)
			talkState[talkUser] = 4
		else
			npcHandler:say('Legion Helmets sind sehr starke und robuste Stahl Helme, die man meistens in Drachen Körpern findet.', cid)
		end
	elseif msgcontains(msg, 'chicken feather') or msgcontains(msg, 'feather') then
		if getPlayerStorageValue(cid, 5009) == 2 then
			npcHandler:say('Bist du hier um mir die 100 Chicken Feathers zu bringen?', cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Chicken Feathers sind ein besonders weiches Material, dass du in Chickens finden kannst.', cid)
		end
	elseif msgcontains(msg, 'honeycomb') then
		if getPlayerStorageValue(cid, 5009) == 3 then
			npcHandler:say('Kommst du mit den lang ersehnten Honeycombs?', cid)
			talkState[talkUser] = 6
		else
			npcHandler:say('Honeycombs sind sehr klebrig aber von sehr großem Genus. Du findest sie in Wasps.', cid)
		end
	elseif msgcontains(msg, 'benedikt') then
		npcHandler:say('Benedikt ist ein Mönch, der zahlreiche Erfahrungen mit Minotauren gemacht hat und deren Leathers hervoragend verarbeiten kann.', cid)
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

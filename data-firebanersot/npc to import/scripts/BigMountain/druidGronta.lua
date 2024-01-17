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

shopModule:addSellableItem({'Acorn'}, 11213, 10)
shopModule:addSellableItem({'Antlers'}, 11214, 50) 
shopModule:addSellableItem({'Bat Wing'}, 5894, 50)
shopModule:addSellableItem({'Bear Paw'}, 5896, 100) 
shopModule:addSellableItem({'Chicken Feather'}, 5890, 30) 
shopModule:addSellableItem({'Warwolf Fur'}, 11235, 30)
shopModule:addSellableItem({'Wolf Paw'}, 5897, 70)
 
shopModule:addSellableItem({'grave flower'}, 2747, 25,'grave flower')
shopModule:addSellableItem({'heaven blossom'}, 5921, 25,'heaven blossom')
shopModule:addSellableItem({'stone herb'}, 2799, 20,'stone herb')
shopModule:addSellableItem({'star herb'}, 2800, 15,'star herb')
shopModule:addSellableItem({'moonflower'}, 2741, 5,'moon flower')
shopModule:addSellableItem({'sling herb'}, 2802, 10,'sling herb')
shopModule:addSellableItem({'troll green'}, 2805, 25,'troll green')
shopModule:addSellableItem({'fern'}, 2801, 24,'fern')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Bin Druide, fertig. Hab keine Zeit für sinnlose Fragen.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Ach ne. Dieser kleine Bastard stört alles. Respektiert nichts. Verursacht Chaos in Natur und in Schakren. Taugt überhaupt nichts. Halte dich fern von ihm, oder machst dich zum Feind!',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'addon') then
		if getPlayerStorageValue(cid, outfits.druidAddon1) == -1 then
			npcHandler:say('Fragst wegen den Pfoten, die ich aufhabe, was? Kann sie dir auch machen. Gib mir 50 {Bear Paws} und 50 {Wolf Paws}. Haste dabei?',cid)
			talkState[talkUser] = 1
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') or msgcontains(msg, 'prüfung') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission2) == 5 then
			npcHandler:say('Sollst zu Irelia, schöne Braut in Bonezone auf Botanical Lands. Sie baut {Sling Herbs} an. Tolle Kräuter für Peremungaf Tränke. Sie soll mir 20 Pfund schicken. Schnell!',cid)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission2) == 6 then
			npcHandler:say({'Soso, da bist du ja. Schön, schön. *nuschel,nuschel* Brauchst gar nicht direkt abzuhauen. Gibt noch nen Auftrag, jaja. Noch einen. Diesmal nen Richtigen, nen Schweren. ...',
							'Brauche noch so eingie Sachen. Hol sie mir. Bring mir {Acorn}, {Antlers}, {Honeycomb}, {Warwolf Fur}, {Wolf Paw}. Von allem eins. Und alles gleichzeitig, klar?! Habe kein Platz zum Lagern, muss direkt verwenden. Verschwinde jetzt. Beeil dich!'},cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission2, 7)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission2) == 7 then
			local status = TRUE
			local zutaten = {11213,11214,11235,5897,5902}
			for i = 1, #zutaten do
				if getPlayerItemCount(cid, zutaten[i]) == 0 then
					status = FALSE
				end
			end
			if status == TRUE then
				for i = 1, #zutaten do
					doPlayerRemoveItem(cid, zutaten[i], 1)
				end
				setPlayerStorageValue(cid, examinationToFireHell.mission2, 8)
				npcHandler:say('Sehr gut. Alle Zutaten dabei. Hast meine Aufgaben gemeistert. Kannst jetzt zurück zu Wächter. Bis dann!',cid)
			else
				npcHandler:say('Siehst doch selber. Hast nicht alles dabei. Mach schon, bring mir das Zeug.',cid)
			end
			npcHandler:releaseFocus(cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'rotten meat') then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 3 then
			if getPlayerFreeCap(cid) >= 2.10 then
				if doPlayerRemoveItem(cid, 2227, 1) == TRUE then
					npcHandler:say({'Hmm, das sieht wirklich übel aus. Vergiftet, ja, vergiftet. Ohhh, grausam. Sehr schrecklich. Könnte es sein, dass...? Aber nein... Oder doch? *wühl,wühl* Jaja, Gegengift. ...',
									'So, hier hast du. Fleisch vergiftet. Nicht gut. Grausam. Sehr schrecklich. Aber könnte es sein, dass der...? Nein, geht nicht... Hmmm... Geh jetzt. Keine Zeit.'},cid)
					doPlayerAddItem(cid, 7489, 1)
					setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 4)
				else
					npcHandler:say('Wovon redest du?',cid)
				end
			else
				npcHandler:say('Besitzt nicht genug Kraft. Geh. Stärke dich!',cid)
				npcHandler:releaseFocus(cid)
			end
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'aristeas') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission2) == 4 then
			npcHandler:say({'Ah, verstehe. Wächter schickt dich. Willst also in die Hölle, was? Sehr dumm. Aber macht nichts, Dummheit kann vergehen. Werde dich prüfen, mal sehen was\'de kannst. *nuschel,nuschel* Brauche dringend {Sling Herbs}. ...',
							'Kräuter eignen sich prächtig zum Brauen von Peremungaf Tränken. *nuschel,nuschel* Brauche wirklich schnell. Geh zu {Irelia}, lebt in Bonezone. Sie baut sie an, sie soll mir schicken. 20 Pfund. Sag ihr das. Schnell!'},cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission2, 5)
		else			
			npcHandler:say('Der Wächter. Er bewacht, wie Name sagt. Er bewacht Hölle. Schrecklich, was? Niemand will Hölle betreten, niemand. Nur dumme Leute. Wächters Beruf ist obsolet, ganz sicher.',cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fisch') or msgcontains(msg, 'lieferung') or msgcontains(msg, 'fritz') then
		if getPlayerStorageValue(cid, 2603) == 1 and getPlayerStorageValue(cid, 2602) == 1 then
			if getPlayerItemCount(cid, 10028) >= 1 then
				npcHandler:say('Fish Flakes!? Vortrefflich, wirklich. Dank an Fischer. Geh jetzt! Keine Zeit.' , cid)
				setPlayerStorageValue(cid, 2603, 2)
				if getPlayerStorageValue(cid, 2603) == 2 and getPlayerStorageValue(cid, 2604) == 2 and getPlayerStorageValue(cid, 2605) == 2 and getPlayerStorageValue(cid, 2606) == 2 then
					setPlayerStorageValue(cid, 2602, 2)
					doPlayerRemoveItem(cid, 10028, 1)
				end
			else
				npcHandler:say('Fischer hat dich wohl geschickt, was? Ohne Ware. Ganz ohne Ware. Das bringt ja nichts.' , cid)
			end
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			if getPlayerItemCount(cid, 5896) >= 50 then
				if getPlayerItemCount(cid, 5897) >= 50 then
					npcHandler:say('Na dann gut, ich muss nur eben... mmh... dann nämlich erst... *nuschel*. So, hier haste die Pfoten. Und jetzt geh, hab keine Zeit.', cid)
					doPlayerRemoveItem(cid, 5896, 50)
					doPlayerRemoveItem(cid, 5897, 50)
					setPlayerStorageValue(cid, outfits.questLog, 1)
					setPlayerStorageValue(cid, outfits.druidAddon1, 1)
					Player(cid):addOutfitAddon(144,1)
					Player(cid):addOutfitAddon(148,1)
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_RED)
					talkState[talkUser] = 0
				else
					npcHandler:say('Was soll das? Hast nicht genug {Wolf Paws}. Bring sie mir!', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Was soll das? Hast nicht genug {Bear Paws}. Bring sie mir!', cid)
				talkState[talkUser] = 0
			end
			npcHandler:releaseFocus(cid)
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

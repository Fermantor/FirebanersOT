local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end




function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') or msgcontains(msg, 'berufung') then
		npcHandler:say('Ich arbeite nicht. Meine Berufung ist das Wandern und Erkunden. Ich lebe, um die Welt zu sehen. Ich m�chte �berall einmal gewesen sein, das ist mein Ziel. Ich bin ein Expeditioner.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'expeditioner') then
		if getPlayerStorageValue(cid, helpingAnExpeditioner.dwarvenPickaxe) == -1 then
			npcHandler:say({'Wie wundersch�n, dass du mich darauf ansprichst. Denn ich lebe wirklich f�r das Abenteuer. Ich will alles sehen, alles erkunden. Doch manche Gebiete sind wirklich schwer zu erkunden, vor allem wenn es um Berge und H�hlen geht. ...',
							'Deswegen ben�tige ich eine spezielle Spitzhacke, um auch die enlegensten Winkel von Fireban begehen zu k�nnen. Eine {Dwarven Pickaxe}! Leider habe ich meine verlegt. Das ist eine Katastrophe, denn gerade hier am Big Mountain gibt es viele Stellen, wo ich diese ben�tige.'},cid)
			talkState[talkUser] = 0
		else
			npcHandler:say({'Wie wundersch�n, dass du mich darauf ansprichst. Denn ich lebe wirklich f�r das Abenteuer. Ich will alles sehen, alles erkunden. Doch manche Gebiete sind wirklich schwer zu erkunden, vor allem wenn es um Berge und H�hlen geht. ...',
							'Deswegen bin ich so froh, dass du mir eine neue {Dwarven Pickaxe} gebracht hast. Mit der und meinem {Obsidian Knife} komme ich jetzt wieder �berall hin. Vielen Dank!'},cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "zin'shenlock") then
		npcHandler:say('Eine prachtvolle Stadt ist das. Sie steckt voller Magie und Geheimnisse. Ein Besuch lohnt sich immer. Allerdings war dies sehr lange Zeit nicht m�glich, da die Segelroute voller Gefahren steckt. Frage einfach Captain John von Pulgra, ob eine Hinfahrt im Moment sicher ist.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "watercave") then
		npcHandler:say({'Eine geheimnisvolle H�hle unterhalb von Bonezone, sie steckt voller Gefahren und hat genau zwei Zug�nge. Ein Weg f�hrt �ber die Mocous Lair, eine verseuchte H�hle versteckt in einem Slime Loch, der andere �ber die Skeleton Cave, eine toter Graben westlich von Little Cotton. Beide Zug�nge werden von Hexen bewacht, also kein Zutritt f�r Unw�rdige. ...',
						'Ich bin nie so tief in die Watercave vorgedrungen, dass ich ernsthaft in Gefahr gewesen w�re. Das ist eigentlich schade, denn am Ende soll es ein Portal geben, dass mit einem speziellen Edelstein aktiviert werden kann. Wo es wohl hinf�hrt?'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "little cotton") then
		npcHandler:say('Ein lustiges kleines Dorf, was seit Jahren f�r die Unabh�ngigkeit zu Bonezone k�mpft. Es ist vor allem f�r reiche Bewohner bestimmt, und so sind auch die Gesch�fte dort angelegt. Es gibt einen Juwelier und sogar einen Troph�en H�ndler. Bei ihm kannst du all deine Tierk�pfe verkaufen, und das legal. Klasse, was?',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'gronta') then
		npcHandler:say('Ein Meister seines Fachs, ich besuchte ihn nun schon viele Male. Er lebt auf der Spitze des Gro�en Berges und wei� so gut wie alles �ber den Druidismus. Nennt man das so?',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') then
		npcHandler:say('Die Inselstadt von Fireban, deren Umland so viele H�hlensysteme besitzt, wie keine andere Stadt. Man muss mit dem Schiff fahren, um sie zu besuchen; unterirdisch f�hrt kein Weg hin. Frag doch mal Captain John in Pulgra, ob er dich hinbringt.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Pulgra, eine Stadt die ich nun schon viele Male bereist habe. Sie ist das Zentrum von Fireban, sagen manche. Ich halte sie f�r eine geschichtlich und kulturell wichtige Stadt, jedoch bei weitem nicht die sch�nste. Dieser Preis geht an Zin\'Shenlock.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'obsidian lance') then
		npcHandler:say('Eine Obsidian Lance ist eine seltene Waffe. Eine Lanze, getragen von ein paar wenigen Kreaturen auf Fireban, so spitz, dass sie selbst die robuste, z�he Haut eines Behemoths durchdringen kann. Das scharfe, harte Obsidian ist ideal, um damit ein Messer herzustellen.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'piece of draconian steel') then
		npcHandler:say('Dieses �u�erst seltene St�ck Stahl stammt noch aus der Urzeit der Drachen. �ber tausende Jahre eingeschlossener Drakonien Stahl, gefunden in der Bergwerken von {Fire Hell}, wurde dieses Material in so manchen Schilden und R�stungen verarbeitet. Brutus aus Pulgra ist bekannt daf�r, diesen Stahl aufbereiten zu k�nnen.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Hm, das sagt mir was. Ein Name, nicht wahr? Ich sch�tze, ein Dieb, Spion oder Schmuggler, denn diese Leute tragen immer Decknamen. Ad hoc w�rde ich sagen, du findest ihn irgendwo in einer H�hle, die er als Versteck nutzt, ich k�nnte mich aber auch irren.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fire hell') then
		npcHandler:say({'Eine der gef�hrlichsten H�hlen von Fireban, und ein wahres Meisterwerk der Natursch�pfung, liegt Fire Hell unter diesem Berg, dem Gro�en Berg. In diesen Untiefen schwimmt man f�rmlich in hei�er, brodelnder Magma. Normale Menschen halten es kaum zehn Minuten darin aus. ...',
						'Es ist einer der wenigen Orte, die ich noch nicht betreten habe. Aristeas, der W�chter der Eingangspforte, hat mich nie hineingelassen. Ich konnte seine Pr�fungen nicht absolvieren. Wenn du einmal dort warst, bitte ich dich mir Bericht zu erstatten. Ich muss einfach wissen, was das Geheimnis um Fire Hell ist.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'backpack') then
		if getPlayerStorageValue(cid, helpingAnExpeditioner.dwarvenPickaxe) == -1 then
			npcHandler:say('Du fragst wegen einem Expedition Backpack? Es tut mir leid, aber ich habe momentan genug Probleme meine {Dwarven Pickaxe} zu suchen. Sie muss hier doch irgendwo sein...', cid)
			talkState[talkUser] = 0
		else
			npcHandler:say('M�chtest du ein {Expedition Backpack} f�r 100 Gold kaufen?', cid)
			talkState[talkUser] = 3
		end
	elseif msgcontains(msg, 'obsidian knife') then
		if getPlayerStorageValue(cid, helpingAnExpeditioner.dwarvenPickaxe) == -1 then
			npcHandler:say('Du fragst wegen einem Obsidian Knife? Es tut mir leid, aber ich habe momentan genug Probleme meine {Dwarven Pickaxe} zu suchen. Sie muss hier doch irgendwo sein...', cid)
			talkState[talkUser] = 0
		else
			npcHandler:say('Ein Obsidian Knife ist n�tzlich, um so manche Tiere zu h�uten. So �berlebt man in der Wildnis. Ich k�nnte dir eines zusammenbauen, wenn du mir eine {Obsidian Lance} und ein {Piece of Draconian Steel} �bergibst. Hast du die Sachen dabei?', cid)
			talkState[talkUser] = 4
		end
	elseif msgcontains(msg, 'dwarven pickaxe') then
		if getPlayerStorageValue(cid, helpingAnExpeditioner.dwarvenPickaxe) == -1 then
			npcHandler:say('Da ich meine verlegt habe, k�nnte ich echt gut eine neue gebrauchen. Hast du eine f�r mich dabei, die du mir schenken w�rdest?', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Mit der neuen Spitzhacke, die du mir gebracht hast, kann ich selbst die engsten H�hlensch�chte begehen. Das ist unglaublich. Vielen Dank nochmal daf�r! Vielleicht kann ich dir ja jetzt was anbieten. Wie w�rs mit einem {Obsidian Knife}?', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			if doPlayerRemoveItem(cid, 4874, 1) == TRUE then
				npcHandler:say('Das ist ja fantastisch. Ich wei� gar nicht, was ich sagen soll, oder besser, wie ich mich revanchieren kann. Ich k�nnte dir eine spezielle Tragetasche anbieten. Sie nennt sich {Expedition Backpack}. M�chtest du sie?',cid)
				setPlayerStorageValue(cid, helpingAnExpeditioner.dwarvenPickaxe, 1)
				talkState[talkUser] = 2
			else
				npcHandler:say('Hmm, es scheint eher, du h�ttest keine Spitzhacke, die du mir leihen k�nntest. Schade.',cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 2 then
			if getPlayerFreeCap(cid) >= 18.00 then
				npcHandler:say('Dann passt das ja gut. Ich habe wieder eine Spitzhacke und du hast einen neuen pratischen Rucksack. Wenn du m�chtest, kann ich dir weitere von diesen Rucks�cken geben, allerdings gegen Entgelt, versteht sich. Denn sie sind teuer in der Herstellung. Sprich mich einfach darauf an.',cid)
				doPlayerAddItem(cid, 11241, 1)
				talkState[talkUser] = 0
			else
				npcHandler:say('Es scheint, du hast nicht die richtige Statur f�r solch einen Rucksack. R�cken zu klein, Kreuz zu hohl, Schultern zu schmal. Ist wohl einfach nicht f�r dich gedacht. Schade.',cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 3 then
			if getPlayerMoney(cid) >= 100 then
				if getPlayerFreeCap(cid) >= 18.00 then
					npcHandler:say('Sch�nes Gesch�ft! Hier bitten sch�n. M�chtest du noch einen Rucksack kaufen?', cid)
					doPlayerRemoveMoney(cid, 100)
					doPlayerAddItem(cid, 11241, 1)
					talkState[talkUser] = 3
				else
					npcHandler:say('Es scheint, du hast nicht die richtige Statur f�r solch einen Rucksack. R�cken zu klein, Kreuz zu hohl, Schultern zu schmal. Ist wohl einfach nicht f�r dich gedacht. Schade.', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Entschuldige, aber ohne Bezahlung kann ich es mir einfach nicht erlauben, dir ein Rucksack zu schenken. Daf�r sind sie zu teuer in der Herstellung.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 4 then
			if getPlayerItemCount(cid, 2425) >= 1 then
				if getPlayerItemCount(cid, 5889) >= 1 then
					npcHandler:say('Klasse, dann gib mal her... so, das muss hierhin... hier entfernen wir das Obsidian, um es dann... mmmhh.. und hier kommt das Draconian hin. Alles klar! Dein Obsidian Knife ist fertig. Bitte sch�n!', cid)
					doPlayerRemoveItem(cid, 2425, 1)
					doPlayerRemoveItem(cid, 5889, 1)
					doPlayerAddItem(cid, 5908, 1)
					talkState[talkUser] = 0
				else
					npcHandler:say('Entschuldige, aber es scheint, du h�ttest gar kein {Piece of Draconian Steel} dabei. Ich brauche das daf�r.', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Entschuldige, aber es scheint, du h�ttest gar keine {Obsidian Lance} dabei. Ich brauche das daf�r.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('W�re auch ein Zufall gewesen. Da kann man wohl nichts machen.', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann eben nicht. Wenn du es dir anders �berlegen solltest, sprich mich einfach auf den Rucksack an.', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Was kann ich sonst f�r dich tun? Vielleicht m�chtest du ja ein {Obsidian Knife}?', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

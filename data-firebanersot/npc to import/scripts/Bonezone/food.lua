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

	local shopWindow = {}
	local t = {
          [2666] = {buyPrice = 3, sellPrice = 0, storage = 1}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
          [2671] = {buyPrice = 5, sellPrice = 0, storage = 1},
          [2667] = {buyPrice = 5, sellPrice = 0, storage = 2},
          [2696] = {buyPrice = 4, sellPrice = 0, storage = 3},
          [13239] = {buyPrice = 10000, sellPrice = 0, storage = 4}
          }
	local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		if getPlayerMoney(cid) < t[item].buyPrice*amount then
			selfSay("Es tut mir leid, aber dein Geld reicht daf�r leider nicht aus.", cid)
		else
			doPlayerAddItem(cid, item, amount)
			doPlayerRemoveMoney(cid, t[item].buyPrice*amount)
			doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " f�r " .. t[item].buyPrice*amount .. " Gold gekauft.")
		end
		return true
	end

	local onSell = function(cid, item, subType, amount)
		doPlayerRemoveItem(cid, item, amount)
		doPlayerAddMoney(cid, t[item].sellPrice*amount)
		doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " f�r	" .. t[item].buyPrice*amount .. " Gold verkauft.")
		--selfSay("Here your are!", cid)
		return true
	end
	
	
	if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress) == -1 then
			npcHandler:say('Sch�n w�rs. Aber leider kann ich im Moment nichts verkaufen. Du k�nntest mir ja {helfen}?.', cid)
		else
			for var, ret in pairs(t) do
				if getPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress) >= ret.storage then
					table.insert(shopWindow, {id = var, subType = 0, buy = ret.buyPrice, sell = ret.sellPrice, name = getItemName(var)})
				end
			end
			openShopWindow(cid, shopWindow, onBuy, onSell) 
			npcHandler:say('Na dann futter dich mal durch mein Angebot.', cid)
		end
		return true
	end
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Oh ho, na da ist aber einer neugierig. Also ich sorge f�r die Mahlzeiten in Bonezone. Naja, eigentlich nur f�r das Fleisch. Um die Beilagen wie Gem�se und Fr�chte k�mmert sich {Irelia} und f�r die Getr�nke ist {Honghar} verantwortlich. Du k�nntest ihnen ja vielleicht Hilfe anbieten.', cid)
	elseif msgcontains(msg, 'grounds') then
		npcHandler:say({'Du fragst was die unterschiedlichen Grounds sind? Das es immer noch Leute gibt, die das nicht wissen. Die drei Grounds sind die sch�tzenden Graslandschaften rund um das Herzst�ck Bonezone. ...',
						'Da haben wir einmal die {Pleasure Grounds}, welche im Norden von Bonezone liegen. Sie sind die gr��ten und am meisten bewachsenen Grasgebiete hier. Au�erdem findest du dort den Maroon Mountain, die Bonelord Cave, die Mocous Lair und die Bonezone Troll Cave. ...',
						'Dann gibt es die {Spiry Grounds}, die sich direkt von hier aus westlich befinden. Sie sind die kleinsten und haben auch keine weitern Besonderheiten. ...',
						'Zu guter letzt w�ren da die {Livley Grounds}, welche du unter Bonezone und rund um Little Cotton findest. Dort wimmelt es nur so von Tieren und Ungeziefer. Jedoch solltest du es nicht vers�umen dort mal vorbeizuschauen. Neben der Skeleton Cave, einem kleinen Wyvern Berg und den Botanical Lands findest du dort auch meine Freundin {Irelia}. ...',
						'Du solltest sie unbedingt mal besuchen. Vielleicht kannst du ja auch ihr was helfen. Also, ich hoffe ich konnte dir helfen.'},cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Du suchst Vials? Xantharus in Little Cotton, dem Bereich gleich unter Bonezone, verkauft welche. Bei ihm wirst du mehr Erfolg als bei mir haben.', cid)
	elseif msgcontains(msg, 'winterberries') or msgcontains(msg, 'winterbeeren') then
		npcHandler:say('Du redest von einem Strauch Winterbeeren? Ja, das sind wirklich sch�ne Fr�chte. Aber nicht f�r Menschen. Durchfall und Fieber sind angesagt, solltest du auch nur eine Beere essen. Pferde jedoch stehen total auf diese kleinen Leckerbissen.', cid)
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') or msgcontains(msg, 'helfen') then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == -1 then
			npcHandler:say({'Ach du lieber Himmel, das finde ich aber nett von dir. Hilfe k�nnte ich n�mlich echt gut gebrauchen, deswegen kommt mir deine Nachfrage sehr gelegen. ...',
							'Zur Zeit verk�mmert Bonezone ein wenig und das wirkt sich auch auf die Stimmung der Leute aus. Ich hab das Gef�hl, ich bin der einzige, der hier noch halbrecht versucht die Laune etwas oben zu halten. ...',
							'Wie auch immer, Fakt ist, dass die Leute momentan sehr unzufrieden sind. Es gibt einfach kein gutes Essen mehr und das m�ssen wir �ndern. ...',
							'Wenn du mir bei der ein oder anderen Sache helfen w�rdest, w�rde das die Mahlzeiten von Bonezone enorm verbessern. Wie siehts aus, w�rst du dabei?'},cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 1 then
			npcHandler:say('Ah, da bist du ja! Hast du mein Cleaver dabei?',cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 2 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Das gibt es doch nicht! Jetzt hab ich endlich mein Cleaver wieder und kann trotzdem kein Fleisch verkaufen. Und wei�t du wieso? Weil das Fleisch nicht gut ist! ...',
								'Irgendwas stimmt damit nicht. Drei Schweine hab ich geschlachtet, und es kam nur ungenie�bares Fleisch dabei raus. Was f�r eine Verschwendung. Und jetzt wei� ich nicht was ich machen soll. ...',
								'Ich habe mal von einem Druiden geh�rt, der sich mit allen m�glichen Tieren, Monstern, Pflanzen und Krankheiten auskennt. Er k�nnte uns bestimmt helfen, das Problem mit den kranken Tieren zu l�sen. ...',
								'W�rst du bereit, diesen Druiden aufzusuchen?'},cid)
				talkState[talkUser] = 4
			else
				npcHandler:say('Was willst du hier? Habe ich dir nicht gesagt, dass ich etwas Zeit brauche, um meine Tiere zu schlachten? Komm sp�ter wieder!',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 3 then
			npcHandler:say('Bitte such diesen Druiden, ich muss einfach ein Heilmittel f�r meine Tiere bekommen.',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 4 then
			if doPlayerRemoveItem(cid, 7489, 1) == TRUE then
				npcHandler:say({'Das gibt es ja nicht! Du hast es tats�chlich geschafft den Druiden zu finden? Das ist ja super! ... Was sagst du da, meine Tiere sind vergiftet? Wie kann das denn passieren? ...',
								'Egal! Hauptsache ist, dass ich nun endlich ein Gegenmittel habe, um diesem Wahnsinn ein Ende zu bereiten. Ich bin dir wirklich sehr dankbar, du hast mir unglaublich geholfen. ...',
								'Nun kann ich endlich wieder mein schmackhaftes Fleisch verkaufen. Wenn du also etwas brauchst, frag mich einfach nach einem {trade}. Du kannst nat�rlich auch ohne Kaufwunsch nochmal bei mir vorbeischauen, ich werde sicherlich noch ein paar Aufgaben f�r dich haben.'},cid)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 5)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 1)
			else
				npcHandler:say('Ahh! Hallo! Hast du den Druiden schon gefunden? ... JA? Er muss dir doch irgendein Heilmittel gegeben haben... Hmmm.',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 5 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == -1 then
			npcHandler:say({'Hey, da bist du ja. Also, ich habe mir gedacht, dass wir nun mein Angebot etwas erweitern k�nnen. Das Fleisch kam auf jeden Fall schonmal gut an, aber ich brauch noch eine Alternative. ...',
							'Deswegen habe ich mir �berlegt vielleicht auch noch Fisch zu verkaufen. Das Problem ist nur, dass ich beim letzten mal, als ich geangelt habe, meine Angel liegen gelassen habe und nun finde ich sie nicht mehr. ...',
							'W�rst du bereit mir meine Angel zu bringen? Du m�sstest sie nat�rlich erstmal suchen.'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 6 then
			npcHandler:say('Du solltest doch meine Angel suchen, schon vergessen?',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 7 then
			npcHandler:say('Hast du meine Angel wirklich gefunden?',cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 8 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Und schon wieder k�nnen wir uns nicht der n�chsten Aufgabe widmen. Diesmal ist das Problem, dass die Fische aus dem umherliegenden Ozean nicht anbei�en, aus welchem Grund auch immer. ...',
								'Langsam habe ich so eine Vermutung, aber zuerst muss ich sicherstellen, dass es nicht an den K�dern liegt, die ich benutze. Ich werde einen besseren K�der verwenden, um zu gucken, ob sie dann anbei�en werden. ...',
								'Ich habe bisher nur von einem solchen K�der geh�rt, der das bewirken kann, doch ist er vergraben in einer gro�en H�hle, genauer gesagt: in einer Bonelord-H�hle. ...',
								'Ich selber habe nat�rlich keine Zeit dazu und bin viel zu schlecht ausger�stet, du jedoch siehst nach einem tapferen Krieger aus, der sich trauen w�rde, solch eine H�hle zu betreten und zu erkunden. ...',
								'Ich wei�, dass es wirklich viel verlangt ist, aber w�rdest du mir diesen K�der besorgen?'},cid)
				talkState[talkUser] = 7
			else
				npcHandler:say('Lass mir bitte noch ein wenig mehr Zeit, so schnell bin ich nun auch wieder nicht.',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 9 then
			npcHandler:say('Ich glaubs nicht, mein Gott bist du schnell! Hast du den besonderen K�der dabei?',cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 10 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == -1 then
			npcHandler:say({'Sch�n dich wiederzusehen! Bist du bereit f�r meine dritte und letzte Aufgabe? Ja? Dann setzt dich hin und h�r gut zu, ich erz�hl dir das ganze nicht zweimal. ...',
							'Fr�her habe ich auch K�se verkauft, damit auch die Vegetarier etwas bei mir zu mampfen haben. Doch heute, da Bonezone so verarmt ist, kann ich mir es nicht mehr leisten, den lang gereiften und teuren K�se zu verkaufen. ...',
							'Das w�rde ich gerne �ndern und den gut bew�hrten K�se wieder in mein Sortiment aufnehmen. Was mir fehlt ist die Milch, jedoch wei� ich wo ich welche herbekommen kann. ...',
							'Oder besser gesagt: Du! Denn hier steigt n�mlich deine Aufgabe ein. Du m�sstest mir die Milch bringen, um bei mir auch K�se kaufen zu k�nnen. Ich sage dir, wo du sie herbekommst, wenn du zustimmst: ...',
							'W�rst du so freundlich und w�rdest mir etwas Milch besorgen?'},cid)
			talkState[talkUser] = 9
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 11 then
			npcHandler:say('Oh, da bist du ja? Hast du die Milch dabei? Wenn ja, sch�tte sie doch bitte in den Kanister dahinten in der Ecke. Dann werde ich endlich wieder meinen K�se herstellen k�nnen.',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 12 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Es war nat�rlich zu erwarten, aber trotzdem bin ich sauer. Auch mit dem K�se stimmt etwas nicht. Ich bin mir sicher, dass es an der Milch liegt. ...',
								'Langsam platzt mir wirklich der Kragen. Als du vor einiger Zeit hierhinkamst dachte ich, dass ich DREI Aufgaben f�r dich h�tte, die nicht so schwer zu erledigen seien. ...',
								'Aber nun muss ich dich nochmals um einen Gefallen bitten: Du musst zur�ck zu {Xantharus} und ihn fragen, wo er denn seine Milch herbekommt, denn die ist eindeutig nicht gut. ...',
								'Wenn er dir nicht glaubt, zeige ihm das hier, mit diesem verschimmelten K�se wirst du ihn sicherlich �berzeugen. Also, frage ihn nach der {Quelle} des K�ses und zeig ihm diesen {Mouldy Cheese}. Viel Gl�ck!'},cid)
				doPlayerAddItem(cid, 2235, 1)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 13)
			else
				npcHandler:say('H�r mal, ich finde es ja sehr nett, dass du mir etwas Milch gebracht hast, aber damit kann ich auch nichts anfangen, wenn du mir nicht etwas Zeit l�sst. Komm bitte sp�ter wieder!',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 13 then
			npcHandler:say('Ich hab dich doch gebeten {Xantharus} aus Little Cotton nach seiner {Quelle} zu fragen. Bevor du etwas neues von mir m�chtest, erledige bitte erstmal das!',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 14 then
			npcHandler:say({'Du hast dich also erneut mit {Xantharus} unterhalten? Und, was hat er gesagt? ... Aha ... Mhhh ... Alles klar! Das bedeutet nicht mehr und nicht weniger, als dass sich meine schlimmsten Bef�rchtungen bewahrheitet haben. Na Klasse! ...',
							'Dass er mir st�ndig meine Milch geklaut hat, muss ich ihm jetzt f�rs Erste verzeihen, ich unterhalte mich sp�ter mit ihm dar�ber. Zu aller erst m�ssen wir uns jetzt um das Problem mit der Strahlung k�mmern. ...',
							'Ja, du hast richtig geh�rt: Strahlung! Sie war die ganze Zeit �ber das Problem f�r die pl�tzlich auftretenden Merkw�rdigkeiten. Und ihr Ursprung liegt... - Ich will es eigentlich gar nicht laut sagen - ... in der {Feverish Factory}. ...',
							'Du wei�t hoffentlich, welche Fabrik dies betrifft? Westlich von Bonezone befindet sich eine kleine Insel, abgespalten von der Hauptinsel, auf welcher die heutzutage versto�ene und vers�uchte Fabrik steht. ...',
							'Sie wurde einfach damals vom Rest der Insel weggeschnitten, da ihre Energiekosten und die Vers�uchungsgefahr zu hoch war. Doch dann begann das Grauen: Strahlung �berall! ...',
							'Es bringt nichts ein Geschw�r einfach nur wegzuschneiden, man muss es auch zerst�ren. Anscheinend haben sich in der Fabrik mittlerweile jede Menge dunkler Kreaturen versteckt, sie ist �beraus gef�hrlich f�r jedes Lebewesen. ...',
							'Es gab Versuche mit Tieren, aber ich will nicht wissen, wie die damals aussahen. Schrecklich! Jedenfalls gibt diese Fabrik heute immer noch Strahlung ab, und das ist hochgiftig. ...',
							'Allerdings erkl�rt es auch warum meine Tiere vergiftet waren, die Fische nicht anbissen und die Milch nicht gut war. Diese Fabrik abzustellen w�rde all unsere Probleme l�sen und die Stadt Bonezone sehr viel weiter bringen. ...',
							'Stell dir nur vor, du w�rst der Jenige, der uns davon befreit, unser Held. Ruhm und Ehre w�rde dir geb�hren. Ich h�tte nicht gedacht, dass ich, ein armer Farmer, dir diese wichtige Aufgabe stellen darf. ...',
							'Wirst du uns von den Qualen befreien und die Fabrik abstellen?'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 15)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 3)
			talkState[talkUser] = 10
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 15 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission4) == -1 then
			npcHandler:say('Ahh, da bist du ja. Wirst du uns von den Qualen befreien und die Fabrik abstellen?',cid)
			talkState[talkUser] = 10
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission4) == 17 then
			npcHandler:say({'DU HAST ES GESCHAFFT! Du bist unser Held, der Retter von Bonezone. Ich werfe mich vor dir nieder und sage von tiefstem Herzen: DANKE SCH�N! ...',
							'Verzeih mir dich um diesen aller, aller letzen Gefallen zu bitten: Geh nach Little Cotton und sprich mit {Atlantos}, dem K�nig von {Bonezone} und frage nach deiner {Belohnung}. Ich habe ihn von deiner Heldentat unterrichtet. ...',
							'Nach allem, was wir durchgemacht haben, finde ich es t�richt dich danach zu fragen, aber trotzdem w�nsche ich es mir: Kommst du mich noch einmal besuchen? Mein Angebot steht jederzeit f�r dich offen! ...',
							'Au�erdem habe ich mein Angebot f�r dich ein wenig erweitert. Du kannst jetzt auch Winterbeeren bei mir kaufen. Aber vorsicht, selber essen solltest du diese nicht. F�r Menschen sind sie �u�erst giftig. Pferde jedoch stehen total auf diese Beeren. Du kannst ja meine im Stall mal f�ttern. Sie werden sich freuen. ...',
							'Auch w�rde ich es toll finden, wenn du mal meine Freundin {Irelia} besuchen w�rdest. Sie arbeitet �stlich der {Livley Grounds} auf dem {Botanical Land}. Vielleicht kannst du ja auch ihr helfen. Also dann, auf ein Wiedersehen, Held von Bonezone!'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission4, 18)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 4)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Das finde ich ja gro�artig! Dann lass uns gleich anfangen und das erste Manko dieser Stadt beheben: Das Fleisch! Seit geraumer Zeit gibt es einfach kein ordentlich saftiges Fleisch mehr in Bonezone. ...',
							'Um dies zu �ndern musst du f�r mich zuallererst einmal zu meiner kleinen Farm im Norden gehen und mir mein {Cleaver} bringen. Bei meinem letzten Besuch habe ich ihn wohl dort vergessen. W�rdest du das tun?'},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Super! Also wie schon gesagt befindet sich mein Cleaver in meiner kleinen Farm auf den {Pleasure Grounds} im Norden. Du musst am Maroon Mountain vorbei, also der rote Berg bewohnt von den Goblins, und dich dann westlich halten. Nicht zu verpassen. Viel Gl�ck!',cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 1)
			talkState[talkUser] = 0	
		elseif talkState[talkUser] == 3 then
			if doPlayerRemoveItem(cid, 2568, 1) == TRUE then
				npcHandler:say('Ahh, da ist ja mein Cleaver. Und ich hatte mir schon Sorgen gemacht... Nun denn, lass mich erstmal alleine. Ich muss mich allm�hlich beeilen, die Leute kriegen Hunger, und ich hab noch nicht ein einziges Schwein geschlachtet. Komm bitte sp�ter wieder, dann k�nnen wir mein Angebot erweitern.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 2)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue, os.time() + theDeliciousHelperQuestTimes.timeDelayMission1)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Du kommst wohl ohne mein Cleaver hierher. Aber ich kann dir nichts verkaufen, solange du mir nicht mein Cleaver gebracht hast. Hol es mir, bitte.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Das finde ich ja super nett. Die Tiere werden sich freuen. Also, ich habe geh�rt, er soll auf einem der h�chsten Punkte des Cyclopen Bergs nahe Pulgra leben. Schau dich doch einfach mal um und zeig ihm das hier, bitte! Er wird dir helfen k�nnen.', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 3)
			doPlayerAddItem(cid, 2227, 1)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Klasse! Also ich habe sie auf jeden Fall irgendwo um Bonezone herum liegen gelassen. Wo genau wei� ich aber nicht mehr. Schau dich einfach mal auf den verschiedenen {Grounds} um.', cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 6)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			if doPlayerRemoveItem(cid, 10223, 1) == TRUE then
				npcHandler:say('Du bist echt der Wahnsinn, wei�t du das? Du hast mir schon so viel geholfen. Durch meine Angel kann ich jetzt endlich wieder Fische angeln und mein Angebot ausbauen. Ich werde deine Hilfe mit Sicherheit nochmal gebrauchen k�nnen, aber du musst mir erstmal etwas Zeit zum Anglen lassen. Bis sp�ter dann!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 8)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue, os.time() + theDeliciousHelperQuestTimes.timeDelayMission2)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Bel�g mich doch nicht, du hast sie ja gar nicht gefunden, oder zumindest nicht dabei. Ich brauche sie dringend!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Gro�artig! Gro�artig! Der K�der kann nicht allzu tief begraben sein, denn sonst w�sste ja keiner von ihm. Suche einfach auf den {Pleasure Grounds} nach einem Eingang in die Bonelord-Cave. Vielen Dank!', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 9)
		elseif talkState[talkUser] == 8 then
			if doPlayerRemoveItem(cid, 10943, 1) == TRUE then
				npcHandler:say('Ich bin sprachlos, wirklich sprachlos. Vielen, vielen Dank. Damit m�ssen die Fische einfach anbei�en. Schau doch nochmal vorbei, wenn du Zeit hast. Es gibt immer was zu tun. Bis sp�ter!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 10)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 2)
			else
				npcHandler:say('Und ich hatte mich schon gefreut. Sag doch bitte nicht ja, wenn du ihn gar nicht hast!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Fantastisch! Mein Freund {Xantharus} arbeitet in {Little Cotton}, dem kleinen Bereich unter Bonezone. Er wird dir die Milch verkaufen. Ich ben�tige nur eine Vial, das reicht f�r den Anfang. Viel Erfolg!', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 11)
		elseif talkState[talkUser] == 10 then	
			npcHandler:say({'Ich glaub es nicht. Du bist der mutigste, tapferste und edelste Mensch, den ich je in meinem Leben kennenlernen durfte. Die �berfahrt zu der Fabrik findest du an der westlichen Spitze der {Pleasure Grounds}. ...',
							'{Embor} wird dich hin�berbringen. Allerdings nur, wenn dies ungef�hrlich ist. Folge seinen Anweisungen! Wenn du auf der Insel bist, suchst du nach einem Keller, aus dem die Fabrik den Strom entnimmt. ...',
							'In diesem Keller haben sich wahrscheinlich mittlerweile energie�hnliche Monster eingenistet. Du wirst ihn schon finden. In dem Keller ist ein auff�lliger gro�er Apparat. Schalte diesen ab! Kehre danach zur�ck zu mir! Ich wei�, dass du es schaffst. Viel Gl�ck!'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission4, 16)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Nicht? Och, wie Schade. Tja, da kann man nichts machen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann h�tte ich mir das Gelaber ja sparen k�nnen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Schade, aber ich bin mir sicher, dass du es noch findest. Was willst du sonst, vielleicht einen {trade}?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Och Manno, ich dachte du k�mst gerade in Fahrt mir zu helfen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Dann komm eben erst vorbei, wenn du sie gefunden hast.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Warum sprichst du mich dann darauf an?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Ich hab fast mit gerechnet. Es ist auch eine schwierige Aufgabe. Tja, dann muss ich eben jemanden anderen fragen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Ok, dann eben nicht.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Dann muss ich eben selber gucken, wie ich jetzt an Milch komme. Ich hab nur so viel zu tun...', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 10 then
			npcHandler:say('NEIN? Nein? Das h�tte ich nicht gedacht, nach allem was du bisher geschafft hast.', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

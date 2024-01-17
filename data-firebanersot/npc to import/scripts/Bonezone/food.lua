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
			selfSay("Es tut mir leid, aber dein Geld reicht dafür leider nicht aus.", cid)
		else
			doPlayerAddItem(cid, item, amount)
			doPlayerRemoveMoney(cid, t[item].buyPrice*amount)
			doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für " .. t[item].buyPrice*amount .. " Gold gekauft.")
		end
		return true
	end

	local onSell = function(cid, item, subType, amount)
		doPlayerRemoveItem(cid, item, amount)
		doPlayerAddMoney(cid, t[item].sellPrice*amount)
		doPlayerSendTextMessage(cid, 20, "Du hast " .. amount .. "x " .. getItemName(item) .. " für	" .. t[item].buyPrice*amount .. " Gold verkauft.")
		--selfSay("Here your are!", cid)
		return true
	end
	
	
	if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress) == -1 then
			npcHandler:say('Schön wärs. Aber leider kann ich im Moment nichts verkaufen. Du könntest mir ja {helfen}?.', cid)
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
		npcHandler:say('Oh ho, na da ist aber einer neugierig. Also ich sorge für die Mahlzeiten in Bonezone. Naja, eigentlich nur für das Fleisch. Um die Beilagen wie Gemüse und Früchte kümmert sich {Irelia} und für die Getränke ist {Honghar} verantwortlich. Du könntest ihnen ja vielleicht Hilfe anbieten.', cid)
	elseif msgcontains(msg, 'grounds') then
		npcHandler:say({'Du fragst was die unterschiedlichen Grounds sind? Das es immer noch Leute gibt, die das nicht wissen. Die drei Grounds sind die schützenden Graslandschaften rund um das Herzstück Bonezone. ...',
						'Da haben wir einmal die {Pleasure Grounds}, welche im Norden von Bonezone liegen. Sie sind die größten und am meisten bewachsenen Grasgebiete hier. Außerdem findest du dort den Maroon Mountain, die Bonelord Cave, die Mocous Lair und die Bonezone Troll Cave. ...',
						'Dann gibt es die {Spiry Grounds}, die sich direkt von hier aus westlich befinden. Sie sind die kleinsten und haben auch keine weitern Besonderheiten. ...',
						'Zu guter letzt wären da die {Livley Grounds}, welche du unter Bonezone und rund um Little Cotton findest. Dort wimmelt es nur so von Tieren und Ungeziefer. Jedoch solltest du es nicht versäumen dort mal vorbeizuschauen. Neben der Skeleton Cave, einem kleinen Wyvern Berg und den Botanical Lands findest du dort auch meine Freundin {Irelia}. ...',
						'Du solltest sie unbedingt mal besuchen. Vielleicht kannst du ja auch ihr was helfen. Also, ich hoffe ich konnte dir helfen.'},cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Du suchst Vials? Xantharus in Little Cotton, dem Bereich gleich unter Bonezone, verkauft welche. Bei ihm wirst du mehr Erfolg als bei mir haben.', cid)
	elseif msgcontains(msg, 'winterberries') or msgcontains(msg, 'winterbeeren') then
		npcHandler:say('Du redest von einem Strauch Winterbeeren? Ja, das sind wirklich schöne Früchte. Aber nicht für Menschen. Durchfall und Fieber sind angesagt, solltest du auch nur eine Beere essen. Pferde jedoch stehen total auf diese kleinen Leckerbissen.', cid)
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') or msgcontains(msg, 'helfen') then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == -1 then
			npcHandler:say({'Ach du lieber Himmel, das finde ich aber nett von dir. Hilfe könnte ich nämlich echt gut gebrauchen, deswegen kommt mir deine Nachfrage sehr gelegen. ...',
							'Zur Zeit verkümmert Bonezone ein wenig und das wirkt sich auch auf die Stimmung der Leute aus. Ich hab das Gefühl, ich bin der einzige, der hier noch halbrecht versucht die Laune etwas oben zu halten. ...',
							'Wie auch immer, Fakt ist, dass die Leute momentan sehr unzufrieden sind. Es gibt einfach kein gutes Essen mehr und das müssen wir ändern. ...',
							'Wenn du mir bei der ein oder anderen Sache helfen würdest, würde das die Mahlzeiten von Bonezone enorm verbessern. Wie siehts aus, wärst du dabei?'},cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 1 then
			npcHandler:say('Ah, da bist du ja! Hast du mein Cleaver dabei?',cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 2 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Das gibt es doch nicht! Jetzt hab ich endlich mein Cleaver wieder und kann trotzdem kein Fleisch verkaufen. Und weißt du wieso? Weil das Fleisch nicht gut ist! ...',
								'Irgendwas stimmt damit nicht. Drei Schweine hab ich geschlachtet, und es kam nur ungenießbares Fleisch dabei raus. Was für eine Verschwendung. Und jetzt weiß ich nicht was ich machen soll. ...',
								'Ich habe mal von einem Druiden gehört, der sich mit allen möglichen Tieren, Monstern, Pflanzen und Krankheiten auskennt. Er könnte uns bestimmt helfen, das Problem mit den kranken Tieren zu lösen. ...',
								'Wärst du bereit, diesen Druiden aufzusuchen?'},cid)
				talkState[talkUser] = 4
			else
				npcHandler:say('Was willst du hier? Habe ich dir nicht gesagt, dass ich etwas Zeit brauche, um meine Tiere zu schlachten? Komm später wieder!',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 3 then
			npcHandler:say('Bitte such diesen Druiden, ich muss einfach ein Heilmittel für meine Tiere bekommen.',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 4 then
			if doPlayerRemoveItem(cid, 7489, 1) == TRUE then
				npcHandler:say({'Das gibt es ja nicht! Du hast es tatsächlich geschafft den Druiden zu finden? Das ist ja super! ... Was sagst du da, meine Tiere sind vergiftet? Wie kann das denn passieren? ...',
								'Egal! Hauptsache ist, dass ich nun endlich ein Gegenmittel habe, um diesem Wahnsinn ein Ende zu bereiten. Ich bin dir wirklich sehr dankbar, du hast mir unglaublich geholfen. ...',
								'Nun kann ich endlich wieder mein schmackhaftes Fleisch verkaufen. Wenn du also etwas brauchst, frag mich einfach nach einem {trade}. Du kannst natürlich auch ohne Kaufwunsch nochmal bei mir vorbeischauen, ich werde sicherlich noch ein paar Aufgaben für dich haben.'},cid)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 5)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 1)
			else
				npcHandler:say('Ahh! Hallo! Hast du den Druiden schon gefunden? ... JA? Er muss dir doch irgendein Heilmittel gegeben haben... Hmmm.',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 5 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == -1 then
			npcHandler:say({'Hey, da bist du ja. Also, ich habe mir gedacht, dass wir nun mein Angebot etwas erweitern können. Das Fleisch kam auf jeden Fall schonmal gut an, aber ich brauch noch eine Alternative. ...',
							'Deswegen habe ich mir überlegt vielleicht auch noch Fisch zu verkaufen. Das Problem ist nur, dass ich beim letzten mal, als ich geangelt habe, meine Angel liegen gelassen habe und nun finde ich sie nicht mehr. ...',
							'Wärst du bereit mir meine Angel zu bringen? Du müsstest sie natürlich erstmal suchen.'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 6 then
			npcHandler:say('Du solltest doch meine Angel suchen, schon vergessen?',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 7 then
			npcHandler:say('Hast du meine Angel wirklich gefunden?',cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 8 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Und schon wieder können wir uns nicht der nächsten Aufgabe widmen. Diesmal ist das Problem, dass die Fische aus dem umherliegenden Ozean nicht anbeißen, aus welchem Grund auch immer. ...',
								'Langsam habe ich so eine Vermutung, aber zuerst muss ich sicherstellen, dass es nicht an den Ködern liegt, die ich benutze. Ich werde einen besseren Köder verwenden, um zu gucken, ob sie dann anbeißen werden. ...',
								'Ich habe bisher nur von einem solchen Köder gehört, der das bewirken kann, doch ist er vergraben in einer großen Höhle, genauer gesagt: in einer Bonelord-Höhle. ...',
								'Ich selber habe natürlich keine Zeit dazu und bin viel zu schlecht ausgerüstet, du jedoch siehst nach einem tapferen Krieger aus, der sich trauen würde, solch eine Höhle zu betreten und zu erkunden. ...',
								'Ich weiß, dass es wirklich viel verlangt ist, aber würdest du mir diesen Köder besorgen?'},cid)
				talkState[talkUser] = 7
			else
				npcHandler:say('Lass mir bitte noch ein wenig mehr Zeit, so schnell bin ich nun auch wieder nicht.',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 9 then
			npcHandler:say('Ich glaubs nicht, mein Gott bist du schnell! Hast du den besonderen Köder dabei?',cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission2) == 10 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == -1 then
			npcHandler:say({'Schön dich wiederzusehen! Bist du bereit für meine dritte und letzte Aufgabe? Ja? Dann setzt dich hin und hör gut zu, ich erzähl dir das ganze nicht zweimal. ...',
							'Früher habe ich auch Käse verkauft, damit auch die Vegetarier etwas bei mir zu mampfen haben. Doch heute, da Bonezone so verarmt ist, kann ich mir es nicht mehr leisten, den lang gereiften und teuren Käse zu verkaufen. ...',
							'Das würde ich gerne ändern und den gut bewährten Käse wieder in mein Sortiment aufnehmen. Was mir fehlt ist die Milch, jedoch weiß ich wo ich welche herbekommen kann. ...',
							'Oder besser gesagt: Du! Denn hier steigt nämlich deine Aufgabe ein. Du müsstest mir die Milch bringen, um bei mir auch Käse kaufen zu können. Ich sage dir, wo du sie herbekommst, wenn du zustimmst: ...',
							'Wärst du so freundlich und würdest mir etwas Milch besorgen?'},cid)
			talkState[talkUser] = 9
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 11 then
			npcHandler:say('Oh, da bist du ja? Hast du die Milch dabei? Wenn ja, schütte sie doch bitte in den Kanister dahinten in der Ecke. Dann werde ich endlich wieder meinen Käse herstellen können.',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 12 then
			if getPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue) <= os.time() then
				npcHandler:say({'Es war natürlich zu erwarten, aber trotzdem bin ich sauer. Auch mit dem Käse stimmt etwas nicht. Ich bin mir sicher, dass es an der Milch liegt. ...',
								'Langsam platzt mir wirklich der Kragen. Als du vor einiger Zeit hierhinkamst dachte ich, dass ich DREI Aufgaben für dich hätte, die nicht so schwer zu erledigen seien. ...',
								'Aber nun muss ich dich nochmals um einen Gefallen bitten: Du musst zurück zu {Xantharus} und ihn fragen, wo er denn seine Milch herbekommt, denn die ist eindeutig nicht gut. ...',
								'Wenn er dir nicht glaubt, zeige ihm das hier, mit diesem verschimmelten Käse wirst du ihn sicherlich überzeugen. Also, frage ihn nach der {Quelle} des Käses und zeig ihm diesen {Mouldy Cheese}. Viel Glück!'},cid)
				doPlayerAddItem(cid, 2235, 1)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 13)
			else
				npcHandler:say('Hör mal, ich finde es ja sehr nett, dass du mir etwas Milch gebracht hast, aber damit kann ich auch nichts anfangen, wenn du mir nicht etwas Zeit lässt. Komm bitte später wieder!',cid)
			end
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission1) == 13 then
			npcHandler:say('Ich hab dich doch gebeten {Xantharus} aus Little Cotton nach seiner {Quelle} zu fragen. Bevor du etwas neues von mir möchtest, erledige bitte erstmal das!',cid)
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 14 then
			npcHandler:say({'Du hast dich also erneut mit {Xantharus} unterhalten? Und, was hat er gesagt? ... Aha ... Mhhh ... Alles klar! Das bedeutet nicht mehr und nicht weniger, als dass sich meine schlimmsten Befürchtungen bewahrheitet haben. Na Klasse! ...',
							'Dass er mir ständig meine Milch geklaut hat, muss ich ihm jetzt fürs Erste verzeihen, ich unterhalte mich später mit ihm darüber. Zu aller erst müssen wir uns jetzt um das Problem mit der Strahlung kümmern. ...',
							'Ja, du hast richtig gehört: Strahlung! Sie war die ganze Zeit über das Problem für die plötzlich auftretenden Merkwürdigkeiten. Und ihr Ursprung liegt... - Ich will es eigentlich gar nicht laut sagen - ... in der {Feverish Factory}. ...',
							'Du weißt hoffentlich, welche Fabrik dies betrifft? Westlich von Bonezone befindet sich eine kleine Insel, abgespalten von der Hauptinsel, auf welcher die heutzutage verstoßene und versäuchte Fabrik steht. ...',
							'Sie wurde einfach damals vom Rest der Insel weggeschnitten, da ihre Energiekosten und die Versäuchungsgefahr zu hoch war. Doch dann begann das Grauen: Strahlung überall! ...',
							'Es bringt nichts ein Geschwür einfach nur wegzuschneiden, man muss es auch zerstören. Anscheinend haben sich in der Fabrik mittlerweile jede Menge dunkler Kreaturen versteckt, sie ist überaus gefährlich für jedes Lebewesen. ...',
							'Es gab Versuche mit Tieren, aber ich will nicht wissen, wie die damals aussahen. Schrecklich! Jedenfalls gibt diese Fabrik heute immer noch Strahlung ab, und das ist hochgiftig. ...',
							'Allerdings erklärt es auch warum meine Tiere vergiftet waren, die Fische nicht anbissen und die Milch nicht gut war. Diese Fabrik abzustellen würde all unsere Probleme lösen und die Stadt Bonezone sehr viel weiter bringen. ...',
							'Stell dir nur vor, du wärst der Jenige, der uns davon befreit, unser Held. Ruhm und Ehre würde dir gebühren. Ich hätte nicht gedacht, dass ich, ein armer Farmer, dir diese wichtige Aufgabe stellen darf. ...',
							'Wirst du uns von den Qualen befreien und die Fabrik abstellen?'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 15)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 3)
			talkState[talkUser] = 10
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 15 and getPlayerStorageValue(cid, theDeliciousHelperQuest.mission4) == -1 then
			npcHandler:say('Ahh, da bist du ja. Wirst du uns von den Qualen befreien und die Fabrik abstellen?',cid)
			talkState[talkUser] = 10
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission4) == 17 then
			npcHandler:say({'DU HAST ES GESCHAFFT! Du bist unser Held, der Retter von Bonezone. Ich werfe mich vor dir nieder und sage von tiefstem Herzen: DANKE SCHÖN! ...',
							'Verzeih mir dich um diesen aller, aller letzen Gefallen zu bitten: Geh nach Little Cotton und sprich mit {Atlantos}, dem König von {Bonezone} und frage nach deiner {Belohnung}. Ich habe ihn von deiner Heldentat unterrichtet. ...',
							'Nach allem, was wir durchgemacht haben, finde ich es töricht dich danach zu fragen, aber trotzdem wünsche ich es mir: Kommst du mich noch einmal besuchen? Mein Angebot steht jederzeit für dich offen! ...',
							'Außerdem habe ich mein Angebot für dich ein wenig erweitert. Du kannst jetzt auch Winterbeeren bei mir kaufen. Aber vorsicht, selber essen solltest du diese nicht. Für Menschen sind sie äußerst giftig. Pferde jedoch stehen total auf diese Beeren. Du kannst ja meine im Stall mal füttern. Sie werden sich freuen. ...',
							'Auch würde ich es toll finden, wenn du mal meine Freundin {Irelia} besuchen würdest. Sie arbeitet östlich der {Livley Grounds} auf dem {Botanical Land}. Vielleicht kannst du ja auch ihr helfen. Also dann, auf ein Wiedersehen, Held von Bonezone!'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission4, 18)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 4)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Das finde ich ja großartig! Dann lass uns gleich anfangen und das erste Manko dieser Stadt beheben: Das Fleisch! Seit geraumer Zeit gibt es einfach kein ordentlich saftiges Fleisch mehr in Bonezone. ...',
							'Um dies zu ändern musst du für mich zuallererst einmal zu meiner kleinen Farm im Norden gehen und mir mein {Cleaver} bringen. Bei meinem letzten Besuch habe ich ihn wohl dort vergessen. Würdest du das tun?'},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Super! Also wie schon gesagt befindet sich mein Cleaver in meiner kleinen Farm auf den {Pleasure Grounds} im Norden. Du musst am Maroon Mountain vorbei, also der rote Berg bewohnt von den Goblins, und dich dann westlich halten. Nicht zu verpassen. Viel Glück!',cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 1)
			talkState[talkUser] = 0	
		elseif talkState[talkUser] == 3 then
			if doPlayerRemoveItem(cid, 2568, 1) == TRUE then
				npcHandler:say('Ahh, da ist ja mein Cleaver. Und ich hatte mir schon Sorgen gemacht... Nun denn, lass mich erstmal alleine. Ich muss mich allmählich beeilen, die Leute kriegen Hunger, und ich hab noch nicht ein einziges Schwein geschlachtet. Komm bitte später wieder, dann können wir mein Angebot erweitern.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 2)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue, os.time() + theDeliciousHelperQuestTimes.timeDelayMission1)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Du kommst wohl ohne mein Cleaver hierher. Aber ich kann dir nichts verkaufen, solange du mir nicht mein Cleaver gebracht hast. Hol es mir, bitte.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Das finde ich ja super nett. Die Tiere werden sich freuen. Also, ich habe gehört, er soll auf einem der höchsten Punkte des Cyclopen Bergs nahe Pulgra leben. Schau dich doch einfach mal um und zeig ihm das hier, bitte! Er wird dir helfen können.', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission1, 3)
			doPlayerAddItem(cid, 2227, 1)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Klasse! Also ich habe sie auf jeden Fall irgendwo um Bonezone herum liegen gelassen. Wo genau weiß ich aber nicht mehr. Schau dich einfach mal auf den verschiedenen {Grounds} um.', cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 6)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			if doPlayerRemoveItem(cid, 10223, 1) == TRUE then
				npcHandler:say('Du bist echt der Wahnsinn, weißt du das? Du hast mir schon so viel geholfen. Durch meine Angel kann ich jetzt endlich wieder Fische angeln und mein Angebot ausbauen. Ich werde deine Hilfe mit Sicherheit nochmal gebrauchen können, aber du musst mir erstmal etwas Zeit zum Anglen lassen. Bis später dann!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 8)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.timeDelayValue, os.time() + theDeliciousHelperQuestTimes.timeDelayMission2)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Belüg mich doch nicht, du hast sie ja gar nicht gefunden, oder zumindest nicht dabei. Ich brauche sie dringend!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Großartig! Großartig! Der Köder kann nicht allzu tief begraben sein, denn sonst wüsste ja keiner von ihm. Suche einfach auf den {Pleasure Grounds} nach einem Eingang in die Bonelord-Cave. Vielen Dank!', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 9)
		elseif talkState[talkUser] == 8 then
			if doPlayerRemoveItem(cid, 10943, 1) == TRUE then
				npcHandler:say('Ich bin sprachlos, wirklich sprachlos. Vielen, vielen Dank. Damit müssen die Fische einfach anbeißen. Schau doch nochmal vorbei, wenn du Zeit hast. Es gibt immer was zu tun. Bis später!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission2, 10)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.shopProgress, 2)
			else
				npcHandler:say('Und ich hatte mich schon gefreut. Sag doch bitte nicht ja, wenn du ihn gar nicht hast!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Fantastisch! Mein Freund {Xantharus} arbeitet in {Little Cotton}, dem kleinen Bereich unter Bonezone. Er wird dir die Milch verkaufen. Ich benötige nur eine Vial, das reicht für den Anfang. Viel Erfolg!', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 11)
		elseif talkState[talkUser] == 10 then	
			npcHandler:say({'Ich glaub es nicht. Du bist der mutigste, tapferste und edelste Mensch, den ich je in meinem Leben kennenlernen durfte. Die Überfahrt zu der Fabrik findest du an der westlichen Spitze der {Pleasure Grounds}. ...',
							'{Embor} wird dich hinüberbringen. Allerdings nur, wenn dies ungefährlich ist. Folge seinen Anweisungen! Wenn du auf der Insel bist, suchst du nach einem Keller, aus dem die Fabrik den Strom entnimmt. ...',
							'In diesem Keller haben sich wahrscheinlich mittlerweile energieähnliche Monster eingenistet. Du wirst ihn schon finden. In dem Keller ist ein auffälliger großer Apparat. Schalte diesen ab! Kehre danach zurück zu mir! Ich weiß, dass du es schaffst. Viel Glück!'},cid)
			setPlayerStorageValue(cid, theDeliciousHelperQuest.mission4, 16)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Nicht? Och, wie Schade. Tja, da kann man nichts machen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann hätte ich mir das Gelaber ja sparen können.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Schade, aber ich bin mir sicher, dass du es noch findest. Was willst du sonst, vielleicht einen {trade}?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Och Manno, ich dachte du kämst gerade in Fahrt mir zu helfen.', cid)
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
			npcHandler:say('NEIN? Nein? Das hätte ich nicht gedacht, nach allem was du bisher geschafft hast.', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end


function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) and npcHandler:isInRange(cid) and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'hallo')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) >= 1 then
			npcHandler:greet(cid)
			return TRUE
		else
			npcHandler:say('Verschwinde blo�, oder ich erhebe meine Kr�fte gegen dich!', cid)
			return false
		end	
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Ich bin die wei�e Hexe der Natur, W�chter �ber die Pflanzen und Tiere auf ganz Fireban. Dies ist meine Berufung seit ich lebe und sorge. ...',
						'Au�erdem muss ich mich noch immer vor den l�cherlichen Angriffen meiner Schwester Hepzibah sch�tzen. Unser Krieg weilt nun schon sehr lange und manchmal sp�rt es ganz Bonezone.'},cid)
	elseif msgcontains(msg, 'hepzibah') then
		npcHandler:say({'Meine Schwester Hepzibah ist die schwarze Hexe der Monster und Kreaturen. Wir haben uns vor langer Zeit zerstritten und f�hren nun einen verbitterten Kampf. ...',
						'Sie greift mich an, indem sie ihre dunklen Kreaturen gegen mich einsetzt und ich wehre sie mit den m�chtigen Kr�ften der Natur ab.'},cid)
	elseif msgcontains(msg, 'watercave') then
		npcHandler:say({'Dies ist die H�hle genau unter uns, welche sich in Mitten eines riesigen unterirdischen Sees von mir erbaut befindet. Sie h�lt eine gro�e Auswahl und Menge Hepzibahs Monster gefangen. ...',
						'Deswegen versucht sie auch schon seit Jahren dort einzubrechen und sich Zugang zu verschaffen, damit sie ihre Kreturen wieder befreien kann. Doch das lasse ich nicht zu!'},cid)
	elseif msgcontains(msg, 'serpent part') then
		npcHandler:say('Der Serpent Part bildet den ersten Abschnitt meiner gro�en komplexen Watercave. Hier habe ich Kreaturen wie Serpent Spawns und Medusae eingesperrt. Nicht ungef�hrlich!', cid)
	elseif msgcontains(msg, 'demon part') then
		npcHandler:say('Der Demon Part ist gleich hinter dem ersten Feuerportal und dort habe ich Monster wie Hellspawns und Demons eingesperrt. Ich empfehle dir, bevor du dort hingehst, dich gut auszur�sten.', cid)
	elseif msgcontains(msg, 'Tar Pit part') then
		npcHandler:say('Zu guter Letzt gibt es noch den Tar Pit Part in meiner Watercave, welcher von Ungeheuern wie Lizards, Drakens und Ghastly Dragons befallen ist.', cid)
	elseif msgcontains(msg, 'feuerportal') then
		npcHandler:say({'Diese Portale sind �berall in meiner Watercave verteilt, um sie vor Eindringlingen zu sch�tzen. Denn um durch solch ein Feuer zu gelangen, muss man vorher die Basin entz�nden. Und das ist gar nicht so leicht: ...',
						'Du brauchst auf jeden Fall ein {Easily Inflammable Sulphur}, welche wirklich selten sind, um das ganze zum brennen zu bringen. Posaun das aber nicht rum!'},cid)
	elseif msgcontains(msg, 'easily inflammable sulphur') then
		npcHandler:say('Dies ist ein wirklich seltendes Item. Du findest manchmal welche in leeren Lava Holes, welche immer in Feuergebieten zu finden sind. Allerdings solltest du dort nicht mit der Hand reingreifen, nimm dir daf�r irgendein Werkzeug, wie zum Beispiel einen Spoon.',cid)
	elseif msgcontains(msg, 'hellspawn tail') then
		npcHandler:say('{Hellspawn Tails} sind die rundgeformten Schw�nze von Hellspawns, starke Demons, welche ich in der Watercave im Demon Part eingesperrt habe.', cid)
	elseif msgcontains(msg, 'empty pipe') then
		npcHandler:say('Dies ist wie eine Art Rohr, mit dem man bestimmte Quellen von Fl�ssigkeiten miteinander verbinden kann. So ist es m�glich, ein bestimmtes Element durch ein Rohr in eine Fl�ssigkeit flie�en zu lassen. Fantastisch, nicht wahr?', cid)
	elseif msgcontains(msg, 'vial of water') then
		npcHandler:say('Eine Vial of Water ist eine ganz normale Vial, nur eben gef�llt mit Wasser. Vials solltest du eigentlich in Bonezone kaufen k�nnen. Frag doch einfach mal rum.', cid)
	elseif msgcontains(msg, 'korus shavir') then
		npcHandler:say('Ein dunkler Drache, der von vielen anderen Kreaturen gef�rchtet wird. Unter gr��ter M�he habe ich es geschafft auch ihn zu fangen und einzusperren.', cid)
	elseif msgcontains(msg, 'swamplair armor') then
		npcHandler:say('Dies ist eine m�chtige Armor der Pflanzen und Natur. Sie sch�tzt dich zwar vor Angriffen der Erde, macht dich jedoch empfindlicher gegen Angriffe des Feuers. Allerdings kann diese m�chtige Armor nur von Kriegern und Fernsch�tzen getragen werden.', cid)
	elseif msgcontains(msg, 'beitritt') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschlie�en') or msgcontains(msg, 'join') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 1 then
			npcHandler:say('M�chtest du dich mir wirklich anschlie�en und mit mir die Natur um Bonezone herum erweitern und dich gegen meine Schwester stellen? Es gibt kein zur�ck mehr!', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du hast dich doch schon l�ngst unserem Klan angeschlossen. Was meinst du damit?', cid)
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 2 then
			npcHandler:say({'Sehr gut, du bist also hier, um deine erste Aufgabe abzuholen. Du musst allerdings wissen, dass es keine leichten Missionen sein werden. Na gut, dann fang ich mal an: ...',
							'Zu aller erst will ich dich ein wenig einsch�tzen und herausfinden, wie wichtig dir dein Beitritt in unseren Klan ist. Daf�r gebe ich dir eine Aufgabe die eventuell etwas Zeit und vor allem viel Kraft verlangt. Mal sehen wie schnell du zur�ck kommst: ...',
							'Ich ben�tige eine {Swamplair Armor}, da sie mir helfen wird mehr Kontrolle �ber die Pflanzen und Tiere zu erringen. Ich hoffe doch du f�hlst dich dieser Aufgabe gewachsen und schaffst es, mir solch eine Armor zu bringen. Viel Erflog!'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 3 then
			npcHandler:say('Hast du die m�chtige {Swamplair Armor} dabei?', cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 4 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1) == -1 then
			npcHandler:say({'Du bist also bereit f�r deine n�chste Aufgabe? Sehr gut! Also, dass du mir die Swamplair Armor gebracht hast, hat mich schon sehr beeindruckt. Du hast dir mein Vertrauen verdient. ...',
							'Also werde ich dir jetzt etwas verraten, was du auf jeden Fall f�r dich behalten musst: Als meine Schwester anfing ihre Monster auf mich zu hetzen, habe ich eine riesige H�hle geschaffen, in der ich allerlei Monster und Kreaturen von ihr eingesperrt habe. ...',
							'Ich nenne diese H�hle die Watercave, da sie in mitten eines riesigen unterirdischen Sees erbaut wurde. Jedoch sind dort nur die st�rksten D�monen aller exestierenden Kreaturen eingesperrt, weswegen Hepzibah auch versucht, sich Zuagng zu dieser H�hle zu verschaffen, um sie wieder zu befreien. ...',
							'Der Eingang zu dieser H�hle befindet sich gleich hinter dieser T�re und der Treppe nach unten. Ich gew�hre dir hiermit den Zugang zu meiner geheimen Watercave, um mir bei weitern Aufgaben behilflich zu sein.'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1, 5)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorStriphinHouse, 1) -- T�r Haus
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorStriphinWatercave, 1) -- T�r Watercave
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1) == 5 then
			npcHandler:say({'Da du nun von der Watercave bescheid wei�t, kann ich dir auch meine n�chste Aufgabe anvertrauen. Sie hat n�mlich etwas mit der Cave zu tun, weswegen ich dich vorwarnen muss: Es wird nicht leicht werden. ...',
							'Du musst f�r mich in den ersten Abschnitt der H�hle, den sogenannten Serpent Part. Dort wirst du auf Kreaturen treffen, die f�r einen starken Krieger wie dich eigentlich kein Problem sein sollten. ...',
							'In der H�hle m�sstest du eine gro�e blaue Kiste finden. In dieser Kiste befindet sich ein Glas mit einem Serum, das mir dabei helfen wird die Vegetation um Bonezone herum f�r lange Zeit zu d�ngen, da es voller m�chtiger Energie steckt, auch wenn man es ihm nicht ansieht. ...',
							'Egal, Hauptsache ist, du besorgst mir diese gr�ne Essenz, damit wir uns darum nicht mehr k�mmern m�ssen. W�rdest du das tun?'},cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1) == 6 then
			npcHandler:say('Bist du hier, um mir das Serum zu bringen?', cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1) == 7 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission2) == -1 then
			npcHandler:say({'Als n�chstes m�ssen wir uns darum k�mmern Hepzibah den Zugang zu meiner Watercave zu verweigern. Sie hat einen Tunnel als Anschlu� an meine H�hle gegraben, den wir dringend zum Einsturz bringen m�ssen. ...',
							'Er befindet sich geradewegs westlich meines Kellers. Du musst alle Holzpf�hle im Tunnel mit einer Pick zerschlagen, damit er einst�rzt. W�rdest du das tun?'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission2) == 8 then
			npcHandler:say('Bitte zerst�re alle Holzpf�hle im Tunnel von Hepzibah, damit sie keinen Weg mehr in die Watercave hat.', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission2) == 9 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission3) == -1 then
			npcHandler:say({'Du hast mir mit dem Zerst�ren der Holzpf�hle wiederum einen gro�en Gefallen getan, da Hepzibah es jetzt viel schwieriger hat in die Watercave zu gelangen. Doch nun muss ich leider sagen: Es wird Ernst! ...',
							'Falls du meine Missionen bisher einfach fandest, kannst du dich jetzt auf was gefasst machen. Wir m�ssen n�mlich in tiefere Gebiete der Watercave vorsto�en. Ich erlaube dir hiermit mein erstes Feuer zu passieren. ...',
							'Die blauen Feuer sind an verschiedenen Stellen der Cave aufgestellt und sorgen f�r die Sicherheit vor Eindringlingen. Um das Portal zwischen solch Feuern benutzen zu k�nnen, musst du vorher die Basin entz�nden. ...',
							'Die Basin entz�ndest du, indem du ein {Easily Inflammable Sulphur} auf sie legst. Simpel, aber sicher. Dein erstes Easily Inflammable Sulphur erh�lst du gratis, doch dann musst du dich selber auf die Suche nach ihnen machen. ...',
							'Wichtig ist nun erstmal, dass ich dir die Mission erl�utere: Hinter dem Feuerportal findest du lauter neue Monster, doch wichtig ist, dass du zu aller erst mal in den Demon Part gehst und mir 10 {Hellspawn Tails} bringst. ...',
							'Diese Ungeheuer vermehren sich n�mlich hier am schnellsten. �ndere das! Alles klar?'},cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission3) == 10 then
			npcHandler:say('Du hast also die 10 {Hellspawn Tails} dabei?', cid)
			talkState[talkUser] = 7
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission3) == 11 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission4) == -1 then
			npcHandler:say({'Deine n�chste Aufgabe wird es sein, wie du vermutlich schon erraten hast, den Tar Pit Part zu betreten und dort eine wichtige Mission f�r mich zu erledigen. ...',
							'Wie du vielleicht schon herausgefunden hast, konntest du schon vorher einen Teil des Tar Pit Parts betreten, genauer gesagt, die oberste Ebene. Doch dieser Teil der H�hle verbirgt noch viel mehr, was du vielleicht an dem Feuerportal am Ende der ersten Ebene erkannt hast. ...',
							'Hinter diesem Portal n�mlich triffst du auf weitere neue Monster und sogar erneut auf ein weiteres Feuerportal. Aber zu dem kommen wir erst in deiner n�chsten Mission. Zuerst musst du f�r mich den Teil hinter dem zweiten Feuerportal im Tar Pit Part erkunden, den Teil, mit den Drakens. ...',
							'Du hast richtig geh�rt. Es sind diese Monster, die ich dort eingesperrt habe, also sei vorsichtig. Aber nun wieder zu deiner Aufgabe: Du wirst in dem eben genannten Teil des Tar Pit Parts ein Rohr finden. ...',
							'In dieses gibts du dann ein besonderes Puder. Kipp Wasser nach und das Puder sollte hinuntergesp�lt werden. ...',
							'Nur um dir noch kurz zu erkl�ren, warum du das machen sollst: Das Tar im Tar Pit Part ist in letzter Zeit immer fl�ssiger geworden. Die Empty Pipe ist direkt an das Tar angeschlo�en und alles was du dort hineinf�llst, flie�t dirket ins Tar. ...',
							'Das Puder, welches du von mir bekommst, ist eine Art Verfestiger und wird das Tar wieder dickfl�ssig machen. Denn in so einem fl�ssigen Zustand, wie das Tar momentan ist, kann es die komplette Watercave �berfluten. Also, nimmst du den Auftrag an?'},cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission4) == 12 then
			npcHandler:say('Erstmal musst du das Puder in das Tar flie�en lassen. Beeil dich, bitte, sonst �berflutet mir das Tar noch die ganze H�hle.', cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission4) == 13 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5) == -1 then
			npcHandler:say({'Das mit dem Puder hast du gut hinbekommen, doch als n�chstes musst du dich erneut beweisen. Es geht nun darum, dass du in den Tar Pit Part gehst und gegen {Korus Shavir} k�mpst. Wenn du in der Lage bist, diesen Boss zu besiegen, gew�hre ich dir den Zugang zum dritten Feuerportal, sowohl im Demon Part als auch im Tar Pit Part. ...',
							'Um zu Korus Shavir zu gelangen, musst du dich im Tar Pit Part bis zum hintersten Feuerportal, von dem ich dir ja auch schon in der vorherigen Mission erz�hlt habe, durchk�mpfen und in dieses hineinlaufen. Es wird dich nicht wie �blich weiter bringen, sondern geradewegs zum abgeschotteten Raum vom Boss teleportieren. ...',
							'Wenn du es geschafft hast ihn zu besiegen, kehre zu mir zur�ck, damit ich dir den Zugang zum dritten Portal im Tar Pit Part und im Demon Part gew�hren kann. Nimmst du die Mission an?'},cid)
			talkState[talkUser] = 9
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5) == 14 then
			npcHandler:say('Deine Aufgabe ist es {Korus Shavir} zu besiegen. Viel Gl�ck!', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5) == 15 then
			npcHandler:say({'Du hast es tats�chlich geschafft Korus Shavir zu besiegen? Unglaublich! Du hast es wirklich verdient, auch das dritte Feuerportal im Tar Pit Part und im Demon Part benutzen und weitere neue Monster bestreiten zu d�rfen. Ich gew�hre dir hiermit den Zutritt! ...',
							'Ich muss dir au�erdem sehr danken, dass du mir bei all diesen Sachen geholfen hast. Ohne dich h�tte das alles sehr, sehr lange gedauert. Und das von der wei�en Hexe gesagt, mag schon was hei�en. ...',
							'Wer wei�, vielleicht brauche ich deine Hilfe irgendwann nochmal, wenn meine Schwester Hepzibah wieder versucht mich zu st�rzen. Bis dahin: Auf Wiedersehen und viel Erfolg bei deinen weiteren Abenteuern! �brigens, hier ist ein kleines Dankesch�n f�r deine Bem�hungen!'},cid)
			doPlayerAddItem(cid, 6547, 6)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5, 16)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5) == 16 then
			npcHandler:say('Ich habe leider momentan keine weiteren Aufgaben f�r dich. Irgendwann vielleicht nochmal.', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('DANN SOLL ES SO SEIN! Hiermit nehme ich dich in die Reihen meiner Allianz auf. Du kannst bei mir nun jederzeit Missionen starten, um mir zu helfen.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, -1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah, -1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			if getPlayerItemCount(cid, 8880) >= 1 then
				npcHandler:say('Das ist ja fantastisch! �brigens kannst du die Swamplair Armor behalten. Es war nur ein Test, um zu gucken, ob du in der Lage bist mir so etwas Wertvolles zu besorgen. Hast du wirklich geglaubt ICH, die wei�e Hexe der Natur, brauche eine Armor, um die Pflanzen kontrollieren zu k�nnen? HAHAHA!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, 4)
				talkState[talkUser] = 0
			else
				npcHandler:say('Ich dachte mir schon, dass du es nicht schaffen w�rdest. Aber, dass du mich auch noch bel�gst...', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Wunderbar! Ich erwarte dich dann hier voller Vorfreude.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1, 6)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 14320, 1) == TRUE then
				npcHandler:say('Das ist ja gro�artig! Vielen Dank daf�r!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission1, 7)
				talkState[talkUser] = 0
			else
				npcHandler:say('Wo ist denn das Fl�schchen?', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Hervorragend! Kehre danach zu mir zur�ck, um dir deine n�chste Mission abzuholen.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission2, 8)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorHepzibahWatercave, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Super! Hier hast du das {Easily Inflammable Sulphur}. �brigens kannst du nur im ersten Bereich des Demon Parts verweilen, zu weiteren Feuerportalen gew�hre ich dir erst sp�ter Zugriff.', cid)
			doPlayerAddItem(cid, 6547, 1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission3, 10)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			if doPlayerRemoveItem(cid, 11221, 10) == TRUE then
				npcHandler:say('Excellent! Damit haben wir uns auch um diese vermaledeiten Hellspawns gek�mmert.', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission3, 11)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast ja �berhaupt keine {Hellspawn Tails} dabei.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Super! Ich denke, es ist alles erkl�rt. Hier hast du das besondere Puder. Sei vorsichtig damit. Au�erdem gew�hre ich dir jetzt auch den Zugriff zum zweiten Feuerportal im Demon Part. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission4, 12)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 2)
			doPlayerAddItem(cid, 15389, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Du bist wirklich ein tapferer Krieger. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinMission5, 14)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dann nicht. Aber du machst dich zum Feind, wenn du dich Hepzibah anschlie�st.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Entt�uschend, aber ich wei�, dass du es schaffst.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('So schwierig ist es nun auch wieder nicht.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Wieso denn nicht?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Steckst du etwa mit Hepzibah unter einer Decke?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Dann gibts auch kein Easily Inflammable Sulphur.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Warum bist du dann hier?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Aber dann wird meine H�hle �berflutet. Hilf mir doch bitte.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Ich hatte dich f�r mutiger gehalten.', cid)
			talkState[talkUser] = 0
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new())

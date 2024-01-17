local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end

function onCreatureSay(cid, type, msg)
	-- if (not npcHandler:isFocused(cid)) and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'hallo')) then
		-- if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) >= 1 then
			-- npcHandler:greet(cid)
			-- return TRUE
		-- else
			-- npcHandler:say('Verschwinde blo�, oder ich erhebe meine Kr�fte gegen dich!', cid)
			-- return false
		-- end	
	-- end
	npcHandler:onCreatureSay(cid, type, msg)	
end


function onThink()							npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) and npcHandler:isInRange(cid) and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'hallo')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) >= 1 then
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
		npcHandler:say({'Mein Name ist Hepzibah und ich bin die schwarze Hexe aller Kreaturen auf Fireban. Dies hast du vielleicht schon an den vielen Monstern bemerkt, an denen du vorbei musstest, als du zu mir wolltest. ...',
						'Eine weitere Aufgabe von mir ist es zu versuchen, meine Schwester Striphin zu st�rzen, da wir uns vor langer Zeit zerstritten haben. Sie will die Wichtigkeit meiner Aufgaben einfach nicht einsehen. Mistst�ck!'},cid)
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say('Meine Schwester Striphin ist die wei�e Hexe der Natur. Ein ewiger anhlatender Krieg weilt zwischen uns, aber eines Tages werde ich sie st�rzen. Vielleicht kannst du dich mir ja anschlie�en und dabei helfen, meiner Schwester zu zeigen, welcher der richtige Weg ist.', cid)
	elseif msgcontains(msg, 'watercave') then
		npcHandler:say({'Meine Schwester Striphin erbaute vor langer Zeit eine H�hle namens Watercave, in welcher sie meine treuen Kreaturen einsperrte und vor mir verbarg. Ich muss diese H�hle erobern und meine Monster befreien. ...',
						'Dazu habe ich einen Tunnel erschaffen, der direkt zur H�hle f�hrt. Dies wird mir helfen, meine wertvollen Wachter zur�ckzugewinnen.'},cid)
	elseif msgcontains(msg, 'serpent part') then
		npcHandler:say('Der erste Teil von der von meiner Schwester erbauten Watercave. Hier wirst du, wie der Name schon sagt, auf jegliche Schlagenwesen treffen. F�r genauere Ausk�nfte, sammele dir deine Erfahrungen selbst.', cid)
	elseif msgcontains(msg, 'demon part') then
		npcHandler:say('Dies ist der zweite Teil in der von meiner Schwester erbauten Watercave. Er befindet sich gleich hinter dem ersten Feuerportal und beherbergt eine Reihe dunkler D�monen. Sehr gef�hrlich!', cid)
	elseif msgcontains(msg, 'Tar Pit part') then
		npcHandler:say('Der dritte und auch gr��te Teil der Watercave. Hier wirst du vermutlich auf Lizards und Drakens treffen, doch ich bin mir sicher, dass meine Schwester dort noch mehr eingesperrt hat.', cid)
	elseif msgcontains(msg, 'feuerportal') then
		npcHandler:say({'Meine Schwester hat diese Feuerportale �berall in ihrer H�hle verteilt um sie vor Eindringlingen und mir zu sch�tzen. Doch ich wei� wie sie funktionieren. Hahaha! ...',
						'Der Trick ist n�mlich, erst die Basin zu entz�nden, bevor man auf das Feuer tritt. Dies tust du, indem du ein {Easily Inflammable Sulphur} auf die Basin legst. ...',
						'Dann kannst du das Portal passieren. Ich hoffe, meine Schwester ist sich immer noch nicht im Klaren, dass ich davon wei�.'},cid)
	elseif msgcontains(msg, 'dragon\'s nest tree') or msgcontains(msg, 'dragons nest tree') then
		npcHandler:say({'Diese Pflanzen Art ist wegen ihrer Kommunikation, die sie untereinander f�hren sehr bekannt. Alle Exemplare sind miteinander vernetzt und haben zus�tzlich eine robuste H�lle und k�nnen starkes Gift zur Verteidigung aussto�en. Nur Feuer hilft gegen sie, da dies die sch�tzende Oberfl�che durchbricht. ...',
						'Au�erdem sind sie sehr auff�llig, was man als weitere Schw�che notieren k�nnte. Ihre markante Bl�te strahlt einen durchdringenden pink-rosa Ton aus und ist weit oben an der Spitze des Baums befestigt.'},cid)
	elseif msgcontains(msg, 'firebug') then
		npcHandler:say('', cid)
	elseif msgcontains(msg, 'easily inflammable sulphur') then
		npcHandler:say('Seltene Items, diese Sulphurs. Man findet sie manchmal in leeren Lava Holes, doch sollte man dort niemlas mit der Hand reingreifen. Nimm daf�r ein Werkzeug, was dabei nicht schmilzt. Wie w�rs mit einem Spoon?',cid)
	elseif msgcontains(msg, 'hellspawn tail') then
		npcHandler:say('Du wei�t nicht was Hellspawn Tails sind? Diese runden schwarzen Schw�nze von der Kreatur Hellspawn. Meine Schwester sperrte sie im Demon Part ihrer Watercave ein. Wenn du Gl�ck hast, findest du ja dort ein paar.', cid)
	elseif msgcontains(msg, 'empty pipe') then
		npcHandler:say('Dies ist wie eine Art Rohr, mit dem man bestimmte Quellen von Fl�ssigkeiten miteinander verbinden kann. So ist es m�glich, ein bestimmtes Element durch ein Rohr in eine Fl�ssigkeit flie�en zu lassen.', cid)
	elseif msgcontains(msg, 'vial of water') then
		npcHandler:say('Eine Vial of Water ist eine gew�hnliche Vial, die gef�llt mit Wasser ist. Vials kannst du in Bonezone kaufen. Frag doch einfach mal herum.', cid)
	elseif msgcontains(msg, 'korus shavir') then
		npcHandler:say('Einer meiner treuesten Diener und ein starker Drache noch dazu. Ich muss leider sagen, dass Striphin es geschafft hat, auch ihn zu fangen. Er kann nur durch einen ehrenvollen Tod wieder befreit werden.', cid)
	elseif msgcontains(msg, 'skullcracker armor') then
		npcHandler:say('Diese wirklich sehr seltene und wertvolle Armor sch�tzt dich vor Angriffen des Todes, macht dich jedoch gleichzeitig empfindlicher gegen die der Heiligkeit. Sie kann ausschlie�lich von Kriegern getragen werden.', cid)
	elseif msgcontains(msg, 'beitritt') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschlie�en') or msgcontains(msg, 'join') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 1 then
			npcHandler:say('Hast du wirklich vor, dich mir zu unterwerfen? Denn wenn du dich daf�r entscheidest, gibt es kein zur�ck mehr.', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('H�r auf meine Zeit zu verschwenden. Du hast dich mir bereits angeschlo�en.', cid)
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 2 then
			npcHandler:say({'Ich bin kein gro�er Redenschwinger, also fange ich gleich an, dir zu erkl�ren, worin deine erste Aufgabe besteht. Na dann mal los: ...',
							'Um deine St�rke besser einordnen zu k�nnen, will ich herausfinden, ob du in der Lage bist mir einen sehr wichtigen und wertvollen Gegenstand zu bringen. Dieser wird mir dabei helfen, alle Kreaturen auf Fireban besser zu kontrollieren. ...',
							'Es handelt sich hierbei um eine {Skullcracker Armor}. Diese ist sehr selten, doch gleichzeitig von gro�er Bedeutung. Beschaffe mir solch eine!'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 3 then
			npcHandler:say('Bist du hier, um mir die {Skullcracker Armor} zu bringen?', cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 4 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == -1 then
			npcHandler:say({'Sch�n, dass du dich entschieden hast, mir weiterhin zu dienen. Denn nach der {Skullcracker Armor} habe ich noch weitere Aufgaben f�r dich. Doch vorerst ein paar Hintergrundinformationen: ...',
							'Meine vermaledeite Schwester Striphin hat vor nicht allzu langer Zeit eine H�hle namens Watercave errichtet, in der sie die m�chtigsten Kreaturen, Monster und W�chter von mir einsperrte. Daf�r muss sie b��en. ...',
							'Nat�rlich muss ich meine Untertanen wieder befreien, denn ohne Volk auch keine Sklaven. Dabei brauche ich jedoch deine Hilfe, denn ich muss leider zugeben: Meine Schwester ist nicht schwach und sie hat ihre H�hle gut gesch�tzt. ...',
							'Trotzdem ist es mir gelungen, einen geheimen Tunnel zur Watercave zu graben, welcher direkt hinter dieser T�r liegt. Ich erlaube dir von nun an, diesen Tunnel zu benutzen, um mir bei weiteren Aufgaben bez�glich der Befreiung meiner Monster zu helfen.'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1, 5)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorHepzibahHouse, 1) -- T�r Tunnel
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorHepzibahWatercave, 1) -- T�r Watercave
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 5 then
			npcHandler:say({'Nachdem du nun von der Watercave erfahren hast und meinen Tunnel benutzen darfst, habe ich nun die n�chste Aufgabe f�r dich. Also h�re gut zu: ...',
							'Gehe f�r mich in den ersten Abschnitt der Watercave, den so genannten Serpent Part. In diesem Teil befinden sich allerlei starke Schlangenkreaturen, doch f�r einen starken Krieger wie dich, sollten sie eigentlich kein Problem darstellen. ...',
							'Deine Aufgabe besteht darin, in der H�hle eine blaue Kiste zu suchen. In dieser Kiste bewahrt Striphin ein sehr m�chtigs Serum auf, das voller Energie steckt. Sie wird es vermutlich f�r die St�rkung der Natur verwenden, aber ich wei�, dass die Energie auch anders benutzt werden kann. ...',
							'Hohle mir dieses D�ngerserum und du h�ttest mir bei dem Versuch, meine Schwester zu st�rzen, sehr geholfen. Alles klar?'},cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 6 then
			npcHandler:say('Du hast also das Serum dabei?', cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 7 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == -1 then
			npcHandler:say({'Wir m�ssen nun daf�r sorgen, dass der Schutz der Watercave zerst�rt wird, um meine Monster wieder zu befreien. Dazu m�ssen wir die weit verbreitete Natur mit all den Pflanzen in der H�hle schw�chen. ...',
							'Auf der obersten Ebene gibt es sieben mal die Pflanze der selben Art: {Dragon\'s Nest Tree}. Durch sie ist die ganze Natur in der H�hle vernetzt und zus�tzlich besitzt sie ein hervorragendes Abwehrsystem. Sie stellt wirklich ein Problem dar. ...',
							'Besorge dir einen {Firebug} und z�nde genug Dragon\'s Nest Trees an, dies wird uns erneut einen Schritt weiter bringen. Nimmst du den Auftrag an?'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == 8 then
			npcHandler:say('Du musst f�r die Zerst�rung Striphin\'s Verteidigung sorgen, indem du genug {Dragon\'s Nest Trees} anz�ndest. Streng dich an!', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == 9 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == -1 then
			npcHandler:say({'Das ist ja gro�artig! Die Zerst�rung der Pflanzen war eine sehr wichtige Aufgabe und hat uns ein ganzes St�ck voran gebracht. Doch nun muss ich dir etwas aufgeben, was nicht so leicht zu bew�ltigen sein wird. ...',
							'Als weiteren Schutz f�r die H�hle, hat meine Schwester Striphin in der H�hle immer wieder Feuerportale aufgestellt, welche man nur unter einer bestimmten Bedingung passieren kann: Man muss die Basin entz�nden. ...',
							'Die Basin entz�ndest du, indem du ein {Easily Inflammable Sulphur} auf sie legst. Dann brennt sie und du kannst durch das blaue Feuer zum gegen�berliegenden gelangen. Eigentlich clever. ...',
							'Da du nun wei�t, wie man sloch ein Feuerportal benutzen kann, bist du f�hig, mir bei meiner n�chsten Aufgabe zu helfen. Diese besteht darin, mir 10 {Hellspawn Tails} aus dem Demon Part bringst. ...',
							'Hellspawns haben die Eigenschaft aus ihrem blo�en Schwanz neu zu enstehen. Also wenn dieser in einem Kampf abgetrennt wird und der restliche K�rper stirbt, erw�chst ein neuer Hellspawn aus dem Hellspawn Tail. Beeindruckend, nicht wahr? ...',
							'Somit k�nnte ich eine neue Armee aus Hellspawns erschaffen, um meine Schwester endg�ltig zu st�rzen. Bist du dabei? Bringst du mir die 10 {Hellspawn Tails}?'},cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == 10 then
			npcHandler:say('Bist du hier, um mir die 10 {Hellspawn Tails} zu bringen?', cid)
			talkState[talkUser] = 7
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == 11 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == -1 then
			npcHandler:say({'Deine n�chste Aufgabe wird es sein, wie du vermutlich schon erraten hast, den Tar Pit Part zu betreten und dort eine wichtige Mission f�r mich zu erledigen. ...',
							'Wie du vielleicht schon herausgefunden hast, konntest du schon vorher einen Teil des Tar Pit Parts betreten, genauer gesagt, die oberste Ebene. Doch dieser Teil der H�hle verbirgt noch viel mehr, was du vielleicht an dem Feuerportal am Ende der ersten Ebene erkannt hast. ...',
							'Hinter diesem Portal n�mlich triffst du auf weitere neue Monster und sogar erneut auf ein weiteres Feuerportal. Aber zu dem kommen wir erst in deiner n�chsten Mission. Zuerst musst du f�r mich den Teil hinter dem zweiten Feuerportal im Tar Pit Part erkunden, den Teil, mit den Drakens. ...',
							'Du hast richtig geh�rt. Es sind diese Monster, die Striphin dort eingesperrt hat, also sei vorsichtig. Du wirst in dieser Gegend des Tar Pit Parts ein Rohr finden. In dieses gibts du dann ein besonderes Puder. Kipp Wasser nach und das Puder sollte hinuntergesp�lt werden. ...',
							'Nur um dir noch kurz zu erkl�ren, warum du das machen sollst: Die Empty Pipe ist direkt ans Tar angeschlo�en, dass hei�t alles, was du dort hineinf�llst flie�t direkt ins Tar. Das Puder, was ich dir geben werde ist wie eine Art Verfestiger, es macht das Tar wieder dickfl�ssig. ...',
							'Da das Tar in letzter Zeit einfach viel zu fl�ssig geworden ist und die Gefahr besteht, dass es die komplette H�hle �berflutet wird und damit all meine Monster und Untertanen ertrinken, musst du das Puder in das Tar flie�en lassen, um es zu verfestigen. Alles klar?'},cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == 12 then
			npcHandler:say('Erstmal musst du das Puder in das Tar flie�en lassen. Beeil dich, bitte, sonst �berflutet das Tar noch die ganze H�hle und ertr�nkt all meine Monster.', cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == 13 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == -1 then
			npcHandler:say({'Wie du wahrscheinlich schon in deiner vorherigen Mission bemerkt hast, verbirgt der Tar Pit Part noch ein drittes Feuerportal. Um allerdings den Zugang zu diesem und zu jenem im {Demon Part} zu erhalten und diese benutzen zu d�rfen, musst du den Boss {Korus Shavir} besiegen. ...',
							'Um zu {Korus Shavir} zu gelangen musst du dich im Tar Pit Part bis zum hintersten Feuerportal durchk�mpfen und in dieses hineinlaufen. Es wird dich nicht wie �blich weiter bringen, sondern geradewegs zum abgeschotteten Raum vom Boss teleportieren. ...',
							'Wenn du f�hig bist, diesen Boss zu erledigen, dann kehre zu mir zur�ck. Nimmst du die Mission an?'},cid)
			talkState[talkUser] = 9
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 14 then
			npcHandler:say('Deine Aufgabe ist es {Korus Shavir} zu besiegen. Sei stark!', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 15 then
			npcHandler:say({'Wu�t ichs doch! Du hast es geschafft. Du bist w�rdig, auch die beiden dritten Feuerportale im Tar Pit Part und im Demon Part benutzen zu d�rfen. Der Zutritt sei dir gew�hrt. ...',
							'Auch bedanke ich mich sehr bei dir. Obwohl wenn ich meine Schwester immernoch nicht gest�rtzt haben, durch deine Hilfe werde ich es nun viel leichter haben. Vielen Dank ...',
							'Eines Tages brauche ich sicherlich nochmal deine Hilfe. Bis dahin: Auf Wiedersehen und ein erfolgreiches Abenteuer. Als kleines Dankesch�n habe ich hier noch eine Belohnung f�r dich.'},cid)
			doPlayerAddItem(cid, 6547, 6)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5, 16)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 16 then
			npcHandler:say('Ich habe leider momentan keine weiteren Aufgaben f�r dich. Irgendwann vielleicht nochmal.', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('DANN SOLL ES SO SEIN! Du geh�rst nun mir und tust, was ich von dir verlange. Komme zu mir, wenn du Auftr�ge erhalten willst.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, -1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin, -1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			if getPlayerItemCount(cid, 8889) == 1 then
				npcHandler:say('Sehr gut! Ich muss sagen, ich bin beeindruckt. Wenn auch ein wenig �berrascht und beleidigt, dass du tats�chlich geglaubt hast, dass ICH, die K�nigin der Kreaturen und Monster, braucht eine Armor, um die Kontrolle zu besitzen. WIE L�CHERLICH! MUHAHAHA!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 4)
				talkState[talkUser] = 0
			else
				npcHandler:say('War ja klar, dass du das nicht schaffst. Du bist eben doch kein w�rdiger Krieger.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Na dann beeil dich, bevor sie sich ihn noch holt.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1, 6)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 14320, 1) == TRUE then
				npcHandler:say('Das wird mir sehr weiterhelfen. Vielen Dank!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1, 7)
				talkState[talkUser] = 0
			else
				npcHandler:say('L�GNER!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Brennt, Pflanzen, BRENNT!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2, 8)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.dragonNestTreesCounter, 0)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Sehr sch�n. Dein erstes {Easily Inflammable Sulphur} kriegst du von mir geschenkt, doch dann musst du dich selbst darum k�mmern, neue zu finden. Lass dir auch gesagt sein, dass du nur das erste Feuerportal benutzen kannst, zu weiteren kriegst du sp�ter Zugriff. Viel Erfolg!', cid)
			doPlayerAddItem(cid, 6547, 1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3, 10)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			if doPlayerRemoveItem(cid, 11221, 10) == TRUE then
				npcHandler:say('Unglaublich! Mit ihnen werde ich eine Armee aus Hellspawns erstellen. Danke!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3, 11)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast ja �berhaupt keine {Hellspawn Tails} dabei.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Sehr sch�n! Ich nehme an, ich habe dir alles so weit erkl�rt. Hier hast du das besondere Puder. Sei vorsichtig damit. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4, 12)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 2)
			doPlayerAddItem(cid, 15389, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Ich w�nsche dir alle Kr�fte und bin mir sicher, dass du es schaffen wirst. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5, 14)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Wie kannst du es wagen? Schlie� dich mir an, oder du machst dich zum Feind.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Na dann streng dich an!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Ich hoffe du wei�t, dass das D�ngerserum von �u�erster Bedeutung ist.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Geh zu dieser verdammten Kiste!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Aha, jetzt, wo wir gegen meine Schwester Striphin vorgehen, kriegst du kalte F��e. Interessant.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Schade. Denn dein erstes {Easily Inflammable Sulphur} h�ttest du gratis von mir bekommen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Dann besorge sie mir. Ich brauche eine Armee.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Du musst das aber tun, sonst sterben all meine W�chter.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Rei� dich zusammen und besiege diesen Boss.', cid)
			talkState[talkUser] = 0
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new())

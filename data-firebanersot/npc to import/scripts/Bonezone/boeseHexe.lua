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
			-- npcHandler:say('Verschwinde bloß, oder ich erhebe meine Kräfte gegen dich!', cid)
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
			npcHandler:say('Verschwinde bloß, oder ich erhebe meine Kräfte gegen dich!', cid)
			return false
		end	
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Mein Name ist Hepzibah und ich bin die schwarze Hexe aller Kreaturen auf Fireban. Dies hast du vielleicht schon an den vielen Monstern bemerkt, an denen du vorbei musstest, als du zu mir wolltest. ...',
						'Eine weitere Aufgabe von mir ist es zu versuchen, meine Schwester Striphin zu stürzen, da wir uns vor langer Zeit zerstritten haben. Sie will die Wichtigkeit meiner Aufgaben einfach nicht einsehen. Miststück!'},cid)
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say('Meine Schwester Striphin ist die weiße Hexe der Natur. Ein ewiger anhlatender Krieg weilt zwischen uns, aber eines Tages werde ich sie stürzen. Vielleicht kannst du dich mir ja anschließen und dabei helfen, meiner Schwester zu zeigen, welcher der richtige Weg ist.', cid)
	elseif msgcontains(msg, 'watercave') then
		npcHandler:say({'Meine Schwester Striphin erbaute vor langer Zeit eine Höhle namens Watercave, in welcher sie meine treuen Kreaturen einsperrte und vor mir verbarg. Ich muss diese Höhle erobern und meine Monster befreien. ...',
						'Dazu habe ich einen Tunnel erschaffen, der direkt zur Höhle führt. Dies wird mir helfen, meine wertvollen Wachter zurückzugewinnen.'},cid)
	elseif msgcontains(msg, 'serpent part') then
		npcHandler:say('Der erste Teil von der von meiner Schwester erbauten Watercave. Hier wirst du, wie der Name schon sagt, auf jegliche Schlagenwesen treffen. Für genauere Auskünfte, sammele dir deine Erfahrungen selbst.', cid)
	elseif msgcontains(msg, 'demon part') then
		npcHandler:say('Dies ist der zweite Teil in der von meiner Schwester erbauten Watercave. Er befindet sich gleich hinter dem ersten Feuerportal und beherbergt eine Reihe dunkler Dämonen. Sehr gefährlich!', cid)
	elseif msgcontains(msg, 'Tar Pit part') then
		npcHandler:say('Der dritte und auch größte Teil der Watercave. Hier wirst du vermutlich auf Lizards und Drakens treffen, doch ich bin mir sicher, dass meine Schwester dort noch mehr eingesperrt hat.', cid)
	elseif msgcontains(msg, 'feuerportal') then
		npcHandler:say({'Meine Schwester hat diese Feuerportale überall in ihrer Höhle verteilt um sie vor Eindringlingen und mir zu schützen. Doch ich weiß wie sie funktionieren. Hahaha! ...',
						'Der Trick ist nämlich, erst die Basin zu entzünden, bevor man auf das Feuer tritt. Dies tust du, indem du ein {Easily Inflammable Sulphur} auf die Basin legst. ...',
						'Dann kannst du das Portal passieren. Ich hoffe, meine Schwester ist sich immer noch nicht im Klaren, dass ich davon weiß.'},cid)
	elseif msgcontains(msg, 'dragon\'s nest tree') or msgcontains(msg, 'dragons nest tree') then
		npcHandler:say({'Diese Pflanzen Art ist wegen ihrer Kommunikation, die sie untereinander führen sehr bekannt. Alle Exemplare sind miteinander vernetzt und haben zusätzlich eine robuste Hülle und können starkes Gift zur Verteidigung ausstoßen. Nur Feuer hilft gegen sie, da dies die schützende Oberfläche durchbricht. ...',
						'Außerdem sind sie sehr auffällig, was man als weitere Schwäche notieren könnte. Ihre markante Blüte strahlt einen durchdringenden pink-rosa Ton aus und ist weit oben an der Spitze des Baums befestigt.'},cid)
	elseif msgcontains(msg, 'firebug') then
		npcHandler:say('', cid)
	elseif msgcontains(msg, 'easily inflammable sulphur') then
		npcHandler:say('Seltene Items, diese Sulphurs. Man findet sie manchmal in leeren Lava Holes, doch sollte man dort niemlas mit der Hand reingreifen. Nimm dafür ein Werkzeug, was dabei nicht schmilzt. Wie wärs mit einem Spoon?',cid)
	elseif msgcontains(msg, 'hellspawn tail') then
		npcHandler:say('Du weißt nicht was Hellspawn Tails sind? Diese runden schwarzen Schwänze von der Kreatur Hellspawn. Meine Schwester sperrte sie im Demon Part ihrer Watercave ein. Wenn du Glück hast, findest du ja dort ein paar.', cid)
	elseif msgcontains(msg, 'empty pipe') then
		npcHandler:say('Dies ist wie eine Art Rohr, mit dem man bestimmte Quellen von Flüssigkeiten miteinander verbinden kann. So ist es möglich, ein bestimmtes Element durch ein Rohr in eine Flüssigkeit fließen zu lassen.', cid)
	elseif msgcontains(msg, 'vial of water') then
		npcHandler:say('Eine Vial of Water ist eine gewöhnliche Vial, die gefüllt mit Wasser ist. Vials kannst du in Bonezone kaufen. Frag doch einfach mal herum.', cid)
	elseif msgcontains(msg, 'korus shavir') then
		npcHandler:say('Einer meiner treuesten Diener und ein starker Drache noch dazu. Ich muss leider sagen, dass Striphin es geschafft hat, auch ihn zu fangen. Er kann nur durch einen ehrenvollen Tod wieder befreit werden.', cid)
	elseif msgcontains(msg, 'skullcracker armor') then
		npcHandler:say('Diese wirklich sehr seltene und wertvolle Armor schützt dich vor Angriffen des Todes, macht dich jedoch gleichzeitig empfindlicher gegen die der Heiligkeit. Sie kann ausschließlich von Kriegern getragen werden.', cid)
	elseif msgcontains(msg, 'beitritt') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschließen') or msgcontains(msg, 'join') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 1 then
			npcHandler:say('Hast du wirklich vor, dich mir zu unterwerfen? Denn wenn du dich dafür entscheidest, gibt es kein zurück mehr.', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Hör auf meine Zeit zu verschwenden. Du hast dich mir bereits angeschloßen.', cid)
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 2 then
			npcHandler:say({'Ich bin kein großer Redenschwinger, also fange ich gleich an, dir zu erklären, worin deine erste Aufgabe besteht. Na dann mal los: ...',
							'Um deine Stärke besser einordnen zu können, will ich herausfinden, ob du in der Lage bist mir einen sehr wichtigen und wertvollen Gegenstand zu bringen. Dieser wird mir dabei helfen, alle Kreaturen auf Fireban besser zu kontrollieren. ...',
							'Es handelt sich hierbei um eine {Skullcracker Armor}. Diese ist sehr selten, doch gleichzeitig von großer Bedeutung. Beschaffe mir solch eine!'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 3 then
			npcHandler:say('Bist du hier, um mir die {Skullcracker Armor} zu bringen?', cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) == 4 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == -1 then
			npcHandler:say({'Schön, dass du dich entschieden hast, mir weiterhin zu dienen. Denn nach der {Skullcracker Armor} habe ich noch weitere Aufgaben für dich. Doch vorerst ein paar Hintergrundinformationen: ...',
							'Meine vermaledeite Schwester Striphin hat vor nicht allzu langer Zeit eine Höhle namens Watercave errichtet, in der sie die mächtigsten Kreaturen, Monster und Wächter von mir einsperrte. Dafür muss sie büßen. ...',
							'Natürlich muss ich meine Untertanen wieder befreien, denn ohne Volk auch keine Sklaven. Dabei brauche ich jedoch deine Hilfe, denn ich muss leider zugeben: Meine Schwester ist nicht schwach und sie hat ihre Höhle gut geschützt. ...',
							'Trotzdem ist es mir gelungen, einen geheimen Tunnel zur Watercave zu graben, welcher direkt hinter dieser Tür liegt. Ich erlaube dir von nun an, diesen Tunnel zu benutzen, um mir bei weiteren Aufgaben bezüglich der Befreiung meiner Monster zu helfen.'},cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1, 5)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorHepzibahHouse, 1) -- Tür Tunnel
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.doorHepzibahWatercave, 1) -- Tür Watercave
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 5 then
			npcHandler:say({'Nachdem du nun von der Watercave erfahren hast und meinen Tunnel benutzen darfst, habe ich nun die nächste Aufgabe für dich. Also höre gut zu: ...',
							'Gehe für mich in den ersten Abschnitt der Watercave, den so genannten Serpent Part. In diesem Teil befinden sich allerlei starke Schlangenkreaturen, doch für einen starken Krieger wie dich, sollten sie eigentlich kein Problem darstellen. ...',
							'Deine Aufgabe besteht darin, in der Höhle eine blaue Kiste zu suchen. In dieser Kiste bewahrt Striphin ein sehr mächtigs Serum auf, das voller Energie steckt. Sie wird es vermutlich für die Stärkung der Natur verwenden, aber ich weiß, dass die Energie auch anders benutzt werden kann. ...',
							'Hohle mir dieses Düngerserum und du hättest mir bei dem Versuch, meine Schwester zu stürzen, sehr geholfen. Alles klar?'},cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 6 then
			npcHandler:say('Du hast also das Serum dabei?', cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission1) == 7 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == -1 then
			npcHandler:say({'Wir müssen nun dafür sorgen, dass der Schutz der Watercave zerstört wird, um meine Monster wieder zu befreien. Dazu müssen wir die weit verbreitete Natur mit all den Pflanzen in der Höhle schwächen. ...',
							'Auf der obersten Ebene gibt es sieben mal die Pflanze der selben Art: {Dragon\'s Nest Tree}. Durch sie ist die ganze Natur in der Höhle vernetzt und zusätzlich besitzt sie ein hervorragendes Abwehrsystem. Sie stellt wirklich ein Problem dar. ...',
							'Besorge dir einen {Firebug} und zünde genug Dragon\'s Nest Trees an, dies wird uns erneut einen Schritt weiter bringen. Nimmst du den Auftrag an?'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == 8 then
			npcHandler:say('Du musst für die Zerstörung Striphin\'s Verteidigung sorgen, indem du genug {Dragon\'s Nest Trees} anzündest. Streng dich an!', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2) == 9 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == -1 then
			npcHandler:say({'Das ist ja großartig! Die Zerstörung der Pflanzen war eine sehr wichtige Aufgabe und hat uns ein ganzes Stück voran gebracht. Doch nun muss ich dir etwas aufgeben, was nicht so leicht zu bewältigen sein wird. ...',
							'Als weiteren Schutz für die Höhle, hat meine Schwester Striphin in der Höhle immer wieder Feuerportale aufgestellt, welche man nur unter einer bestimmten Bedingung passieren kann: Man muss die Basin entzünden. ...',
							'Die Basin entzündest du, indem du ein {Easily Inflammable Sulphur} auf sie legst. Dann brennt sie und du kannst durch das blaue Feuer zum gegenüberliegenden gelangen. Eigentlich clever. ...',
							'Da du nun weißt, wie man sloch ein Feuerportal benutzen kann, bist du fähig, mir bei meiner nächsten Aufgabe zu helfen. Diese besteht darin, mir 10 {Hellspawn Tails} aus dem Demon Part bringst. ...',
							'Hellspawns haben die Eigenschaft aus ihrem bloßen Schwanz neu zu enstehen. Also wenn dieser in einem Kampf abgetrennt wird und der restliche Körper stirbt, erwächst ein neuer Hellspawn aus dem Hellspawn Tail. Beeindruckend, nicht wahr? ...',
							'Somit könnte ich eine neue Armee aus Hellspawns erschaffen, um meine Schwester endgültig zu stürzen. Bist du dabei? Bringst du mir die 10 {Hellspawn Tails}?'},cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == 10 then
			npcHandler:say('Bist du hier, um mir die 10 {Hellspawn Tails} zu bringen?', cid)
			talkState[talkUser] = 7
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission3) == 11 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == -1 then
			npcHandler:say({'Deine nächste Aufgabe wird es sein, wie du vermutlich schon erraten hast, den Tar Pit Part zu betreten und dort eine wichtige Mission für mich zu erledigen. ...',
							'Wie du vielleicht schon herausgefunden hast, konntest du schon vorher einen Teil des Tar Pit Parts betreten, genauer gesagt, die oberste Ebene. Doch dieser Teil der Höhle verbirgt noch viel mehr, was du vielleicht an dem Feuerportal am Ende der ersten Ebene erkannt hast. ...',
							'Hinter diesem Portal nämlich triffst du auf weitere neue Monster und sogar erneut auf ein weiteres Feuerportal. Aber zu dem kommen wir erst in deiner nächsten Mission. Zuerst musst du für mich den Teil hinter dem zweiten Feuerportal im Tar Pit Part erkunden, den Teil, mit den Drakens. ...',
							'Du hast richtig gehört. Es sind diese Monster, die Striphin dort eingesperrt hat, also sei vorsichtig. Du wirst in dieser Gegend des Tar Pit Parts ein Rohr finden. In dieses gibts du dann ein besonderes Puder. Kipp Wasser nach und das Puder sollte hinuntergespült werden. ...',
							'Nur um dir noch kurz zu erklären, warum du das machen sollst: Die Empty Pipe ist direkt ans Tar angeschloßen, dass heißt alles, was du dort hineinfüllst fließt direkt ins Tar. Das Puder, was ich dir geben werde ist wie eine Art Verfestiger, es macht das Tar wieder dickflüssig. ...',
							'Da das Tar in letzter Zeit einfach viel zu flüssig geworden ist und die Gefahr besteht, dass es die komplette Höhle überflutet wird und damit all meine Monster und Untertanen ertrinken, musst du das Puder in das Tar fließen lassen, um es zu verfestigen. Alles klar?'},cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == 12 then
			npcHandler:say('Erstmal musst du das Puder in das Tar fließen lassen. Beeil dich, bitte, sonst überflutet das Tar noch die ganze Höhle und ertränkt all meine Monster.', cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4) == 13 and getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == -1 then
			npcHandler:say({'Wie du wahrscheinlich schon in deiner vorherigen Mission bemerkt hast, verbirgt der Tar Pit Part noch ein drittes Feuerportal. Um allerdings den Zugang zu diesem und zu jenem im {Demon Part} zu erhalten und diese benutzen zu dürfen, musst du den Boss {Korus Shavir} besiegen. ...',
							'Um zu {Korus Shavir} zu gelangen musst du dich im Tar Pit Part bis zum hintersten Feuerportal durchkämpfen und in dieses hineinlaufen. Es wird dich nicht wie üblich weiter bringen, sondern geradewegs zum abgeschotteten Raum vom Boss teleportieren. ...',
							'Wenn du fähig bist, diesen Boss zu erledigen, dann kehre zu mir zurück. Nimmst du die Mission an?'},cid)
			talkState[talkUser] = 9
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 14 then
			npcHandler:say('Deine Aufgabe ist es {Korus Shavir} zu besiegen. Sei stark!', cid)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 15 then
			npcHandler:say({'Wußt ichs doch! Du hast es geschafft. Du bist würdig, auch die beiden dritten Feuerportale im Tar Pit Part und im Demon Part benutzen zu dürfen. Der Zutritt sei dir gewährt. ...',
							'Auch bedanke ich mich sehr bei dir. Obwohl wenn ich meine Schwester immernoch nicht gestürtzt haben, durch deine Hilfe werde ich es nun viel leichter haben. Vielen Dank ...',
							'Eines Tages brauche ich sicherlich nochmal deine Hilfe. Bis dahin: Auf Wiedersehen und ein erfolgreiches Abenteuer. Als kleines Dankeschön habe ich hier noch eine Belohnung für dich.'},cid)
			doPlayerAddItem(cid, 6547, 6)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5, 16)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 3)
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5) == 16 then
			npcHandler:say('Ich habe leider momentan keine weiteren Aufgaben für dich. Irgendwann vielleicht nochmal.', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('DANN SOLL ES SO SEIN! Du gehörst nun mir und tust, was ich von dir verlange. Komme zu mir, wenn du Aufträge erhalten willst.', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, -1)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah, 2)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin, -1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			if getPlayerItemCount(cid, 8889) == 1 then
				npcHandler:say('Sehr gut! Ich muss sagen, ich bin beeindruckt. Wenn auch ein wenig überrascht und beleidigt, dass du tatsächlich geglaubt hast, dass ICH, die Königin der Kreaturen und Monster, braucht eine Armor, um die Kontrolle zu besitzen. WIE LÄCHERLICH! MUHAHAHA!', cid)
				setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin, 4)
				talkState[talkUser] = 0
			else
				npcHandler:say('War ja klar, dass du das nicht schaffst. Du bist eben doch kein würdiger Krieger.', cid)
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
				npcHandler:say('LÜGNER!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Brennt, Pflanzen, BRENNT!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission2, 8)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.dragonNestTreesCounter, 0)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Sehr schön. Dein erstes {Easily Inflammable Sulphur} kriegst du von mir geschenkt, doch dann musst du dich selbst darum kümmern, neue zu finden. Lass dir auch gesagt sein, dass du nur das erste Feuerportal benutzen kannst, zu weiteren kriegst du später Zugriff. Viel Erfolg!', cid)
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
				npcHandler:say('Du hast ja überhaupt keine {Hellspawn Tails} dabei.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Sehr schön! Ich nehme an, ich habe dir alles so weit erklärt. Hier hast du das besondere Puder. Sei vorsichtig damit. Viel Glück!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission4, 12)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.portalsWatercave, 2)
			doPlayerAddItem(cid, 15389, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 9 then
			npcHandler:say('Ich wünsche dir alle Kräfte und bin mir sicher, dass du es schaffen wirst. Viel Glück!', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahMission5, 14)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Wie kannst du es wagen? Schließ dich mir an, oder du machst dich zum Feind.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Na dann streng dich an!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Ich hoffe du weißt, dass das Düngerserum von äußerster Bedeutung ist.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Geh zu dieser verdammten Kiste!', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Aha, jetzt, wo wir gegen meine Schwester Striphin vorgehen, kriegst du kalte Füße. Interessant.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Schade. Denn dein erstes {Easily Inflammable Sulphur} hättest du gratis von mir bekommen.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Dann besorge sie mir. Ich brauche eine Armee.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Du musst das aber tun, sonst sterben all meine Wächter.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 8 then
			npcHandler:say('Reiß dich zusammen und besiege diesen Boss.', cid)
			talkState[talkUser] = 0
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new())

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
	local player = Player(cid)
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Was das? Du redest arbeiten? Nicht arbeiten. Ich nicht. Tun nur die kleinen Leute. Ich mach zum Spa�. Bin gut darin. Mache Sachen die Spa� machen. K�mpfen zum Beispiel, mit Br�dern. Oder Dinge zerst�ren.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "sauer") or msgcontains(msg, "w�tend") or msgcontains(msg, "raging") then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == -1 then
			npcHandler:say('Ja, bin w�tend. Br�der �gern mich. Verpr�geln mich. Sollen sterben.',cid)
			talkState[talkUser] = 0
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 6 then
			npcHandler:say('Bin nicht mehr w�tend. Dank dir. Hab dich lieb, kleiner Mann. Soll ich was f�r dich zerst�ren?',cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Ja, bin w�tend. Br�der �gern mich. Verpr�geln mich. Sollen sterben. Froh du hilfst. Berichte von deiner Mission, wenn fertig.',cid)
		end
	elseif msgcontains(msg, "k�mpfen") or msgcontains(msg, "br�der") or msgcontains(msg, "spa�") or msgcontains(msg, "giants") or msgcontains(msg, "zyklopen") or msgcontains(msg, "cyclops") then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == -1 then
			npcHandler:say({'K�mpfen mit Br�dern. F�r dich nicht Br�der. Nat�rlich. F�r dich Zyklopen, glaub ich. Riesen, nennen die kleinen Leute uns. Meine Rasse hei�t Behemoth, glaub ich, bei kleinen Leuten. Alles meine Br�der. ...',
							'Aber ich sauer. Weil Br�der mich immer �gern. Macht mich w�tend. Und traurig. Ich hasse Br�der. Immer zwei gegen einen. Immer auf mich. Dummk�pfe. Sollen sterben. Will nicht mehr bluten. Will Br�der verpr�geln. Hilfst du mir?'},cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('K�mpfen mit Br�dern. F�r dich nicht Br�der. Nat�rlich. F�r dich Zyklopen, glaub ich. Riesen, nennen die kleinen Leute uns. Meine Rasse hei�t Behemoth, glaub ich, bei kleinen Leuten. Alles meine Br�der.',cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "zerst�ren") then
		npcHandler:say('Mag es Sachen zu zerdr�cken. Verbiegen, auseinanderrei�en, umformen. Aber nur weiche Sachen. Wie Metalle und so. Dinge von kleinen Leuten. Waffen und R�stungen. Sind so schlecht gebaut. Kann man gut zerst�ren. Das macht auch Spa�.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "metall") or msgcontains(msg, "waffen") or msgcontains(msg, "r�stungen") then
		npcHandler:say('Dinge von kleinen Leuten sind toll. Kann man gut zerdr�cken. Lieblings ist Riesenschwert. Gibt einen sch�nen Batzen Metall. Oder Drachenschild. Ist sch�nes Drachenmetall drin. Toll ist auch ein Teufelshelm. Kiregt man hei�es Metall. Oder eine K�nigsarmor. Hat so tolles Edelmetall.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'gronta') then
		npcHandler:say('Kleiner Mann auf Spitze vom Berg. So hoch geh ich nicht. Auch Br�der nicht. Wir haben H�henangst.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') then
		npcHandler:say('Kleines Land da dr�ben. Ich schwimm manchmal r�ber. Ist leicht. Gibt es viele Br�der. Leben in H�hlen. In unserer Sprache hei�t Formak.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Kleines St�dtchen. Da hinten. Gehe nicht dahin. Kleine Leute m�gen uns nicht. Sind zu gro�.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'formak') then
		npcHandler:say('Gibt es viele von Br�dern. Sehr gro�e H�hle in Knirschmampf. �hm, Bonezone, nennst du das, glaub ich.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Kleines Tierchen. Wie die kleinen Leute. Wie? Ist kein Tierchen. Ist ein kleiner Mann. Kann nicht sein. Dummer Name. Dumm. Wie die kleinen Leute halt sind.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fire hell') then
		npcHandler:say('Sehr hei� da. Mag ich nicht. Leben aber auch Br�der da. Die findens toll. Ich nicht. Wenn du hin willst, geh zu kleinem Mann n�rdlich vom Berg. L�sst dich aber bestimmt nicht rein.',cid)
		talkState[talkUser] = 0
	elseif msg == 'riesenschwert' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Tolles Teil. Kann dir einen Batzen Eisen daraus machen. Hast eins?',cid)
			talkState[talkUser] = 10
		else
			npcHandler:say('Tolles Teil. Kann dir einen Batzen Eisen daraus machen. Will aber nicht. Bin w�tend.', cid)
			talkState[talkUser] = 0
		end
	elseif msg == 'drachenschild' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Foll Vett. So sch�n weich. Auseinanderrei�en! Jetz hab ich Lust zu zerst�ren. Hast dabei?',cid)
			talkState[talkUser] = 11
		else
			npcHandler:say('Foll Vett. So sch�n weich. Auseinanderrei�en! Jetz hab ich Lust zu zerst�ren. Bin aber so sauer. Menno.', cid)
			talkState[talkUser] = 0
		end
	elseif msg == 'teufelshelm' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Krass. Setz mich immer drauf. Danach platt. Das lustig. Soll ich dir zeigen?',cid)
			talkState[talkUser] = 12
		else
			npcHandler:say('Krass. Setz mich immer drauf. Danach platt. Das lustig. Will jetzt aber nicht.', cid)
			talkState[talkUser] = 0
		end
	elseif msg == 'k�nigsarmor' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Klasse R�stung. Sch�ne Farben. Kaputt machen! Das toll. Hast eine?',cid)
			talkState[talkUser] = 13
		else
			npcHandler:say('Klasse R�stung. Sch�ne Farben. Kaputt machen! Das toll. Aber nicht Br�der. Die nicht toll.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') or msgcontains(msg, 'aufgabe') then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == 1 then
			if player:getStorageValue(killingInTheNameOfTasks[4].counterStorage) >= killingInTheNameOfTasks[4].amountToKill then
				npcHandler:say('Super klasse. Liebe dich. Alle tot. Haha. Tot... Bin aber immer noch sauer. Will sehen, wie du sie get�tet hast. Gib mir die K�pfe von zwei Br�dern. Egal, wie sie aussehen. Dann wei� ich, du hast alle get�tet. Machst das?',cid)
				player:setStorageValue(aRagingGiantsQuest.mission1, 2)
				player:setStorageValue(killingInTheNameOfTasks[4].counterStorage, -1)
				talkState[talkUser] = 3
			else
				npcHandler:say('Kleiner L�gner! Du hast nicht genug Br�der get�tet. Sie m�ssen aber sterben.',cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif player:getStorageValue(aRagingGiantsQuest.mission1) == 2 and player:getStorageValue(aRagingGiantsQuest.mission2) == -1 then
			npcHandler:say('Bin immer noch sauer. Will sehen, wie du Br�der get�tet hast. Gib mir die K�pfe von zwei Br�dern. Egal, wie sie aussehen. Dann wei� ich, du hast alle get�tet. Machst das?',cid)
			talkState[talkUser] = 3
		elseif player:getStorageValue(aRagingGiantsQuest.mission2) == 3 then
			if player:removeItem(7398, 2) == TRUE or player:removeItem(7396, 2) == TRUE then
				npcHandler:say('HUMDUK! Lieber Kleiner. Sieht toll aus die neuen K�pfe. H�ng ich mir hier hin, glaub ich. Haha. Tote Br�der. Jetzt nur noch meinen Vater t�ten. Das toll. Aber ist stark. Ich kann nicht, du schon, glaub ich. Machst das?',cid)
				player:setStorageValue(aRagingGiantsQuest.mission2, 4)
				talkState[talkUser] = 4
			else
				npcHandler:say('Kleiner L�gner! Du hast keine K�pfe von Br�dern dabei. Sie m�ssen aber sterben.',cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif player:getStorageValue(aRagingGiantsQuest.mission2) == 4 and player:getStorageValue(aRagingGiantsQuest.mission3) == -1 then
			npcHandler:say('Danke f�r K�pfe von Br�dern. Jetzt nur noch meinen Vater t�ten. Das toll. Aber ist stark. Ich kann nicht, du schon, glaub ich. Machst das?',cid)
			talkState[talkUser] = 4
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 5 then
			npcHandler:say('Vater findest du hier im Berg. Lebt in kleinem Raum hinter Wand. Kommt durch Loch raus und rein. Zerschlag Wand mit Spitzhacke. Dann du kannst rein und t�ten.',cid)
			talkState[talkUser] = 0
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 6 then
			npcHandler:say('Danke nochmal f�r T�ten von Papa. Bin nicht mehr w�tend. Dank dir. Hab dich lieb, kleiner Mann. Soll ich was f�r dich zerst�ren?',cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Hab nix.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Toll. Mag dich. Hilf mir Br�der zu t�ten. Normal bei uns. Sie machen auch bei mir. Wollen mich verpr�geln, tot schlagen. Diesmal nicht. Diesmal sie sterben. T�te sie. 250 von meinen Br�dern. Ok?', cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Humduk. Toller Kleiner. Hab dich gern. Komm wieder, wenn du fertig bist mit t�ten. Dondon!', cid)
			player:setStorageValue(aRagingGiantsQuest.mission1, 1)
			player:setStorageValue(killingInTheNameOfTasks[4].counterStorage, 0)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Humduk! Freu mich. Beeil dich. Will nicht mehr sauer sein. Dondon!', cid)
			player:setStorageValue(aRagingGiantsQuest.mission2, 3)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Humduk Motta! Blut flie�t schnell. Ganz in rot. B�ser Vater. Der bald tot. - Vater findest du hier im Berg. Lebt in kleinem Raum hinter Wand. Kommt durch Loch raus und rein. Zerschlag Wand mit Spitzhacke. Dann du kannst rein und t�ten.', cid)
			player:setStorageValue(aRagingGiantsQuest.mission3, 5)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Humduk! Was ich kaputt machen f�r dich? Riesenschwert, Drachenschild, Teufelshelm oder K�nigsarmor?', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 10 then
			if player:removeItem(2393, 1) == TRUE then
				npcHandler:say('Humduk! *knirsch* *knack* *quietsch*. So, hier bitte. Das lustig.', cid)
				player:addItem(5892)
			else
				npcHandler:say('Hast nichts. Spast!',cid)
				npcHandler:releaseFocus(cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 11 then
			if player:removeItem(2516, 1) == TRUE then
				npcHandler:say('Humduk! *knirsch* *knack* *quietsch*. So, hier bitte. Das lustig.', cid)
				player:addItem(5889)
			else
				npcHandler:say('Hast nichts. Spast!',cid)
				npcHandler:releaseFocus(cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 12 then
			if player:removeItem(2462, 1) == TRUE then
				npcHandler:say('Humduk! *knirsch* *knack* *quietsch*. So, hier bitte. Das lustig.', cid)
				player:addItem(5888)
			else
				npcHandler:say('Hast nichts. Spast!',cid)
				npcHandler:releaseFocus(cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 13 then
			if player:removeItem(2487, 1) == TRUE then
				npcHandler:say('Humduk! *knirsch* *knack* *quietsch*. So, hier bitte. Das lustig.', cid)
				player:addItem(5887)
			else
				npcHandler:say('Hast nichts. Spast!',cid)
				npcHandler:releaseFocus(cid)
			end
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dummkopf.', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Mag dich doch nicht.', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Missgeburt!', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Schade. Warum du hier?', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 10 then
			npcHandler:say('Missgeburt!', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 11 then
			npcHandler:say('Missgeburt!', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 12 then
			npcHandler:say('Missgeburt!', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 13 then
			npcHandler:say('Missgeburt!', cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

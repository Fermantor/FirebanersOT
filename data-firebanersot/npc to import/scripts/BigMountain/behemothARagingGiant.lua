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
		npcHandler:say('Was das? Du redest arbeiten? Nicht arbeiten. Ich nicht. Tun nur die kleinen Leute. Ich mach zum Spaß. Bin gut darin. Mache Sachen die Spaß machen. Kämpfen zum Beispiel, mit Brüdern. Oder Dinge zerstören.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "sauer") or msgcontains(msg, "wütend") or msgcontains(msg, "raging") then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == -1 then
			npcHandler:say('Ja, bin wütend. Brüder ägern mich. Verprügeln mich. Sollen sterben.',cid)
			talkState[talkUser] = 0
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 6 then
			npcHandler:say('Bin nicht mehr wütend. Dank dir. Hab dich lieb, kleiner Mann. Soll ich was für dich zerstören?',cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Ja, bin wütend. Brüder ägern mich. Verprügeln mich. Sollen sterben. Froh du hilfst. Berichte von deiner Mission, wenn fertig.',cid)
		end
	elseif msgcontains(msg, "kämpfen") or msgcontains(msg, "brüder") or msgcontains(msg, "spaß") or msgcontains(msg, "giants") or msgcontains(msg, "zyklopen") or msgcontains(msg, "cyclops") then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == -1 then
			npcHandler:say({'Kämpfen mit Brüdern. Für dich nicht Brüder. Natürlich. Für dich Zyklopen, glaub ich. Riesen, nennen die kleinen Leute uns. Meine Rasse heißt Behemoth, glaub ich, bei kleinen Leuten. Alles meine Brüder. ...',
							'Aber ich sauer. Weil Brüder mich immer ägern. Macht mich wütend. Und traurig. Ich hasse Brüder. Immer zwei gegen einen. Immer auf mich. Dummköpfe. Sollen sterben. Will nicht mehr bluten. Will Brüder verprügeln. Hilfst du mir?'},cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Kämpfen mit Brüdern. Für dich nicht Brüder. Natürlich. Für dich Zyklopen, glaub ich. Riesen, nennen die kleinen Leute uns. Meine Rasse heißt Behemoth, glaub ich, bei kleinen Leuten. Alles meine Brüder.',cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "zerstören") then
		npcHandler:say('Mag es Sachen zu zerdrücken. Verbiegen, auseinanderreißen, umformen. Aber nur weiche Sachen. Wie Metalle und so. Dinge von kleinen Leuten. Waffen und Rüstungen. Sind so schlecht gebaut. Kann man gut zerstören. Das macht auch Spaß.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "metall") or msgcontains(msg, "waffen") or msgcontains(msg, "rüstungen") then
		npcHandler:say('Dinge von kleinen Leuten sind toll. Kann man gut zerdrücken. Lieblings ist Riesenschwert. Gibt einen schönen Batzen Metall. Oder Drachenschild. Ist schönes Drachenmetall drin. Toll ist auch ein Teufelshelm. Kiregt man heißes Metall. Oder eine Königsarmor. Hat so tolles Edelmetall.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'gronta') then
		npcHandler:say('Kleiner Mann auf Spitze vom Berg. So hoch geh ich nicht. Auch Brüder nicht. Wir haben Höhenangst.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') then
		npcHandler:say('Kleines Land da drüben. Ich schwimm manchmal rüber. Ist leicht. Gibt es viele Brüder. Leben in Höhlen. In unserer Sprache heißt Formak.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Kleines Städtchen. Da hinten. Gehe nicht dahin. Kleine Leute mögen uns nicht. Sind zu groß.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'formak') then
		npcHandler:say('Gibt es viele von Brüdern. Sehr große Höhle in Knirschmampf. Ähm, Bonezone, nennst du das, glaub ich.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Kleines Tierchen. Wie die kleinen Leute. Wie? Ist kein Tierchen. Ist ein kleiner Mann. Kann nicht sein. Dummer Name. Dumm. Wie die kleinen Leute halt sind.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fire hell') then
		npcHandler:say('Sehr heiß da. Mag ich nicht. Leben aber auch Brüder da. Die findens toll. Ich nicht. Wenn du hin willst, geh zu kleinem Mann nördlich vom Berg. Lässt dich aber bestimmt nicht rein.',cid)
		talkState[talkUser] = 0
	elseif msg == 'riesenschwert' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Tolles Teil. Kann dir einen Batzen Eisen daraus machen. Hast eins?',cid)
			talkState[talkUser] = 10
		else
			npcHandler:say('Tolles Teil. Kann dir einen Batzen Eisen daraus machen. Will aber nicht. Bin wütend.', cid)
			talkState[talkUser] = 0
		end
	elseif msg == 'drachenschild' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Foll Vett. So schön weich. Auseinanderreißen! Jetz hab ich Lust zu zerstören. Hast dabei?',cid)
			talkState[talkUser] = 11
		else
			npcHandler:say('Foll Vett. So schön weich. Auseinanderreißen! Jetz hab ich Lust zu zerstören. Bin aber so sauer. Menno.', cid)
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
	elseif msg == 'königsarmor' then
		if player:getStorageValue(aRagingGiantsQuest.mission2) == 4 then
			npcHandler:say('Klasse Rüstung. Schöne Farben. Kaputt machen! Das toll. Hast eine?',cid)
			talkState[talkUser] = 13
		else
			npcHandler:say('Klasse Rüstung. Schöne Farben. Kaputt machen! Das toll. Aber nicht Brüder. Die nicht toll.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') or msgcontains(msg, 'aufgabe') then
		if player:getStorageValue(aRagingGiantsQuest.mission1) == 1 then
			if player:getStorageValue(killingInTheNameOfTasks[4].counterStorage) >= killingInTheNameOfTasks[4].amountToKill then
				npcHandler:say('Super klasse. Liebe dich. Alle tot. Haha. Tot... Bin aber immer noch sauer. Will sehen, wie du sie getötet hast. Gib mir die Köpfe von zwei Brüdern. Egal, wie sie aussehen. Dann weiß ich, du hast alle getötet. Machst das?',cid)
				player:setStorageValue(aRagingGiantsQuest.mission1, 2)
				player:setStorageValue(killingInTheNameOfTasks[4].counterStorage, -1)
				talkState[talkUser] = 3
			else
				npcHandler:say('Kleiner Lügner! Du hast nicht genug Brüder getötet. Sie müssen aber sterben.',cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif player:getStorageValue(aRagingGiantsQuest.mission1) == 2 and player:getStorageValue(aRagingGiantsQuest.mission2) == -1 then
			npcHandler:say('Bin immer noch sauer. Will sehen, wie du Brüder getötet hast. Gib mir die Köpfe von zwei Brüdern. Egal, wie sie aussehen. Dann weiß ich, du hast alle getötet. Machst das?',cid)
			talkState[talkUser] = 3
		elseif player:getStorageValue(aRagingGiantsQuest.mission2) == 3 then
			if player:removeItem(7398, 2) == TRUE or player:removeItem(7396, 2) == TRUE then
				npcHandler:say('HUMDUK! Lieber Kleiner. Sieht toll aus die neuen Köpfe. Häng ich mir hier hin, glaub ich. Haha. Tote Brüder. Jetzt nur noch meinen Vater töten. Das toll. Aber ist stark. Ich kann nicht, du schon, glaub ich. Machst das?',cid)
				player:setStorageValue(aRagingGiantsQuest.mission2, 4)
				talkState[talkUser] = 4
			else
				npcHandler:say('Kleiner Lügner! Du hast keine Köpfe von Brüdern dabei. Sie müssen aber sterben.',cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif player:getStorageValue(aRagingGiantsQuest.mission2) == 4 and player:getStorageValue(aRagingGiantsQuest.mission3) == -1 then
			npcHandler:say('Danke für Köpfe von Brüdern. Jetzt nur noch meinen Vater töten. Das toll. Aber ist stark. Ich kann nicht, du schon, glaub ich. Machst das?',cid)
			talkState[talkUser] = 4
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 5 then
			npcHandler:say('Vater findest du hier im Berg. Lebt in kleinem Raum hinter Wand. Kommt durch Loch raus und rein. Zerschlag Wand mit Spitzhacke. Dann du kannst rein und töten.',cid)
			talkState[talkUser] = 0
		elseif player:getStorageValue(aRagingGiantsQuest.mission3) == 6 then
			npcHandler:say('Danke nochmal für Töten von Papa. Bin nicht mehr wütend. Dank dir. Hab dich lieb, kleiner Mann. Soll ich was für dich zerstören?',cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Hab nix.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Toll. Mag dich. Hilf mir Brüder zu töten. Normal bei uns. Sie machen auch bei mir. Wollen mich verprügeln, tot schlagen. Diesmal nicht. Diesmal sie sterben. Töte sie. 250 von meinen Brüdern. Ok?', cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Humduk. Toller Kleiner. Hab dich gern. Komm wieder, wenn du fertig bist mit töten. Dondon!', cid)
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
			npcHandler:say('Humduk Motta! Blut fließt schnell. Ganz in rot. Böser Vater. Der bald tot. - Vater findest du hier im Berg. Lebt in kleinem Raum hinter Wand. Kommt durch Loch raus und rein. Zerschlag Wand mit Spitzhacke. Dann du kannst rein und töten.', cid)
			player:setStorageValue(aRagingGiantsQuest.mission3, 5)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Humduk! Was ich kaputt machen für dich? Riesenschwert, Drachenschild, Teufelshelm oder Königsarmor?', cid)
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

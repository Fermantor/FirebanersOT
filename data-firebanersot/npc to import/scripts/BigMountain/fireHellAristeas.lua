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
		npcHandler:say('Meine Berufung ist es, die gigantische und m�chtige Fire Hell zu bewachen. Ich sorge daf�r, dass kein Unw�rdiger je die brodelnden Hallen dieser unterirdischen Feuerh�hle betritt.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'fire hell') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission1) == -1 then
			npcHandler:say({'Fire Hell ist ein Ort des Grauens. Ein Ort der Qualen. Ein Ort des Feuers und der Magmars. Es ist die H�lle von Fireban, und der Tod f�r fast jeden Menschen, der sie betritt. ...',
							'Nur sehr wenigen Menschen ist es gestattet Fire Hell zu betreten. Und meine Aufgabe ist es diesen Schutz zu bewahren. Der einzige Weg in die H�lle f�hrt durch die T�r hinter mir, doch ohne meine Erlaubnis kommt da niemand durch. ...',
							'Wenn du hier bist, um Fire Hell zu betreten, muss ich dich warnen: Schwierige Aufgaben erwarten dich. Du hast richtig geh�rt. Ich werde dir eine Reihe Aufgaben stellen, um deine F�higkeiten einsch�tzen zu k�nnen. ...',
							'Meisterst du all diese Missionen, werde ich dir den Zugang zu Fire Hell gestatten. �berlege es dir gut.'},cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission4) == 14 then
			npcHandler:say({'Fire Hell ist ein Ort des Grauens. Ein Ort der Qualen. Ein Ort des Feuers und der Magmars. Es ist die H�lle von Fireban, und der Tod f�r fast jeden Menschen, der sie betritt. ...',
							'Nur sehr wenigen Menschen ist es gestattet Fire Hell zu betreten. Und meine Aufgabe ist es diesen Schutz zu bewahren. Der einzige Weg in die H�lle f�hrt durch die T�r hinter mir, doch ohne meine Erlaubnis kommt da niemand durch. ...',
							'Du bist einer der wenigen Menschen, dem ich gestatte, die T�r hinter mir zu gebrauchen un die brodelnden Hallen von Fire Hell zu betreten. Nutze dies weise!'},cid)
		else
			npcHandler:say({'Fire Hell ist ein Ort des Grauens. Ein Ort der Qualen. Ein Ort des Feuers und der Magmars. Es ist die H�lle von Fireban, und der Tod f�r fast jeden Menschen, der sie betritt. ...',
							'Nur sehr wenigen Menschen ist es gestattet Fire Hell zu betreten. Und meine Aufgabe ist es diesen Schutz zu bewahren. Der einzige Weg in die H�lle f�hrt durch die T�r hinter mir, doch ohne meine Erlaubnis kommt da niemand durch. ...',
							'Du hast dich ja bereits bei mir gemeldet, um alle meine Pr�fungen zu absolvieren, die ich dir stellen werde. Meisterst du all diese Missionen, werde ich dir den Zugang zu Fire Hell gestatten.'},cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'outlaws') then
		npcHandler:say('Wilde sind das. Sie kamen hierher von den unterschiedlichsten Orten der Welt, manche sagen sogar von Materia. Sie schmuggelten illegale Ware �ber die Grenzen und leben jetzt teilweise nomadisch, teilweise station�r. Hier auf der Insel sind sie weit verbreitet.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'gronta') then
		npcHandler:say('Gronta lebt auf diesem Berg und ist der m�chtigste Druide von Fireban, wenn man von der Legende zweier Hexen auf Bonezone absieht. Diese sollen sogar noch mehr Macht �ber die Natur und Gesch�pfe von Fireban haben. Einfach unglaubwrdig!',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') then
		npcHandler:say('Bonezone ist die Stadt hinter dem Horizont ostwerts von Pulgra. Die Umgebung dort beherbergt die verschiedensten Kreaturen in ihren H�hlen der Manifestation. Reisende erz�hlen von gigantischen unterirdischen Komplexen und begehbaren Ozeanen. Du solltest sie unbedingt besuchen.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Pulgra ist die gro�artige Stadt gar nicht weit von hier im Osten. Sie begann als kleines Dorf und ist heute das �lteste Reich auf Fireban. Ich k�nnte noch viel geschichtliches Zeug erz�hlen, aber eigentlich will ich dir nur die Taverne empfehlen. Dort gibts echt gutes Bier.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Sagt mir nichts. Ist das ein Gericht? H�rt sich ja wiederlich an!',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'buch') or msgcontains(msg, 'kristall') or msgcontains(msg, 'crystal') or msgcontains(msg, 'zerissen') or msgcontains(msg, 'seite') then
		npcHandler:say({'Du redest von der herausgerissenen Seite in dem Buch im linken Regal? Ja, das ist wirklich eine Trag�die. Einst war ein M�dchen hier, sie nannte sich Beatrice. Sie war voller Tatendrang und Motivation, meine Pr�fungen zu meistern. ...',
						'Allerdings merkte ich gleich auf den ersten Blick, dass bei ihr alle Hoffnung verloren sei. Sie erz�hlte mir etwas von einem Geliebten namens Dante und einem roten Kristall, den sie ihm schenken wolle. Von kriegerlichem Verst�ndnis war da keine Spur. ...',
						'Sie versagte gleich bei meiner ersten Pr�fung und schaffte es nicht, alle blauen Arkansteine zu zerschlagen. Aus Zorn, oder wei� Gott was, pl�nderte sie meine B�cherregale, und riss eine Seite aus einem Geschichtsbuch zu Fire Hell heraus. ...',
						'Ich versuchte, sie aufzuhalten, doch sie bedrohte mich mit einer Spitzhacke. Einfach l�cherlich. Ich sah noch, wie sie mit dem Werkzeug einen dicken Stein gleich hier �ber uns zerschlug, und durch einen Riss im Boden fl�chtete. Wahrscheinlich ist sie dort verendet, denn den Monstern gewachsen war sie allemal nicht.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'aufgaben') or msgcontains(msg, 'missionen') or msgcontains(msg, 'zugang') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission1) == -1 then
			npcHandler:say('Du willst also versuchen meine Aufgaben zu meistern, um dir den Zugang zu Fire Hell zu verschaffen?', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission4) == 14 then
			npcHandler:say('Du hast den Zugang zu Fire Hell bereits erhalten, indem du all meine Pr�fungen gemeistert hast.', cid)
			talkState[talkUser] = 0
		else
			npcHandler:say('Wir haben doch schon abgekl�rt, dass ich dich pr�fen werde. Du hast eine aktuelle {Quest}.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') or msgcontains(msg, 'pr�fung') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission1) == 1 then
			npcHandler:say({'Du bist also bereit f�r deine erste Pr�fung? Na dann los! Wir fangen mit etwas leichtem an. Auf diese Weise sortiere ich all die Bewerber, die nicht mal ein Schwert f�hren k�nnen, direkt zu Beginn aus. ...',
							'�stlich dieser Insel �berhalb des langgestrecktem Arms des gro�en Berges befindet sich ein Camp der Outlaws. Diese wilden Langfinger besitzen einige Macht hier in diesem Gebiet. ...',
							'Dies liegt nicht zuletzt an der Zauberkraft der Hexen, die f�r die ungew�hliche Willenskraft der Outlaws verantwortlich sind. Neben dem Camp haben die Hexen eines ihrer Lager mit ihren wertvollen blauen Arkansteinen. ...',
							'Diese Steine ben�tigen sie f�r ihre kraftvolle Magie, sie sind der Odem ihrer Hexerei. Besch�digt man diese Steine, schw�cht man alle Hexen, welche ihre Kraft von diesem beziehen. ...',
							'Finde das Camp, �berliste die Hexen vor Ort und zerschlage die Steine mit einer Spitzhacke. Verstanden?'},cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission1) == 2 then
			npcHandler:say('Deine erste Pr�fung besteht darin das Outlaw Camp �stlich von der Big Mountain Insel zu finden und die blauen Arkansteine der Hexen mit einer Spitzhacke zu besch�digen. Viel Erfolg!',cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission1) == 3 and getPlayerStorageValue(cid, examinationToFireHell.mission2) == -1 then
			npcHandler:say({'Bereit f�r deine zweite Pr�fung? Sehr gut. Diese allerdings wirst du nicht bei mir ablegen, sondern bei {Gronta}, dem gro�artigen Druiden von Fireban. ...',
							'Er wohnt auf der Spitze dieses Berges, jedoch ist der Weg lang und beschwerlich. Von hier aus f�hrt kein Weg hin, den musst du schon selber finden. Mach dich auf Kraxelei gefasst. ...',
							'Wenn du Gronta gefunden hast, sage ihm meinen Namen, und er wird wissen, dass ich dich wegen der Pr�fung schicke. Alles klar soweit?'},cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission2) == 4 or getPlayerStorageValue(cid, examinationToFireHell.mission2) == 5 or getPlayerStorageValue(cid, examinationToFireHell.mission2) == 6 or getPlayerStorageValue(cid, examinationToFireHell.mission2) == 7 then
			npcHandler:say('Deine zweite Pr�fung besteht darin Gronta, den m�chtigen Druiden auf der Spitze dieses Berges zu finden und ihm meinen Name zu sagen. Er wird dir eine Aufgabe stellen. Viel Erfolg!',cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission2) == 8 and getPlayerStorageValue(cid, examinationToFireHell.mission3) == -1 then
			npcHandler:say({'Deine dritte Pr�fung also, he? Na warte mal ab. Du wirst es dir wahrscheinlich noch anders �berlegen. Ein guter Krieger muss auch beweisen k�nnen, dass er seine volle Umgebung immer unter Kontrolle hat. ...',
							'Aus diesem Grund wird deine n�chste Aufgabe dich in alle Ecken und Enden dieser Insel zwingen, die du sonst sicherlich eher meiden w�rdest. Ich habe f�r diese Mission eigens {5 Basins} rundum aufgestellt, und du musst sie alle finden. ...',
							'Wenn du eine solche Basin entdeckt hast, musst du sie entz�nden und ich werde als W�chter des Feuers wissen, dass du die Basin erreichen konntest. ...',
							'Wenn du alle Basins gefunden hast, kehre zu mir zur�ck und ich werde dich belohnen. Bist du stets gewillt diese Mission entgegen zu nehmen?'},cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission3) == 9 then
			npcHandler:say('Deine dritte Pr�fung besteht darin, alle Basins auf diesem Berg zu finden und sie zu entz�nden. Du hast noch nicht alle f�nf Basins gefunden. Kehre zu mir zur�ck, wenn es so weit ist, und ich werde dich belohnen.',cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission3) == 10 then
			npcHandler:say('Du hast deine dritte Pr�fung hervorragend gemeistert. Daf�r belohne ich dich mit einem Easily Inflammable Sulphur. Du wirst dieses seltene Item bestimmt noch gebrauchen k�nnen. ',cid)
			doPlayerAddItem(cid, 6547, 1)
			setPlayerStorageValue(cid, examinationToFireHell.mission3, 11)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission3) == 11 and getPlayerStorageValue(cid, examinationToFireHell.mission4) == -1 then
			npcHandler:say({'Du hast bisher alle Pr�fungen gemeistert. Das hei�t, dir steht nicht mehr viel im Weg, um den Zugang zu Fire Hell zu erhalten. Ehrlich gesagt, nur noch eine letzte Pr�fung. Und diese wird beweisen, ob du tats�chlich w�rdig bist Fire Hell zu betreten. ...',
							'Deine Aufgabe ist es, in das violette Feuer �ber dir zu treten und zu beweisen, dass du dessen flammende Macht widerstehen kannst, ohne grausame Verbrennungen davon zu tragen. Nur dann bist du ein wahrer Krieger des Feuers und darfst Fire Hell betreten. ...',
							'Wirst du diese Mission annehmen und mir, dem W�chter der brodelnden Unterwelt, beweisen, dass du ein w�rdiger Krieger bist?'},cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission4) == 12 then
			npcHandler:say('Deine vierte Pr�fung besteht darin, auf das violette Feuer in meinem Haus zu treten und zu beweisen, dass du der Macht der Flamme widerstehen kannst.',cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission4) == 13 then
			npcHandler:say('Du hast dich wirklich gro�artig geschlagen in allen meinen Pr�fungen. Daf�r werde ich dir den Zugang zu Fire Hell gew�hren. Doch bleibe stets auf der sicheren und richtigen Seite, denn die Gro�meister von Fireban zeigen wenig Gande. Viel Erfolg auf deinen weiteren Reisen!',cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission4, 14)
			setPlayerStorageValue(cid, examinationToFireHell.fireHellDoor, 1)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, examinationToFireHell.mission4) == 14 then
			npcHandler:say('Du hast alle meine Pr�fungen mit Bravur bestanden und den Zugang zu Fire Hell erhalten. Doch bleibe stets auf der sicheren und richtigen Seite, denn die Gro�meister von Fireban zeigen wenig Gande. Viel Erfolg auf deinen weiteren Reisen!',cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('So soll es sein! Ich werde dich pr�fen. Du kannst mich nun immer nach einer {Quest} fragen und ich werde dir eine Pr�fung aufgeben. Viel Erfolg!',cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, examinationToFireHell.mission1, 1)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Nun sch�n. Dann gutes Gelingen. Kehre zu mir zur�ck, wenn du es geschafft hast, um dir deine n�chste Mission abzuholen.',cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission1, 2)
			talkState[talkUser] = 0	
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Hervorragend! Dann finde Gronta, erledige seinen Auftrag und kehre zu mir zur�ck. Viel Gl�ck!',cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, examinationToFireHell.mission2, 4)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Tats�chlich? Nicht schlecht. Ich erwarte dich hier wieder. Viel Erfolg!', cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission3, 9)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Einen steinernen Schutz, der dich vor allen Hitzesch�den bewahrt, w�nsche ich dir. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, examinationToFireHell.mission4, 12)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dies �berrascht mich nicht, nur die Wenigsten besitzen den Mut dazu.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Wenn du schon vor der ersten Pr�fung zur�ckweichst, hast du keine Chance in Fire Hell zu �berleben.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Hast wohl Angst vor Gronta, was? Kann ich sogar verstehen.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Nichts anderes habe ich erwartet. Du bist einfach zu schwach.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Die Kraft des Feuers zwingt dich wohl in die Knie. Die meisten Menschen untersch�tzen das.', cid)
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

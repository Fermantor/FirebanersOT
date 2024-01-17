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
		npcHandler:say('Huhuuuuhuu.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "dante") or msgcontains(msg, "kristall") or msgcontains(msg, "crystal") then
		if getPlayerStorageValue(cid, theCrystalOfLove.mission1) == -1 then
			npcHandler:say('Huuuuh. Huuh. *hust, hust*. Hu.. *hust*. Wie kannst du davon wissen? Das ist unm�glich. Du wei�t von meinem Geliebten Dante und meiner Begierde, ihm den roten Kristall der Liebe zu schenken?',cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 1 then
			if getPlayerItemCount(cid, 10614) >= 1 then
				npcHandler:say({'Ich kann es nicht fassen! Der Kristall der Liebe, der einzigartige tiefrote Kristall. Du hast ihn gefunden. Du hast ihn zu mir gebracht. Daf�r bin ich dir ewig dankbar, und das mag bei einem schon Geist was hei�en. ...',
								'Und ich w�rde gerne... also... wenn es m�glich w�re... Ist es zu viel verlangt, dich um einen letzten Gefallen zu bitten, damit meine Seele auf ewig ruhen kann? Darf ich von dir verlangen, den Kristall meinem Geliebten Dante zu bringen? ...',
								'Es w�rde mein druchsichtiges Herz mit Freude erf�llen, wenn du das f�r mich tun k�nntest. Mein Geist kann diesen Ort leider nicht verlassen, da ich hier gestorben bin. Und ohnehin k�nnte ich den Kristall gar nicht anfassen, da ich ja ein Geist bin. ...',
								'Dante ist inzwischen nat�rlich auch schon gestorben. Sein Grab ist allerdings weit entfernt von hier. Fr�her lebten wir n�mlich in Bonezone, eine Stadt auf einer Insel im Osten. Sie ist nur mit dem Boot zu erreichen. ...',
								'Wie ich vor langer Zeit von einem Freund h�rte, wurde Dante auf einem kleinen Friedhof auf den Spiry Ground westlich von Bonezone begraben. Dieser Friedhof soll jedoch inzwischen versunken sein, wobei er immernoch unterirdisch zu erreichen ist. ...',
								'Du solltest also in der Lage sein auf den Spiry Grounds einen Eingang in eine H�hle zu finden, um den Friedhof und somit Dantes Grab aufzusuchen. Lege den Kristall in Dantes Grab und ich werde in Frieden ruhen k�nnen. ...',
								'Eine Kleinigkeit noch: Die meisten Gr�ber sind mit einem Fluch belegt, der die Pl�nderung durch einen Sch�nder verhindert. Es wird ein Opfer von {20 Demonic Essences} erwartet, damit du das Grab aufbuddeln darfst. Trage sie einfach bei dir. Berichte mir, wenn du es geschafft hast. Viel Gl�ck und Dank an dich!'},cid)
				setPlayerStorageValue(cid, theCrystalOfLove.mission1, 2)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du l�gst! Du tr�gst den Kristall nicht mit dir. Ich wusste, dass du es nicht schaffen w�rdest.',cid)
				talkState[talkUser] = 0
			end
		elseif getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 2 then
			npcHandler:say('Bitte versuche Dantes Grab in Bonezone unterhalb der Spiry Grounds zu finden und mit dem Opfer von {20 Demonic Essences} den roten Kristall zu vergraben. Ich w�re dir so dankbar.',cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 3 then
			npcHandler:say({'Du bist mein Retter und Held auf ewig. Du hast mir bewiesen, dass sich die Macht der Liebe sogar auf andere Menschen �bertr�gt. Ich danke dir vom ganzen transparenten Herzen. ...',
							'Leider habe ich nicht viel, womit ich dich belohnen kann, was Materielles schon gar nicht. Jedoch hast du mir bewiesen, dass du ein wahrer Krieger bist, da du den Kampf mit zwei Demons aufgenommen hast, um den roten Kristall zu erhalten. ...',
							'Besuche den Schneider von Bonezone. Sein Name ist {Avion} und er ist der Vater des K�nigs Atlantos. Nenn ihm meinen Namen und er wird dich mit einem neuen Outfit belohnen. Das ist alles, was ich dir anbieten kann. Vielen Dank f�r all deine Hilfe!'},cid)
			setPlayerStorageValue(cid, theCrystalOfLove.mission1, 4)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 4 then
			npcHandler:say({'Du bist mein Retter und Held auf ewig. Du hast mir bewiesen, dass sich die Macht der Liebe sogar auf andere Menschen �bertr�gt. Ich danke dir vom ganzen transparenten Herzen. ...',
							'Leider habe ich nicht viel, womit ich dich belohnen kann, was Materielles schon gar nicht. Jedoch hast du mir bewiesen, dass du ein wahrer Krieger bist, da du den Kampf mit zwei Demons aufgenommen hast, um den roten Kristall zu erhalten. ...',
							'Besuche den Schneider von Bonezone. Sein Name ist {Avion} und er ist der Vater des K�nigs Atlantos. Nenn ihm meinen Namen und er wird dich mit einem neuen Outfit belohnen. Das ist alles, was ich dir anbieten kann. Vielen Dank f�r all deine Hilfe!'},cid)
			talkState[talkUser] = 0
		elseif getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 4 then
			npcHandler:say('Du bist mein Retter und Held auf ewig. Danke f�r all deine Dienste, die du mir, Dante und der Liebe zuteil kommen lie�est.',cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "ja") or msgcontains(msg, "yes") then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Aber wie? Wie hast du das herausgefunden? ... Ich habe Dante geliebt, er war mein Ein und Alles, mein Grund zu leben. Aus diesem Grund wollte ich ihm auch den Kristall der Liebe schenken. Um ihm meine unsterbliche Liebe zu beweisen. ...',
							'Ich habe es jedoch nicht geschafft. Ich konnte die Pr�fungen von Aristeas, dem W�chter von Fire Hell, nicht bestehen. Und so stibitzte ich eine Seite eines Buches aus seiner Bibliothek und versuchte durch einen versteckten Riss im Boden hinter einem schweren Stein, den ich mit einer Spitzhacke zerschlug, einen anderen Weg nach Fire Hell zu finden. ...',
							'Doch wie es scheint, gibt es nur diesen einen durch die T�r in Aristeas Haus. Denn kaum hatte ich mich durch sie Spalte hindurchgezw�ngt, �berraschten mich mehrere Feuergestalten. Sie t�teten mich an Ort und Stelle, und mein Wunsch, Dante den Kristall zu �berbringen, wurde f�r immer vernichtet. ...',
							'Nun existiert nur noch mein Geist an diesem grauenvollen Ort und wird auf ewig Trauer und Schmerz empfinden. Die Legende besagt, dass der Kristall irgendwo tief in Fire Hell verborgen liegt, in einer Art Festung des Grauens, oder besser gesagt unter dieser Festung. ...',
							'Ich besa� den Schl�ssel, von dem es hie�, er passe zu der einen T�r innerhalb dieser Festung, die zum roten Kristall f�hre. Wenn du meine Leiche irgendwo im Berg �ber uns finden solltest, k�nntest du vielleicht den Schl�ssel an dich nehmen und so zum roten Kristall gelangen. ...',
							'Sollte dir das gelingen, w�re ich dir zutiefst verbunden, wenn du zu mir kommen w�rdest, damit ich den roten Kristall der Liebe einmal mit eigenen Augen sehen kann, und seien es nur Geisteraugen.'},cid)
			setPlayerStorageValue(cid, theCrystalOfLove.mission1, 1)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "nein") or msgcontains(msg, "no") then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Aber wie solltest du sonst davon erfahren haben? ... Ich habe Dante geliebt, er war mein Ein und Alles, mein Grund zu leben. Aus diesem Grund wollte ich ihm auch den Kristall der Liebe schenken. Um ihm meine unsterbliche Liebe zu beweisen. ...',
							'Ich habe es jedoch nicht geschafft. Ich konnte die Pr�fungen von Aristeas, dem W�chter von Fire Hell, nicht bestehen. Und so stibitzte ich eine Seite eines Buches aus seiner Bibliothek und versuchte durch einen versteckten Riss im Boden hinter einem schweren Stein, den ich mit einer Spitzhacke zerschlug, einen anderen Weg nach Fire Hell zu finden. ...',
							'Doch wie es scheint, gibt es nur diesen einen durch die T�r in Aristeas Haus. Denn kaum hatte ich mich durch sie Spalte hindurchgezw�ngt, �berraschten mich mehrere Feuergestalten. Sie t�teten mich an Ort und Stelle, und mein Wunsch, Dante den Kristall zu �berbringen, wurde f�r immer vernichtet. ...',
							'Nun existiert nur noch mein Geist an diesem grauenvollen Ort und wird auf ewig Trauer und Schmerz empfinden. Die Legende besagt, dass der Kristall irgendwo tief in Fire Hell verborgen liegt, in einer Art Festung des Grauens, oder besser gesagt unter dieser Festung. ...',
							'Ich besa� den Schl�ssel, von dem es hie�, er passe zu der einen T�r innerhalb dieser Festung, die zum roten Kristall f�hre. Wenn du meine Leiche irgendwo im Berg �ber uns finden solltest, k�nntest du vielleicht den Schl�ssel an dich nehmen und so zum roten Kristall gelangen. ...',
							'Sollte dir das gelingen, w�re ich dir zutiefst verbunden, wenn du zu mir kommen w�rdest, damit ich den roten Kristall der Liebe einmal mit eigenen Augen sehen kann, und seien es nur Geisteraugen.'},cid)
			setPlayerStorageValue(cid, theCrystalOfLove.mission1, 1)
			talkState[talkUser] = 0
		end
	else
		npcHandler:say('Huuuh.',cid)
		talkState[talkUser] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

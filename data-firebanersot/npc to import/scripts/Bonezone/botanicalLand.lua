local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end
 
local function itemEntfernen(cid, item)
	return doPlayerRemoveItem(cid,item,getPlayerItemCount(cid, item))
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local player = Player(cid)
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Ach, wie wundersch�n, dass du mich danach fragst. Nun, zuerst kurz zu meiner Familie, auch wenn du das nicht gefragt hast, hehe. Mein Sohn ist der K�nig dieser Stadt, der m�chtige {Atlantos}. Gut, das klingt etwas �bertrieben. ...',
						'Und mein Mann Avion ist der Schneider dieser Stadt. Du kannst ihn ja mal besuchen, ebenso wie meinen Sohn. Und nun zu meiner Aufgabe: Die Flora und Fauna von Bonezone, genau hier in den Botanical Lands im Osten. ...',
						'Ab und zu brauche ich mal {Hilfe} beim versorgen der Pflanzen und Tiere, deswegen sei nicht scheu und frag einfach, wenn du Langeweile hast.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'atlantos') or msgcontains(msg, 'k�nig') then
		npcHandler:say('Ja, vor vielen Jahren sind wir hier hingezogen, zuvor lebten wir auf einem Bauernhof weit enfernt. Mein Sohn hat sich politisch sehr engagiert und ist zum K�nig ernannt worden. Darauf bin ich immernoch sehr stolz. Er kommt uns regelm��ig von Little Cotton aus besuchen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'avion') then
		npcHandler:say('Mein Mann Avion ist mein gr��ter Schatz. Ich glaube nicht, dass uns noch etwas trennen kann. Er arbeitet im Westen der Stadt in einem kleinen Laden, wo er mit Teppichen und anderen besonderen Textilien handelt. Er wird bestimmt auch Aufgaben f�r dich haben.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'sling herbs') or msgcontains(msg, 'gronta') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission2) == 5 then
			if getPlayerStorageValue(cid, theBotanicalHelp.mission3) == 7 then
				npcHandler:say('Eine Bestellung von 20 Pfund Sling Herbs an Gronta? Ja, stimmt, diese Kr�uter eignen sich gro�artig zum Brauen von Peremungaf Tr�nken. Ist kein Problem. Durch deine Hilfe habe ich jetzt so viel Zeit. Vielen Dank nochmal!',cid)
				setPlayerStorageValue(cid, examinationToFireHell.mission2, 6)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Was bitte? Gronta schickt dich. Er will 20 Pfund Sling Herbs sagst du? Es tut mir leid, aber ich habe im Moment einfach zu wenig Zeit, um auch noch Bestellungen aufzunehmen. Ich k�nnte echt {Hilfe} gebrauchen.', cid)
			end
		else
			npcHandler:say('Du fragst nach meinem seltsamen Freund Gronta? Wie interessant. Er bestellt �fters Pflanzen, Kr�uter und Fr�chte bei mir. Er ist ein m�chtiger Druide und lebt auf der Spitze des Big Mountains westw�rts von Pulgra. Geh ihn doch mal besuchen, auch wenn er nicht sehr gespr�chig ist.',cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'hilfe') or msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, theBotanicalHelp.mission1) == -1 then
			npcHandler:say('Das finde ich aber voll nett von dir. Also ich h�tte schon was zu tun, ist auch nicht so schwierig. Also, m�chtest du mir helfen?', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 1 then
			npcHandler:say('Bist du etwa schon mit dem Verscheuchen der M�wen aus den B�umen fertig? Ich denke eher nicht.', cid)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 2 then
			npcHandler:say('Vielen Dank f�r diesen Gefallen, den du mir da mit den B�umen gemacht hast. Das war wirklich sehr nett. Hier eine kleine Belohnung, hehe. M�chtest du direkt die n�chste Aufgabe bestreiten?', cid)
			doPlayerAddExp(cid,10000, false, true)
			doPlayerAddMoney(cid, 500)
			setPlayerStorageValue(cid, theBotanicalHelp.mission1, 3)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 3 and getPlayerStorageValue(cid, theBotanicalHelp.mission2) == -1 then
			npcHandler:say('Vielen Dank nochmal f�r die Sache mit den B�umen. Deine Belohnung hast du ja schon erhalten. M�chtest du jetzt den n�chsten Auftrag annehmen?', cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission2) == 4 then
			npcHandler:say('Welche der Fr�chte hast du mir denn mitgebracht? Die {Oranges}, die {Melons}, die {Corncobs} oder die {Blueberries}?', cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission2) == 5 and getPlayerStorageValue(cid, theBotanicalHelp.mission3) == -1 then
			npcHandler:say({'Bereit f�r den letzten Job? Alles klar! Zur Information: Ich habe alle deine Fr�chte, die du mir gebracht hast, nun angepflanzt und muss jetzt nat�rlich erstmal warten, bis diese gewachsen sind. ...',
							'Als sehr gutes D�nger hat sich bei mir immer das Knochenmehl erwiesen. Also ist deine n�chste Aufgabe mir genug normale Knochen zu bringen, damit all meine Felder versorgt sind. W�rdest du das tun?'},cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission3) == 6 then
			npcHandler:say('Ah, hast du Knochen dabei?', cid)
			talkState[talkUser] = 7
		end
	elseif talkState[talkUser] == 5 then
		local function obstPruefen(cid)
			if getPlayerStorageValue(cid, theBotanicalHelp.mission2Oranges) == 1 and getPlayerStorageValue(cid, theBotanicalHelp.mission2Melons) == 1 and getPlayerStorageValue(cid, theBotanicalHelp.mission2Corncobs) == 1 and getPlayerStorageValue(cid, theBotanicalHelp.mission2Blueberries) == 1 then
				setPlayerStorageValue(cid, theBotanicalHelp.mission2,5)
				doPlayerAddExp(cid,50000, false, true)
				doPlayerAddMoney(cid, 1000)
				return TRUE
			else
				return FALSE
			end
		end
		local fruechte = {
		{name = 'Oranges', id = 2675, amount = 30, storageValue = theBotanicalHelp.mission2Oranges, weight = '55 oz. '},
		{name = 'Melons', id = 2682, amount = 10, storageValue = theBotanicalHelp.mission2Melons, weight = '95 oz. '},
		{name = 'Corncobs', id = 2686, amount = 20, storageValue = theBotanicalHelp.mission2Corncobs, weight = '70 oz. '},
		{name = 'Blueberries', id = 2677, amount = 100, storageValue = theBotanicalHelp.mission2Blueberries, weight = '20 oz. '}
		}
		for k = 1, #fruechte do
			if msgcontains(msg, fruechte[k].name) then
				if getPlayerStorageValue(cid, fruechte[k].storageValue) == -1 then 
					if getPlayerItemCount(cid, fruechte[k].id) == 0 then
						npcHandler:say('Du hast ja gar keine ' .. fruechte[k].name .. ' dabei. Komm wieder, wenn du welche hast!', cid)
						talkState[talkUser] = 0
					elseif getPlayerItemCount(cid, fruechte[k].id) < fruechte[k].amount then
						npcHandler:say('Das sind aber nicht genug! Und ich hab kein Bock nachher selber alles zusammenzurechnen, wenn du mir das in so Porti�nchen bringst. Ich seh es als Geschenk, aber bitte bringe mir einfach die ' .. fruechte[k].weight .. fruechte[k].name .. '!', cid)
						itemEntfernen(cid, fruechte[k].id)
						talkState[talkUser] = 0
					elseif getPlayerItemCount(cid, fruechte[k].id) == fruechte[k].amount then
						itemEntfernen(cid, fruechte[k].id)
						setPlayerStorageValue(cid, fruechte[k].storageValue, 1)
						if obstPruefen(cid) == TRUE then
							npcHandler:say('Perfekt! Damit hast du mir alle Fr�chte gebracht und der Job ist erledigt. Ich danke dir! Eine kleine Belohnung f�r dich, hehe.', cid)
							talkState[talkUser] = 0
						else
							npcHandler:say('Super! Damit h�tten wir die ' .. fruechte[k].name .. ' schonmal erledigt. Hast du sonst noch was dabei?', cid)
						end
					elseif getPlayerItemCount(cid, fruechte[k].id) > fruechte[k].amount then
						itemEntfernen(cid, fruechte[k].id)
						setPlayerStorageValue(cid, fruechte[k].storageValue, 1)
						if obstPruefen(cid) == TRUE then
							npcHandler:say('Perfekt! Mehr als erwartet und du hast damit alle Fr�chte zu mir gebracht. Ich danke dir! Eine kleine Belohnung f�r dich, hehe.', cid)
							talkState[talkUser] = 0
						else
							npcHandler:say('Sogar mehr ' .. fruechte[k].name .. ' als erwartet. Nicht schlecht! Hast du sonst noch was dabei?', cid)
						end
					end
				else
					if getPlayerItemCount(cid, fruechte[k].id) == 0 then
						npcHandler:say('Du hast ja gar keine dabei, aber ' .. fruechte[k].name .. ' hast du ja eh schon erledigt. Hast du sonst noch was dabei?', cid)
					else
						npcHandler:say('Noch mehr ' .. fruechte[k].name .. '! Naja, kann ja nie schaden, hehe. Hast du sonst noch was dabei?', cid)
						itemEntfernen(cid, fruechte[k].id)
					end
				end
				return TRUE
			else
				npcHandler:say('Das kenn ich leider nicht. Ich dachte, du bist wegen deiner Mission hier.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Sehr sch�n, dann pass gut auf. Siehst du den Baum da hinten? Ja, genau der! Der, welcher so komisch leuchtet. Das ist ein magischer Baum, er verf�gt �ber besondere F�higkeiten. Es gibt davon hier ein paar. Sie sind jedoch auch �beraus empfindlich. ...',
							'Die M�wen lieben sie, da sie im Stamm ein besonderes Harz enthalten, welches die Fruchbarkeit und das Lustgef�hl der M�wen steigert. Allerdings ist das Luxus und die M�wen sind darauf nicht angewiesen, deswegen muss ich sie regelm��ig aus den B�umen verscheuchen. ...',
							'Wenn du das dieses Mal f�r mich erledigen k�nntest, w�re das hervorragend. Dieser hier direkt zwischen meinen Farmen ist nat�rlich nicht von M�wen befallen, darum k�mmere ich mich selbst. W�rdest du denn aber die M�wen aus den restlichen magischen B�umen verscheuchen?'},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Das ist wirklich gro�artig! Es gibt von den B�umen genau f�nf hier unter Bonezone auf den Lively Grounds. Das Suchen sollte nicht allzu schwierig sein. Wenn du sie gefunden hast reicht einmal kr�ftig am Stamm r�tteln. Das verscheucht die M�wen. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission1, 1)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Sehr gut! Wie w�rs, wenn du mir nun mal ein paar Sachen bringst? Ich brauche noch 55 oz. {Oranges}, 95 oz. {Melons}, 70 oz. {Corncobs} und 20 oz. {Blueberries}. W�rdest du mir diese Mengen bringen?', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Super! Na dann, auf eine frohe Ernte, hehe.', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission2, 4)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Perfekt! Ich sage dir Bescheid, sobald du mir genug Knochen gebracht hast, sodass all meine Felder mit D�nger versorgt sind. Viel Gl�ck!', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission3, 6)
			setPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount, 0)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 7 then
			if getPlayerItemCount(cid, 2230) == 0 then
				npcHandler:say('Warum behauptest du, du h�ttest welche dabei, wenn dem nicht so ist? Versteh ich nicht.', cid)
			else
				setPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount, getPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount) + getPlayerItemCount(cid, 2230))
				itemEntfernen(cid, 2230)
				if getPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount) >= 27 then
					setPlayerStorageValue(cid, theBotanicalHelp.mission3, 7)
					-- setPlayerStorageValue(cid, 5220, 1)
					npcHandler:say('Ausgezeichnet! Damit haben wir jetzt auch genug Knochen f�r alle Felder zusammen. Die Pflanzen werden sich freuen; und du auch, denn es ist wieder eine Belohnung f�r dich drin. Vielen Dank nochmal f�r all deine Hilfe. Lebe Wohl!', cid)
					doPlayerAddExp(cid,30000, false, true)
					doPlayerAddMoney(cid, 1000)
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('Danke daf�r! Jedoch musst du mir noch ein paar mehr bringen, es reicht noch nicht f�r alle Felder.', cid)
					talkState[talkUser] = 0
				end
			end
		end	
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('H�, aber das meintest du doch gerade.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann hab ich ja alles umsonst erkl�rt. Manno!', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Dann lass dir noch etwas Zeit damit.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Also so schwierig sind die Sachen jetzt auch nicht zu besorgen.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Pl�tzlich nicht mehr?', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 7 then
			npcHandler:say('Es tut mir leid, aber warum bist du dann hier?', cid)
			npcHandler:releaseFocus(cid)
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

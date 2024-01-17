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
		npcHandler:say({'Ach, wie wunderschön, dass du mich danach fragst. Nun, zuerst kurz zu meiner Familie, auch wenn du das nicht gefragt hast, hehe. Mein Sohn ist der König dieser Stadt, der mächtige {Atlantos}. Gut, das klingt etwas übertrieben. ...',
						'Und mein Mann Avion ist der Schneider dieser Stadt. Du kannst ihn ja mal besuchen, ebenso wie meinen Sohn. Und nun zu meiner Aufgabe: Die Flora und Fauna von Bonezone, genau hier in den Botanical Lands im Osten. ...',
						'Ab und zu brauche ich mal {Hilfe} beim versorgen der Pflanzen und Tiere, deswegen sei nicht scheu und frag einfach, wenn du Langeweile hast.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'atlantos') or msgcontains(msg, 'könig') then
		npcHandler:say('Ja, vor vielen Jahren sind wir hier hingezogen, zuvor lebten wir auf einem Bauernhof weit enfernt. Mein Sohn hat sich politisch sehr engagiert und ist zum König ernannt worden. Darauf bin ich immernoch sehr stolz. Er kommt uns regelmäßig von Little Cotton aus besuchen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'avion') then
		npcHandler:say('Mein Mann Avion ist mein größter Schatz. Ich glaube nicht, dass uns noch etwas trennen kann. Er arbeitet im Westen der Stadt in einem kleinen Laden, wo er mit Teppichen und anderen besonderen Textilien handelt. Er wird bestimmt auch Aufgaben für dich haben.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'sling herbs') or msgcontains(msg, 'gronta') then
		if getPlayerStorageValue(cid, examinationToFireHell.mission2) == 5 then
			if getPlayerStorageValue(cid, theBotanicalHelp.mission3) == 7 then
				npcHandler:say('Eine Bestellung von 20 Pfund Sling Herbs an Gronta? Ja, stimmt, diese Kräuter eignen sich großartig zum Brauen von Peremungaf Tränken. Ist kein Problem. Durch deine Hilfe habe ich jetzt so viel Zeit. Vielen Dank nochmal!',cid)
				setPlayerStorageValue(cid, examinationToFireHell.mission2, 6)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Was bitte? Gronta schickt dich. Er will 20 Pfund Sling Herbs sagst du? Es tut mir leid, aber ich habe im Moment einfach zu wenig Zeit, um auch noch Bestellungen aufzunehmen. Ich könnte echt {Hilfe} gebrauchen.', cid)
			end
		else
			npcHandler:say('Du fragst nach meinem seltsamen Freund Gronta? Wie interessant. Er bestellt öfters Pflanzen, Kräuter und Früchte bei mir. Er ist ein mächtiger Druide und lebt auf der Spitze des Big Mountains westwärts von Pulgra. Geh ihn doch mal besuchen, auch wenn er nicht sehr gesprächig ist.',cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'hilfe') or msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, theBotanicalHelp.mission1) == -1 then
			npcHandler:say('Das finde ich aber voll nett von dir. Also ich hätte schon was zu tun, ist auch nicht so schwierig. Also, möchtest du mir helfen?', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 1 then
			npcHandler:say('Bist du etwa schon mit dem Verscheuchen der Möwen aus den Bäumen fertig? Ich denke eher nicht.', cid)
			npcHandler:releaseFocus(cid)
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 2 then
			npcHandler:say('Vielen Dank für diesen Gefallen, den du mir da mit den Bäumen gemacht hast. Das war wirklich sehr nett. Hier eine kleine Belohnung, hehe. Möchtest du direkt die nächste Aufgabe bestreiten?', cid)
			doPlayerAddExp(cid,10000, false, true)
			doPlayerAddMoney(cid, 500)
			setPlayerStorageValue(cid, theBotanicalHelp.mission1, 3)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission1) == 3 and getPlayerStorageValue(cid, theBotanicalHelp.mission2) == -1 then
			npcHandler:say('Vielen Dank nochmal für die Sache mit den Bäumen. Deine Belohnung hast du ja schon erhalten. Möchtest du jetzt den nächsten Auftrag annehmen?', cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission2) == 4 then
			npcHandler:say('Welche der Früchte hast du mir denn mitgebracht? Die {Oranges}, die {Melons}, die {Corncobs} oder die {Blueberries}?', cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, theBotanicalHelp.mission2) == 5 and getPlayerStorageValue(cid, theBotanicalHelp.mission3) == -1 then
			npcHandler:say({'Bereit für den letzten Job? Alles klar! Zur Information: Ich habe alle deine Früchte, die du mir gebracht hast, nun angepflanzt und muss jetzt natürlich erstmal warten, bis diese gewachsen sind. ...',
							'Als sehr gutes Dünger hat sich bei mir immer das Knochenmehl erwiesen. Also ist deine nächste Aufgabe mir genug normale Knochen zu bringen, damit all meine Felder versorgt sind. Würdest du das tun?'},cid)
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
						npcHandler:say('Das sind aber nicht genug! Und ich hab kein Bock nachher selber alles zusammenzurechnen, wenn du mir das in so Portiönchen bringst. Ich seh es als Geschenk, aber bitte bringe mir einfach die ' .. fruechte[k].weight .. fruechte[k].name .. '!', cid)
						itemEntfernen(cid, fruechte[k].id)
						talkState[talkUser] = 0
					elseif getPlayerItemCount(cid, fruechte[k].id) == fruechte[k].amount then
						itemEntfernen(cid, fruechte[k].id)
						setPlayerStorageValue(cid, fruechte[k].storageValue, 1)
						if obstPruefen(cid) == TRUE then
							npcHandler:say('Perfekt! Damit hast du mir alle Früchte gebracht und der Job ist erledigt. Ich danke dir! Eine kleine Belohnung für dich, hehe.', cid)
							talkState[talkUser] = 0
						else
							npcHandler:say('Super! Damit hätten wir die ' .. fruechte[k].name .. ' schonmal erledigt. Hast du sonst noch was dabei?', cid)
						end
					elseif getPlayerItemCount(cid, fruechte[k].id) > fruechte[k].amount then
						itemEntfernen(cid, fruechte[k].id)
						setPlayerStorageValue(cid, fruechte[k].storageValue, 1)
						if obstPruefen(cid) == TRUE then
							npcHandler:say('Perfekt! Mehr als erwartet und du hast damit alle Früchte zu mir gebracht. Ich danke dir! Eine kleine Belohnung für dich, hehe.', cid)
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
			npcHandler:say({'Sehr schön, dann pass gut auf. Siehst du den Baum da hinten? Ja, genau der! Der, welcher so komisch leuchtet. Das ist ein magischer Baum, er verfügt über besondere Fähigkeiten. Es gibt davon hier ein paar. Sie sind jedoch auch überaus empfindlich. ...',
							'Die Möwen lieben sie, da sie im Stamm ein besonderes Harz enthalten, welches die Fruchbarkeit und das Lustgefühl der Möwen steigert. Allerdings ist das Luxus und die Möwen sind darauf nicht angewiesen, deswegen muss ich sie regelmäßig aus den Bäumen verscheuchen. ...',
							'Wenn du das dieses Mal für mich erledigen könntest, wäre das hervorragend. Dieser hier direkt zwischen meinen Farmen ist natürlich nicht von Möwen befallen, darum kümmere ich mich selbst. Würdest du denn aber die Möwen aus den restlichen magischen Bäumen verscheuchen?'},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Das ist wirklich großartig! Es gibt von den Bäumen genau fünf hier unter Bonezone auf den Lively Grounds. Das Suchen sollte nicht allzu schwierig sein. Wenn du sie gefunden hast reicht einmal kräftig am Stamm rütteln. Das verscheucht die Möwen. Viel Glück!', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission1, 1)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Sehr gut! Wie wärs, wenn du mir nun mal ein paar Sachen bringst? Ich brauche noch 55 oz. {Oranges}, 95 oz. {Melons}, 70 oz. {Corncobs} und 20 oz. {Blueberries}. Würdest du mir diese Mengen bringen?', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Super! Na dann, auf eine frohe Ernte, hehe.', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission2, 4)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Perfekt! Ich sage dir Bescheid, sobald du mir genug Knochen gebracht hast, sodass all meine Felder mit Dünger versorgt sind. Viel Glück!', cid)
			setPlayerStorageValue(cid, theBotanicalHelp.mission3, 6)
			setPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount, 0)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 7 then
			if getPlayerItemCount(cid, 2230) == 0 then
				npcHandler:say('Warum behauptest du, du hättest welche dabei, wenn dem nicht so ist? Versteh ich nicht.', cid)
			else
				setPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount, getPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount) + getPlayerItemCount(cid, 2230))
				itemEntfernen(cid, 2230)
				if getPlayerStorageValue(cid, theBotanicalHelp.mission3BoneCount) >= 27 then
					setPlayerStorageValue(cid, theBotanicalHelp.mission3, 7)
					-- setPlayerStorageValue(cid, 5220, 1)
					npcHandler:say('Ausgezeichnet! Damit haben wir jetzt auch genug Knochen für alle Felder zusammen. Die Pflanzen werden sich freuen; und du auch, denn es ist wieder eine Belohnung für dich drin. Vielen Dank nochmal für all deine Hilfe. Lebe Wohl!', cid)
					doPlayerAddExp(cid,30000, false, true)
					doPlayerAddMoney(cid, 1000)
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('Danke dafür! Jedoch musst du mir noch ein paar mehr bringen, es reicht noch nicht für alle Felder.', cid)
					talkState[talkUser] = 0
				end
			end
		end	
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Hä, aber das meintest du doch gerade.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Dann hab ich ja alles umsonst erklärt. Manno!', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Dann lass dir noch etwas Zeit damit.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Also so schwierig sind die Sachen jetzt auch nicht zu besorgen.', cid)
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Plötzlich nicht mehr?', cid)
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

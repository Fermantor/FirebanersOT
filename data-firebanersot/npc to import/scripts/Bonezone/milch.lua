local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end
 


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Sch�n, dass du fragst. Ich habe jetzt nicht die riesen Aufgabe, aber trotzdem bin ich nicht unwichtig. Ich bin der jenige, der sich darum k�mmert, dass das Essen von der Hauptstadt Bonezone auch hier runter zu den Leuten nach Little Cotton kommt. ...',
						'Dies ist eine sehr wichtige Aufgabe und darf nicht untersch�tzt werden. Au�erdem stelle ich meine eigene {Milch} her, worauf ich auch sehr stolz bin.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'milch') or msgcontains(msg, 'milk') then
		npcHandler:say('Ahh, willst du etwas von meiner selbstgemachten Milch kaufen? 100 Gold pro {Vial}.', cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Achso. Naja, nat�rlich kannst du auch eine {Vial} ohne Inhalt kaufen, wobei meine Milch sehr lecker ist. Das w�rde dann 20 Gold pro Vial kosten. Einverstanden?', cid)
		talkState[talkUser] = 3
	elseif msgcontains(msg, 'quelle') then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) == 13 then
			npcHandler:say({'Meine Quelle...? Also... Ich wei� nicht. Warum willst du das wissen? ... Was sagst du? Trevor hat dich geschickt? Was soll das hei�en, meine Milch ist verdorben? Mit meiner Milch ist alles ok! ...',
							'Ich erz�hl doch nicht allen das Geheimnis, wie ich an meine kostbare Milch komme. Ich sage dir: Mit meiner Milch ist alles OK!'},cid)
			talkState[talkUser] = 2
		elseif getPlayerStorageValue(cid, theDeliciousHelperQuest.mission3) > 13 then
			npcHandler:say('H�rzu, ich habe dir meine Quelle bereits verraten. Werde bitte nicht aufdringlich.', cid)
		else
			npcHandler:say('Als ob ich einem Wildfremden einfach die Quelle meiner kostbaren Milch anvertraue. Also wirklich!', cid)
		end
	elseif msgcontains(msg, 'mouldy cheese') then
		if talkState[talkUser] == 2 then
			if doPlayerRemoveItem(cid, 2235, 1) == TRUE then
				npcHandler:say({'Hmm, mit dem K�se scheint ja wirklich etwas nicht zu stimmen... Und du bist sicher, dass er mit meiner Milch hergestellt wurde? Tja, nun denn! ...',
								'Ich habe wohl keine andere Wahl, nicht wahr? Also ich hohle mir die Milch eigentlich immer... also naja... aus Trevors Farm. DAS IST KEIN DIEBSTAHL! Irgendwie. Oder? ...',
								'Wo er mir doch den Zugang zu seiner Farm gew�hrt hat, da hat es sich eben angeboten. Nun ja, es w�re eben eine Verschwendung der ganzen Milch halber. Verstehst du? ...',
								'Wie auch immer, ist ja auch egal, zumindest ist es nicht meine Schuld, dass der K�se verschimmelt ist. Die Tiere geh�ren ja schlie�lich nicht mir. Da musst du ihn fragen, was er mit seinen Tieren anstellt.'},cid)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission3, 14)
			else
				npcHandler:say('Ich kann dir auch einfach W�rter an den Kopf werfen, wenn du das lustig findest.', cid)
			end
		else
			npcHandler:say('Wie bitte? Werd bitte ein bisschen konkreter!', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			if getPlayerMoney(cid) >= 100 then
				if getPlayerFreeCap(cid) >= 1.80 then
					npcHandler:say('Na dann, hier hast du eine Vial gef�llt mit Milch f�r 100 Gold. Danke Sch�n!', cid)
					doPlayerRemoveMoney(cid, 100)
					doPlayerAddItem(cid, 2006,6)
					talkState[talkUser] = 0
				else
					npcHandler:say('Es tut mir leid, aber du scheinst nicht mehr genug tragen zu k�nnen. Lege erstmal etwas ab!', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('100 Gold, sagte ich. Nicht umsonst!', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 3 then
			if getPlayerMoney(cid) >= 20 then
				if getPlayerFreeCap(cid) >= 1.80 then
					npcHandler:say('Also gut, hier hast du eine leere Vial. Bitte sch�n!', cid)
					doPlayerRemoveMoney(cid, 20)
					doPlayerAddItem(cid, 2006, 0)
					talkState[talkUser] = 0
				else
					npcHandler:say('Es tut mir leid, aber du scheinst nicht mehr genug tragen zu k�nnen. Lege erstmal etwas ab!', cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('Als ob du keine 20 Gold mehr h�ttest.', cid)
				talkState[talkUser] = 0
			end
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

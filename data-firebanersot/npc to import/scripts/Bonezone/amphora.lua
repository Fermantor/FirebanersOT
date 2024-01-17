local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end
 
npcHandler:setMessage(MESSAGE_GREET, '|PLAYERNAME|, aus welchem Grund bist du hier?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'So wirst du meine Grabkammer niemals verlassen können.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Du wirst ohne mich keinen Weg hier raus finden.')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local playerCap = getPlayerFreeCap(cid)

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Ich habe meine Berufung verloren, als ich mein Leben verloren habe. Doch früher einmal, als das Leben noch so in mir strotze, da ward ich glücklich als Magd. Das hat sich inzwischen geändert.',cid)
	elseif msgcontains(msg, 'belohnung') or msgcontains(msg, 'reward') then
		if getPlayerStorageValue(cid, 5225) == 1 then
			npcHandler:say('Als Dankeschön für deinen Gefallen, darfst du dir eines der Objekte aus meiner Schatzkammer aussuchen. Möchtest du eine {Noble Axe}, ein {Spellbook of Warding} oder eine {Modified Crossbow}?',cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, 5225) == 2 then
			npcHandler:say('Du hast schon eine Belohung von mir erhalten. Werd nicht undankbar, denn ich bin dir sehr dankbar.',cid)
		else
			npcHandler:say('Eine Belohnung für was? Ich vergebe keinen fremden Menschen Dinge aus meiner Schatzkammer, ohne dass diese vorher etwas für mich getan haben. Warum bist du wirklich hier?',cid)
		end
	elseif msgcontains(msg, 'gefallen') or msgcontains(msg, 'favor') or msgcontains(msg, 'favour') then
		if getPlayerStorageValue(cid, 5225) == 1 then	
			npcHandler:say('Und für deisen Gefallen danke ich dir immer noch sehr!',cid)
		else
			npcHandler:say('Das werde ich dir nicht verraten. Du musst mein Rätsel selber lösen, damit du eine Belohnung erhälst.',cid)
		end
	elseif msgcontains(msg, 'tom korux') then
		if getPlayerStorageValue(cid, 5225) == 1 then
			npcHandler:say({'Ja, mein Geliebter Tom Korux. Es war mir schon damals klar, dass unsere Beziehung nicht geheim bleiben konnte. Doch ich hätte nicht gedacht, dass mein Vater, mein eigener Vater, mich vor den Augen aller anderen Leute enthaupten würde. ...',
							'Als er herausfand, dass ich und Tom Korux in Kontakt miteinander standen - dies war natürlich nachdem er in den schwarzen Tümpel geworfen wurde und sich in ein Monster verwandelt hatte - ist er ausgerastet. So etwas, habe ich noch nie gesehen. ...',
							'Er hat mich angebrüllt und auf mich eingeschlagen, schließlich war er der Anführer der damaligen Hexenverfolgung. Seine eigene Tochter, verliebt in eine dunkle Kreatur. Ich glaube, es war für ihn so schrecklich wie für mich. ...',
							'Seitdem er mich auf dem Marktplatz geköpft hat und ich hier nun in dieser Grabkammer lebe, wartete ich auf den Retter, der mich befreien wird. Und das hast du nun getan. Ich danke dir!'},cid)
		else
			npcHandler:say({'Ja, mein Geliebter Tom Korux. Es war mir schon damals klar, dass unsere Beziehung nicht geheim bleiben konnte. Doch ich hätte nicht gedacht, dass mein Vater, mein eigener Vater, mich vor den Augen aller anderen Leute enthaupten würde. ...',
							'Als er herausfand, dass ich und Tom Korux in Kontakt miteinander standen - dies war natürlich nachdem er in den schwarzen Tümpel geworfen wurde und sich in ein Monster verwandelt hatte - ist er ausgerastet. So etwas, habe ich noch nie gesehen. ...',
							'Er hat mich angebrüllt und auf mich eingeschlagen, schließlich war er der Anführer der damaligen Hexenverfolgung. Seine eigene Tochter, verliebt in eine dunkle Kreatur. Ich glaube, es war für ihn so schrecklich wie für mich. ...',
							'Seitdem er mich auf dem Marktplatz geköpft hat und ich hier nun in dieser Grabkammer lebe, warte ich auf den Retter, der mich {befreien} wird, damit ich endlich von den Qualen loskomme und in Frieden ruhen kann.'},cid)
		end
	elseif msgcontains(msg, 'befreien') or msgcontains(msg, 'befreiung') then
		if getPlayerStorageValue(cid, 5225) == 1 then
			npcHandler:say('Entschuldige bitte, aber ich verstehe dich nicht. Du hast meine Seele doch schon befreit.', cid)
		else
			npcHandler:say('Verstehe ich dich richtig? Du willst meine Seele von all den Qualen und Schmerzen, die sie nun schon seit geraumer Zeit plagen, befreien. Du willst mir helfen glücklich und in Frieden Ruhen zu können?', cid)
			talkState[talkUser] = 2
		end
	elseif msgcontains(msg, 'back') or msgcontains(msg, 'raus') or msgcontains(msg, 'zurück') or msgcontains(msg, 'verlassen') or msgcontains(msg, 'teleport') then
		if getPlayerStorageValue(cid, 5225) == 2 then
			npcHandler:say('Mit dem größten Vergnügen erfülle ich dir diesen Wunsch! Möchtest du meine Schatzkammer verlassen?',cid)
		else
			npcHandler:say('Also bist du nur deswegen hier? Schade, ich dachte vielleicht... ach, nicht so wichtig. Möchtest du meine Grabkammer wirklich ohne einen kleinen Gefallen verlassen?',cid)
		end
		talkState[talkUser] = 1
	elseif talkState[talkUser] == 3 then
		if msgcontains(msg, 'noble axe') then
			if playerCap >= getItemWeight(7456, 1, FALSE) then
				npcHandler:say('Aber Natürlich! Hiermit überreiche ich dir eine Noble Axe. Viel Erfolg damit!',cid)
				doPlayerAddItem(cid, 7456, 1)
				setPlayerStorageValue(cid, 5225, 2)
			else
				npcHandler:say('Du scheinst keine Tragekapazität zu besitzen, um die Noble Axe aufzunehmen.',cid)
			end
			talkState[talkUser] = 0
		elseif msgcontains(msg, 'spellbook of warding') then
			if playerCap >= getItemWeight(8901, 1, FALSE) then
				npcHandler:say('Aber Natürlich! Hiermit überreiche ich dir ein Spellbook of Warding. Viel Erfolg damit!',cid)
				doPlayerAddItem(cid, 8901, 1)
				setPlayerStorageValue(cid, 5225, 2)
			else
				npcHandler:say('Du scheinst keine Tragekapazität zu besitzen, um die Spellbook of Warding aufzunehmen.',cid)
			end
			talkState[talkUser] = 0
		elseif msgcontains(msg, 'modified crossbow') then
			if playerCap >= getItemWeight(8849, 1, FALSE) then
				npcHandler:say('Aber Natürlich! Hiermit überreiche ich dir eine Modified Crossbow. Viel Erfolg damit!',cid)
				doPlayerAddItem(cid, 8849, 1)
				setPlayerStorageValue(cid, 5225, 2)
			else
				npcHandler:say('Du scheinst keine Tragekapazität zu besitzen, um die Modified Crossbow aufzunehmen.',cid)
			end
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Viel Glück auf deiner Reise!',cid)
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
			doTeleportThing(cid, {x=2848,y=1667,z=12}, TRUE)
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
			npcHandler:releaseFocus(cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('ICH DANKE DIR VON TIEFSTEM HERZEN! Ich stehe in deiner Schuld. Nun werde ich meinen Geliebten Tom Korux wiedersehen. Damit hast du dir eine {Belohnung} verdient. Sage mir Bescheid, wenn du meine Schatzkammer {verlassen} möchtest.',cid)
			setPlayerStorageValue(cid, 5225, 1)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Nicht? Was möchtest du dann? Hast du dir vielleicht doch einen Gefallen überlegt, den du für mich tun könntest?',cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			npcHandler:say('ABER WARUM DENN NICHT? DU BIST MEINE EINZIGE CHANCE!',cid)
			talkState[talkUser] = 0
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

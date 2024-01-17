local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_GREET, 'Lust auf eine Trophäe, oder lieber eine verkaufen, |PLAYERNAME|?')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Trophäen sind mein Spezialgebiet.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Dann kriegste eben keine.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Komm wieder, |PLAYERNAME|.')

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'behemoth trophy'}, 7396, 20000,'behemoth trophy')
shopModule:addSellableItem({'bonebeast trophy'}, 11161, 6000,'bonebeast trophy')
shopModule:addSellableItem({'cyclops trophy'}, 7398, 500,'cyclops trophy')
shopModule:addSellableItem({'deer trophy'}, 7397, 3000,'deer trophy')
shopModule:addSellableItem({'demon trophy'}, 7393, 40000,'demon trophy')
shopModule:addSellableItem({'disgusting trophy'}, 11338, 3000,'disgusting trophy')
shopModule:addSellableItem({'dragon lord trophy'}, 7399, 10000,'dragon lord trophy')
shopModule:addSellableItem({'lion trophy'}, 7400, 3000,'lion trophy')
shopModule:addSellableItem({'lizard trophy'}, 11336, 8000,'lizard trophy')
shopModule:addSellableItem({'minotaur trophy'}, 7401, 500,'minotaur trophy')
shopModule:addSellableItem({'wolf trophy'}, 7394, 3000,'wolf trophy')
shopModule:addSellableItem({'orc trophy'}, 7395, 1000,'orc trophy')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local player = Player(cid)
	
	local ranks =
	{
	{points = 10, rankName = 'Hood'},
	{points = 20, rankName = 'Tell'},
	{points = 40, rankName = 'Hawkeye'},
	{points = 70, rankName = 'Legolas'},
	{points = 100, rankName = 'Ares'}
	}
	local promotionAvailable = false
	if player:getStorageValue(trophyHuntingGuild.pointCounter) == 5 then
		promotionAvailable = true
	else
		if player:getStorageValue(trophyHuntingGuild.pointCounter) >= ranks[player:getStorageValue(trophyHuntingGuild.rankStorage)+1].points then
			promotionAvailable = ranks[player:getStorageValue(trophyHuntingGuild.rankStorage)+1].rankName
		end
	end
	
	local levelRanges = {6,50,80,130}
	local playerLevelRange = 400
	local taskArray = {}
	local runningTaskArray = {}
	local counter = 1
	for i = 1,#levelRanges do
		if player:getLevel() >= levelRanges[i] == false then
			playerLevelRange = (i-1)*100
			break
		end
	end
	if playerLevelRange > 0 then
		for id, task in pairs(killingInTheNameOfTasks) do
			if id >= playerLevelRange and id < playerLevelRange+100 then
				taskArray[counter] = task
				counter = counter+1
			end
		end
	end
	
	local acceptTaskText =
	{
	'Super! Viel Erfolg bei der Jagd. Kehre zu mir zurück, wenn du genug getötet hast.',
	'Fantastisch! Ich erwarte deine Berichte, sobald du die Task erledigt hast.',
	'Hervorragend! Ich erwarte deine Berichte, sobald du die Task erledigt hast.',
	'Gute Jagd, alter Freund! Kehre zu mir zurück, wenn du genug getötet hast.'
	}
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Trophäen! TROPHÄEN! Das ist mein Beruf! Ich kaufe aber nur welche. Sie sind mir viel zu wertvoll, als das ich sie wieder weggeben möchte, meine kleinen Babys. ...',
						'Außerdem bin ich Gründer der {Trophy Hunting Guild}. Wir jagen Monster zu friedlichen Zwecken, um Überpopulation zu verhindern. Sag mir bescheid, falls du {beitreten} möchtest?'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'test') then
		-- print(taskArray[1].name)
		-- print(taskArray[2].name)
		-- print(taskArray[3].name)
		-- print(taskArray[4].name)
		if isInArray(taskArray[4], 'carniphila') then
			print('true')
		end
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Direkt nebenan in dem hohen Haus lebt Xantharus. Er verkauft schon sein Leben lang Vials.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'join') or msgcontains(msg, 'beitreten') then
		if player:getStorageValue(trophyHuntingGuild.baseStorage) == -1 then
			npcHandler:say('So, du willst also unserer Gilde beitreten und im Auftrag für uns Monster töten?', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du bist bereits Mitglied der Gilde, ' .. getPlayerName(cid) .. ', oder hast du das etwa vergessen?', cid)
		end
	elseif msgcontains(msg, 'task') then
		if player:getStorageValue(trophyHuntingGuild.rankStorage) == -1 then
			npcHandler:say('Bevor du nicht Mitglied unserer Gilde bist, kannst du leider auch keine Tasks bei mir annehmen. Du könntest ja erstmal {beitreten}.', cid)
			talkState[talkUser] = 0
		else
			if promotionAvailable ~= false and promotionAvailable ~= true then
				npcHandler:say('Ich bewundere dein Tatendrang, Champ, aber du bist erstmal bereit für eine {Beförderung}, bevor du weitere Tasks erledigen kannst.', cid)
				talkState[talkUser] = 0
				return true
			end
			local currentTask = 0
			while currentTask < player:getStorageValue(trophyHuntingGuild.taskCounter) do
				local taskID = player:getStorageValue(trophyHuntingGuild.task1 + currentTask)
				local task = killingInTheNameOfTasks[taskID]
				if player:getStorageValue(task.counterStorage) >= task.amountToKill then
					finishKillingInTheNameOfTask(player, taskID, currentTask)
					if task.bossName == nil then
						npcHandler:say('Gute Arbeit, alter Freund. Du hast erfolgreich ' .. task.amountToKill .. ' ' .. task.name .. ' getötet. Dafür erhälst du ' .. task.rewardXP .. ' XP und ' .. task.rewardPoints .. ' Punkte in unserer Gilde.', cid)
					else
						npcHandler:say(killingInTheNameOfText[taskID].bossText, cid)
					end
					talkState[talkUser] = 0
					return true
				end
				currentTask = currentTask + 1
			end
			if playerLevelRange == 0 then
				npcHandler:say('Tut mir leid, aber dein Level ist leider zu niedrig, um bei uns Tasks zu erfüllen. Du könntest dich ernsthaft verletzen. Werde erst einmal stärker.', cid)
			else
				local text = 'Alles klar, wähle aus folgenden Kreaturen: '
				for i = 1,#taskArray-1 do
					text = text .. '{' .. taskArray[i].name .. '}, '
				end
				text = text .. '{' .. taskArray[#taskArray].name .. '}. Also, welches möchtest du?'
				npcHandler:say(text, cid)
				talkState[talkUser] = 2
			end
		end
	elseif msgcontains(msg, 'beförderung') or msgcontains(msg, 'promotion') then
		if player:getStorageValue(trophyHuntingGuild.rankStorage) == -1 then
			npcHandler:say('Als Fremder unserer Gilde werde ich dir sicherlich keine Beförderung geben. Du könntest ja erstmal {beitreten}.', cid)
		else
			if promotionAvailable == false then
				npcHandler:say('Du besitzt momentan noch nicht genügend Punkte in unserer Gilde, um im Rang aufzusteigen. Absolviere mehr Tasks! Wenn du keine Tasks mehr machen kannst, empfehle ich dir im Level aufzusteigen. Auf höheren Leveln erwarten dich weitere Tasks.', cid)
				player:setStorageValueUp(trophyHuntingGuild.rankStorage, 1, 5)
			elseif promotionAvailable == true then
				npcHandler:say('Du hast schon den höhsten Rang in unserer Gilde. Ich kann dir leider keine weitere Beförderung anbieten. Ich wäre dir trotzdem dankbar, wenn du weitere Tasks für uns erledigen kannst.', cid)
			else
				npcHandler:say('Glückwunsch, ' .. player:getName() .. '! Hiermit befördere ich dich zum Rang \'' .. promotionAvailable .. '\'! Du kannst jetzt weitere Tasks annehmen.', cid)
			end
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'abbrechen') or msgcontains(msg, 'cancel') then
		if player:getStorageValue(trophyHuntingGuild.taskCounter) == 3 then
			npcHandler:say('Möchtest du eine laufende Task abbrechen?', cid)
			talkState[talkUser] = 3
		else
			npcHandler:say('Du hast doch keine drei laufenden Tasks. Warum solltest du dann eine abbrechen wollen? Nutze zunächst deinen freien Taskplatz.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Alles klar. Du bist nun Auszubildender der Gilde und kannst jederzeit bis zu drei {Tasks} annehmen. Komm zu mir und gib mir Bescheid, solltest du eine Task erfüllt haben. ...',
							'Das Abschließen einer Task bringt dir Punkte, mit denen du im Rang aufsteigst. Den ersten Rang erhälst du mit 10 Punkten, sodass wir dich ein bisschen einschätzen können. Sprich mich gelegentlich auf eine Beförderung an. Wenn du würdig bist, werde ich dir einen neuen Rang verleihen. ...', -- Rang: Hood, Tell, Hawkeye, Legolas, Ares
							'Manche Geschöpfe versammeln sich um einen Anführer, der meist stärker als alle anderen von ihnen ist. Solltest du die Task solcher Monster beenden, gewähre ich dir danach das Töten ihres Bosses. ...',
							'Hast du noch Fragen? Nein, keine? Sehr gut. Dann mach dich ran: Nimm endlich eine Task an und beginn zu jagen. Es gibt viel zu tun.'}, cid)
			player:setStorageValue(killingInTheNameOfBaseStorage, 1)
			player:setStorageValue(trophyHuntingGuild.rankStorage, 0)
			player:setStorageValue(trophyHuntingGuild.pointCounter, 0)
			player:setStorageValue(trophyHuntingGuild.taskCounter, 0)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Welche Task möchtest du abbrechen? ' .. killingInTheNameOfTasks[player:getStorageValue(trophyHuntingGuild.task1)].name .. ', ' .. killingInTheNameOfTasks[player:getStorageValue(trophyHuntingGuild.task2)].name .. ' oder ' .. killingInTheNameOfTasks[player:getStorageValue(trophyHuntingGuild.task3)].name .. '?', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] >= 100 then
			npcHandler:say(acceptTaskText[math.random(1,#acceptTaskText)], cid)
			startKillingInTheNameOfTask(player, talkState[talkUser])
			talkState[talkUser] = 0
		end
	elseif talkState[talkUser] == 2 or talkState[talkUser] == 4 then
		for i = 1,#taskArray do
			if msg:lower() == taskArray[i].name:lower() then
				if player:getStorageValue(taskArray[i].counterStorage + 100) == 1 then
					if talkState[talkUser] == 4 then
						finishKillingInTheNameOfTask(player, taskID, currentTask)
						npcHandler:say('Alles klar, ich breche deine Task ' .. taskArray[i].name .. ' hiermit ab. Du kannst nun eine andere Task annehmen.', cid)
					else
						npcHandler:say('Diese Task hast du bereits in Auftrag genommen. Bisher hast du ' .. player:getStorageValue(taskArray[i].counterStorage) .. ' von ' .. taskArray[i].amountToKill .. ' ' .. taskArray[i].name .. ' getötet. Das reicht leider noch nicht ganz. Komm wieder, wenn du fertig bist.', cid)
					end
					talkState[talkUser] = 0
				elseif player:getStorageValue(trophyHuntingGuild.taskCounter) == 3 then
					npcHandler:say('Du hast bereits drei Tasks angenommen. Meinst du etwa, drei verschiedene Monster zu jagen, genügt nicht? Übernimm dich nicht. Wenn du unbedingt willst, kannst du aber eine Task abbrechen. Möchtest du das?', cid)
					talkState[talkUser] = 3
				elseif player:getStorageValue(taskArray[i].counterStorage + 200) == 2 then
					npcHandler:say('Du hast diese Task bereits drei mal absolviert. Sei vorsichtig, wie viel du jagst. Wir wollen kein Aussterben der Rasse, sondern nur gegen die Überpopulation angehen. Möchtest du vielleicht stattdessen ein anderes Monster jagen?', cid)
					talkState[talkUser] = 2
				else
					if talkState[talkUser] == 4 then
						npcHandler:say('Diese Task läuft aktuell gar nicht. Was soll ich dann da abbrechen?', cid)
						talkState[talkUser] = 0
					else
						npcHandler:say(killingInTheNameOfText[taskArray[i].id].acceptText, cid)
						talkState[talkUser] = taskArray[i].id
					end
				end
				return true
			end
		end
		npcHandler:say('Davon habe ich noch nie gehört.', cid)
		talkState[talkUser] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

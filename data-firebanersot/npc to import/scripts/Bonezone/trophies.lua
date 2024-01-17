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

local acceptTaskText =
{
'Super! Viel Erfolg bei der Jagd. Kehre zu mir zurück, wenn du genug getötet hast.',
'Fantastisch! Ich erwarte deine Berichte, sobald du die Task erledigt hast.',
'Hervorragend! Ich erwarte deine Berichte, sobald du die Task erledigt hast.',
'Gute Jagd, alter Freund! Kehre zu mir zurück, wenn du genug getötet hast.'
}
	
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
	if player:getStorageValue(trophyHuntingGuild.rankStorage) == 5 then
		promotionAvailable = true
	elseif player:getStorageValue(trophyHuntingGuild.rankStorage) ~= -1 then
		if player:getStorageValue(trophyHuntingGuild.pointCounter) >= ranks[player:getStorageValue(trophyHuntingGuild.rankStorage)+1].points then
			promotionAvailable = ranks[player:getStorageValue(trophyHuntingGuild.rankStorage)+1].rankName
		end
	end
	
	local levelRanges = {6,50,80,130}
	local playerLevelRange = 400
	local taskArray = {}
	local runningTaskArray = {}
	local bosses = {}
	for i = 1,#levelRanges do
		if player:getLevel() >= levelRanges[i] == false then
			playerLevelRange = (i-1)*100
			break
		end
	end
	if playerLevelRange > 0 then
		for id, task in pairs(killingInTheNameOfTasks) do
			if id >= playerLevelRange and id < playerLevelRange+100 then
				taskArray[#taskArray+1] = task
			end
			if player:getStorageValue(task.counterStorage+100) == 1 and id >= 100 then
				runningTaskArray[#runningTaskArray+1] = task
			end
			if id >= 100 and id < 400 and task.bossName ~= nil and player:getStorageValue(task.counterStorage+300) ~= 1 then
				bosses[#bosses+1] = task
			end
		end
	end
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Trophäen! TROPHÄEN! Das ist mein Beruf! Ich kaufe aber nur welche. Sie sind mir viel zu wertvoll, als das ich sie wieder weggeben möchte, meine kleinen Babys. ...',
						'Außerdem bin ich Gründer der {Trophy Hunting Guild}. Wir jagen Monster zu friedlichen Zwecken, um Überpopulation zu verhindern. Sag mir bescheid, falls du {beitreten} möchtest.'},cid)
		talkState[talkUser] = 0
		return true
	elseif msgcontains(msg, 'test') then
		-- player:addExperience(10000000, true)
		-- print(#taskArray)
		-- print(#runningTaskArray)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Direkt nebenan in dem hohen Haus lebt Xantharus. Er verkauft schon sein Leben lang Vials.', cid)
		talkState[talkUser] = 0
		return true
	elseif msgcontains(msg, 'join') or msgcontains(msg, 'beitreten') then
		if player:getStorageValue(trophyHuntingGuild.baseStorage) == -1 then
			npcHandler:say('So, du willst also unserer Gilde beitreten und im Auftrag für uns Monster töten?', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du bist bereits Mitglied der Gilde, ' .. getPlayerName(cid) .. ', oder hast du das etwa vergessen?', cid)
		end
		return true
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Alles klar. Du bist nun Auszubildender der Gilde und kannst jederzeit bis zu drei {Tasks} annehmen. Komm zu mir und gib mir Bescheid, solltest du eine Task erfüllt haben. ...',
							'Das Abschließen einer Task bringt dir Punkte, mit denen du im Rang aufsteigst. Den ersten Rang erhälst du mit 10 Punkten, sodass wir dich ein bisschen einschätzen können. Sprich mich gelegentlich auf eine Beförderung an. Wenn du würdig bist, werde ich dir einen neuen Rang verleihen. ...', -- Rang: Hood, Tell, Hawkeye, Legolas, Ares
							'Hast du noch Fragen? Nein, keine? Sehr gut. Dann mach dich ran: Nimm endlich eine Task an und beginn zu jagen. Es gibt viel zu tun.'}, cid)
			player:setStorageValue(killingInTheNameOfBaseStorage, 1)
			player:setStorageValue(trophyHuntingGuild.rankStorage, 0)
			player:setStorageValue(trophyHuntingGuild.pointCounter, 0)
			player:setStorageValue(trophyHuntingGuild.bossPointCounter, 0)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Welche Task möchtest du abbrechen? {' .. runningTaskArray[1].name .. '}, {' .. runningTaskArray[2].name .. '} oder {' .. runningTaskArray[3].name .. '}?', cid)
			talkState[talkUser] = 4
		elseif talkState[talkUser] == 5 then
			npcHandler:say('Tatsächlich? Na dann, sei es dir gewährt. Mach dich auf und töte dieses widerliche Monster. Viel Glück!', cid)
			player:setStorageValueUp(trophyHuntingGuild.bossPointCounter, -1) -- bossPointCounter -1
			talkState[talkUser] = 0
		elseif talkState[talkUser] >= 100 then
			npcHandler:say(acceptTaskText[math.random(1,#acceptTaskText)], cid)
			startKillingInTheNameOfTask(player, talkState[talkUser])
			talkState[talkUser] = 0
		end
		return true
	end
	
	if player:getStorageValue(trophyHuntingGuild.rankStorage) == -1 then
		npcHandler:say('Ich kann dir leider nicht weiterhelfen, solange du mir fremd bist. Du könntest unserer \'Trophy Hunting Guild\' ja {beitreten}, um mein Vertrauen zu gewinnen.', cid)
		talkState[talkUser] = 0
	else
		if msgcontains(msg, 'task') then
			if promotionAvailable ~= false and promotionAvailable ~= true then
				npcHandler:say('Ich bewundere dein Tatendrang, Champ, aber du bist erstmal bereit für eine {Beförderung}, bevor du weitere Tasks erledigen kannst.', cid)
				talkState[talkUser] = 0
				return true
			end
			while #runningTaskArray > 0 do
				local cT = runningTaskArray[1]
				if player:getStorageValue(cT.counterStorage) >= killingInTheNameOfTasks[cT.id].amountToKill then
					finishKillingInTheNameOfTask(player, cT.id)
					if cT.bossName == nil then
						npcHandler:say('Gute Arbeit, alter Freund. Du hast erfolgreich ' .. cT.amountToKill .. ' ' .. cT.name .. ' getötet. Dafür erhälst du ' .. cT.rewardXP .. ' XP und ' .. cT.rewardPoints .. ' Punkte in unserer Gilde.', cid)
						talkState[talkUser] = 0
					else -- boss vorhanden
						if cT.id >= 400 and player:getStorageValue(cT.counterStorage+200) > 1 then -- 130+ task wurde zum ersten mal beendet
							npcHandler:say('Wow! Ich bin sehr beeindruckt von deiner Willenskraft. Gute Arbeit, alter Freund! Hiermit verleihe ich dir einen {Bosspunkt}, mit dem du dich zwischen allen Bossen der unteren Levelsgruppen entscheiden kannst. Oder möchtest du nochmal gegen {' .. cT.bossName .. '}, den Boss der ' .. cT.name .. ', kämpfen?', cid)
							player:setStorageValueUp(trophyHuntingGuild.bossPointCounter, 1) -- bossPointCounter +1
							talkState[talkUser] = 5
						else -- normale boss task
							npcHandler:say(killingInTheNameOfText[cT.id].bossText, cid)
							player:setStorageValue(cT.counterStorage+300, 1) -- boss storage auf 1
							talkState[talkUser] = 0
						end
					end
					return true
				end
				table.remove(runningTaskArray, 1)
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
		elseif msgcontains(msg, 'beförderung') or msgcontains(msg, 'promotion') then
			if promotionAvailable == false then
				npcHandler:say('Du besitzt momentan noch nicht genügend Punkte in unserer Gilde, um im Rang aufzusteigen. Absolviere mehr Tasks! Wenn du keine Tasks mehr machen kannst, empfehle ich dir im Level aufzusteigen. Auf höheren Leveln erwarten dich weitere Tasks.', cid)
			elseif promotionAvailable == true then
				npcHandler:say('Du hast schon den höhsten Rang in unserer Gilde. Ich kann dir leider keine weitere Beförderung anbieten. Ich wäre dir trotzdem dankbar, wenn du weitere Tasks für uns erledigen kannst.', cid)
			else
				npcHandler:say('Glückwunsch, ' .. player:getName() .. '! Hiermit befördere ich dich zum Rang \'' .. promotionAvailable .. '\'! Du kannst jetzt weitere Tasks annehmen.', cid)
				player:setStorageValueUp(trophyHuntingGuild.rankStorage, 1)
			end
			talkState[talkUser] = 0
		elseif msgcontains(msg, 'abbrechen') or msgcontains(msg, 'cancel') then
			if #runningTaskArray == 3 then
				npcHandler:say('Möchtest du eine laufende Task abbrechen?', cid)
				talkState[talkUser] = 3
			else
				npcHandler:say('Du hast doch keine drei laufenden Tasks. Warum solltest du dann eine abbrechen wollen? Nutze zunächst deinen freien Taskplatz.', cid)
				talkState[talkUser] = 0
			end
		elseif msgcontains(msg, 'boss') then
			if player:getStorageValue(trophyHuntingGuild.bossPointCounter) > 0 then
				local text = 'Gerne. Wähle aus einem der folgenden Bosse: '
				for i = 1,#bosses-1 do
					text = text .. '{' .. bosses[i].bossName .. '}, '
				end
				text = text .. '{' .. bosses[#bosses].bossName .. '}.'
				npcHandler:say(text, cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('Zur Zeit besitzt du leider keine Bosspunkte.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 2 or talkState[talkUser] == 4 then
			local counter = #runningTaskArray
			while counter > 0 do
				if msg:lower() == runningTaskArray[counter].name:lower() then
					if talkState[talkUser] == 2 then
						npcHandler:say('Diese Task hast du bereits in Auftrag genommen. Bisher hast du ' .. player:getStorageValue(runningTaskArray[counter].counterStorage) .. ' von ' .. runningTaskArray[counter].amountToKill .. ' ' .. runningTaskArray[counter].name .. ' getötet. Das reicht leider noch nicht ganz. Komm wieder, wenn du fertig bist.', cid)
					else
						npcHandler:say('Alles klar, ich breche deine Task ' .. runningTaskArray[counter].name .. ' hiermit ab. Du kannst nun eine andere Task annehmen.', cid)
						finishKillingInTheNameOfTask(player, runningTaskArray[counter].id, false)
					end
					talkState[talkUser] = 0
					return true
				end
				counter = counter-1
			end
			for i = 1,#taskArray do
				if msg:lower() == taskArray[i].name:lower() then
					if #runningTaskArray == 3 then
						npcHandler:say('Du hast bereits drei Tasks angenommen. Meinst du etwa, drei verschiedene Monster zu jagen, genügt nicht? Übernimm dich nicht. Wenn du unbedingt willst, kannst du aber eine Task abbrechen. Möchtest du das?', cid)
						talkState[talkUser] = 3
					elseif player:getStorageValue(taskArray[i].counterStorage + 200) == 3 and playerLevelRange ~= 400 then
						npcHandler:say('Du hast diese Task bereits drei mal absolviert. Sei vorsichtig, wie viel du jagst. Wir wollen kein Aussterben der Rasse, sondern nur gegen die Überpopulation angehen. Möchtest du vielleicht stattdessen ein anderes Monster jagen?', cid)
						talkState[talkUser] = 2
					else
						npcHandler:say(killingInTheNameOfText[taskArray[i].id].acceptText, cid)
						talkState[talkUser] = taskArray[i].id
					end
					return true
				end
			end
			npcHandler:say('Davon habe ich noch nie gehört.', cid)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 6 then
			while #bosses > 0 do
				if msg:lower() == bosses[1].bossName:lower() then
					npcHandler:say('So sei es! Mach dich auf und töte ' .. bosses[1].bossName .. ', den Boss der ' .. bosses[1].name .. '.', cid)
					player:setStorageValue(bosses[1].counterStorage+300, 1) -- bossStorage auf 1
					player:setStorageValueUp(trophyHuntingGuild.bossPointCounter, -1) -- bossPointCounter -1
					talkState[talkUser] = 0
					return true
				end
				table.remove(bosses,1)
			end
			npcHandler:say('Diesen Boss kenn ich nicht.', cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

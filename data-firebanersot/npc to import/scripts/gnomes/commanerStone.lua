local questCooldown = 60*60*20 -- 20 Stunden Cooldown
local story = {}
local function cancelStory(cid)
	if not(story[cid]) then return true end
	for _, eventId in pairs(story[cid]) do
		stopEvent(eventId)
	end
	story[cid] = {}
end
 
function creatureFarewell(cid)
	if not(isPlayer(cid)) then return true end
	cancelStory(cid)
	return true
end

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
		if msg == "hi" or msg == "hallo" or msg == "hello" then
			if getPlayerStorageValue(cid, 51234) == 2 then
				npcHandler:say("Hallo Rekrut.", cid)
				npcHandler:addFocus(cid)
			else
				npcHandler:say("Ich bin zur Zeit sehr beschäftigt. Als Neuankömmling sprich doch bitte mit Gnomette!", cid)
			end
		else
			return false
		end
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	cancelStory(cid)
	if msg == "job" or msg == "beruf" then
		npcHandler:say('Ich bin dafür zuständig, unseren neuen Rekruten sinnvolle Aufgaben zu geben und ihre Stärke zu testen. Wenn Du Interesse hast, frag mich nach einer {Mission}.',cid)
	elseif msgcontains(msg, "bye") then
         npcHandler:say("Bye.", cid)
         npcHandler:releaseFocus(cid)
	end
	
	return true
end

function CommanderMission(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	local rang = getPlayerStorageValue(cid, 51240) >= 30
	local rang2 = getPlayerStorageValue(cid, 51240) >= 120
	npcHandler:say("Für deinen Rang sind " ..(rang and "vier" or "zwei").. " Missionen verfügbar: Crystal {Keeper}" ..(rang and ", {Spark} Hunting, monster {Extermination} und Mushroom {Digging}." or " und {Spark} Hunting.")..(rang2 and " Übrigens kannst Du mit Deinem Rang nun auch bei Gnomeral Missionen in Gnomebase Alpha anfangen." or ""), cid)
	npcHandler:resetNpc()
	return true
end

function CommanderReport(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	local rang = getPlayerStorageValue(cid, 51240) >= 30
	npcHandler:say("Über welche Mission willst Du berichten? Crystal {Keeper}" ..(rang and ", {Spark} Hunting, {Extermination} oder Mushroom {Digging}?" or " oder {Spark} Hunting?"), cid)
	return true
end

function taskStart(cid, msg, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local storage, item, access, text = parameters.questStorage, parameters.item, parameters.access, parameters.text
	if getPlayerStorageValue(cid, 51240) >= access then
		if getPlayerStorageValue(cid, storage) == -1 then
			if getPlayerStorageValue(cid, storage + 1) == -1 then -- Cooldown Storage
				npcHandler:say(text, cid)
				setPlayerStorageValue(cid, storage, 0)
				if item ~= 0 then
					doPlayerAddItem(cid, item, 1)
				end
			else
				npcHandler:say("Es tut mir leid, aber Du musst noch länger warten, bis Du diese Mission erneut machen kannst.", cid)
			end
		else
			npcHandler:say("Du hast diese Mission bereits angenommen. Vergiss nicht, mir {Bericht} zu erstatten, wenn Du fertig bist.", cid)
		end
	else
		npcHandler:say("Dafür bist Du noch nicht bereit.", cid)
	end
	npcHandler:resetNpc()
	return true
end

function taskReport(cid, msg, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local storage, access, endValue, reputation, item = parameters.questStorage, parameters.access, parameters.endValue, parameters.reputation, parameters.item
	if getPlayerStorageValue(cid, 51240) >= access then
		if getPlayerStorageValue(cid, storage) >= endValue then
			npcHandler:say("Gute Arbeit. Das hilft uns sehr. Nimm Deinen Token und dieses gnomish supply package als Belohnung.", cid)
			setPlayerStorageValue(cid, storage, -1)
			setPlayerStorageValue(cid, 51240, getPlayerStorageValue(cid, 51240) + reputation)
			setPlayerStorageValue(cid, storage + 1, 1)
			doPlayerAddItem(cid, 18215, 1)
			doPlayerAddItem(cid, 18422, 1)
			if getPlayerItemCount(cid, item) >= 1 then
				doPlayerRemoveItem(cid, item, 1)
			end
			if getPlayerStorageValue(cid, 51240) >= 120 and getPlayerStorageValue(cid, 51236) == -1 then
				setPlayerStorageValue(cid, 51236, 1)
			end
			if getPlayerStorageValue(cid, 51240) >= 480 and getPlayerStorageValue(cid, 51237) == -1 then
				setPlayerStorageValue(cid, 51237, 1)
			end
			if getPlayerStorageValue(cid, 51240) >= 1440 and getPlayerStorageValue(cid, 51238) == -1 then
				setPlayerStorageValue(cid, 51238, 1)
			end
		else
			npcHandler:say("Du bist damit noch nicht fertig!", cid)
		end
	end
	npcHandler:resetNpc()
	return true
end

local node1 = keywordHandler:addKeyword({'report'}, CommanderReport, {npcHandler = npcHandler, onlyFocus = true})
node1:addChildKeyword({'keeper'}, taskReport, {npcHandler = npcHandler, questStorage = 51241, access = 0, endValue = 5, reputation = 5, item = 18219,  reset = true})
node1:addChildKeyword({'spark'}, taskReport, {npcHandler = npcHandler, questStorage = 51243, access = 0, endValue = 7, reputation = 5, item = 18213, reset = true})
node1:addChildKeyword({'extermination'}, taskReport, {npcHandler = npcHandler, questStorage = 51245, access = 30, endValue = 10, reputation = 5, reset = true})
node1:addChildKeyword({'digging'}, taskReport, {npcHandler = npcHandler, questStorage = 51247, access = 30, endValue = 3, reputation = 5, item = 18344, reset = true})

local node2 = keywordHandler:addKeyword({'bericht'}, CommanderReport, {npcHandler = npcHandler, onlyFocus = true})
node2:addChildKeyword({'keeper'}, taskReport, {npcHandler = npcHandler, questStorage = 51241, access = 0, endValue = 5, reputation = 5, item = 18219,  reset = true})
node2:addChildKeyword({'spark'}, taskReport, {npcHandler = npcHandler, questStorage = 51243, access = 0, endValue = 7, reputation = 5, item = 18213, reset = true})
node2:addChildKeyword({'extermination'}, taskReport, {npcHandler = npcHandler, questStorage = 51245, access = 30, endValue = 10, reputation = 5, reset = true})
node2:addChildKeyword({'digging'}, taskReport, {npcHandler = npcHandler, questStorage = 51247, access = 30, endValue = 3, reputation = 5, item = 18344, reset = true})
		
keywordHandler:addKeyword({'mission'}, CommanderMission, {npcHandler = npcHandler, onlyFocus = true})
keywordHandler:addKeyword({'keeper'}, taskStart, {npcHandler = npcHandler, questStorage = 51241, item = 18219, access = 0, endValue = 6, reset = true, text = "Du musst für uns ein paar beschädigte Kristalle reparieren. Gehe zu den Crystal Grounds und repariere sie, indem Du diesen Harmonic Crystal auf sie benutzt. Mache das bei fünf Stück und komm dann wieder zu mir."})
keywordHandler:addKeyword({'spark'}, taskStart, {npcHandler = npcHandler, questStorage = 51243, item = 18213, access = 0, endValue = 8, reset = true, text = "Nimm diesen Extraktor und bohre ihn in den Körper eines toten Crystal Crushers. Das wird Deinen eigenen Körper mit Energy Funken aufladen. Lade ihn mit sieben Funken auf und komm dann wieder zu mir."})
keywordHandler:addKeyword({'extermination'}, taskStart, {npcHandler = npcHandler, onlyFocus = true, questStorage = 51245, item = 0, access = 30, endValue = 11, reset = true, text = "Die Wiggler sind zu einer richtigen Pest geworden, die unsere Ressourcen bedrohen. Töte 10 von ihnen in dem Mushroom Garden, oder den Truffle Grounds. Berichte mir anschließend."})
keywordHandler:addKeyword({'digging'}, taskStart, {npcHandler = npcHandler, questStorage = 51247, item = 18344, access = 30, endValue = 4, reset = true, text = "Nimm dieses Schwein und fütter es mit Trüffeln. Geh dafür in die Truffle Grounds und locke einen Mushroom Sniffler über die Erdlöcher auf dem Boden. Manchmal buddelt er dabei Trüffel aus. Fütter er drei mal und bring es dann wieder zu mir zurück."})


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

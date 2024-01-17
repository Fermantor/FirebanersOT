local questCooldown = 60*60*20 -- 20 Stunden Cooldown

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
	if msg == "job" or msg == "beruf" then
		npcHandler:say('Ich bin der Kommander der gnomischen Verteidigung und habe einige {Missionen} für unsere Bigfoot Rekruten.',cid)
	elseif msgcontains(msg, "bye") then
         npcHandler:say("Bye.", cid)
         npcHandler:releaseFocus(cid)
	end
	
	return true
end

function GnomeralMission(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	local rang = getPlayerStorageValue(cid, 51240) >= 480
	npcHandler:say("Für deinen Rang sind " ..(rang and "vier" or "zwei").. " Missionen verfügbar: {Matchmaker}" ..(rang and ", Golem {Repair}, {Spore} Gathering und {Grindstone} Hunt." or " und Golem {Repair}."), cid)
	npcHandler:resetNpc()
	return true
end

function CommanderReport(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	local rang = getPlayerStorageValue(cid, 51240) >= 480
	npcHandler:say("Über welche Mission willst Du berichten? {Matchmaker}" ..(rang and ", Golem {Repair}, {Spore} Gathering oder {Grindstone} Hunt?" or " oder Golem {Repair}?"), cid)
	return true
end

function taskStart(cid, msg, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local storage, item, access, text = parameters.questStorage, parameters.item, parameters.access, nein, "Mission gestartet."
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
		if getPlayerStorageValue(cid, storage) == endValue then
			if storage == 51253 and getPlayerItemCount(cid, item) == 0 then
				npcHandler:say("Du bist damit noch nicht fertig!", cid)
				npcHandler:resetNpc()
				return true
			end
			npcHandler:say("Gute Arbeit. Das hilft uns sehr. Nimm Deine Token und dieses gnomish supply package als Belohnung.", cid)
			setPlayerStorageValue(cid, storage, -1)
			setPlayerStorageValue(cid, 51240, getPlayerStorageValue(cid, 51240) + reputation)
			setPlayerStorageValue(cid, storage + 1, 1)
			doPlayerAddItem(cid, 18215, 1)
			doPlayerAddItem(cid, 18422, 2)
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
node1:addChildKeyword({'matchmaker'}, taskReport, {npcHandler = npcHandler, questStorage = 51249, access = 120, endValue = 1, reputation = 10, item = 0,  reset = true})
node1:addChildKeyword({'repair'}, taskReport, {npcHandler = npcHandler, questStorage = 51251, access = 120, endValue = 4, reputation = 5, item = 18343, reset = true})
node1:addChildKeyword({'spore'}, taskReport, {npcHandler = npcHandler, questStorage = 51253, access = 480, endValue = 0, reputation = 10, item = 18332, reset = true})
node1:addChildKeyword({'grindstone'}, taskReport, {npcHandler = npcHandler, questStorage = 51255, access = 480, endValue = 1, reputation = 10, item = 18337, reset = true})

local node2 = keywordHandler:addKeyword({'bericht'}, CommanderReport, {npcHandler = npcHandler, onlyFocus = true})
node2:addChildKeyword({'matchmaker'}, taskReport, {npcHandler = npcHandler, questStorage = 51249, access = 120, endValue = 1, reputation = 10, item = 0,  reset = true})
node2:addChildKeyword({'repair'}, taskReport, {npcHandler = npcHandler, questStorage = 51251, access = 120, endValue = 4, reputation = 5, item = 18343, reset = true})
node2:addChildKeyword({'spore'}, taskReport, {npcHandler = npcHandler, questStorage = 51253, access = 480, endValue = 0, reputation = 10, item = 18332, reset = true})
node2:addChildKeyword({'grindstone'}, taskReport, {npcHandler = npcHandler, questStorage = 51255, access = 480, endValue = 1, reputation = 10, item = 18337, reset = true})
		
keywordHandler:addKeyword({'mission'}, GnomeralMission, {npcHandler = npcHandler, onlyFocus = true})
keywordHandler:addKeyword({'matchmaker'}, taskStart, {npcHandler = npcHandler, questStorage = 51249, item = 18313, access = 120, reset = true})
keywordHandler:addKeyword({'repair'}, taskStart, {npcHandler = npcHandler, questStorage = 51251, item = 18343, access = 120, reset = true})
keywordHandler:addKeyword({'spore'}, taskStart, {npcHandler = npcHandler, questStorage = 51253, item = 18328, access = 480, reset = true})
keywordHandler:addKeyword({'grindstone'}, taskStart, {npcHandler = npcHandler, questStorage = 51255, item = 0, access = 480, reset = true})


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

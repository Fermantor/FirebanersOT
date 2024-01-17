local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local days = 1 * 10
 
function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                npcHandler:onThink() end
 
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'mount') then
		if getPlayerStorageValue(cid, 15906) == -1 then
			doPlayerAddMount(cid, 22)     
			npcHandler:say('Now you have a rented horse for the next 24 hours.', cid)
			Zeit = os.time() + days
			setPlayerStorageValue(cid, 15905, Zeit)
			setPlayerStorageValue(cid, 15906, 1)
		else
			npcHandler:say('No!!', cid)
		end
	end
	return TRUE
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
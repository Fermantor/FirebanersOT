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
	if msgcontains(msg, 'heilen') then
		if getCreatureHealth(cid) < (getCreatureMaxHealth(cid)*0.75) then
			doCreatureAddHealth(cid, ((getCreatureMaxHealth(cid)*0.75)-getCreatureHealth(cid))+1)
			doSendMagicEffect(getPlayerPosition(cid), 12)
			npcHandler:say('Nun siehst du schon viel besser aus.', cid)
		else
			npcHandler:say('Tut mir leid, aber du siehst nicht sehr verwundet aus.', cid)
		end
	elseif msgcontains(msg, 'elena') then
		if getPlayerStorageValue(cid, 20005) <= 0 then
			npcHandler:say('Ah, hat sie wieder mit meiner Arbeit rumgeprahlt? Nun, mit den richtigen Materialien kann ich dir im Handumdrehen dein eigenes {Backpack} machen.', cid)
		end
	elseif msgcontains(msg, 'backpack') or msgcontains(msg, 'back pack') or msgcontains(msg, 'addon') or msgcontains(msg, 'outfit') then
		if getPlayerStorageValue(cid, 20005) <= 0 then
			npcHandler:say('Nun, ich als Meister der Minotauren kann aus ein paar {Minotaur Leathers} im Handumdrehen ein schönes Backpack machen. Bist du interessiert?', cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, 20005) == 1 then
			npcHandler:say('Bist du hier, um mir die 100 Minotaur Leathers zu bringen?', cid)
			talkState[talkUser] = 2
		end
	elseif msgcontains(msg, 'ja') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Also gut, bringe mir 100 {Minotaur Leathers} und das Backpack ist dein.', cid)
			talkState[talkUser] = 0
			setPlayerStorageValue(cid, 20005, 1)
		elseif talkState[talkUser] == 2 then
			if getPlayerItemCount(cid, 5878) >= 100 then
				doPlayerRemoveItem(cid, 5878, 100)
				npcHandler:say('Wunderbar, das Backpack habe ich im Handumdrehen gemacht... und hier... und da... FERTIG! Ich hoffe, du findest Gefallen daran.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 20005, 2)
				doPlayerAddOutfit(cid,136,1)
				doPlayerAddOutfit(cid,128,1)
				doSendMagicEffect(getPlayerPosition(cid), 12)
			else
				npcHandler:say('Ohne das nötige Material kann auch ich keine gute Arbeit abliefern. Es müssen schon 100 Minotaur Leathers sein.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif msgcontains(msg, 'minotaur leather') or msgcontains(msg, 'minotaur leathers') then
		npcHandler:say('Minotaur Leathers sind ein hervorragendes Material für feste und starke Kleidung. Leider ist es sehr schwer einen Minotauren zu erlegen und ihm das Leather unbeschädigt zu entfernen.', cid)
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

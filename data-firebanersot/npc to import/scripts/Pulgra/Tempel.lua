local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local condition = {
	[1] = CONDITION_POISON,
	[2] = CONDITION_FIRE,
	[3] = CONDITION_ENERGY,
	[4] = CONDITION_BLEEDING,
	[5] = CONDITION_PARALYZE,
	[6] = CONDITION_DROWN,
	[7] = CONDITION_FREEZING,
	[8] = CONDITION_CURSED
}

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
		local Heal = FALSE
		for i = 1, #condition do
			if getCreatureCondition(cid, condition[i]) == TRUE then
				doRemoveCondition(cid, condition[i])
				Heal = TRUE
			end
		end
		if getCreatureHealth(cid) < (getCreatureMaxHealth(cid)*0.75) then
			doCreatureAddHealth(cid, ((getCreatureMaxHealth(cid)*0.75)-getCreatureHealth(cid))+1)
		end
		if Heal == TRUE then 
			npcHandler:say('Nun siehst du schon viel besser aus.', cid)
			doSendMagicEffect(getPlayerPosition(cid), 12)
		else
			npcHandler:say('Tut mir leid, aber du siehst nicht sehr verwundet aus.', cid)
		end
	elseif msgcontains(msg, 'blessing') or msgcontains(msg, 'bless') then
		npcHandler:say('Es gibt 5 Blessings in Tibia. Jedes trägt dazu bei, dich vor Verlust bei einem Tod zu schützen. Das {Spiritual Shielding}, das {Embrace of Tibia}, das {Fire of the Suns}, das {Wisdom of Solitude} und das {Spark of the Phoenix}.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'suns') then -- Blessing 3
		if not getPlayerBlessing(cid, 3) then
			npcHandler:say('Willst du das Fire of the Suns für ' .. getBlessPrice(cid) .. ' Gold kaufen?.', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du hast dieses Blessing bereits erhalten.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'spiritual') then -- Blessing 4
		if not getPlayerBlessing(cid, 4) then
			npcHandler:say('Willst du das Spiritual Shielding für ' .. getBlessPrice(cid) .. ' Gold kaufen?.', cid)
			talkState[talkUser] = 2
		else
			npcHandler:say('Du hast dieses Blessing bereits erhalten.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'solitude') then -- Blessing 1
		npcHandler:say('Wenn du das {Wisdom of Solitude} Blessing kaufen willst, musst du zu Antonius in Bonezone gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'embrace') then -- Blessing 2
		npcHandler:say('Wenn du das {Embrace of Tibia} Blessing kaufen willst, musst du zu Antonius in Bonezone gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'phoenix') then -- Blessing 5
		npcHandler:say('Wenn du das {Spark of the Phoenix} Blessing kaufen willst, musst du zum Dwarf Burak in Pulgra gehen Er lebt dort im Dwarf Berg.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then	
			if doPlayerRemoveMoney(cid, getBlessPrice(cid)) == TRUE then
				doPlayerAddBlessing(cid, 3)
				npcHandler:say('Hiermit erhälst du den Segen des Wisdom of Solitude.', cid)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				talkState[talkUser] = 0
			end
		elseif 	talkState[talkUser] == 2 then
			if doPlayerRemoveMoney(cid, getBlessPrice(cid)) == TRUE then
				doPlayerAddBlessing(cid, 4)
				npcHandler:say('Hiermit erhälst du den Segen des Wisdom of Solitude.', cid)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				talkState[talkUser] = 0
			end
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

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
			Heal = TRUE
		end
		if Heal == TRUE then 
			npcHandler:say('Jetzt bist du für deinen nächsten Kampf vorbereitet.', cid)
			doSendMagicEffect(getPlayerPosition(cid), 12)
			talkState[talkUser] = 0
		else
			npcHandler:say('Du scheinst nicht sonderlich geschwächt zu sein. Es wäre eine Verschwendung, meine Energie für gesunde Menschen zu verbrauchen.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Das ist eigentlich nicht mein Fachgebiet. Ich mag keine verkorkte Zauberei. Aber, um dir zu helfen, kann ich dir verraten, dass es in Little Cotton einen Mann namens Xantharus gibt. Er kümmert sich um Vials und derlei Sachen.', cid)
	elseif msgcontains(msg, 'blessing') or msgcontains(msg, 'bless') then
		npcHandler:say('Es gibt 5 Blessings in Tibia. Jedes trägt dazu bei, dich vor Verlust bei einem Tod zu schützen. Das {Spiritual Shielding}, das {Embrace of Tibia}, das {Fire of the Suns}, das {Wisdom of Solitude} und das {Spark of the Phoenix}.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'solitude') then -- Blessing 1
		if not getPlayerBlessing(cid, 1) then
			npcHandler:say('Willst du das Wisdom of Solitude für ' .. getBlessPrice(cid) .. ' Gold kaufen?.', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du hast dieses Blessing bereits erhalten.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'embrace') then -- Blessing 2
		if not getPlayerBlessing(cid, 2) then
			npcHandler:say('Willst du das Embrace of Tibia für ' .. getBlessPrice(cid) .. ' Gold kaufen?.', cid)
			talkState[talkUser] = 2
		else
			npcHandler:say('Du hast dieses Blessing bereits erhalten.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'suns') then -- Blessing 3
		npcHandler:say('Wenn du das {Fire of Suns} Blessing kaufen willst, musst du zu Alfred in Pulgra gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'spiritual') then -- Blessing 4
		npcHandler:say('Wenn du das {Spiritual Shielding} Blessing kaufen willst, musst du zu Alfred in Pulgra gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'phoenix') then -- Blessing 5
		npcHandler:say('Wenn du das {Spark of the Phoenix} Blessing kaufen willst, musst du zum Dwarf Burak in Pulgra gehen Er lebt dort im Dwarf Berg.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then	
			if doPlayerRemoveMoney(cid, getBlessPrice(cid)) == TRUE then
				doPlayerAddBlessing(cid, 1)
				npcHandler:say('Hiermit erhälst du den Segen des Wisdom of Solitude.', cid)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				talkState[talkUser] = 0
			end
		elseif 	talkState[talkUser] == 2 then
			if doPlayerRemoveMoney(cid, getBlessPrice(cid)) == TRUE then
				doPlayerAddBlessing(cid, 2)
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

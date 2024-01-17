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
		npcHandler:say('ICH BIN DER KÖNIG VON BONEZONE. ICH REGIERE DIESE STADT UND VERTEILE DIE {PROMOTION}!',cid)
	elseif msgcontains(msg, 'belohnung') or msgcontains(msg, 'reward') then
		if getPlayerStorageValue(cid, theDeliciousHelperQuest.mission4) == 18 then
			if getPlayerFreeCap(cid) >= 39.80 then
				npcHandler:say('TREVOR HAT MIR VON DEINER HELDENTAT ERZÄHLT! DU HAST IHM UND GANZ BONEZONE EINEN GROßEN GEFALLEN GETAN! NIMM DIES ALS DEINE BELOHNUNG!',cid)
				doAddContainerItem(rewardBackpackBZ, 2170, 1) -- Silver Amulet
				doAddContainerItem(rewardBackpackBZ, 2168, 1) -- Life Ring
				local rewardBackpackBZ = doCreateItemEx(18393) -- Mushroom Backpack
				doAddContainerItem(rewardBackpackBZ, 2152, 50) -- 50 Platinum Coins
				doAddContainerItem(rewardBackpackBZ, 2796, 20) -- 20 Green Mushrooms
				doAddContainerItem(rewardBackpackBZ, 2789, 20) -- 20 Brown Mushrooms
				doAddContainerItem(rewardBackpackBZ, 2787, 20) -- 20 White Mushrooms
				doPlayerAddItemEx(cid, rewardBackpackBZ, 1)
				setPlayerStorageValue(cid, theDeliciousHelperQuest.mission4, 19)
			else
				npcHandler:say('ES TUT MIR LEID, ABER DU BESITZT LEIDER NICHT GENUG TRAGKRAFT!',cid)
			end
		end
	elseif msgcontains(msg, 'promotion') then
		if getPlayerPremiumDays(cid) >= 1 then
			if getPlayerLevel(cid) >= 50 then
				if getPlayerStorageValue(cid, promotion) == -1 then
					npcHandler:say('WILLST DU PROMOTION FÜR 20.000 KAUFEN?',cid)
					talkState[talkUser] = 1
				else
					npcHandler:say('DAS FINDE ICH GUT, ABER DU HAST SCHON PROMOTION!',cid)
					talkState[talkUser] = 0
				end
			else
				npcHandler:say('DU BRAUCHST LEVEL 50 ODER HÖHER, UM PROMOTION ZU ERLANGEN!',cid)
				talkState[talkUser] = 0
			end
		else
			npcHandler:say('DU MUSST PREMIUM BESITZEN, UM DIR PROMOTION ZU KAUFEN!',cid)
			talkState[talkUser] = 0
		end	
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			if doPlayerRemoveMoney(cid, 20000) == TRUE then
				doPlayerSetVocation(cid,getPlayerVocation(cid)+4)
				setPlayerStorageValue(cid, promotion, 1)
				npcHandler:say('NUN GUT, DU HAST JETZT PROMOTION!',cid)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
				talkState[talkUser] = 0
			else
				npcHandler:say('DU TRÄGST LEIDER NICHT GENUG GELD MIT DIR!',cid)
				talkState[talkUser] = 0
			end
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)                 npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                             npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
	local shopWindow = {}
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	local PremiumSpells = FALSE
	local AllSpells = FALSE
	local Vocations = {0, "non vocations"}
	-- 1,5 Sorcerer
	-- 2,6 Druid
	-- 3,7 Paladin
	-- 4,8 Knight
    local spells = {
	[8704] = { buy = 500, spell = "Tiny Healing", name = "Level 010: Tiny Healing", vocations = {0}, level = 10, premium = 0},
	}
    local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		npcHandler:say("You have choosen the spell: " .. spells[item].spell .. " which costs " .. spells[item].buy .. " gold.", cid)
		if not getPlayerLearnedInstantSpell(cid, spells[item].spell) then
			if getPlayerLevel(cid) >= spells[item].level then
				if isInArray(spells[item].vocations, getPlayerVocation(cid)) then
					if getPlayerMoney(cid) >= spells[item].buy then
						doPlayerRemoveMoney(cid, spells[item].buy)
						playerLearnInstantSpell(cid, spells[item].spell)
						doSendMagicEffect(getPlayerPosition(cid), 12)
						npcHandler:say("Du hast den Spruch " .. spells[item].spell .. " gelernt.", cid)
					else
						npcHandler:say("Du hast nicht genug Geld.", cid)
					end
				else
					npcHandler:say("Dieser Spruch ist nicht für deine Vocation.", cid)
				end
			else
				npcHandler:say("Du brauchst Level " .. spells[item].level .. " oder mehr, um diesen Spruch zu lernen.", cid)
			end
		else
			npcHandler:say("Du kennst diesen Spell bereits.", cid)
		end
		return true
	end
 
	if msgcontains(msg, 'spells') then
		if isInArray(Vocations, getPlayerVocation(cid)) == TRUE or Vocations == ALL then
			npcHandler:say("Hier sind die Spells, die du von mir lernen kannst.", cid)
			for var, item in pairs(spells) do
				if (not getPlayerLearnedInstantSpell(cid, item.spell) and getPlayerLevel(cid) >= item.level and isInArray(item.vocations, getPlayerVocation(cid)) and (item.premium == 1 and PremiumSpells == TRUE or item.premium == 0)) or AllSpells == TRUE then
					table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name})
				end
			end
			openShopWindow(cid, shopWindow, onBuy, onSell)
		else
			npcHandler:say("Sorry, aber ich teile meine Zauberspruchkunst nur mit "..  onlyVocation[3], cid)
		end
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
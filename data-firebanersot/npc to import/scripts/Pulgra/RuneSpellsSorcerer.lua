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
	local PremiumSpells = TRUE
	local AllSpells = FALSE
	local onlyVocation = {1,5, 'Sorcerers'}
	-- 1,5 Sorcerer
	-- 2,6 Druid
	-- 3,7 Paladin
	-- 4 Knight
    local spells = {
	[2285] = { buy = 300, spell = "Poison Field Rune", name = "Level 014: ", vocations = {1,2,5,6}, level = 14, premium = 0},
	[2301] = { buy = 500, spell = "Fire Field Rune", name = "Level 015: ", vocations = {1,2,5,6}, level = 15, premium = 0},
	[2266] = { buy = 600, spell = "Cure Poison Rune", name = "Level 015: ", vocations = {2,6}, level = 15, premium = 0},
	[2265] = { buy = 600, spell = "Intense Healing Rune", name = "Level 015: ", vocations = {2,6}, level = 15, premium = 0},
	[2287] = { buy = 500, spell = "Light Magic Missile Rune", name = "Level 015: ", vocations = {1,2,5,6}, level = 15, premium = 0},
	[2290] = { buy = 800, spell = "Convince Creature Rune", name = "Level 016: ", vocations = {2,6}, level = 16, premium = 0},
	[2261] = { buy = 700, spell = "Destroy Field Rune", name = "Level 017: ", vocations = {1,2,3,5,6,7}, level = 17, premium = 0},
	[2277] = { buy = 700, spell = "Energy Field Rune", name = "Level 018: ", vocations = {1,2,5,6}, level = 18, premium = 0},
	[2310] = { buy = 900, spell = "Desintegrate Rune", name = "Level 021: ", vocations = {1,2,3,5,6,7}, level = 21, premium = 1},
	[2292] = { buy = 1400, spell = "Stalagmite Rune", name = "Level 024: ", vocations = {1,2,5,6}, level = 24, premium = 0},
	[2273] = { buy = 1500, spell = "Ultimate Healing Rune", name = "Level 024: ", vocations = {2,6}, level = 24, premium = 0},
	[2311] = { buy = 1500, spell = "Heavy Magic Missile Rune", name = "Level 025: ", vocations = {1,2,5,6}, level = 25, premium = 0},
	[2286] = { buy = 1000, spell = "Poison Bomb Rune", name = "Level 025: ", vocations = {2,6}, level = 25, premium = 1},
	[2302] = { buy = 1600, spell = "Fireball Rune", name = "Level 027: ", vocations = {1,5}, level = 27, premium = 1},
	[2305] = { buy = 1500, spell = "Fire Bomb Rune", name = "Level 027: ", vocations = {1,2,5,6}, level = 27, premium = 0},
	[2291] = { buy = 1300, spell = "Chameleon Rune", name = "Level 027: ", vocations = {2,6}, level = 27, premium = 0},
	[2316] = { buy = 1200, spell = "Animate Dead Rune", name = "Level 027: ", vocations = {1,2,5,6}, level = 27, premium = 1},
	[2295] = { buy = 1600, spell = "Holy Missile Rune", name = "Level 027: ", vocations = {3,7}, level = 27, premium = 1},
	[2308] = { buy = 1800, spell = "Soulfire Rune", name = "Level 027: ", vocations = {1,2,5,6}, level = 27, premium = 1},
	[2269] = { buy = 2000, spell = "Wild Growth Rune", name = "Level 027: ", vocations = {6}, level = 27, premium = 1},
	[2271] = { buy = 1700, spell = "Icicle Rune", name = "Level 028: ", vocations = {2,6}, level = 28, premium = 1},
	[2288] = { buy = 1100, spell = "Stone Shower Rune", name = "Level 028: ", vocations = {2,6}, level = 28, premium = 1},
	[2315] = { buy = 1100, spell = "Thunderstorm Rune", name = "Level 028: ", vocations = {1,5}, level = 28, premium = 1},
	[2289] = { buy = 1600, spell = "Poison Wall Rune", name = "Level 029: ", vocations = {1,2,5,6}, level = 29, premium = 1},
	[2304] = { buy = 1200, spell = "Great Fireball Rune", name = "Level 030: ", vocations = {1,5}, level = 30, premium = 0},
	[2274] = { buy = 1200, spell = "Avalanche Rune", name = "Level 030: ", vocations = {2,6}, level = 30, premium = 0},
	[2313] = { buy = 1800, spell = "Explosion Rune", name = "Level 031: ", vocations = {1,2,5,6}, level = 31, premium = 0},
	[2293] = { buy = 2100, spell = "Magic Wall Rune", name = "Level 032: ", vocations = {1,5}, level = 32, premium = 1},
	[2303] = { buy = 2000, spell = "Fire Wall Rune", name = "Level 033: ", vocations = {1,2,5,6}, level = 33, premium = 0},
	[2262] = { buy = 2300, spell = "Energy Bomb Rune", name = "Level 037: ", vocations = {1,5}, level = 37, premium = 1},
	[2279] = { buy = 2500, spell = "Energy Wall Rune", name = "Level 041: ", vocations = {1,2,5,6}, level = 41, premium = 1},
	[2268] = { buy = 3000, spell = "Sudden Death Rune", name = "Level 045: ", vocations = {1,5}, level = 45, premium = 0},
	[2278] = { buy = 1900, spell = "Paralyze Rune", name = "Level 054: ", vocations = {2,6}, level = 54, premium = 1},
	}
    local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		if not getPlayerLearnedInstantSpell(cid, spells[item].spell) then
			if getPlayerLevel(cid) >= spells[item].level then
				if isInArray(spells[item].vocations, getPlayerVocation(cid)) then
					if getPlayerMoney(cid) >= spells[item].buy then
						doPlayerRemoveMoney(cid, spells[item].buy)
						playerLearnInstantSpell(cid, spells[item].spell)
						doSendMagicEffect(getPlayerPosition(cid), 12)
						selfSay("Du hast " .. spells[item].spell .. " gelernt.", cid)
					else
						selfSay("Du hast nicht genug Geld.", cid)
					end
				else
					selfSay("Dieser Rune Spell ist nicht für deine Vocation.", cid)
				end
			else
				selfSay("Du brauchst Level " .. spells[item].level .. " oder höher um diesen Rune Spell zu lernen.", cid)
			end
		else
			selfSay("Du kannst diesen Rune Spell bereits.", cid)
		end
		return true
	end
 
	if msgcontains(msg, 'spells') then
		if isInArray(onlyVocation, getPlayerVocation(cid)) or onlyVocation == FALSE then
			selfSay("Hier sind die Rune Spells, die du von mir lernen kannst.", cid)
			for var, item in pairs(spells) do
				if (not getPlayerLearnedInstantSpell(cid, item.spell) and getPlayerLevel(cid) >= item.level and isInArray(item.vocations, getPlayerVocation(cid)) and (item.premium == 1 and PremiumSpells == TRUE or item.premium == 0)) or AllSpells == TRUE then
					table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name .. '' .. item.spell})
				end
			end
			openShopWindow(cid, shopWindow, onBuy, onSell)
		else
			selfSay("Sorry, aber ich verkaufe Rune Spells nur an " .. Vocations[3], cid)
		end
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
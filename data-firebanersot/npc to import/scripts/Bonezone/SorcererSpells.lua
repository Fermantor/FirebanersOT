local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)                 npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                             npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'health potion'}, 7618, 45, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 50, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 100, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 80, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 190, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 120, 1, 'great mana potion')
shopModule:addBuyableItem({'great spirit'}, 8472, 190, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 310, 1, 'ultimate health potion')


shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 5, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 5, 'empty great potion flask')
shopModule:addSellableItem({'vial'},2006, 5, 'vial')

 
function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

	local shopWindow = {}
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	local PremiumSpells = TRUE
	local AllSpells = FALSE
	local onlyVocation = {1,5,'Sorcerers.'}
	-- 1,5 Sorcerer
	-- 2,6 Druid
	-- 3,7 Paladin
	-- 4,8 Knight
    local spells = {
	[8704] = { buy = 170, spell = "Light Healing", name = "Level 008: Light Healing", vocations = {1,2,3,5,6,7}, level = 8, premium = 0},
	[7618] = { buy = 300, spell = "Wound Cleansing", name = "Level 008: Wound Cleansing", vocations = {4,8}, level = 8, premium = 0},
	[2120] = { buy = 200, spell = "Magic Rope", name = "Level 009: Magic Rope", vocations = {1,2,3,4,5,6,7,8}, level = 9, premium = 1},
	[10092] = { buy = 150, spell = "Cure Poison", name = "Level 010: Cure Poison", vocations = {1,2,3,4,5,6,7,8}, level = 10, premium = 0},
	[2287] = { buy = 800, spell = "Energy Strike", name = "Level 012: Energy Strike", vocations = {1,2,5,6}, level = 12, premium = 1},
	[1386] = { buy = 500, spell = "Levitate", name = "Level 012: Levitate", vocations = {1,2,3,4,5,6,7,8}, level = 12, premium = 1},
	[2051] = { buy = 500, spell = "Great Light", name = "Level 013: Great Light", vocations = {1,2,3,4,5,6,7,8}, level = 13, premium = 0},
	[2544] = { buy = 450, spell = "Conjure Arrow", name = "Level 013: Conjure Arrow", vocations = {3,7}, level = 13, premium = 0},
	[1490] = { buy = 800, spell = "Terra Strike", name = "Level 013: Terra Strike", vocations = {1,2,5,6}, level = 13, premium = 1},
	[2169] = { buy = 600, spell = "Haste", name = "Level 014: Haste", vocations = {1,2,3,4,5,6,7,8}, level = 14, premium = 1},
	[1489] = { buy = 800, spell = "Flame Strike", name = "Level 014: Flame Strike", vocations = {1,2,5,6}, level = 14, premium = 1},
	[2671] = { buy = 300, spell = "Food", name = "Level 014: Food", vocations = {2,6}, level = 14, premium = 0},
	[2523] = { buy = 450, spell = "Magic Shield", name = "Level 014: Magic Shield", vocations = {1,2,5,6}, level = 14, premium = 0},
	[6683] = { buy = 800, spell = "Ice Strike", name = "Level 015: Ice Strike", vocations = {1,2,5,6}, level = 15, premium = 1},
	[2383] = { buy = 1000, spell = "Brutal Strike", name = "Level 016: Brutal Strike", vocations = {4,8}, level = 16, premium = 1},
	[2545] = { buy = 700, spell = "Conjure Poisoned Arrow", name = "Level 016: Conjure Poisoned Arrow", vocations = {3,7}, level = 16, premium = 0},
	[6300] = { buy = 800, spell = "Death Strike", name = "Level 016: Death Strike", vocations = {1,5}, level = 16, premium = 1},
	[2376] = { buy = 800, spell = "Physical Strike", name = "Level 016: Physical Strike", vocations = {2,6}, level = 16, premium = 1},
	[2543] = { buy = 750, spell = "Conjure Bolt", name = "Level 017: Conjure Bolt", vocations = {3,7}, level = 17, premium = 1},
	[7488] = { buy = 800, spell = "Heal Friend", name = "Level 018: Heal Friend", vocations = {2,6}, level = 18, premium = 1},
	[1487] = { buy = 850, spell = "Fire Wave", name = "Level 018: Fire Wave", vocations = {1,5}, level = 18, premium = 0},
	[6684] = { buy = 850, spell = "Ice Wave", name = "Level 018: Ice Wave", vocations = {2,6}, level = 18, premium = 0},
	[5787] = { buy = 2000, spell = "Challenge", name = "Level 020: Challenge", vocations = {8}, level = 20, premium = 1},
	[2265] = { buy = 350, spell = "Intense Healing", name = "Level 020: Intense Healing", vocations = {1,2,3,5,6,7}, level = 20, premium = 0},
	[2206] = { buy = 1300, spell = "Strong Haste", name = "Level 020: Strong Haste", vocations = {1,2,5,6}, level = 20, premium = 1},
	[1504] = { buy = 1000, spell = "Cure Electrification", name = "Level 022: Cure Electrification", vocations = {2,6}, level = 22, premium = 1},
	[2389] = { buy = 1100, spell = "Ethereal Spear", name = "Level 023: Ethereal Spear", vocations = {3,7}, level = 23, premium = 1},
	[5024] = { buy = 1000, spell = "Energy Beam", name = "Level 023: Energy Beam", vocations = {1,5}, level = 23, premium = 0},
	[13929] = { buy = 1000, spell = "Creature Illusion", name = "Level 023: Creature Illusion", vocations = {1,2,5,6}, level = 23, premium = 0},
	[7364] = { buy = 800, spell = "Conjure Sniper Arrow", name = "Level 024: Conjure Sniper Arrow", vocations = {3,7}, level = 24, premium = 1},
	[2546] = { buy = 1000, spell = "Conjure Explosive Arrow", name = "Level 025: Conjure Explosvie Arrow", vocations = {3,7}, level = 25, premium = 0},
	[2195] = { buy = 1300, spell = "Charge", name = "Level 025: Charge", vocations = {4,8}, level = 25, premium = 1},
	[9007] = { buy = 2000, spell = "Summon Creature", name = "Level 025: Summon Creature", vocations = {1,2,5,6}, level = 25, premium = 0},
	[2202] = { buy = 1600, spell = "Cancel Invisibility", name = "Level 026: Cancel Invvisibility", vocations = {3,7}, level = 26, premium = 1},
	[2308] = { buy = 1500, spell = "Ignite", name = "Level 026: Ignite", vocations = {1,5}, level = 26, premium = 0},
	[2163] = { buy = 1600, spell = "Ultimate Light", name = "Level 026: Ultimate Light", vocations = {1,2,5,6}, level = 26, premium = 1},
	[13883] = { buy = 1500, spell = "Whirlwind Throw", name = "Level 028: Whirlwind Throw", vocations = {4,8}, level = 28, premium = 1},
	[2315] = { buy = 1800, spell = "Great Energy Beam", name = "Level 029: Great Energy Beam", vocations = {1,5}, level = 29, premium = 0},
	[8474] = { buy = 2000, spell = "Cure Burning", name = "Level 030: Cure Burning", vocations = {2,6}, level = 30, premium = 1},
	[2273] = { buy = 1000, spell = "Ultimate Healing", name = "Level 030: Ultimate Healing", vocations = {1,2,5,6}, level = 30, premium = 0},
	[18492] = { buy = 4000, spell = "Enchant Party", name = "Level 032: Enchant Party", vocations = {1,5}, level = 32, premium = 1},
	[18491] = { buy = 4000, spell = "Protect Party", name = "Level 032: Protect Party", vocations = {3,7}, level = 32, premium = 1},
	[18489] = { buy = 4000, spell = "Heal Party", name = "Level 032: Heal Party", vocations = {2,6}, level = 32, premium = 1},
	[18490] = { buy = 4000, spell = "Train Party", name = "Level 032: Train Party", vocations = {4,8}, level = 32, premium = 1},
	[1505] = { buy = 1500, spell = "Groundshaker", name = "Level 033: Groundshaker", vocations = {4,8}, level = 33, premium = 1},
	[7363] = { buy = 850, spell = "Conjure Piercing Bolt", name = "Level 033: Conjure Piercing Bolt", vocations = {3,7}, level = 33, premium = 1},
	[1491] = { buy = 2500, spell = "Electrify", name = "Level 034: Electrify", vocations = {1,5}, level = 34, premium = 1},
	[7588] = { buy = 3000, spell = "Divine Healing", name = "Level 035: Divine Healing", vocations = {3,7}, level = 35, premium = 0},
	[2393] = { buy = 2500, spell = "Berserk", name = "Level 035: Berserk", vocations = {4,8}, level = 35, premium = 1},
	[2165] = { buy = 2000, spell = "Invisibility", name = "Level 035: Invisibility", vocations = {1,2,5,6}, level = 35, premium = 0},
	[8919] = { buy = 2200, spell = "Mass Healing", name = "Level 036: Mass Healing", vocations = {2,6}, level = 36, premium = 1},
	[2279] = { buy = 2500, spell = "Energy Wave", name = "Level 038: Energy Wave", vocations = {1,5}, level = 38, premium = 0},
	[2289] = { buy = 2500, spell = "Terra Wave", name = "Level 038: Terra Wave", vocations = {2,6}, level = 38, premium = 0},
	[2295] = { buy = 1800, spell = "Divine Missile", name = "Level 040: Divine Missile", vocations = {3,7}, level = 40, premium = 1},
	[1903] = { buy = 2500, spell = "Inflict Wound", name = "Level 040: Inflict Wound", vocations = {4,8}, level = 40, premium = 1},
	[671] = { buy = 7500, spell = "Strong Ice Wave", name = "Level 040: Strong Ice Wave", vocations = {2,6}, level = 40, premium = 1},
	[2433] = { buy = 2000, spell = "Enchant Staff", name = "Level 041: Enchant Staff", vocations = {5}, level = 41, premium = 1},
	[7367] = { buy = 2000, spell = "Enchant Spear", name = "Level 045: Enchant Spear", vocations = {3,7}, level = 45, premium = 1},
	[6558] = { buy = 2500, spell = "Cure Bleeding", name = "Level 045: Cure Bleeding", vocations = {2,4,6,8}, level = 45, premium = 1},
	[2298] = { buy = 3000, spell = "Divine Caldera", name = "Level 050: Divine Caldera", vocations = {3,7}, level = 50, premium = 1},
	[1496] = { buy = 6000, spell = "Envenom", name = "Level 050: Envenom", vocations = {2,6}, level = 50, premium = 1},
	[6132] = { buy = 4000, spell = "Recovery", name = "Level 050: Recovery", vocations = {3,4,7,8}, level = 50, premium = 1},
	[8920] = { buy = 6000, spell = "Rage of the Skies", name = "Level 055: Rage of the Skies", vocations = {1,5}, level = 55, premium = 1},
	[2522] = { buy = 6000, spell = "Protector", name = "Level 055: Protector", vocations = {4,8}, level = 55, premium = 1},
	[2309] = { buy = 5000, spell = "Lightning", name = "Level 055: Lightning", vocations = {1,5}, level = 55, premium = 1},
	[11303] = { buy = 6000, spell = "Swift Foot", name = "Level 055: Swift Foot", vocations = {3,7}, level = 55, premium = 1},
	[4208] = { buy = 6000, spell = "Wrath of Nature", name = "Level 055: Wrath of Nature", vocations = {2,6}, level = 55, premium = 1},
	[2547] = { buy = 2000, spell = "Conjure Power Bolt", name = "Level 059: Conjure Power Bolt", vocations = {7}, level = 59, premium = 1},
	[9110] = { buy = 8000, spell = "Eternal Winter", name = "Level 060: Eternal Winter", vocations = {2,6}, level = 60, premium = 1},
	[7416] = { buy = 8000, spell = "Blood Rage", name = "Level 060: Blood Rage", vocations = {4,8}, level = 60, premium = 1},
	[2187] = { buy = 8000, spell = "Hell's Core", name = "Level 060: Hell's Core", vocations = {1,5}, level = 60, premium = 1},
	[7591] = { buy = 8000, spell = "Salvation", name = "Level 060: Salvation", vocations = {3,7}, level = 60, premium = 1},
	[5777] = { buy = 8000, spell = "Sharpshooter", name = "Level 060: Sharpshooter", vocations = {3,7}, level = 60, premium = 1},
	[8930] = { buy = 4000, spell = "Front Sweep", name = "Level 070: Front Sweep", vocations = {4,8}, level = 70, premium = 1},
	[2300] = { buy = 7500, spell = "Holy Flash", name = "Level 070: Holy Flash", vocations = {3,7}, level = 70, premium = 1},
	[8062] = { buy = 6000, spell = "Strong Terra Strike", name = "Level 070: Strong Terra Strike", vocations = {2,6}, level = 70, premium = 1},
	[1492] = { buy = 6000, spell = "Strong Flame Strike", name = "Level 070: Strong Flame Strike", vocations = {1,5}, level = 70, premium = 1},
	[2268] = { buy = 6000, spell = "Curse", name = "Level 075: Curse", vocations = {1,5}, level = 75, premium = 1},
	[6301] = { buy = 6000, spell = "Cure Curse", name = "Level 080: Cure Curse", vocations = {3,7}, level = 80, premium = 1},
	[8473] = { buy = 6000, spell = "Intense Wound Cleansing", name = "Level 080: Intense Wound Cleansing", vocations = {4,8}, level = 80, premium = 1},
	[6686] = { buy = 6000, spell = "Strong Ice Strike", name = "Level 080: Strong Ice Strike", vocations = {2,6}, level = 80, premium = 1},
	[2311] = { buy = 7500, spell = "Strong Energy Strike", name = "Level 080: Strong Energy Strike", vocations = {1,5}, level = 80, premium = 1},
	[2421] = { buy = 7500, spell = "Fierce Berserk", name = "Level 090: Fierce Berserk", vocations = {4,8}, level = 90, premium = 1},
	[7378] = { buy = 10000, spell = "Strong Ethereal Spear", name = "Level 090: Strong Ethereal Spear", vocations = {3,7}, level = 90, premium = 1},
	[7465] = { buy = 15000, spell = "Ultimate Flame Strike", name = "Level 090: Ultimate Flame Strike", vocations = {1,5}, level = 90, premium = 1},
	[12334] = { buy = 15000, spell = "Ultimate Terra Strike", name = "Level 090: Ultimate Terra Strike", vocations = {2,6}, level = 90, premium = 1},
	[2640] = { buy = 10000, spell = "Intense Recovery", name = "Level 100: Intense Recovery", vocations = {3,4,7,8}, level = 100, premium = 1},
	[10547] = { buy = 15000, spell = "Ultimate Energy Strike", name = "Level 100: Ultimate Energy Strike", vocations = {1,5}, level = 100, premium = 1},
	[2271] = { buy = 15000, spell = "Ultimate Ice Strike", name = "Level 100: Ultimate Ice Strike", vocations = {2,6}, level = 100, premium = 1},
	[2390] = { buy = 20000, spell = "Annihilation", name = "Level 110: Annihilator", vocations = {4,8}, level = 110, premium = 1},
	}
    local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		selfSay("Du hast den Spell " .. spells[item].spell .. " ausgesucht, der " .. spells[item].buy .. " Gold kostet.", cid)
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
					selfSay("Dieser Spell ist nicht f�r deine Vocation.", cid)
				end
			else
				selfSay("Du brauchst Level " .. spells[item].level .. " oder h�her, um diesen Spell zu lernen.", cid)
			end
		else
			selfSay("Du kannst diesen Spell bereits.", cid)
		end
		return true
	end
 
	if msgcontains(msg, 'spells') then
		if isInArray(onlyVocation, getPlayerVocation(cid)) or onlyVocation == FALSE then
			selfSay("Hier sind die Spells, die du von mir lernen kannst.", cid)
			for var, item in pairs(spells) do
				if (not getPlayerLearnedInstantSpell(cid, item.spell) and getPlayerLevel(cid) >= item.level and isInArray(item.vocations, getPlayerVocation(cid)) and (item.premium == 1 and PremiumSpells == TRUE or item.premium == 0)) or AllSpells == TRUE then
					table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name})
				end
			end
			openShopWindow(cid, shopWindow, onBuy, onSell)
		else
			selfSay("Sorry, aber ich verkaufe Spells nur an " .. onlyVocation[3], cid)
		end
	elseif msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		selfSay({'Och wie nett. Naja, ich bin l�ngst nicht so gut wie {Majux}, aber ich kann schon einiges. Im Grunde genommen braue ich nur {Potions}, aber darin werde ich immer besser. ...',
						'Kennst du {Striphin}? Sie ist die Gute Hexe der Natur von Bonezone. Ich kaufe bei ihr meine Zutaten. Sie wohnt tief in einer H�hle gleich �ber der Stadt. ...',
						'Au�erdem ist sie die Schwester von {Hepzibah}, die B�se Hexe der Monster von Bonezone. Upps, hab ich schon wieder zu viel geredet? Tut mir leid. Bl�de Gewohneit.'},cid)
	elseif msgcontains(msg, 'potions') then
		selfSay('Haha, du willst etwas �ber meine Potions h�ren, nicht? Gelernt habe ich das alles von {Majux}, dem gr��ten Alchemisten von Fireban. Nachdem ich meine Zutaten von {Striphin} kriege, braue ich dann eine Nacht lang durch. Also, frag doch nach einem {trade} und kauf ein paar frische Potions.', cid)
	elseif msgcontains(msg, 'majux') then
		selfSay('Er lebt in Pulgra und braut dort die besten Potions von Fireban. Manchmal kaufe ich selber noch bei ihm ein. Statte ihm doch mal einen Besuch ab. Ich bin mir sicher, er w�rde sich freuen.', cid)
	elseif msgcontains(msg, 'striphin') then
		selfSay({'Oh ja, nach ihr fragen alle Kunden. Sie ist die Wei�e Hexe und k�mmert sich um die Natur in und um Bonezone. Ab und zu kommt sie aus ihrer H�hle und stattet uns allen einen Besuch ab. ...',
						'Und dann f�ttert sie die Tiere und d�ngt die Pflanzen hier oben mit ihren magischen Kr�utern und ihren geheimnisvollen D�ngermitteln. Das ist wirklich pure Zauberei. ...',
						'Sie ist sehr nett, wei�t du? Sie ist die Schwester von {Hepzibah}. Wenn du stark genug bist die vielen starken Kreaturen, die in ihrer H�hle leben, zu besiegen, dann solltest du unbedingt mal zu Striphin gehen..'},cid)
	elseif msgcontains(msg, 'hepzibah') then
		selfSay({'Ich f�rchte mich von ihr zu reden, aber wenn du es unbedingt h�ren willst: Sie ist die Schwarze Hexe von Bonezone und vermehrt alle Monster auf Fireban. Das ist der Grund, warum sie nie aussterben, warum sie nie aufh�ren zur�ckzukehren. ...',
						'Manchmal l�sst sie die dunkelsten Kreaturen erwachen, die dann mehrere Tage lang fuchtbar schreien und w�ten. Doch die H�hlen, in denen diese Monster leben, sind unheimlich gef�hrlich und fast nicht zu erreichen. ...',
						'Es gibt nur B�cher dar�ber, aber keiner hat es je geschafft, sie zu t�ten. Wer wei�, vielleicht bist du ja der jenige, der uns eines Tages von diesen Qualen befreien wird. Frag Striphin ob du ihr helfen kannst. Sie versucht schon seit Jahren sie zu besiegen. Zwing mich aber nie wieder, von Hepzibah zu reden. Wir haben alle Angst vor ihr.'},cid)
	elseif msgcontains(msg, 'vial') then
		selfSay('Vials? Die kannst du bei Xantharus in Little Cotton kaufen. Wei�t du, dem Bereich unter Bonezone. Er ist wirklich nett und so. Einmal hat er mir geholfen, meine Flaschen f�r die Vials... Ich glaube ich schweife schon wieder ab. Es tut mir leid.', cid)
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local townState = {}
local vocationState = {}
local talkState = {}
local townPosition = 
{
	[2] = {x = 2069, y = 2086, z = 6},
	[3] = {x = 2785, y = 1691, z = 6}
}
local itemSet = 
{
	[1] =	{
				{8820, 1}, -- Mage Hat
				{8819, 1}, -- Magician's Robe
				{2175, 1}, -- Spellbook
				{2190, 1}, -- Wand of Vortex
				{7620, 5}, -- Mana Potion
				{2152, 5} -- 5 Platinum Coins
			},
	[2] =	{
				{8820, 1}, -- Mage Hat
				{8819, 1}, -- Magician's Robe
				{2175, 1}, -- Spellbook
				{2182, 1}, -- Snakebite Rod
				{7620, 5}, -- Mana Potion
				{2152, 5} -- 5 Platinum Coins
			},
	[3] =	{
				{8923, 1}, -- Ranger Legs
				{2660, 1}, -- Ranger's Cloak
				{2456, 1}, -- Bow
				{2544, 50}, -- Arrows
				{2389, 5}, -- Spears
				{7618, 5}, -- Health Potion
				{2152, 5} -- 5 Platinum Coins
			},
	[4] =	{
				{2481, 1}, -- Soldier Helmet
				{2465, 1}, -- Brass Armor
				{2478, 1}, -- Brass Legs
				{2509, 1}, -- Steel Shield
				{7618, 5}, -- Health Potion
				{8602, 1}, -- Jagged Sword
				{2152, 5} -- 5 Platinum Coins
			}
 }

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(not npcHandler:isFocused(cid)) then
		talkState[talkUser] = 0
		return false
	end
	if talkState[talkUser] == 1 then
		if msgcontains(msg, 'knight') then
			npcHandler:say('EIN STARKER KNIGHT ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 2
		elseif msgcontains(msg, 'druid') then
			npcHandler:say('EIN WEISER DRUID ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 3
		elseif msgcontains(msg, 'sorcerer') then
			npcHandler:say('EIN MÄCHTIGER ZAUBERER ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 4
		elseif msgcontains(msg, 'paladin') then
			npcHandler:say('EIN PRÄZISER PALADIN ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('ICH FRAGTE, WELCHEN BERUF WILLST DU ERLERNEN? {KNIGHT}, {SORCERER}, {DRUID} ODER {PALADIN}?', cid)
			talkState[talkUser] = 1
		end
	elseif talkState[talkUser] == 2 then
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			vocationState[talkUser] = 4
			if getPlayerPremiumDays(cid) >= 1 then
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA} ODER {BONEZONE}?', cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA}?', cid)
				talkState[talkUser] = 6
			end
		else
			npcHandler:say('ICH SAGTE, EIN STARKER KNIGHT ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 2
		end
	elseif talkState[talkUser] == 3 then
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			vocationState[talkUser] = 2
			if getPlayerPremiumDays(cid) >= 1 then
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA} ODER {BONEZONE}?', cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA}?', cid)
				talkState[talkUser] = 6
			end
		else
			npcHandler:say('ICH SAGTE, EIN STARKER KNIGHT ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 3
		end
	elseif talkState[talkUser] == 4 then
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			vocationState[talkUser] = 1
			if getPlayerPremiumDays(cid) >= 1 then
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA} ODER {BONEZONE}?', cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA}?', cid)
				talkState[talkUser] = 6
			end
		else
			npcHandler:say('ICH SAGTE, EIN STARKER KNIGHT ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 4
		end
	elseif talkState[talkUser] == 5 then
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			vocationState[talkUser] = 3
			if getPlayerPremiumDays(cid) >= 1 then
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA} ODER {BONEZONE}?', cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('SO WIRST DU DER STÄRKSTE KNIGHT WERDEN, DEN DIE WELT JE GESEHEN HAT. IN WELCHER STADT WILLST DU LEBEN? {PULGRA}?', cid)
				talkState[talkUser] = 6
			end
		else
			npcHandler:say('ICH SAGTE, EIN STARKER KNIGHT ALSO? BIST DU DIR GANZ SICHER, DIESE ENTSCHEIDUNG KANNST DU NICHT RÜCKGÄNGIG MACHEN!', cid)
			talkState[talkUser] = 5
		end
	elseif talkState[talkUser] == 6 then
		if msgcontains(msg, 'pulgra') then
			townState[talkUser] = 2
			npcHandler:say('ALSO PULGRA, BIST DU BEREIT ENDGÜLTIG LOSZUREISEN?', cid)
			talkState[talkUser] = 7
		elseif msgcontains(msg, 'bonezone') then
			if getPlayerPremiumDays(cid) >= 1 then
				townState[talkUser] = 3
				npcHandler:say('ALSO BONEZONE, BIST DU BEREIT ENDGÜLTIG LOSZUREISEN?', cid)
				talkState[talkUser] = 7
			else
				npcHandler:say('ES IST NUR PREMIUM SPIELERN ERLAUBT DIESE STADT ZU BEREISEN. ALSO WOHIN WILLST DU? {PULGRA}', cid)
				talkState[talkUser] = 6
			end
		else
			if getPlayerPremiumDays(cid) >= 1 then
				npcHandler:say('IN WELCHER STADT WILLST DU LEBEN? {PULGRA} ODER {BONEZONE}?', cid)
				talkState[talkUser] = 6
			else
				npcHandler:say('IN WELCHER STADT WILLST DU LEBEN? {PULGRA}?', cid)
				talkState[talkUser] = 6
			end
		end
	elseif talkState[talkUser] == 7 then
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			npcHandler:say('SO SEI ES, VIEL GLÜCK AUF DEINER REISE!', cid)
			doPlayerSetVocation(cid,vocationState[talkUser])
			doPlayerSetTown(cid, townState[talkUser])
			doTeleportThing(cid, townPosition[townState[talkUser]], TRUE)
			doSendMagicEffect(getPlayerPosition(cid), 10)
			if townState[talkUser] == 3 then
				setPlayerStorageValue(54321, 1)
			end
			talkState[talkUser] = 0
			
			local text = ""
			if getPlayerVocation(cid) == 4 then
				text = "Ein Backpack mit deinem Startequipment wurde in das Depot dieser Stadt geschickt. Falls dir die Waffe nicht gefällt, kannst du sie bei einem Knight Guild NPC umtauschen. Frage einfach nach einem 'tausch'."
			else
				text = "Ein Backpack mit deinem Startequipment wurde in das Depot dieser Stadt geschickt."
			end
			doPlayerSendTextMessage(cid, 18, text)
			doPlayerAddDepotItems(cid, townState[talkUser], itemSet[getPlayerVocation(cid)], 1988, "Hier ist ein Startequipment für dich.")
		else
			npcHandler:say('BIST DU BEREIT ENDGÜLTIG LOSZUREISEN?', cid)
			talkState[talkUser] = 7
		end
		
	else
		if msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
			if getPlayerLevel(cid) <= 7 then
				npcHandler:say('DU BIST JA NOCH NICHTMALS LEVEL 8! WIE BIST DU ÜBERHAUPT HIER HOCH GEKOMMEN? VERSCHWINDE UND WERDE STÄRKER!', cid)
			elseif getPlayerLevel(cid) >= 10 then
				npcHandler:say('ES TUT MIR LEID, ABER MIT DEM LEVEL KANNST DU LEIDER NICHT MEHR RUNTER VON PANTRA! JETZT MUSST DU EWIG HIER BLEIBEN!', cid)
			else
				npcHandler:say('NUN GUT, WELCHEN BERUF WILLST DU ERLERNEN? {KNIGHT}, {SORCERER}, {DRUID} ODER {PALADIN}?', cid)
				talkState[talkUser] = 1
			end
		else
			npcHandler:say('ICH HABE DICH GEFRAGT, OB DU BEREIT BIST DER GEFAHR INS AUGE ZU SEHEN UND AUF DIE MAINWORLD ZU WECHSELN?', cid)
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

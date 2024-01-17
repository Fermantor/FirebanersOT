local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local Topic, count, transferTo_name = {}, {}, {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

local function getCount(string)
	local b, e = string:find('%d+')
	return b and e and tonumber(string:sub(b, e)) or -1
end
 
local function playerExists(name)
	local v, ret = db.getResult("SELECT `name` FROM `players` WHERE `name` = " .. db.escapeString(name) .. ";"), nil
	if v:getID() ~= -1 then
		ret = v:getDataString('name')
	end
	v:free()
	return ret
end
 
function greetCallback(cid)
	Topic[cid], count[cid], transferTo_name[cid] = 0, 0,0
	return true
end
 
function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, 'job') then
		npcHandler:say('Ich bin die {Bank} von Pulgra. Ich regel den ganzen Zahlungsverkehr und lager das Geld der Spieler.', cid)
	elseif msgcontains(msg, 'balance') or msgcontains(msg, 'kontostand') then
		npcHandler:say('Dein Kontostand beträgt ' .. getPlayerBalance(cid) .. ' Gold.', cid)
		Topic[cid] = 0
	elseif (msgcontains(msg, 'deposit') or msgcontains(msg, 'lagern')) and (msgcontains(msg, 'all') or msgcontains(msg, 'alles')) then
		if getPlayerMoney(cid) > 0 then
			count[cid] = getPlayerMoney(cid)
			npcHandler:say('Möchtest du wirklich ' .. count[cid] .. ' Gold einzahlen?', cid)
			Topic[cid] = 2
		else
			npcHandler:say('Bitte sag mir, wie viel Gold du einzahlen möchtest.', cid)
			Topic[cid] = 1
		end
	elseif msgcontains(msg, 'deposit') or msgcontains(msg, 'lagern') then
		if getCount(msg) == 0 then
			npcHandler:say('Du nimmst mich auf den Arm, oder??', cid)
			Topic[cid] = 0
		elseif getCount(msg) ~= -1 then
			if getPlayerMoney(cid) >= getCount(msg) then
				count[cid] = getCount(msg)
				npcHandler:say('Möchtest du wirklich ' .. count[cid] .. ' Gold einzahlen?', cid)
				Topic[cid] = 2
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				Topic[cid] = 0
			end
		else
			npcHandler:say('Bitte sag mir, wie viel Gold du einzahlen möchtest.', cid)
			Topic[cid] = 1
		end
	elseif Topic[cid] == 1 then
		if getCount(msg) == -1 then
			npcHandler:say('Bitte sag mir, wie viel Gold du einzahlen möchtest.', cid)
			Topic[cid] = 1
		else
			if getPlayerMoney(cid) >= getCount(msg) then
				count[cid] = getCount(msg)
				npcHandler:say('Möchtest du wirklich ' .. count[cid] .. ' Gold einzahlen?', cid)
				Topic[cid] = 2
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				Topic[cid] = 0
			end
		end
	elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'ja')) and Topic[cid] == 2 then
		if doPlayerRemoveMoney(cid, count[cid]) then
			doPlayerSetBalance(cid, getPlayerBalance(cid) + count[cid])
			npcHandler:say('Okay, wir haben ' .. count[cid] .. ' Gold deinem Konto hinzugefügt. Du kannst dein Geld jederzeit wieder abheben, wenn du willst.', cid)
		else
			npcHandler:say('Ich bin untröstlich, aber es sieht so aus, als ob du dein Gold verloren hast. Ich hoffe du bekommst es zurück.', cid)
		end
		Topic[cid] = 0
	elseif (msgcontains(msg, 'no') or msgcontains(msg, 'nein')) and Topic[cid] == 2 then
		npcHandler:say('Wie du meinst. Kann ich sonst noch etwas für dich tun?', cid)
		Topic[cid] = 0
	elseif msgcontains(msg, 'withdraw') or msgcontains(msg, 'abheben') then
		if getCount(msg) == 0 then
			npcHandler:say('Sicher, du willst nichts, also kriegst du auch nichts!', cid)
			Topic[cid] = 0
		elseif getCount(msg) ~= -1 then
			if getPlayerBalance(cid) >= getCount(msg) then
				count[cid] = getCount(msg)
				npcHandler:say('Bist du sicher, dass du ' .. count[cid] .. ' Gold von deinem Konto abheben willst?', cid)
				Topic[cid] = 4
			else
				npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
				Topic[cid] = 0
			end
		else
			npcHandler:say('Bitte sag mir, wie viel Gold du abheben willst?', cid)
			Topic[cid] = 3
		end
	elseif Topic[cid] == 3 then
		if getCount(msg) == -1 then
			npcHandler:say('Bitte sag mir, wie viel Gold du abheben willst?', cid)
			Topic[cid] = 3
		else
			if getPlayerBalance(cid) >= getCount(msg) then
				count[cid] = getCount(msg)
				npcHandler:say('Bist du sicher, dass du ' .. count[cid] .. ' Gold von deinem Konto abheben willst?', cid)
				Topic[cid] = 4
			else
				npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
				Topic[cid] = 0
			end
		end
	elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'ja')) and Topic[cid] == 4 then
		if getPlayerBalance(cid) >= count[cid] then
			doPlayerAddMoney(cid, count[cid])
			doPlayerSetBalance(cid, getPlayerBalance(cid) - count[cid])
			npcHandler:say('Hier bitte schön, ' .. count[cid] .. ' Gold. Bitte lass mich wissen, wenn ich sonst noch was für dich tun kann.', cid)
		else
			npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
		end
		Topic[cid] = 0
	elseif (msgcontains(msg, 'no') or msgcontains(msg, 'nein')) and Topic[cid] == 4 then
		npcHandler:say('Der Kunde ist König! Komm jederzeit wieder, wenn du Geld abheben willst.', cid)
		Topic[cid] = 0
	elseif msgcontains(msg, 'transfer') or msgcontains(msg, 'überweisen') then
		if getCount(msg) == 0 then
			npcHandler:say('Bitte, denk drüber nach, okay?', cid)
			Topic[cid] = 0
		elseif getCount(msg) ~= -1 then
			count[cid] = getCount(msg)
			if getPlayerBalance(cid) >= count[cid] then
				npcHandler:say('An wen willst du ' .. count[cid] .. ' Gold überweisen?', cid)
				Topic[cid] = 6
			else
				npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
				Topic[cid] = 0
			end
		else
			npcHandler:say('Bitte sag mir, wie viel Geld du überweisen willst.', cid)
			Topic[cid] = 5
		end
	elseif Topic[cid] == 5 then
		if getCount(msg) == -1 then
			npcHandler:say('Bitte sag mir, wie viel Geld du überweisen willst.', cid)
			Topic[cid] = 5
		else
			count[cid] = getCount(msg)
			if getPlayerBalance(cid) >= count[cid] then
				npcHandler:say('An wen willst du ' .. count[cid] .. ' Gold überweisen?', cid)
				Topic[cid] = 6
			else
				npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
				Topic[cid] = 0
			end
		end
	elseif Topic[cid] == 6 then
		local v = getPlayerByName(msg)
		if getPlayerBalance(cid) >= count[cid] then
			if v then
				transferTo_name[cid] = msg
				npcHandler:say('Möchtest du wirklich ' .. count[cid] .. ' Gold an ' .. getPlayerName(v) .. ' überweisen?', cid)
				Topic[cid] = 7
			elseif playerExists(msg):lower() == msg:lower() then
				transferTo_name[cid] = msg
				npcHandler:say('Möchtest du wirklich ' .. count[cid] .. ' Gold an ' .. getPlayerName(v) .. ' überweisen?', cid)
				Topic[cid] = 7
			else
				npcHandler:say('Dieser Spieler existiert nicht.', cid)
				Topic[cid] = 0
			end
		else
			npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
			Topic[cid] = 0
		end
	elseif Topic[cid] == 7 and (msgcontains(msg, 'yes') or msgcontains(msg, 'ja')) then
		if getPlayerBalance(cid) >= count[cid] then
			local v = getPlayerByName(transferTo_name[cid])
			if v then
				doPlayerSetBalance(cid, getPlayerBalance(cid) - count[cid])
				doPlayerSetBalance(v, getPlayerBalance(v) + count[cid])
				npcHandler:say('Alles klar. Du hast ' .. count[cid] .. ' Gold an ' .. getPlayerName(v) .. ' überwiesen.', cid)
			elseif playerExists(transferTo_name[cid]):lower() == transferTo_name[cid]:lower() then
				doPlayerSetBalance(cid, getPlayerBalance(cid) - count[cid])
				db.query('UPDATE `players` SET `balance` = `balance` + ' .. count[cid] .. ' WHERE `name` = ' .. db.escapeString(transferTo_name[cid]) .. ' LIMIT 1;')
				npcHandler:say('Very well. You have transferred ' .. count[cid] .. ' gold to ' .. playerExists(transferTo_name[cid]) .. '.', cid)
			else
				npcHandler:say('Dieser Spieler existiert nicht.', cid)
			end
		else
			npcHandler:say('Du hast nicht genug Geld auf deinem Konto.', cid)
		end
		Topic[cid] = 0
	elseif Topic[cid] == 7 and (msgcontains(msg, 'no') or msgcontains(msg, 'nein')) then
		npcHandler:say('Okay, kann ich sonst noch was für dich tun?', cid)
		Topic[cid] = 0
	elseif msgcontains(msg, 'change gold') or msgcontains(msg, 'tausche gold') then
		npcHandler:say('Wie viele Platin Münzen willst du kriegen?', cid)
		Topic[cid] = 8
	elseif Topic[cid] == 8 then
		if getCount(msg) < 1 then
			npcHandler:say('Hmm, kann ich sonst noch was tun?', cid)
			Topic[cid] = 0
		else
			count[cid] = getCount(msg)
			npcHandler:say('Du willst also ' .. count[cid] * 100 .. ' von deinem Gold in ' .. count[cid] .. ' Platin Münzen umtauschen?', cid)
			Topic[cid] = 9
		end
	elseif Topic[cid] == 9 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
			if doPlayerRemoveItem(cid, 2148, count[cid] * 100) then
				npcHandler:say('Hier bitte schön.', cid)
				doPlayerAddItem(cid, 2152, count[cid])
			else
				npcHandler:say('Sorry, du hast nicht genug Gold Münzen.', cid)
			end
		else
			npcHandler:say('Na gut, kann ich dir sonst irgenwie helfen?', cid)
		end
		Topic[cid] = 0
	elseif msgcontains(msg, 'change platinum') or msgcontains(msg, 'tausche platin') then
		npcHandler:say('Möchtest du deine Platin Münzen in Gold oder Crystal tauschen?', cid)
		Topic[cid] = 10
	elseif Topic[cid] == 10 then
		if msgcontains(msg, 'gold') then
			npcHandler:say('`Wie viele Platin Münzen willst du in Gold umtauschen?', cid)
			Topic[cid] = 11
		elseif msgcontains(msg, 'crystal') then
			npcHandler:say('Wie viele Crystal Münzen willst du kriegen?', cid)
			Topic[cid] = 13
		else
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
			Topic[cid] = 0
		end
	elseif Topic[cid] == 11 then
		if getCount(msg) < 1 then
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
			Topic[cid] = 0
		else
			count[cid] = getCount(msg)
			npcHandler:say('Du willst also ' .. count[cid] .. ' Platin Münzen in ' .. count[cid] * 100 .. ' Gold Münzen Tauschen?', cid)
			Topic[cid] = 12
		end
	elseif Topic[cid] == 12 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
			if doPlayerRemoveItem(cid, 2152, count[cid]) then
				npcHandler:say('Hier bitte sehr.', cid)
				doPlayerAddItem(cid, 2148, count[cid] * 100)
			else
				npcHandler:say('Sorry, aber du hast nicht genug Platin Münzen.', cid)
			end
		else
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
		end
		Topic[cid] = 0
	elseif Topic[cid] == 13 then
		if getCount(msg) < 1 then
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
			Topic[cid] = 0
		else
			count[cid] = getCount(msg)
			npcHandler:say('Du willst also ' .. count[cid] * 100 .. ' Platin Münzen in ' .. count[cid] .. ' Crystal Münzen tauschen?', cid)
			Topic[cid] = 14
		end
	elseif Topic[cid] == 14 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
			if doPlayerRemoveItem(cid, 2152, count[cid] * 100) then
				npcHandler:say('Hier bitte sehr.', cid)
				doPlayerAddItem(cid, 2160, count[cid])
			else
				npcHandler:say('Sorry, aber du hast nicht genug Platin Münzen.', cid)
			end
		else
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
		end
		Topic[cid] = 0
	elseif msgcontains(msg, 'change crystal') or msgcontains(msg, 'tausche crystal') then
		npcHandler:say('Wie viele Crystal Münzen willst du in Platin umtauschen?', cid)
		Topic[cid] = 15
	elseif Topic[cid] == 15 then
		if getCount(msg) == -1 or getCount(msg) == 0 then
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
			Topic[cid] = 0
		else
			count[cid] = getCount(msg)
			npcHandler:say('Du willst also ' .. count[cid] .. ' Crystal Münzen in ' .. count[cid] * 100 .. ' Platin Münzen eintauschen?', cid)
			Topic[cid] = 16
		end
	elseif Topic[cid] == 16 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'ja') then
			if doPlayerRemoveItem(cid, 2160, count[cid]) then
				npcHandler:say('Hier bitte sehr.', cid)
				doPlayerAddItem(cid, 2152, count[cid] * 100)
			else
				npcHandler:say('Sorry, du hast nicht genug Crystal Münzen.', cid)
			end
		else
			npcHandler:say('Gut, kann ich dir mit was anderem behilflich sein?', cid)
		end
		Topic[cid] = 0
	elseif msgcontains(msg, 'change') or msgcontains(msg, 'tausch') then
		npcHandler:say('Es gibt drei verschiedene Münzen Typen in Tibia: 100 Gold Münzen sind 1 Platin Münze, 100 Platinum Münzen sind 1 Crystal Münze. Wenn du also 100 Gold in 1 Platin tauschen willst, sag einfach \'{change gold}\' und dann \'1 Platin\'.', cid)
		Topic[cid] = 0
	elseif msgcontains(msg, 'bank') then
		npcHandler:say('Wir {tauschen} Geld für dich. Du kannst außerdem deinen {Kontostand} einsehen, {lagern}, oder Geld {abheben}.', cid)
		Topic[cid] = 0
	end
	return TRUE
end
 
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
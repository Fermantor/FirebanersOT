local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'purple backpack'}, 2001, 15, 1,'purple backpack')
shopModule:addBuyableItem({'purple bag'}, 1994, 4, 1,'purple bag')
shopModule:addBuyableItem({'baking tray'}, 2561, 20, 1,'baking tray')
shopModule:addBuyableItem({'kitchen knife'}, 2566, 10, 1,'kitchen knife')

shopModule:addBuyableItem({'fishing'}, 2580, 30, 1,'fishing rod')
shopModule:addBuyableItem({'scythe'}, 2550, 30, 1,'scythe')
shopModule:addBuyableItem({'pan'}, 2563, 20, 1,'pan')
shopModule:addBuyableItem({'plate'}, 2035, 6, 1,'plate')
shopModule:addBuyableItem({'spoon'}, 2565, 10, 1,'spoon')

	

local Ernte = {
[1] = {id = 2682, preis = 150, min = 1, max = 1, typ = 2}, -- Melon
[2] = {id = 2686, preis = 100, min = 1, max = 2, typ = 2}, -- Corn
[3] = {id = 2684, preis = 75, min = 1, max = 3, typ = 2}, -- Carrot
[4] = {id = 2680, preis = 40, min = 1, max = 5, typ = 1}, -- Strawberry
[5] = {id = 2681, preis = 50, min = 1, max = 1, typ = 1}, -- Grapes
[6] = {id = 8838, preis = 50, min = 1, max = 2, typ = 2}, -- Potato
[7] = {id = 8840, preis = 40, min = 1, max = 5, typ = 1}, -- Raspberry
[8] = {id = 8842, preis = 150, min = 1, max = 1, typ = 2}, -- Cucumber
[9] = {id = 8843, preis = 75, min = 1, max = 2, typ = 2}, -- Onion
[10] = {id = 2685, preis = 75, min = 1, max = 3, typ = 1}, -- Tomato
[11] = {id = 8845, preis = 200, min = 1, max = 2, typ = 2}, -- Beetroot
[12] = {id = 2683, preis = 500, min = 1, max = 1, typ = 2}, -- Pumpkin
}

local Feld = {
[1] = {x = 2029, y = 2095, z = 7, stackpos = 255},
[2] = {x = 2029, y = 2096, z = 7, stackpos = 255}
}
function feldSauber(Item)
	local Pos = Feld[Ernte[Item].typ]
	for i = Pos.y, Pos.y + 2, 2 do
		for k = Pos.x, Pos.x + 6 do
			local Posi = {x = k, y = i, z = 7, stackpos = 255}
			if isCreature(getThingfromPos(Posi).uid) ~= TRUE then
				while getThingfromPos(Posi).itemid ~= 0 do
					doRemoveItem(getThingfromPos(Posi).uid)
				end
			end
		end
	end
	return TRUE
end

function Ernten(Item)
	feldSauber(Item)
	local Pos = Feld[Ernte[Item].typ]
	for i = Pos.y, Pos.y + 2, 2 do
		for k = Pos.x, Pos.x + 6 do
			local Posi = {x = k, y = i, z = 7, stackpos = 255}
			if isCreature(getThingfromPos(Posi).uid) ~= TRUE then
				doCreateItem(Ernte[Item].id, math.random(Ernte[Item].min,Ernte[Item].max), Posi)
				doSendMagicEffect(Posi, 14)
			else
				doSendMagicEffect(Posi, CONST_ME_POFF)
			end
		end
	end
	setGlobalStorageValue(2679 + Ernte[Item].typ, -1)
	return TRUE
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Ike bin hier Farmer von Beruf. Brauchste \'n paar Tools, kann ik dir sicher auch weiter helfn\'. Schau ma auf\'n {trade} vorbei, oder wenn de magst, mach ich dir auch so\'n {Backpack}, oder {Hut}, wie ik den hab.',cid)
	elseif msgcontains(msg, 'addon') or msgcontains(msg, 'outfit') then
		npcHandler:say('Nun, wie de vielleicht sehn\' kannst, trag ik meine beste Arbeit am eigenen Leib. Der {Hut} und dat {Backpack} sind der Grund, warum ik in janz Pulgra bekannt bin.',cid)
	elseif msgcontains(msg, 'backpack') or msgcontains(msg, 'back pack') and getPlayerStorageValue(cid, 22001) == -1 then
		npcHandler:say('Ach du willst also auch so \'en Ding auf\'m Rücken tragen wat? Kann ik dir nich krum nehmen, mit dem Ding schaust\'e einfach gut aus. Bring mir einfach 100 Minotaur Leather und wir sin\' im Geschäft. Deal?',cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, 'hut') or msgcontains(msg, 'hat')) and getPlayerStorageValue(cid, 22002) == -1 then
		npcHandler:say('Der Hut is schon was hübsches, wa? Wenn du dir nich zu fein bist, mir ein paar Sachen dafür zu bringen, hast\'e bald auch so einen. Bist du dabei?' ,cid)
		talkState[talkUser] = 2
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') or msgcontains(msg, 'deal') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Also Deal! Jut. Dann komm wieder wenn de die 100 Mino\' Leathers hast.',cid)
			setPlayerStorageValue(cid, outfits.questLog, 1)
			setPlayerStorageValue(cid, outfits.citizenAddon1, 1)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Kluge Entscheidung von dir. Als erste brauch ich einen Legion Helmet. Kannste den besorgen, leg ik sofort los.',cid)
			setPlayerStorageValue(cid, outfits.questLog, 1)
			setPlayerStorageValue(cid, outfits.citizenAddon2, 1)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] >= 3 and talkState[talkUser] <= 13 then
			if doPlayerRemoveMoney(cid, Ernte[talkState[talkUser]-2].preis) == TRUE then
				npcHandler:say('Also jut, ich werde mit der Arbeit bejinnen. Komm in 15 Minuten wieder und hol dir die Ernte ab.',cid)
				setGlobalStorageValue(2679 + Ernte[talkState[talkUser]-2].typ, 1)
				feldSauber(talkState[talkUser]-2)
				addEvent(Ernten, 1000*15*60, talkState[talkUser]-2)
			else
				npcHandler:say('Et tut mir leid, aber du has\' nich jenug Jeld.',cid)
			end
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'minotaur leather') or msgcontains(msg, 'leather') then
		if getPlayerStorageValue(cid, outfits.citizenAddon1) == 1 then
			if getPlayerItemCount(cid, 5878) >= 100 then
				doPlayerRemoveItem(cid, 5878, 100)
				npcHandler:say('Wunderbar, dat Backpack hab ik im nu fertig... nur hier wat... und da... FERTIG. Hier hasse dein Exemplar. Hoffe et sagt dir zu und du kommst weiterhin bei mir einkaufen.', cid)
				setPlayerStorageValue(cid, outfits.citizenAddon1, 2)
				Player(cid):addOutfitAddon(136,1)
				Player(cid):addOutfitAddon(128,1)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_RED)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Also et müssen schon 100 Minotaur Leathers sein, sonst kann ich damit nichts anfangen.', cid)
				talkState[talkUser] = 0
			end
		end	
	elseif msgcontains(msg, 'legion helmet') then
		if getPlayerStorageValue(cid, outfits.citizenAddon2) == 1 then
			if doPlayerRemoveItem(cid, 2480, 1) == TRUE then
				npcHandler:say('Wunderbar, damit kann ik arbeiten. Als nächstes brauch ik ein paar Chicken Feathers. Sagen wa 100 Stück. Und damit das janze schön zusammen hält, noch ein bisschen Honig...', cid)
				npcHandler:say('50 Honeycombs sollten reichen. Bring mir die beiden Sach\'n und der Hut is im Nu fertig.', cid)
				setPlayerStorageValue(cid, outfits.citizenAddon2, 2)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Also ik weiß nicht, was du da hast, aber \'en Legion Helmet ist dat nich.', cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		end
	elseif msgcontains(msg, 'honeycomb') or msgcontains(msg, 'chicken feather') then
		if getPlayerStorageValue(cid, outfits.citizenAddon2) == 2 then
			if getPlayerItemCount(cid, 5902) >= 50 and getPlayerItemCount(cid, 5890) >= 100 then
				doPlayerRemoveItem(cid, 5902, 50)
				doPlayerRemoveItem(cid, 5890, 100)
				npcHandler:say('Oh wahnsinn, du hast alles beisammen. Warte, \'n bisschen hier und da, und ... Tadaaa, de\'n Hut is fertig. Bidde schön. Empfehle mich ruhig weiter.', cid)
				setPlayerStorageValue(cid, outfits.citizenAddon1, 3)
				Player(cid):addOutfitAddon(136,2)
				Player(cid):addOutfitAddon(128,2)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_RED)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('Et tut mir leid, aber du muss mir schon alles auf einmal bringen, vorher kann ik nich mit der Arbeit beginnen.', cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		end
	elseif msgcontains(msg, 'garten') or msgcontains(msg, 'pflanzen') or msgcontains(msg, 'anpflanzen') then
		npcHandler:say('Ik kann in meinem Garten allerlei tolle Sachen anpflanzen, jegen Bezahlung versteht sich. Ik hab {Melonen}, {Mais}, {Karotten}, {Erdbeeren}, {Trauben}, {Tomaten}, {Kartoffeln}, {Himbeeren}, {Gurken}, {Zwiebeln} und {Rote Beete}.', cid)
	elseif msgcontains(msg, 'melon') or msgcontains(msg, 'melonen') then -- Melon
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik ein paar Melonen für dich anpflanzen? Dat würde dich dann ' .. Ernte[1].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 3
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'corn') or msgcontains(msg, 'mais') then -- Corn
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik Mais für dich anpflanzen? Dat würde dich dann ' .. Ernte[2].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 4
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'carrot') or msgcontains(msg, 'karotten') then -- Carrot
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik ein paar Karotten für dich anpflanzen? Dat würde dich dann ' .. Ernte[3].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 5
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'strawberry') or msgcontains(msg, 'erdbeeren') then -- Strawberry
		if getGlobalStorageValue(2680) ~= 1 then
			npcHandler:say('Soll ik ein paar Erdbeeren für dich anpflanzen? Dat würde dich dann ' .. Ernte[4].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 6
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'grapes') or msgcontains(msg, 'trauben')then -- Grapes
		if getGlobalStorageValue(2680) ~= 1 then
			npcHandler:say('Soll ik ein paar Trauben für dich anpflanzen? Dat würde dich dann ' .. Ernte[5].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 7
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'potato') or msgcontains(msg, 'kartoffeln') then -- Potato
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik ein paar Kartoffeln für dich anpflanzen? Dat würde dich dann ' .. Ernte[6].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 8
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'rasperry') or msgcontains(msg, 'himbeeren') then -- Rasperry
		if getGlobalStorageValue(2680) ~= 1 then
			npcHandler:say('Soll ik ein paar Himbeeren für dich anpflanzen? Dat würde dich dann ' .. Ernte[7].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 9
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'cucumber') or msgcontains(msg, 'gurken') then -- Cucumber
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik ein paar Gurken für dich anpflanzen? Dat würde dich dann ' .. Ernte[8].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 10
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'onion') or msgcontains(msg, 'zwiebeln') then -- Onion
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik ein paar Zwiebeln für dich anpflanzen? Dat würde dich dann ' .. Ernte[9].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 11
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'tomato') or msgcontains(msg, 'tomaten') then -- Tomato
		if getGlobalStorageValue(2680) ~= 1 then
			npcHandler:say('Soll ik ein paar Tomaten für dich anpflanzen? Dat würde dich dann ' .. Ernte[10].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 12
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'beetroot') or msgcontains(msg, 'rote beete') then -- Beetroot
		if getGlobalStorageValue(2681) ~= 1 then
			npcHandler:say('Soll ik was Rote Beete für dich anpflanzen? Dat würde dich dann ' .. Ernte[11].preis .. ' Gold kosten. Außerdem räume ich dat janze Feld auf, wenn ik sähe. Als sieh zu, dat alles von dir in Sicherheit is!', cid)
			talkState[talkUser] = 13
		else
			npcHandler:say('Sorry, aber et scheint, als ob wen anderes meine Dienste jerade in Anspruch jenommen hat, deswejen musste dich noch wat jedulden.', cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Jut, wenn de nicht magst. Ich zwing dich zu jar nichts. Du müsst ja weiter so rumlaufen.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Jut, wenn de nicht magst. Ich zwing dich zu jar nichts. Du müsst ja weiter so rumlaufen.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

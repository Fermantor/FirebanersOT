local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

npcHandler:setMessage(MESSAGE_GREET, 'Guten Tag, |PLAYERNAME|. Suchst du günstige, aber hochwertige {Potions}, bist du bei mir genau richtig.')
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'health potion'}, 7618, 40, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 45, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 100, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 80, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 190, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 120, 1, 'great mana potion')
shopModule:addBuyableItem({'great spirit'}, 8472, 190, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 310, 1, 'ultimate health potion')

shopModule:addSellableItem({'berserk potion'}, 7439, 500, 'berserk potion')
shopModule:addSellableItem({'bullseye potion'}, 7443, 500, 'bullseye potion')
shopModule:addSellableItem({'mastermind potion'}, 7440, 500, 'mastermind potion')

shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 5, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 5, 'empty great potion flask')
shopModule:addSellableItem({'vial'},2006, 5, 'vial')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local vials1 = getPlayerItemCount(cid, 7636)
	local vials2 = getPlayerItemCount(cid, 7634)
	local vials3 = getPlayerItemCount(cid, 7635)
	
	if msgcontains(msg, 'job') then
		npcHandler:say('Ich bin der größte und bekannteste Alchmist von ganz Pulgra... oder vieleicht sogar von ganz Fireban. Wenn du mein Angebot sehen willst, frag einfach nach einen {trade}.', cid)
	elseif msgcontains(msg, 'potions') then
		npcHandler:say('Meine Potions sind gewiss die besten im ganzen Land. Frag mich nach einem {trade}, um dich selbst zu überzeugen.', cid)
	elseif msgcontains(msg, 'vial') then
		if vials1 >= 1 or vials2 >= 1 or vials3 >= 1 then
			if vials1 >= 100 or vials2 >= 100 or vials3 >= 100 then
				npcHandler:say('Willst du mir alle deine Vials für ' .. vials1*5 + vials2*5 + vials3*5 .. ' Gold verkaufen oder willst du ein {Lottery Ticket} haben?', cid)
				talkState[talkUser] = 1
			else
				npcHandler:say('Willst du mir alle deine Vials für ' .. vials1*5 + vials2*5 + vials3*5 .. ' Gold verkaufen?', cid)
				talkState[talkUser] = 1
			end
		else
			npcHandler:say('Du hast keine Vials!', cid)
		end
	elseif msgcontains(msg, 'verkaufen') or msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Hier sind deine ' .. vials1*5 + vials2*5 + vials3*5 .. ' Gold.', cid)
			doPlayerAddItem(cid, 2148, vials1*5 + vials2*5 + vials3*5)
			doPlayerRemoveItem(cid, 7636, vials1)
			doPlayerRemoveItem(cid, 7634, vials2)
			doPlayerRemoveItem(cid, 7635, vials3)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 2 then
			local flask = FALSE
			if vials1 >= 100 then
				flask = TRUE
				doPlayerRemoveItem(cid, 7636, 100)
			elseif vials2 >= 100 then
				flask = TRUE
				doPlayerRemoveItem(cid, 7634, 100)
			elseif vials3 >= 100 then
				flask = TRUE
				doPlayerRemoveItem(cid, 7635, 100)
			end
			if flask == TRUE then
				doPlayerAddItem(cid, 5957)
				npcHandler:say('Vielen Dank, hier ist dein Lottery Ticket hast du noch mehr vials?', cid)
				talkState[talkUser] = 2
			else
				npcHandler:say('Es tut mir leid, aber ich brauche 100 vials von der SELBEN Sorte.', cid)
				talkState[talkUser] = 0
			end
		end
	elseif talkState[talkUser] == 3 then
		if getPlayerStorageValue(cid, 20010) ~= 1 then
			if getPlayerItemCount(cid, 5958) >= 1 then
				doPlayerRemoveItem(cid, 5958, 1)
				npcHandler:say('Hier bitte sehr, dein brand neuer Potion Gürtel.', cid)
				doPlayerAddOutfit(cid, 138, 1)
				doPlayerAddOutfit(cid, 133, 1)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 20010, 1)
			else
				npcHandler:say('Bitte, du verschwendest meine Zeit.', cid)
				talkState[talkUser] = 0
			end
		else
			npcHandler:say('Sei doch nicht albern, du hast deinen Preis doch schon abgeholt', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'lottery') or msgcontains(msg, 'lotto') or msgcontains(msg, 'ticket') then
		if vials1 >= 100 or vials2 >= 100 or vials3 >= 100 then
			npcHandler:say('Willst du 100 leere Potion Flask für ein Lottery Ticket eintauschen?', cid)
			talkState[talkUser] = 2
		else
			npcHandler:say('Ich kann dir für 100 leere Potion Flask ein Lottery Ticket geben. Komm einfach wieder, wenn du 100 hast?', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'winning') or msgcontains(msg, 'gewinn') or msgcontains(msg, 'addon') then
		npcHandler:say('Wenn du ein Winning Lottery Ticket erhalten hast, bekommst du dafür ein hübsches Addon. Willst du eins einlösen?', cid)
		talkState[talkUser] = 3
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

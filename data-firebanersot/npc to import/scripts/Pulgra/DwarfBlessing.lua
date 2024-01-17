local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_GREET, 'Sei gegrüßt |PLAYERNAME|. Was führt dich an diesen {heiligen} Ort?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Nun, dann eben so...')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Gehe in Frieden.')

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'iron ore'}, 5880, 500)
shopModule:addSellableItem({'Geomancer\'s Robe'}, 12414, 80)
shopModule:addSellableItem({'Geomancer\'s Staff'}, 12419, 120)

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'job') or msgcontains(msg, 'heilig') then
		npcHandler:say('Ich bin der Grok der Dwarfs. Bei euch würde man das wohl als Priester bezeichnen. Ich vergebe das {Blessing Spark of the Phoenix} und bin der Kontaktmann zwischen Menschen und Dwarfs.',cid)
	elseif msgcontains(msg, 'blessing') or msgcontains(msg, 'bless') then
		npcHandler:say('Es gibt 5 Blessings in Tibia. Jedes trägt dazu bei, dich vor Verlust bei einem Tod zu schützen. Das {Spiritual Shielding}, das {Embrace of Tibia}, das {Fire of the Suns}, das {Wisdom of Solitude} und das {Spark of the Phoenix}.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'suns') then -- Blessing 3
		npcHandler:say('Wenn du das {Fire of Suns} Blessing kaufen willst, musst du zu Alfred in Pulgra gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'spiritual') then -- Blessing 4
		npcHandler:say('Wenn du das {Spiritual Shielding} Blessing kaufen willst, musst du zu Alfred in Pulgra gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'solitude') then -- Blessing 1
		npcHandler:say('Wenn du das {Wisdom of Solitude} Blessing kaufen willst, musst du zu Antonius in Bonezone gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'embrace') then -- Blessing 2
		npcHandler:say('Wenn du das {Embrace of Tibia} Blessing kaufen willst, musst du zu Antonius in Bonezone gehen.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'phoenix') then -- Blessing 5
		if not getPlayerBlessing(cid, 5) then
			npcHandler:say('Willst du das Sprak of the Phoenix für ' .. getBlessPrice(cid) .. ' Gold kaufen?.', cid)
			talkState[talkUser] = 1
		else
			npcHandler:say('Du hast dieses Blessing bereits erhalten.', cid)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'fisch') or msgcontains(msg, 'lieferung') or msgcontains(msg, 'fritz') then
		if getPlayerStorageValue(cid, 2604) == 1 and getPlayerStorageValue(cid, 2602) == 1 then
			if getPlayerItemCount(cid, 10028) >= 1 then
				npcHandler:say('Hmm, wir dwarfs leben ja eigentlich ohne Einfluss der Menschen... aber seitdem ich dieses Zeug probiert habe, kann ich nicht mehr ohne. Gib schon her!' , cid)
				setPlayerStorageValue(cid, 2604, 2)
				if getPlayerStorageValue(cid, 2603) == 2 and getPlayerStorageValue(cid, 2604) == 2 and getPlayerStorageValue(cid, 2605) == 2 and getPlayerStorageValue(cid, 2606) == 2 then
					setPlayerStorageValue(cid, 2602, 2)
					doPlayerRemoveItem(cid, 10028, 1)					
				end
			else
				npcHandler:say('Es ist nett das Fritz dich schickt, aber ich glaube du hast die Ware vergessen...' , cid)
			end
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then	
			if doPlayerRemoveMoney(cid, getBlessPrice(cid)) == TRUE then
				doPlayerAddBlessing(cid, 5)
				npcHandler:say('Hiermit erhälst du den Segen des Spark of the Phoenix.', cid)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_BLUE)
				talkState[talkUser] = 0
			else
				npcHandler:say('Du hast nicht genug Geld.', cid)
				talkState[talkUser] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

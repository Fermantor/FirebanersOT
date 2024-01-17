local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 1, 'spellbook')

shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 10, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 15, 'empty great potion flask')

shopModule:addBuyableItem({'health potion'}, 7618, 45, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 50, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 100, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 80, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 190, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 120, 1, 'great mana potion')
shopModule:addBuyableItem({'great spirit'}, 8472, 190, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 310, 1, 'ultimate health potion')

shopModule:addBuyableItem({'blank rune'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'avalanche'}, 2274, 45, 1, 'avalanche rune')
shopModule:addBuyableItem({'antidote'}, 2266, 65, 1, 'antidote rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 210, 1, 'chameleon rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 80, 1, 'convince creature rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 15, 1, 'destroy field rune')
shopModule:addBuyableItem({'energy field'}, 2277, 38, 1, 'energy field rune')
shopModule:addBuyableItem({'energy wall'}, 2279, 85, 1, 'energy wall rune')
shopModule:addBuyableItem({'explosion'}, 2313, 31, 1, 'explosion rune')
shopModule:addBuyableItem({'fire bomb'}, 2305, 117, 1, 'fire bomb rune')
shopModule:addBuyableItem({'fire field'}, 2301, 28, 1, 'fire field rune')
shopModule:addBuyableItem({'fire wall'}, 2303, 61, 1, 'fire wall rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 45, 1, 'great fireball rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 12, 1, 'heavy magic missile rune')
shopModule:addBuyableItem({'intense healing'}, 2265, 95, 1, 'intense healing rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 4, 1, 'light magic missile rune')
shopModule:addBuyableItem({'poison field'}, 2285, 21, 1, 'poison field rune')
shopModule:addBuyableItem({'poison wall'}, 2289, 52, 1, 'poison wall rune')
shopModule:addBuyableItem({'stalagmite'}, 2292, 12, 1, 'stalagmite rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 108, 1, 'sudden death rune')
shopModule:addBuyableItem({'ultimate healing'}, 2273, 175, 1, 'ultimate healing rune')

shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 1000, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 2000, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 10000, 'wand of decay')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 20000, 'wand of cosmic energy')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 1000, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 2000, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 10000, 'necrotic rod')
shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 20000, 'terra rod')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local vials1 = getPlayerItemCount(cid, 7636)
	local vials2 = getPlayerItemCount(cid, 7634)
	local vials3 = getPlayerItemCount(cid, 7635)
	
	if msgcontains(msg, 'vial') then
		if vials1 >= 1 or vials2 >= 1 or vials3 >= 1 then
			npcHandler:say('Willst du mir alle deine Vials für ' .. vials1*5 + vials2*5 + vials3*5 .. ' Gold verkaufen?', cid)
			talkState[talkUser] = 1
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
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

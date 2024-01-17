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

shopModule:addBuyableItem({'brass helmet'}, 2460, 120, 'brass helmet')
shopModule:addBuyableItem({'chain helmet'}, 2458, 52, 'chain helmet')
shopModule:addBuyableItem({'dark helmet'}, 2490, 1000, 'dark helmet')
shopModule:addBuyableItem({'iron helmet'}, 2459, 390, 'iron helmet')
shopModule:addBuyableItem({'leather helmet'}, 2461, 12, 'leather helmet')
shopModule:addBuyableItem({'steel helmet'}, 2457, 580, 'steel helmet')
shopModule:addBuyableItem({'soldier helmet'}, 2481, 110, 'soldier helmet')
shopModule:addBuyableItem({'studded helmet'}, 2482, 63, 'studded helmet')
shopModule:addBuyableItem({'viking helmet'}, 2473, 265, 'viking helmet')

shopModule:addBuyableItem({'belted cape'}, 8872, 1300, 'belted cape')
shopModule:addBuyableItem({'brass armor'}, 2465, 450, 'brass armor')
shopModule:addBuyableItem({'cape'}, 2654, 9, 'cape')
shopModule:addBuyableItem({'chain armor'}, 2464, 200, 'chain armor')
shopModule:addBuyableItem({'coat'}, 2651, 8, 'coat')
shopModule:addBuyableItem({'dark armor'}, 2489, 1500, 'dark armor')
shopModule:addBuyableItem({'green tunic'}, 2652, 25, 'green tunic')
shopModule:addBuyableItem({'jacket'}, 2650, 12, 'jacket')
shopModule:addBuyableItem({'leather armor'}, 2467, 25, 'leather armor')
shopModule:addBuyableItem({'magician robe'}, 8819, 450, 'magician robe')
shopModule:addBuyableItem({'noble armor'}, 2486, 8000, 'noble armor')
shopModule:addBuyableItem({'plate armor'}, 2463, 1200, 'plate armor')
shopModule:addBuyableItem({'ranger cloak'}, 2660, 550, 'ranger cloak')
shopModule:addBuyableItem({'scale armor'}, 2483, 260, 'scale armor')
shopModule:addBuyableItem({'spirit cloak'}, 8870, 1000, 'spirit cloak')
shopModule:addBuyableItem({'studded armor'}, 2484, 90, 'studded armor')

shopModule:addBuyableItem({'brass legs'}, 2478, 195, 'brass legs')
shopModule:addBuyableItem({'chain legs'}, 2648, 80, 'chain legs')
shopModule:addBuyableItem({'leather legs'}, 2649, 10, 'leather legs')
shopModule:addBuyableItem({'studded legs'}, 2468, 60, 'studded legs')

shopModule:addBuyableItem({'leather boots'}, 2643, 2,'leather boots')

shopModule:addSellableItem({'batwing hat'}, 10016, 8000,'batwing hat')
shopModule:addSellableItem({'brass helmet'}, 2460, 30,'brass helmet')
shopModule:addSellableItem({'charmer tiara'}, 3971, 900,'charmer tiara')
shopModule:addSellableItem({'chain helmet'}, 2458, 17,'chain helmet')
shopModule:addSellableItem({'dark helmet'}, 2490, 250,'dark helmet')
shopModule:addSellableItem({'devil helmet'}, 2462, 200,'devil helmet')
shopModule:addSellableItem({'feather headdress'}, 3970, 850,'feather headdress')
shopModule:addSellableItem({'helmet of the deep'}, 12541, 5000,'helmet of the deep')
shopModule:addSellableItem({'horseman helmet'}, 3969, 280,'horseman helmet')
shopModule:addSellableItem({'iron helmet'}, 2459, 150,'iron helmet')
shopModule:addSellableItem({'leather helmet'}, 2461, 4,'leather helmet')
shopModule:addSellableItem({'mystic turban'}, 2663, 150,'mystic turban')
shopModule:addSellableItem({'soldier helmet'}, 2481, 16,'soldier helmet')
shopModule:addSellableItem({'steel helmet'}, 2457, 293,'steel helmet')
shopModule:addSellableItem({'strange helmet'}, 2479, 500,'strange helmet')
shopModule:addSellableItem({'studded helmet'}, 2482, 20,'studded helmet')
shopModule:addSellableItem({'tribal mask'}, 3967, 250,'tribal mask')
shopModule:addSellableItem({'viking helmet'}, 2473, 66,'viking helmet')

shopModule:addSellableItem({'belted cape'}, 8872, 500,'belted cape')
shopModule:addSellableItem({'brass armor'}, 2465, 150,'brass armor')
shopModule:addSellableItem({'chain armor'}, 2464, 70,'chain armor')
shopModule:addSellableItem({'coat'}, 2651, 10, 'coat')
shopModule:addSellableItem({'dark armor'}, 2489, 400,'dark armor')
shopModule:addSellableItem({'focus cape'}, 8871, 6000,'focus cape')
shopModule:addSellableItem({'glacier robe'}, 7897, 11000,'glacier robe')
shopModule:addSellableItem({'jacket'}, 2650, 5,'jacket')
shopModule:addSellableItem({'leather armor'}, 2467, 12,'leather armor')
shopModule:addSellableItem({'leopard armor'}, 3968, 1000,'leopard armor')
shopModule:addSellableItem({'noble armor'}, 2486, 900,'noble armor')
shopModule:addSellableItem({'plate armor'}, 2463, 400,'plate armor')
shopModule:addSellableItem({'scale armor'}, 2483, 75,'scale armor')
shopModule:addSellableItem({'simple dress'}, 2657, 50,'simple dress')
shopModule:addSellableItem({'spellweaver robe'}, 11355, 12000,'spellweaver robe')
shopModule:addSellableItem({'spirit cloak'}, 8870, 350,'spirit cloak')
shopModule:addSellableItem({'studded armor'}, 2484, 25,'studded armor')

shopModule:addSellableItem({'bast skirt'}, 3983, 750,'bast skirt')
shopModule:addSellableItem({'brass legs'}, 2478, 49,'brass legs')
shopModule:addSellableItem({'chain legs'}, 2648, 25,'chain legs')
shopModule:addSellableItem({'leather legs'}, 2649, 9,'leather legs')
shopModule:addSellableItem({'plate legs'}, 2647, 115,'plate legs')
shopModule:addSellableItem({'studded legs'}, 2468, 15,'studded legs')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Achso! Also, mein Job ist es, die Leute mit Schutz zu versehen. Vor allem Kriegern verkaufe ich immer gerne meine Rüstungen, um sie auf ihren bevorstehenden Kampf vorzubereiten.',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Im Bereich unter Bonezone soll es einen Mann namens Xantharus geben. Versuchs bei ihm.', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

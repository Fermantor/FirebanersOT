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

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')
shopModule:addBuyableItem({'magic lightwand'}, 2163, 400, 'magic lightwand')

shopModule:addBuyableItem({'avalanche'}, 2274, 90, 1, 'avalanche rune')
shopModule:addBuyableItem({'blank rune'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 420, 1, 'chameleon rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 160, 1, 'convince creature rune')
shopModule:addBuyableItem({'energy bomb'}, 2264, 324, 1, 'energy bomb rune')
shopModule:addBuyableItem({'energy field'}, 2277, 76, 1, 'energy field')
shopModule:addBuyableItem({'energy wall'}, 2279, 170, 1, 'energy wall rune')
shopModule:addBuyableItem({'explosion'}, 2313, 62, 1, 'explosion rune')
shopModule:addBuyableItem({'fire bomb'}, 2305, 234, 1, 'fire bomb rune')
shopModule:addBuyableItem({'fire field'}, 2301, 56, 1, 'fire field rune')
shopModule:addBuyableItem({'fire wall'}, 2303, 122, 1, 'fire wall rune')
shopModule:addBuyableItem({'fireball'}, 2302, 60, 1, 'fire ball')
shopModule:addBuyableItem({'great fireball'}, 2304, 90, 1, 'great fireball rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 24, 1, 'heavy magic missile rune')
shopModule:addBuyableItem({'holy missile missile'}, 2295, 32, 1, 'holy missile rune')
shopModule:addBuyableItem({'icicle'}, 2271, 60, 1, 'icicle rune')
shopModule:addBuyableItem({'intense healing'}, 2265, 190, 1, 'intense healing rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 8, 1, 'light magic missile rune')
shopModule:addBuyableItem({'poison bomb'}, 2286, 170, 1, 'poison bomb rune')
shopModule:addBuyableItem({'poison field'}, 2285, 42, 1, 'poison field')
shopModule:addBuyableItem({'poison wall'}, 2289, 104, 1, 'poison wall rune')
shopModule:addBuyableItem({'stalagmite'}, 2292, 24, 1, 'stalagmite rune')
shopModule:addBuyableItem({'stone shower'}, 2288, 74, 1, 'stoneshower rune')
shopModule:addBuyableItem({'thunderstorm'}, 2315, 74, 1, 'thunderstorm rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 216, 1, 'sudden death rune')

shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 1000, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 2000, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 10000, 'wand of decay')
shopModule:addBuyableItem({'wand of draconia', 'draconia'}, 8921, 15000, 'wand of draconia')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 20000, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 30000, 'wand of inferno')
shopModule:addBuyableItem({'wand of starstorm', 'starstorm'}, 8920, 36000, 'wand of starstorm')
shopModule:addBuyableItem({'wand of voodoo', 'voodoo'}, 8922, 44000, 'wand of voodoo')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 1000, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 2000, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 10000, 'necrotic rod')
shopModule:addBuyableItem({'northwind rod', 'northwind'}, 8911, 15000, 'northwind rod')
shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 20000, 'terra rod')
shopModule:addBuyableItem({'hailstorm rod', 'hailstorm'}, 2183, 30000, 'hailstorm rod')
shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 36000, 'springsprout rod')
shopModule:addBuyableItem({'underworld rod', 'underworld'}, 8910, 44000,  'underworld rod')

shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 50, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 100, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 2188, 500, 'wand of decay')
shopModule:addSellableItem({'wand of draconia', 'draconia'}, 8921, 750, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 1000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'},2187, 1500, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm', 'starstorm'}, 8920, 1800, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo', 'voodoo'}, 8922, 2200, 'wand of voodoo')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 50,'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 100,   'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 2185, 500, 'necrotic rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 750, 'northwind rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 2181, 1000, 'terra rod')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'}, 2183, 1500, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod', 'springsprout'}, 8912, 1800, 'springsprout rod')
shopModule:addSellableItem({'underworld rod', 'underworld'}, 8910, 2200, 'underworld rod')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

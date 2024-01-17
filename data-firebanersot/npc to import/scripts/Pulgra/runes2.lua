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

shopModule:addBuyableItem({'avalanche'}, 2274, 45, 1, 'avalanche rune')
shopModule:addBuyableItem({'blank rune'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 210, 1, 'chameleon rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 80, 1, 'convince creature rune')
shopModule:addBuyableItem({'energy bomb'}, 2264, 162, 1, 'energy bomb rune')
shopModule:addBuyableItem({'energy field'}, 2277, 38, 1, 'energy field')
shopModule:addBuyableItem({'energy wall'}, 2279, 85, 1, 'energy wall rune')
shopModule:addBuyableItem({'explosion'}, 2313, 31, 1, 'explosion rune')
shopModule:addBuyableItem({'fire bomb'}, 2305, 117, 1, 'fire bomb rune')
shopModule:addBuyableItem({'fire field'}, 2301, 28, 1, 'fire field rune')
shopModule:addBuyableItem({'fire wall'}, 2303, 61, 1, 'fire wall rune')
shopModule:addBuyableItem({'fireball'}, 2302, 30, 1, 'fire ball')
shopModule:addBuyableItem({'great fireball'}, 2304, 45, 1, 'great fireball rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 12, 1, 'heavy magic missile rune')
shopModule:addBuyableItem({'holy missile missile'}, 2295, 16, 1, 'holy missile rune')
shopModule:addBuyableItem({'icicle'}, 2271, 30, 1, 'icicle rune')
shopModule:addBuyableItem({'intense healing'}, 2265, 95, 1, 'intense healing rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 4, 1, 'light magic missile rune')
shopModule:addBuyableItem({'poison bomb'}, 2286, 85, 1, 'poison bomb rune')
shopModule:addBuyableItem({'poison field'}, 2285, 21, 1, 'poison field')
shopModule:addBuyableItem({'poison wall'}, 2289, 52, 1, 'poison wall rune')
shopModule:addBuyableItem({'stalagmite'}, 2292, 12, 1, 'stalagmite rune')
shopModule:addBuyableItem({'stone shower'}, 2288, 37, 1, 'stoneshower rune')
shopModule:addBuyableItem({'thunderstorm'}, 2315, 37, 1, 'thunderstorm rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 108, 1, 'sudden death rune')

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

shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 100, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 200, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 2188, 1000, 'wand of decay')
shopModule:addSellableItem({'wand of draconia', 'draconia'}, 8921, 1500, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 2000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'},2187, 3000, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm', 'starstorm'}, 8920, 3600, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo', 'voodoo'}, 8922, 4400, 'wand of voodoo')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 100,'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 200,   'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 2185, 1000, 'necrotic rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 1500, 'northwind rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 2181, 2000, 'terra rod')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'}, 2183, 3000, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod', 'springsprout'}, 8912, 3600, 'springsprout rod')
shopModule:addSellableItem({'underworld rod', 'underworld'}, 8910, 4400, 'underworld rod')

shopModule:addSellableItem({'spellbook'}, 2175, 100,'spellbook')
 
shopModule:addSellableItem({'spellbook of enlightenment'}, 8900, 4000, 'spellbook of enlightenment')
shopModule:addSellableItem({'spellbook of warding'}, 8901, 8000, 'spellbook of warding')
shopModule:addSellableItem({'spellbook of mind control'}, 8902, 13000, 'spellbook of mind control')
shopModule:addSellableItem({'spellbook of lost souls'}, 8903, 19000, 'spellbook of lost souls')




function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

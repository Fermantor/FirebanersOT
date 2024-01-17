local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

npcHandler:setMessage(MESSAGE_SENDTRADE, 'Dies ist mein kostbares Angebot. Überlege dir gut, wenn du etwas kaufen möchtest.')

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'black pearl'}, 2144, 560, 'black pearl')
shopModule:addBuyableItem({'small amethyst'}, 2150, 400, 'small amethyst')
shopModule:addBuyableItem({'small diamond'}, 2145, 600, 'small diamond')
shopModule:addBuyableItem({'small emerald'}, 2149, 500, 'small emerald')
shopModule:addBuyableItem({'small ruby'}, 2147, 500, 'small ruby')
shopModule:addBuyableItem({'small sapphire'}, 2146, 500, 'small sapphire')
shopModule:addBuyableItem({'white pearl'}, 2143, 320, 'white pearl')

shopModule:addSellableItem({'black pearl'}, 2144, 280, 'black pearl')
shopModule:addSellableItem({'giant shimmering pearl'}, 7632, 3000, 'giant shimmering pearl')
shopModule:addSellableItem({'giant shimmering pearl'}, 7633, 3000, 'giant shimmering pearl')
shopModule:addSellableItem({'gold ingot'}, 9971, 5000, 'gold ingot')
shopModule:addSellableItem({'silver brooch'}, 2134, 150, 'silver brooch')
shopModule:addSellableItem({'small amethyst'}, 2150, 200, 'small amethyst')
shopModule:addSellableItem({'small diamond'}, 2145, 300, 'small diamond')
shopModule:addSellableItem({'small emerald'}, 2149, 250, 'small emerald')
shopModule:addSellableItem({'small ruby'}, 2147, 250, 'small ruby')
shopModule:addSellableItem({'small sapphire'}, 2146, 250, 'small sapphire')
shopModule:addSellableItem({'Green Crystal Shard'}, 18415, 400, 'Green Crystal Shard')
shopModule:addSellableItem({'Blue Crystal Shard'}, 18413, 400, 'Blue Crystal Shard')
shopModule:addSellableItem({'Violet Crystal Shard'}, 18414, 1500, 'Violet Crystal Shard')
shopModule:addSellableItem({'Green Crystal Splinter'}, 18416, 400, 'Green Crystal Splinter')
shopModule:addSellableItem({'Brown Crystal Splinter'}, 18417, 400, 'Brown Crystal Splinter')
shopModule:addSellableItem({'Blue Crystal Splinter'}, 18418, 400, 'Blue Crystal Splinter')
shopModule:addSellableItem({'Cyan Crystal Fragment'}, 18419, 800, 'Cyan Crystal Fragment')
shopModule:addSellableItem({'Red Crystal Fragment'}, 18420, 800, 'Red Crystal Fragment')
shopModule:addSellableItem({'Green Crystal Fragment'}, 18421, 800, 'Green Crystal Fragment')
shopModule:addSellableItem({'small topaz'}, 9970, 200, 'small topaz')
shopModule:addSellableItem({'white pearl'}, 2143, 160, 'white pearl')
shopModule:addSellableItem({'blue gem'}, 2158, 5000, 'blue gem')
shopModule:addSellableItem({'yellow gem'}, 2154, 1000, 'yellow gem')
shopModule:addSellableItem({'violet gem'}, 2153, 10000, 'violet gem')
shopModule:addSellableItem({'red gem'}, 2156, 1000, 'red gem')
shopModule:addSellableItem({'green gem'}, 2155, 5000, 'green gem')
shopModule:addSellableItem({'golden mug'}, 2033, 250, 'golden mug')

shopModule:addSellableItem({'brown crystal splinter'}, 18417, 400)
shopModule:addSellableItem({'green crystal splinter'}, 18416, 400)
shopModule:addSellableItem({'red crystal fragment'}, 18420, 800)
shopModule:addSellableItem({'green crystal fragment'}, 18421, 800)
shopModule:addSellableItem({'green crystal shard'}, 18415, 1500)
shopModule:addSellableItem({'violet crystal shard'}, 18414, 1500)

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Ich bin für die wertvollen Dinge in Bonezone zuständig. Auch bin die einzige, die alle Edelsteine kauft, also zöger bloß nicht mich nach einem {trade} zu fragen.',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Ich habe gehört Xantharus hier in Little Cotton verkauft Vials. Frag ihn doch mal.', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

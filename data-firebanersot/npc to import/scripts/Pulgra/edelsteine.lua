local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

npcHandler:setMessage(MESSAGE_GREET, 'Guten Tag, |PLAYERNAME|. Hast du ein paar funkelnde {Edelsteine} für mich?')
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
shopModule:addSellableItem({'small topaz'}, 9970, 200, 'small topaz')
shopModule:addSellableItem({'white pearl'}, 2143, 160, 'white pearl')

shopModule:addSellableItem({'brown crystal splinter'}, 18417, 400)
shopModule:addSellableItem({'green crystal splinter'}, 18416, 400)
shopModule:addSellableItem({'red crystal fragment'}, 18420, 800)
shopModule:addSellableItem({'green crystal fragment'}, 18421, 800)
shopModule:addSellableItem({'green crystal shard'}, 18415, 1500)
shopModule:addSellableItem({'violet crystal shard'}, 18414, 1500)

 
function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, 'job') then
		npcHandler:say('Ich bin die Juwelier von Pulgra. Falls du ein paar Edelsteine kaufen, oder verkaufen willst, frag nach einem {trade}.', cid)
	elseif msgcontains(msg, 'edelstein') then
		npcHandler:say('Eldesteine sind meine große Leidenschaft, seit ich klein war. Heute verdien ich mein Geld mit ihnen.', cid)
	elseif msgcontains(msg, 'fisch') or msgcontains(msg, 'lieferung') or msgcontains(msg, 'fritz') then
		if getPlayerStorageValue(cid, 2606) == 1 and getPlayerStorageValue(cid, 2602) == 1 then
			if getPlayerItemCount(cid, 10028) >= 1 then
				if math.random(1,5) == 1 then
					npcHandler:say('Oh, da ist sind ja endlich meine geliebten Fish Flakes, danke dir! Ich bin einfach verrückt nach dem Zeug. Richte Fritz einen Gruß von mir aus und nimm dieses kleine Geschenk von mir.' , cid)
					doPlayerAddItem(cid, 2145, 2)
				else
					npcHandler:say('Oh, da ist sind ja endlich meine geliebten Fish Flakes, danke dir! Ich bin einfach verrückt nach dem Zeug. Richte Fritz einen gruß von mir aus.' , cid)
				end
				setPlayerStorageValue(cid, 2606, 2)
				if getPlayerStorageValue(cid, 2603) == 2 and getPlayerStorageValue(cid, 2604) == 2 and getPlayerStorageValue(cid, 2605) == 2 and getPlayerStorageValue(cid, 2606) == 2 then
					setPlayerStorageValue(cid, 2602, 2)
					doPlayerRemoveItem(cid, 10028, 1)
				end
			else
				npcHandler:say('Es ist nett das Fritz dich schickt, aber ich glaube du hast die Ware vergessen...' , cid)
			end
		end
	end
	return TRUE
end
 
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
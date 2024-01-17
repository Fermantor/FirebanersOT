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

shopModule:addBuyableItem({'ancient shield'}, 2532, 5000, 'ancient shield')
shopModule:addBuyableItem({'brass shield'}, 2511, 65, 'brass shield')
shopModule:addBuyableItem({'dwarven shield'}, 2525, 500, 'dwarven shield')
shopModule:addBuyableItem({'plate shield'}, 2510, 125, 'plate shield')
shopModule:addBuyableItem({'steel shield'}, 2509, 240, 'steel shield')
shopModule:addBuyableItem({'studded shield'}, 2526, 50, 'studded shield')
shopModule:addBuyableItem({'viking shield'}, 2531, 260, 'viking shield')
shopModule:addBuyableItem({'wooden shield'}, 2512, 15, 'wooden shield')

shopModule:addBuyableItem({'axe'}, 2386, 20,'axe')
shopModule:addBuyableItem({'battle axe'}, 2378, 235,'battle axe')
shopModule:addBuyableItem({'hand axe'}, 2380, 8,'hand axe')
shopModule:addBuyableItem({'sickle'}, 2405, 7,'sickle')

shopModule:addBuyableItem({'battle hammer'}, 2417, 350,'battle hammer')
shopModule:addBuyableItem({'staff'}, 2401, 40,'staff')
shopModule:addBuyableItem({'clerical mace'}, 2423, 540,'clerical mace')
shopModule:addBuyableItem({'club'}, 2382, 5,'club')
shopModule:addBuyableItem({'daramanian mace'}, 2439, 500,'daramanian mace')
shopModule:addBuyableItem({'mace'}, 2398, 90,'mace')
shopModule:addBuyableItem({'morning star'}, 2394, 430,'morning star')
shopModule:addBuyableItem({'war hammer'}, 2391, 10000,'war hammer')

shopModule:addBuyableItem({'bone sword'}, 2450, 75,'bone sword')
shopModule:addBuyableItem({'carlin sword'}, 2395, 473,'carlin sword')
shopModule:addBuyableItem({'dagger'}, 2379, 5,'dagger')
shopModule:addBuyableItem({'longsword'}, 2397, 160,'longsword')
shopModule:addBuyableItem({'rapier'}, 2384, 15,'rapier')
shopModule:addBuyableItem({'sabre'}, 2385, 35,'sabre')
shopModule:addBuyableItem({'serpent sword'}, 2409, 6000,'serpent sword')
shopModule:addBuyableItem({'short sword'}, 2406, 30,'short sword')
shopModule:addBuyableItem({'sword'}, 2376, 85,'sword')
shopModule:addBuyableItem({'twin hooks'}, 11309, 1100,'twin hooks')
shopModule:addBuyableItem({'two handed sword'}, 2377, 950,'two handed sword')

shopModule:addSellableItem({'ancient shield'}, 2532, 900,'ancient shield')
shopModule:addSellableItem({'battle shield'}, 2513, 95,'battle shield')
shopModule:addSellableItem({'black shield'}, 2529, 800,'black shield')
shopModule:addSellableItem({'bone shield'}, 2541, 80,'bone shield')
shopModule:addSellableItem({'bonelord shield'}, 2518, 1200,'bonelord shield')
shopModule:addSellableItem({'brass shield'}, 2511, 16,'brass shield')
shopModule:addSellableItem({'copper shield'}, 2530, 50,'copper shield')
shopModule:addSellableItem({'dark shield'}, 2521, 400,'dark shield')
shopModule:addSellableItem({'dragon shield'}, 2516, 4000,'dragon shield')
shopModule:addSellableItem({'dwarven shield'}, 2525, 100,'dwarven shield')
shopModule:addSellableItem({'guardian shield'}, 2515, 2000,'guardian shield')
shopModule:addSellableItem({'plate shield'}, 2510, 45,'plate shield')
shopModule:addSellableItem({'salamander shield'}, 3975, 280,'salamander shield')
shopModule:addSellableItem({'sentinel shield'}, 3974, 120,'sentinel shield')
shopModule:addSellableItem({'steel shield'}, 2509, 80,'steel shield')
shopModule:addSellableItem({'studded shield'}, 2526, 16,'studded shield')
shopModule:addSellableItem({'tusk shield'}, 3973, 850,'tusk shield')
shopModule:addSellableItem({'viking shield'}, 2531, 85,'viking shield')
shopModule:addSellableItem({'wooden shield'}, 2512, 5,'wooden shield')

shopModule:addSellableItem({'axe'}, 2386, 7,'axe')
shopModule:addSellableItem({'barbarian axe'}, 7749, 185,'barbarian axe')
shopModule:addSellableItem({'battle axe'}, 2378, 80,'battle axe')
shopModule:addSellableItem({'double axe'}, 2387, 260,'double axe')
shopModule:addSellableItem({'halberd'}, 2381, 400,'halberd')
shopModule:addSellableItem({'hand axe'}, 2380, 4,'hand axe')
shopModule:addSellableItem({'hatchet'}, 2388, 25,'hatchet')
shopModule:addSellableItem({'knight axe'}, 7750, 2000,'knight axe')
shopModule:addSellableItem({'obsidian lance'}, 2425, 500,'obsidian lance')
shopModule:addSellableItem({'orcish axe'}, 2328, 350,'orcish axe')
shopModule:addSellableItem({'sickle'}, 2405, 3,'sickle')

shopModule:addSellableItem({'battle hammer'}, 2417, 120,'battle hammer')
shopModule:addSellableItem({'bone club'}, 2382, 5,'bone club')
shopModule:addSellableItem({'clerical mace'}, 7754, 170,'clerical mace')
shopModule:addSellableItem({'club'}, 2382, 1,'club')
shopModule:addSellableItem({'crowbar'}, 2416, 50,'crowbar')
shopModule:addSellableItem({'daramanian mace'}, 2439, 500,'daramanian mace')
shopModule:addSellableItem({'dragon hammer'}, 2434, 2000,'dragon hammer')
shopModule:addSellableItem({'mace'}, 2398, 30,'mace')
shopModule:addSellableItem({'mammoth whopper'}, 7381, 300,'mammoth whopper')
shopModule:addSellableItem({'morning star'}, 2394, 100,'morning star')
shopModule:addSellableItem({'scythe'}, 2550, 12,'scythe')
shopModule:addSellableItem({'skull staff'}, 2436, 6000,'skull staff')
shopModule:addSellableItem({'spiked squelcher'}, 7452, 5000,'spiked squelcher')
shopModule:addSellableItem({'taurus mace'}, 7425, 500,'taurus mace')
shopModule:addSellableItem({'war hammer'}, 2391, 1200,'war hammer')

shopModule:addSellableItem({'bone sword'}, 2450, 20,'bone sword')
shopModule:addSellableItem({'broadsword'}, 2413, 500,'broadsword')
shopModule:addSellableItem({'carlin sword'}, 2395, 118,'carlin sword')
shopModule:addSellableItem({'crystal sword'}, 7449, 600,'crystal sword')
shopModule:addSellableItem({'dagger'}, 2379, 2,'dagger')
shopModule:addSellableItem({'fire sword'}, 2392, 4000,'fire sword')
shopModule:addSellableItem({'heavy machete'}, 2442, 90,'heavy machete')
shopModule:addSellableItem({'ice rapier'}, 2396, 1000,'ice rapier')
shopModule:addSellableItem({'katana'}, 2412, 35,'katana')
shopModule:addSellableItem({'longsword'}, 2397, 51,'longsword')
shopModule:addSellableItem({'machete'}, 2420, 6,'machete')
shopModule:addSellableItem({'poison dagger'}, 2411, 50,'poison dagger')
shopModule:addSellableItem({'rapier'}, 2384, 5,'rapier')
shopModule:addSellableItem({'sabre'}, 2385, 12,'sabre')
shopModule:addSellableItem({'scimitar'}, 2419, 150,'scimitar')
shopModule:addSellableItem({'serpent sword'}, 2409, 900,'serpent sword')
shopModule:addSellableItem({'short sword'}, 2406, 10,'short sword')
shopModule:addSellableItem({'silver dagger'}, 2402, 500,'silver dagger')
shopModule:addSellableItem({'spike sword'}, 2383, 1000,'spike sword')
shopModule:addSellableItem({'sword'}, 2376, 25,'sword')
shopModule:addSellableItem({'templar scytheblade'}, 3963, 200,'templar scytheblade')
shopModule:addSellableItem({'twin hooks'}, 11309, 500,'twin hooks')
shopModule:addSellableItem({'two handed sword'}, 2377, 450,'two handed sword')
shopModule:addSellableItem({'wyvern fang'}, 7408, 1500,'wyvern fang')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say('Jo, ich sorge für den DAMAAAAGE! Also den fetten Schaden, yeah! Kauf, was dir gefallen!',cid)
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Schaue mal unten in Little Cotton nach. Ein Mann namens Xantharus verkauft dort Vials.', cid)
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

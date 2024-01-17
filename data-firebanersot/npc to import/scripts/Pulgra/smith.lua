local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local BrutusTimer = 60*60*3 -- 3 Stunden
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'ancient shield'}, 2532, 5000, 'ancient shield')

shopModule:addBuyableItem({'sickle'}, 2405, 7,'sickle')

shopModule:addBuyableItem({'staff'}, 2401, 40,'staff')
shopModule:addBuyableItem({'clerical mace'}, 2423, 540,'clerical mace')
shopModule:addBuyableItem({'daramanian mace'}, 2439, 500,'daramanian mace')
shopModule:addBuyableItem({'war hammer'}, 2391, 10000,'war hammer')

shopModule:addBuyableItem({'serpent sword'}, 2409, 6000,'serpent sword')
shopModule:addBuyableItem({'twin hooks'}, 11309, 1100,'twin hooks')

shopModule:addBuyableItem({'cape'}, 2654, 9, 'cape')
shopModule:addBuyableItem({'jacket'}, 2650, 12, 'jacket')
shopModule:addBuyableItem({'noble armor'}, 2486, 8000, 'noble armor')

shopModule:addBuyableItem({'leather boots'}, 2643, 2,'leather boots')

shopModule:addSellableItem({'ancient shield'}, 2532, 900,'ancient shield')
shopModule:addSellableItem({'battle shield'}, 2513, 95,'battle shield')
shopModule:addSellableItem({'black shield'}, 2529, 800,'black shield')
shopModule:addSellableItem({'brass shield'}, 2511, 16,'brass shield')
shopModule:addSellableItem({'copper shield'}, 2530, 50,'copper shield')
shopModule:addSellableItem({'dark shield'}, 2521, 400,'dark shield')
shopModule:addSellableItem({'dragon shield'}, 2516, 4000, 'dragon shield')
shopModule:addSellableItem({'dwarven shield'}, 2525, 100,'dwarven shield')
shopModule:addSellableItem({'guardian shield'}, 2515, 2000,'guardian shield')
shopModule:addSellableItem({'plate shield'}, 2510, 45,'plate shield')
shopModule:addSellableItem({'steel shield'}, 2509, 80,'steel shield')
shopModule:addSellableItem({'studded shield'}, 2526, 16,'studded shield')
shopModule:addSellableItem({'vampire shield'}, 2534, 15000, 'vampire shield')
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
shopModule:addSellableItem({'orcish axe'}, 2428, 350,'orcish axe')
shopModule:addSellableItem({'sickle'}, 2405, 3,'sickle')

shopModule:addSellableItem({'battle hammer'}, 2417, 120,'battle hammer')
shopModule:addSellableItem({'bone club'}, 2382, 5,'bone club')
shopModule:addSellableItem({'clerical mace'}, 7754, 170,'clerical mace')
shopModule:addSellableItem({'club'}, 2382, 1,'club')
shopModule:addSellableItem({'crowbar'}, 2416, 50,'crowbar')
shopModule:addSellableItem({'daramanian mace'}, 2439, 500,'daramanian mace')
shopModule:addSellableItem({'dragonbone staff'}, 7430, 3000, 'dragonbone staff')
shopModule:addSellableItem({'dragon hammer'}, 2434, 2000,'dragon hammer')
shopModule:addSellableItem({'mace'}, 2398, 30,'mace')
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
shopModule:addSellableItem({'twin hooks'}, 11309, 500,'twin hooks')
shopModule:addSellableItem({'two handed sword'}, 2377, 450,'two handed sword')

shopModule:addSellableItem({'brass helmet'}, 2460, 30,'brass helmet')
shopModule:addSellableItem({'charmer tiara'}, 3971, 900,'charmer tiara')
shopModule:addSellableItem({'chain helmet'}, 2458, 17,'chain helmet')
shopModule:addSellableItem({'dark helmet'}, 2490, 250,'dark helmet')
shopModule:addSellableItem({'devil helmet'}, 2462, 1000,'devil helmet')
shopModule:addSellableItem({'horseman helmet'}, 3969, 280,'horseman helmet')
shopModule:addSellableItem({'iron helmet'}, 2459, 150,'iron helmet')
shopModule:addSellableItem({'leather helmet'}, 2461, 4,'leather helmet')
shopModule:addSellableItem({'soldier helmet'}, 2481, 16,'soldier helmet')
shopModule:addSellableItem({'steel helmet'}, 2457, 293,'steel helmet')
shopModule:addSellableItem({'strange helmet'}, 2479, 500,'strange helmet')
shopModule:addSellableItem({'studded helmet'}, 2482, 20,'studded helmet')
shopModule:addSellableItem({'viking helmet'}, 2473, 66,'viking helmet')

shopModule:addSellableItem({'belted cape'}, 8872, 500,'belted cape')
shopModule:addSellableItem({'brass armor'}, 2465, 150,'brass armor')
shopModule:addSellableItem({'chain armor'}, 2464, 70,'chain armor')
shopModule:addSellableItem({'coat'}, 2651, 'coat')
shopModule:addSellableItem({'dark armor'}, 2489, 400,'dark armor')
shopModule:addSellableItem({'jacket'}, 2650,'jacket')
shopModule:addSellableItem({'leather armor'}, 2467, 12,'leather armor')
shopModule:addSellableItem({'leopard armor'}, 3968, 1000,'leopard armor')
shopModule:addSellableItem({'noble armor'}, 2486, 900,'noble armor')
shopModule:addSellableItem({'plate armor'}, 2463, 400,'plate armor')
shopModule:addSellableItem({'scale armor'}, 2483, 75,'scale armor')
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
	local player = Player(cid)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local questStatus = player:getStorageValue(trashSellerQuest.baseStorage)
	if msg == "job" or msg == "beruf" or msg == "schmiede" then
		npcHandler:say(
		{
			'Ich bin der Schmied von Pulgra und kaufe allerlei Waffen, Schilde und Rüstungen. Frag mich einfach nach einem {trade}. ...',
			'Wenn du allerdings an mehr interessiert bist, ich arbeite zur Zeit auch an einem {Prototypen} zum Items verkaufen.'
		},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'prototyp') or msgcontains(msg, "trash seller") then
		if questStatus == -1 then
			npcHandler:say(
			{
				"Ich habe durch enge und lange Zusammenarbeit mit Majux eine Alchemie Station entwickelt, die es einem ermöglicht unterwegs Metalle zu zersetzen. ...",
				"Durch ein Quantenportal, wird die Portable Station mit meiner Schmiede verbunden und alles, was unterwegs zersetzt wird, landet in seiner Rohform hier bei mir. ...",
				"Aber das ist noch nicht alles. Ich bin nicht nur in der Lage Materie auf diesem Weg zu empfangen, sondern auch zu verschicken. ...",
				"Dadurch ist es möglich, dass ich Dir, wenn du unterwegs Metalle zersetzt, direkt den entsprechenden Gegenwert in Gold zukommen lassen kann. ...",
				"Somit also das ideale Tool, für jeden Kämpfer, der unterwegs viele Items findet, die sonst viel zu schwer zum tragen wären. ...",
				"Und da kommst du ins Spiel. Ich sehe du bist Abenteuerlustig, Dir fehlt es jedoch noch am nötigen Kleingeld. Hättest du Interesse, mit meinem Prototypen einen Feldversuch durchzuführen?"
			},cid)
			talkState[talkUser] = 1
		end
		
		
	elseif msgcontains(msg, 'crown armor') then
		player:addItem(26378,1)
		player:setStorageValue(trashSellerQuest.baseStorage,0)
		npcHandler:say('Wenn du mir eine Crown Armor bringst, kann ich dir ein schönes {Piece of Royal Steel} schmieden! Hast du eine dabei?',cid)
	elseif msgcontains(msg, 'giant sword') then
		npcHandler:say('Wenn du mir ein Giant Sword bringst, kann ich dir ein schönes {Huge Chunk of Crude Iron} schmieden! Hast du eine dabei?',cid)
		talkState[talkUser] = 2
	elseif msgcontains(msg, 'devil helmet') then
		npcHandler:say('Wenn du mir einen Devil Helmet bringst, kann ich dir ein schönes {Piece of Hell Steel} schmieden! Hast du eine dabei?',cid)
		talkState[talkUser] = 3
	elseif msgcontains(msg, 'dragon shield') then
		npcHandler:say('Wenn du mir ein Dragon Shield bringst, kann ich dir ein schönes {Piece of Draconian Steel} schmieden! Hast du eine dabei?',cid)
		talkState[talkUser] = 4
	elseif msgcontains(msg, 'piece of royal steel') then
		npcHandler:say('Wenn du ein Piece of Royal Steel willst, musst du mir eine {Crown Armor} bringen! Deal?',cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'piece of draconian steel') then
		npcHandler:say('Wenn du ein Piece of Draconian Steel willst, musst du mir ein {Dragon Shield} bringen! Deal?',cid)
		talkState[talkUser] = 4
	elseif msgcontains(msg, 'piece of hell steel') then
		npcHandler:say('Wenn du ein Piece of Hell Steel willst, musst du mir einen {Devil Helmet} bringen! Deal?',cid)
		talkState[talkUser] = 3
	elseif msgcontains(msg, 'huge chunk of crude iron') then
		npcHandler:say('Wenn du ein Huge Chunk of Crude Iron willst, musst du mir ein {Giant Sword} bringen! Deal?',cid)
		talkState[talkUser] = 2	
	elseif msgcontains(msg, 'outfit') or msgcontains(msg, 'sword') or msgcontains(msg, 'schwert') then
		if getPlayerStorageValue(cid, 22014) == -1 then
			npcHandler:say('Das Schwert da auf meinem Rücken meinst du? Ja das ist wahrhaft eine Meisterleistung, selbst geschmiedet wohl gemerkt. Haste da nen Gefallen dran gefunden?',cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, 22014) == 1 then
			npcHandler:say('Du schon wieder? Hast du die 100 {Iron Ores} dabei?',cid)
			talkState[talkUser] = 7
		elseif getPlayerStorageValue(cid, 22014) == 2 then
			npcHandler:say('Du bist also hier um dich von deinem {Piece of Royal Steel} zu verabschieden? Hahaha',cid)
			talkState[talkUser] = 8
		elseif getPlayerStorageValue(cid, 22014) == 3 then
			npcHandler:say('Nun ich muss schon zugeben, dass dir das Schwert wirklich exzellent steht!',cid)
			talkState[talkUser] = 0
			
		end
		
		
	elseif msg == "ja" or msg == "yes" then
		if talkState[talkUser] == 1 and questStatus == -1 then
			npcHandler:say(
			{
				"Das hatte ich gehofft, wunderbar! Gut fangen wir vorne an. Als erstes musst du eine Quantenverschränkung mit der Schmiede herstellen, um Materie hin und her zu schicken. ...",
				"Ich will dich auch gar nicht all zu sehr mit Einzellheiten langweilen, da ich selbst nur wenig über dieses Thema weiß. Majux ist der Alchemist mit dem Durchblick in Quantenphysik. ...",
				"Bitte gehe zu ihm und frage ihn nach 'Quantenverschränkung', er sollte dann alles weitere mit dir klären. Wenn du damit durch bist, komm wieder hier her."
			},cid)
			player:setStorageValue(trashSellerQuest.baseStorage,1)
			player:setStorageValue(trashSellerQuest.mission1,1)
			talkState[talkUser] = 0
			
			
		elseif talkState[talkUser] == 2 then -- Giant Sword
			if getPlayerStorageValue(cid, 5890) <= os.time() then
				if doPlayerRemoveItem(cid, 2393, 1) == TRUE then
					npcHandler:say('Alles klar, ich werde gleich mit der Arbeit beginnen. Du kannst dein Huge Chunk of Crude Iron in ca 3 Stunden in der Kiste dort vorne holen kommen.',cid)
					-- doPlayerAddItem(cid, 5892, 1)
					setPlayerStorageValue(cid, 5892, os.time()+BrutusTimer)
					setPlayerStorageValue(cid, 5890, os.time()+BrutusTimer)
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('Es tut mir leid, aber ich brauche ein Giant Sword dafür.',cid)
				end
			else
				npcHandler:say('Es tut mir leid, aber ich kann immer nur ein Teil für dich schmieden. Bitte warte, bis ich mit der Arbeit fertig bin.',cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then -- Devil Helmet
			if getPlayerStorageValue(cid, 5890) <= os.time() then
				if doPlayerRemoveItem(cid, 2462, 1) == TRUE then
					npcHandler:say('Alles klar, ich werde gleich mit der Arbeit beginnen. Du kannst dein Piece of Hell Steel in ca 3 Stunden in der Kiste dort vorne holen kommen.',cid)
					-- doPlayerAddItem(cid, 5888, 1)
					setPlayerStorageValue(cid, 5888, os.time()+BrutusTimer)
					setPlayerStorageValue(cid, 5890, os.time()+BrutusTimer)
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('Es tut mir leid, aber ich brauche einen Devil Helmet dafür.',cid)
				end
			else
				npcHandler:say('Es tut mir leid, aber ich kann immer nur ein Teil für dich schmieden. Bitte warte, bis ich mit der Arbeit fertig bin.',cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 4 then -- Dragon Shield
			if getPlayerStorageValue(cid, 5890) <= os.time() then
				if doPlayerRemoveItem(cid, 2516, 1) == TRUE then
					npcHandler:say('Alles klar, ich werde gleich mit der Arbeit beginnen. Du kannst dein Piece of Draconian Steel in ca 3 Stunden in der Kiste dort vorne holen kommen.',cid)
					-- doPlayerAddItem(cid, 5889, 1)
					setPlayerStorageValue(cid, 5889, os.time()+BrutusTimer)
					setPlayerStorageValue(cid, 5890, os.time()+BrutusTimer)
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('Es tut mir leid, aber ich brauche ein Dragon Shield dafür.',cid)
				end
			else
				npcHandler:say('Es tut mir leid, aber ich kann immer nur ein Teil für dich schmieden. Bitte warte, bis ich mit der Arbeit fertig bin.',cid)
			end
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 5 then
			npcHandler:say(
			{
				'Hahaha, ja das dachte ich mir schon, wer ist nicht scharf auf das Teil, was? Nun es zu schmieden ist allerdings kein Kinderspiel und kostet ein paar Resourcen. ...',
				'Um es herzustellen brauche ich mindestens... hmm... sagen wir 100 {Iron Ores}. Und für den Griff noch ein schönes {Piece of Royal Steel} ...',
				'Das kannst du auch direkt von mir herstellen lassen, kostet dich nur ne {Crown Armor} und ein bisschen Zeit. Also, haben wir nen Deal?'
			},cid)
			talkState[talkUser] = 6
		elseif talkState[talkUser] == 6 then
			npcHandler:say('Na gut, dann verschwende mal keine Zeit und geht die Materialien sammeln!',cid)
			setPlayerStorageValue(cid, 22014, 1)
			setPlayerStorageValue(cid, 22000, 1)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 7 then
			if getPlayerItemCount(cid, 5880) >= 100 then
				doPlayerRemoveItem(cid, 5880, 100) 
				npcHandler:say('Das ist ja sagenhaft! 100 markelose {Iron Ores}. Und alle auf einen Haufen das ist super! Bring mir jetzt noch ein {Piece of Royal Steel} und du hast dein Schwert.', cid)
				setPlayerStorageValue(cid, 22014, 2)
				talkState[talkUser] = 0
			else
				npcHandler:say('Ähmm, wo sind da jetzt die 100 Iron Ores, bitte? Ich hab auch noch andere Sachen zu tun, stör mich bitte nicht sinnlos.', cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif talkState[talkUser] == 8 then
			if doPlayerRemoveItem(cid, 5887, 1) == TRUE then
				npcHandler:say('Ja, das ist schade, haha. Aber du bekommst ja auch was schönes im Gegenzug dafür. Nur hier ein wenig hämmern und dort... FERTIG! Hier bitte, viel Spaß mit deinem neuen Schwert!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 22014, 3)
				addAddon(cid, "warrior", 2)
				doSendMagicEffect(getPlayerPosition(cid), 13)
			else
				npcHandler:say('Und ich hab mich schon gefreut, endlich mal wieder was feines zu schmieden.', cid)
				talkState[talkUser] = 0
			end
		end
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

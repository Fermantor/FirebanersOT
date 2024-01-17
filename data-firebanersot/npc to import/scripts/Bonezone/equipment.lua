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

shopModule:addBuyableItem({'beach backpack'}, 5949, 20, 1,'beach backpack')
shopModule:addBuyableItem({'beach bag'}, 5950, 4, 1,'beach bag')

shopModule:addBuyableItem({'shovel'}, 2554, 50, 1,'shovel')
shopModule:addBuyableItem({'pick'}, 2553, 50, 1,'pick')
shopModule:addBuyableItem({'rope'}, 2120, 50, 1,'rope')
shopModule:addBuyableItem({'machete'}, 2420, 50, 1,'machete')
shopModule:addBuyableItem({'fishing'}, 2580, 50, 1,'fishing rod')
shopModule:addBuyableItem({'scythe'}, 2550, 50, 1,'scythe')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Also ik mach eigentlich nur Backpacks, Shovels und noch en paar andere Sachen. Dat Metall für die Utensilien krieg ich natürlich aus Pulgra geliefert, jeden Montag morgen. Die ham da nämlich ne Dwarvenhöhle, weißte? ...',
						'Aber wennde irgendwelchen Sachen für die Küche willst, musste mit meiner Frau Florena sprechen, sowat verkauf ik nämlich nicht.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'vial') then
		npcHandler:say('Hmm, ik glaub in Little Cotton jibbet einen Mann, der heißt Xantharus. Ich hab jehört, der verkauft Vials.', cid)
	elseif msgcontains(msg, 'sword') or msgcontains(msg, 'schwert') then
		if getPlayerStorageValue(cid, outfits.knightAddon1) == -1 then
			npcHandler:say({'Ahh, dir sinn die Besonderheiten an meinem Outfit und an dem meiner Frau aufgefallen? Dat ist schön! Nun, es hat mich einiges an Arbeit gekostet, dat alles herzustellen. ...',
							'Wennde willst, kann ich dafür sorgen, dat auch du so wunderbar ausehen wirst, wie wir es tun. Auch wenn es dich etwas kosten wird. Hmm, wie wärs, Interesse?'},cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, outfits.knightAddon1) == 1 then
			npcHandler:say('Bist du allen ernstes hier, um mir die 100 {Iron Ores} zu bringen?',cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, outfits.knightAddon1) == 2 then
			npcHandler:say('Ahh, du hast es also tatsächlich geschafft ein {Huge Cunk of Crude Iron} zu besorgen?',cid)
			talkState[talkUser] = 4
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say({'Soso, dat freut mich ja. Wie ich es dir allerdings schon gesagt habe ist dat alles nicht umsonst, ne? Vielleicht weißte es ja schon, aber in Pulgra gibts ne Dwarvenhöhle, in der es von Eisen nur so wimmelt. ...',
							'Ich benutze dieses Eisen um meine Ware herzustellen, obwohl es nicht sehr einfach ist, da dran zu kommen. Deswegen ist es auch sehr kostbar. Du kannst das Eisen natürlich auch sonst wo herholen, aber es muss echtes Iron Ore sein. Und davon 100 Stück. ...',
							'Außerdem brauche ich dann noch ein Huge Chunk of Crude Iron. Da musst du allerdings selber mal gucken, wo du das herbekommst, weiß ik nämlich nicht. Sprich doch mal mit Brutus in Pulgra. ...',
							'Also, {100 Iron Ores} und ein {Huge Chunk of Crude Iron}, dann kriegste dein Schwert. Bist du in der Lage mir dat zu bringen?'},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Das find ik wirklich toll. Na dann mach dich mal an die Arbeit!',cid)
			setPlayerStorageValue(cid, outfits.knightAddon1, 1)
			setPlayerStorageValue(cid, outfits.questLog, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			if getPlayerItemCount(cid, 5880) >= 100 then
				doPlayerRemoveItem(cid, 5880, 100) 
				npcHandler:say('Dat ist ja der Wahnsinn! 100 echte fein gearbeitete Iron Ores. So viele hatte ik noch nie auf einmal. Entschuldige. Nun den Huge Chunk of Crude Iron, bitte. Wahnsinn! 100 Iron Ores...', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, outfits.knightAddon1, 2)
			else
				npcHandler:say('Ähmm, wo sind da jetzt die 100 Iron Ores, bitte? Ik hab auch noch andere Sachen zu tun, stör mich bitte nicht sinnlos.', cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		elseif talkState[talkUser] == 4 then
			if doPlayerRemoveItem(cid, 5892, 1) == TRUE then
				npcHandler:say('Jawohl, davon hab ik geredet. Ich vermute, du musstest etwas eintauschen. Wie auch immer: Hier hast du dein wohlverdientes Schwert für dein Outfit!', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, outfits.questLog, 1)
				setPlayerStorageValue(cid, outfits.knightAddon1, 3)
				Player(cid):addOutfitAddon(139,1)
				Player(cid):addOutfitAddon(131,1)
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_RED)
			else
				npcHandler:say('Und ik hab mich schon gefreut, aber et war irgendwie klar, dass du das nicht schaffst.', cid)
				talkState[talkUser] = 0
				npcHandler:releaseFocus(cid)
			end
		end
	elseif msgcontains(msg, 'nein') or msgcontains(msg, 'no') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Naja, schade! Ik dachte wirklich es hätte endlich mal jemand Interesse.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Na dat hättest du mal früher sagen können. Dann hätt ich mir meine ausschweifende Rede sparen können.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 3 then
			npcHandler:say('Achso, ja dann frag doch einfach nach einem {trade}.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		elseif talkState[talkUser] == 4 then
			npcHandler:say('Nicht? Schade. Ist aber auch schwierig dieses verdammte Ding zu kriegen.',cid)
			talkState[talkUser] = 0
			npcHandler:releaseFocus(cid)
		end
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

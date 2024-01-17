local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)             	    npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid)           	npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg)     		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()                           	npcHandler:onThink() 						end
 
 
function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) and npcHandler:isInRange(cid) and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'hallo')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.hepzibahJoin) <= 1 then
			npcHandler:greet(cid)
			return TRUE
		else
			npcHandler:say('Wasss wagst du es mich anzusprechen, Feind?', cid)
			return false
		end	
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		npcHandler:say({'Issss dasss wahr? Du möchstessst etwasss über meinen Beruf wissen? Nun ja, Ich bewache den Eingang der Mocous Lair, die Höhle gleich zu unsssseren Füßzssen. Oder zumindest deinen Füßzssen. ...',
						'Denn in diessser Höhle lebt meine Königin Striphin, die weißzsse Hexe der Natur. Ich diene ihr nun schon ssseit Jahren und will mich keinem anderen anschließzssen. ...',
						'Ich empfehle auch dir, dich ihr anzuschließzssen, da sie die gutmütigste und großzügigste Frau issst, die ich je kennenlernen durfte.'},cid)
	elseif msgcontains(msg, 'mocous lair') then
		npcHandler:say('Diesss issst die Höhle hier gleich vor meinem kleinen Hügel. Sszie isst mit giftigen Kreaturen bestückt. Dasss heißt, dass nur wahre Krieger essz bisss zum Hausss meiner Königin Striphin schaffen.', cid)
	elseif msgcontains(msg, 'hepzibah') then
		npcHandler:say({'Bitte frag mich nicht nach ihr. Diessse abscheuliche Kreatur versucht schon sszeit Jahren ihre Schwester Striphin zu vernichten. Denn sszie issst die bössze und schwarze Hexe der Monsster und Ungeheuer. ...',
						'Du verfeindest dich mit unsss, wenn du dich ihr anschließst. Ich würde esss dir nicht empfehlen.'},cid)
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say({'Ihre hochwohl geborene Königlichkeit isssst meine Mutter in allen Zzzeiten. Ich diene ihr bissz an mein Lebensssende und kämpfe gegen jene, welche ihr feindlich gesssinnt sind. ...',
						'Wenn du den Zugang zu ihrem Hausss und ihr Vertrauen haben willst, kann ich ihr bescheid geben, dass du ein wahrer und vertrauenssswürdiger Kämpfer bisst.'},cid)
	elseif (msgcontains(msg, 'beitritt') or msgcontains(msg, 'anschließzssen') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschließen') or msgcontains(msg, 'join')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == -1 then
			if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah) ~= 2 then
				npcHandler:say('Alssszo gut. Sssoll ich dir den Zszzugang zu Striphins Hausss gewähren, sodassss du mal mit ihr sprechen kannssst, um dich ihr anzuschließzssen?', cid)
				talkState[talkUser] = 1
			else
				npcHandler:say('WASSSZ? Wie ich sehe, hasszt du dich bereitsss Hepzibah angeschlosszen. Verschwinde bloßzs, oder ich werde dich angreifen.', cid)
				talkState[talkUser] = 0
			end
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 1 then
			npcHandler:say('Wie gessagt, du hassst nun die Wahl: Entweder du schließsst dich meiner Königin Striphin an, welche dich bereitsss erwartet, oder du machssst dich zum Feind und gehst auf Hepzibahs Sssseite. Entscheide klug!', cid)
		else
			npcHandler:say('Wasss meinst du damit? Du bissst doch bereitss Teil unserer Allianz. Oder hegst du etwa Misstrauen?', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dann werde ich ihr ssssagen, dass sszie auf einen starken tapferen Kämpfer warten sssoll. Wobei du dich natürlich immer noch entscheiden kannst, bisssher hassst du ja kein Vertrag unterschrieben. Ssssss...', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, 1) -- 1. Tür
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionQuestLog, 1) -- Questlog Fraktionen
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin, 1) -- Questlog Striphin anschließen
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Schließzss dich bloßzss nicht {Hepzibah} an.', cid)
			talkState[talkUser] = 0
		end
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
--npcHandler:addModule(FocusModule:new())
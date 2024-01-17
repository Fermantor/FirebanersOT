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
		npcHandler:say({'Issss dasss wahr? Du m�chstessst etwasss �ber meinen Beruf wissen? Nun ja, Ich bewache den Eingang der Mocous Lair, die H�hle gleich zu unsssseren F��zssen. Oder zumindest deinen F��zssen. ...',
						'Denn in diessser H�hle lebt meine K�nigin Striphin, die wei�zsse Hexe der Natur. Ich diene ihr nun schon ssseit Jahren und will mich keinem anderen anschlie�zssen. ...',
						'Ich empfehle auch dir, dich ihr anzuschlie�zssen, da sie die gutm�tigste und gro�z�gigste Frau issst, die ich je kennenlernen durfte.'},cid)
	elseif msgcontains(msg, 'mocous lair') then
		npcHandler:say('Diesss issst die H�hle hier gleich vor meinem kleinen H�gel. Sszie isst mit giftigen Kreaturen best�ckt. Dasss hei�t, dass nur wahre Krieger essz bisss zum Hausss meiner K�nigin Striphin schaffen.', cid)
	elseif msgcontains(msg, 'hepzibah') then
		npcHandler:say({'Bitte frag mich nicht nach ihr. Diessse abscheuliche Kreatur versucht schon sszeit Jahren ihre Schwester Striphin zu vernichten. Denn sszie issst die b�ssze und schwarze Hexe der Monsster und Ungeheuer. ...',
						'Du verfeindest dich mit unsss, wenn du dich ihr anschlie�st. Ich w�rde esss dir nicht empfehlen.'},cid)
	elseif msgcontains(msg, 'striphin') then
		npcHandler:say({'Ihre hochwohl geborene K�niglichkeit isssst meine Mutter in allen Zzzeiten. Ich diene ihr bissz an mein Lebensssende und k�mpfe gegen jene, welche ihr feindlich gesssinnt sind. ...',
						'Wenn du den Zugang zu ihrem Hausss und ihr Vertrauen haben willst, kann ich ihr bescheid geben, dass du ein wahrer und vertrauensssw�rdiger K�mpfer bisst.'},cid)
	elseif (msgcontains(msg, 'beitritt') or msgcontains(msg, 'anschlie�zssen') or msgcontains(msg, 'zugang') or msgcontains(msg, 'anschlie�en') or msgcontains(msg, 'join')) then
		if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == -1 then
			if getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionHepzibah) ~= 2 then
				npcHandler:say('Alssszo gut. Sssoll ich dir den Zszzugang zu Striphins Hausss gew�hren, sodassss du mal mit ihr sprechen kannssst, um dich ihr anzuschlie�zssen?', cid)
				talkState[talkUser] = 1
			else
				npcHandler:say('WASSSZ? Wie ich sehe, hasszt du dich bereitsss Hepzibah angeschlosszen. Verschwinde blo�zs, oder ich werde dich angreifen.', cid)
				talkState[talkUser] = 0
			end
		elseif getPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin) == 1 then
			npcHandler:say('Wie gessagt, du hassst nun die Wahl: Entweder du schlie�sst dich meiner K�nigin Striphin an, welche dich bereitsss erwartet, oder du machssst dich zum Feind und gehst auf Hepzibahs Sssseite. Entscheide klug!', cid)
		else
			npcHandler:say('Wasss meinst du damit? Du bissst doch bereitss Teil unserer Allianz. Oder hegst du etwa Misstrauen?', cid)
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Dann werde ich ihr ssssagen, dass sszie auf einen starken tapferen K�mpfer warten sssoll. Wobei du dich nat�rlich immer noch entscheiden kannst, bisssher hassst du ja kein Vertrag unterschrieben. Ssssss...', cid)
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.striphinJoin, 1) -- 1. T�r
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionQuestLog, 1) -- Questlog Fraktionen
			setPlayerStorageValue(cid, theQuestOfTheQuarreledWitches.fractionStriphin, 1) -- Questlog Striphin anschlie�en
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, 'no') or msgcontains(msg, 'nein') then
		if talkState[talkUser] == 1 then
			npcHandler:say('Schlie�zss dich blo�zss nicht {Hepzibah} an.', cid)
			talkState[talkUser] = 0
		end
	end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
--npcHandler:addModule(FocusModule:new())
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

function gnometteRecruits(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
    end
	if getPlayerStorageValue(cid, 51234) == 1 then
		npcHandler:say('Exzellent! Ich bin so aufgeregt, wegen all dieser mutigen Leute, die beitreten wollen. So, du kannst nun anfangen {Missionen} für unser Rekruten Programm die Treppe runter zu erledigen, ich werde dir den Mittelsmann auf der Karte markieren. Aber erstmal solltest du vielleicht wissen, {worum} es hier überhaupt geht!', cid)
		setPlayerStorageValue(cid, 51234, 2)
		setPlayerStorageValue(cid, 51240, 0)
		doAddMapMark(cid, { x = 2393, y = 2049, z = 10 }, MAPMARK_EXCLAMATION, "Commander Stone (Missions)")    
	elseif getPlayerStorageValue(cid, 51234) == 2 then
		npcHandler:say('Du bist doch bereits Mitglied!', cid)
	else
		npcHandler:say('Du solltest erst mit Xelvar reden. Wie bist Du überhaupt hier hin gekommen?', cid)
	end
	keywordHandler:moveUp(1)
	return true
end

local node1 = keywordHandler:addKeyword({'rekruten'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'So, du bist also hier um ein Rekrut zu werden?'})
node1:addChildKeyword({'ja'}, gnometteRecruits, {npcHandler = npcHandler, onlyFocus = true, reset = true})
node1:addChildKeyword({'yes'}, gnometteRecruits, {npcHandler = npcHandler, onlyFocus = true, reset = true})
node1:addChildKeyword({'nein'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Okay, Dann komm wieder, wenn du deine Meinung geÃ¤ndert hast.', reset = true})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Okay, Dann komm wieder, wenn du deine Meinung geÃ¤ndert hast.', reset = true})
npcHandler:addModule(FocusModule:new())





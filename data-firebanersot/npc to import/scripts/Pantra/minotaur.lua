local story = {}
local talkState = {}
local Wave = 1
local WaveDelay = 3 -- Minuten
local Mino = 
{
	
	[1]	=	
		{
		["Minotaur"] = {
						{ x = 753 , y = 219 , z = 14 },
						{ x = 743 , y = 219 , z = 14 },
						{ x = 749 , y = 212 , z = 14 },
						{ x = 745 , y = 212 , z = 14 },
						{ x = 747 , y = 222 , z = 14 }
						}
		},
	[2]	=	
		{
		["Minotaur"] = {
						{ x = 753 , y = 219 , z = 14 },
						{ x = 743 , y = 219 , z = 14 },
						{ x = 749 , y = 212 , z = 14 },
						{ x = 745 , y = 212 , z = 14 },
						{ x = 747 , y = 222 , z = 14 },
						{ x = 747 , y = 201 , z = 14 }
						}
		},
	[3]	=	
		{
		["Minotaur"] = {
						{ x = 753 , y = 219 , z = 14 },
						{ x = 743 , y = 219 , z = 14 },
						{ x = 749 , y = 212 , z = 14 },
						{ x = 745 , y = 212 , z = 14 },
						{ x = 747 , y = 222 , z = 14 },
						{ x = 747 , y = 201 , z = 14 },
						{ x = 747 , y = 205 , z = 14 }
						}
		},
	[4]	=	
		{
		["Minotaur"] = {
						{ x = 743 , y = 219 , z = 14 },
						{ x = 749 , y = 212 , z = 14 },
						{ x = 745 , y = 212 , z = 14 },
						},
		["PantraMinotaurBoss"] = {
						{ x = 748 , y = 223 , z = 14 }
						}
		},
	[5]	=	
		{
		["Minotaur"] = {
						{ x = 743 , y = 219 , z = 14 },
						{ x = 749 , y = 212 , z = 14 },
						{ x = 745 , y = 212 , z = 14 },
						},
		["PantraOrcBoss"] = {
						{ x = 748 , y = 223 , z = 14 }
						}
		},
}

function MinotaurenSpawnen()
	for monster, position in pairs(Mino[Wave]) do
		for i = 1, #position do
			doSummonCreature(monster, position[i])
		end
	end
	if Wave ~= #Mino then
		Wave = Wave + 1
		addEvent(MinotaurenSpawnen, 1000*60*WaveDelay)
	else
		setGlobalStorageValue(13016, 1)
		doSetItemActionId(getThingfromPos({ x = 559, y = 235, z = 9, stackpos = 1}).uid, 23016)
		Wave = 1
	end
end
 
local function cancelStory(cid)
	if not(story[cid]) then return true end
	for _, eventId in pairs(story[cid]) do
		stopEvent(eventId)
	end
	story[cid] = {}
end
 
function creatureFarewell(cid)
	--if not(isPlayer(cid)) then return true end
	cancelStory(cid)
	return true
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	cancelStory(cid)
	if msgcontains(msg, 'job') then
		npcHandler:say("Ich bin der Minotauren König von Pantra. Meine bestimmung ist es diese {Tür} hier verschloßen zu halten.", cid)
	elseif msgcontains(msg, 'tür') or msgcontains(msg, 'türe') or msgcontains(msg, 'door') or msgcontains(msg, 'öffnen') then
		npcHandler:say("Hinter dieser {Tür} ist das dritte und letzte {Siegel} von Pantra, zur Befreiung des {Drachens}.", cid)
	elseif msgcontains(msg, 'drache') or msgcontains(msg, 'drachen') or msgcontains(msg, 'dragon') then
		local Text1 = "Der Drache lebt tief unter Pantra und bewacht die Stadt vor dem Bösen. Nur wenige haben ihn bisher gesehen und zweifeln seine existens an ..."
		local Text2 = "Fakt ist, man muss alle 3 {Siegel} brechen, um zur Kammer des Drachen zu gelangen."
		story[cid] = selfStory({Text1, Text2}, cid, 8000)
	elseif msgcontains(msg, 'siegel') then
		npcHandler:say("Um zum dritten und letzten Siegel zu gelangen, musst Du durch die verschloßene {Tür} hinter mir. Ich werde sie aber nicht öffnen, bevor du nicht den {Test} bestanden hast.", cid)
	elseif (msgcontains(msg, 'test') or msgcontains(msg, 'prüfung') or msgcontains(msg, 'fight')) and getGlobalStorageValue(13015) ~= 1 then
		npcHandler:say("Wenn ich die {Tür} öffnen soll, musst du meine Armee besiegen. Aber ich fackel nicht lange rum, denn ich sehe das Feuer in deinen Augen. Willst du dich versuchen?", cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, 'ja') and talkState[talkUser] == 1 then
		npcHandler:say("MEINE MINOTAUREN! ZUM ANGRIFF!!!", cid)
		setGlobalStorageValue(13015, 1)
		addEvent(MinotaurenSpawnen, 1000)
		talkState[talkUser] = 0
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'nein') and talkState[talkUser] == 1 then
		npcHandler:say("Haha, das dachte ich mir schon, hast wohl die Hosen voll, was? Lauf lieber um dein Leben, bevor ich es mir anders überlege!", cid)
		npcHandler:releaseFocus(cid)
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, creatureFarewell)
npcHandler:setCallback(CALLBACK_CREATURE_DISAPPEAR, creatureFarewell)
npcHandler:addModule(FocusModule:new())

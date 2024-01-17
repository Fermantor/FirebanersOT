local function cancelStory(cid)
	if not(story[cid]) then return true end
	for _, eventId in pairs(story[cid]) do
		stopEvent(eventId)
	end
	story[cid] = {}
end
 
function creatureFarewell(cid)
	if not(isPlayer(cid)) then return true end
	cancelStory(cid)
	return true
end

local EliteHunterValue  = 20010

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local story = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end
 
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'NAME'}, ID, KOSTEN, SUBTYPE,'NAME IM TRADE FENSTER')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	cancelStory(cid)
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') then
		if getPlayerStorageVlaue(cid, EliteHunterValue) == -1 then
			npcHandler:say('Wie schon gesagt, bin ich die Empfangsdame der {Elite Hunter} Gilde. Ich nehme Anträge für Neuanmeldungen an. Sag bescheid, wenn du {beitreten} willst.',cid)
		elseif getPlayerStorageValue(cid, EliteHunterValue) == 0
			npcHandler:say('Wie schon gesagt, bin ich die Empfangsdame der {Elite Hunter} Gilde. Deinen Antrag hab ich übrigens nicht vergessen.',cid)
		else
			npcHandler:say('Wie schon gesagt, bin ich die Empfangsdame der {Elite Hunter} Gilde. Aber als Mitglied weißt du das natürlich.',cid)
		end
	elseif msgcontains(msg, 'elite hunter') or msgcontains(msg, 'guild') or msgcontains(msg, 'gilde') then
		local Text1 = 'Wir sind die Elite Hunter Gilde. Wir sind eine der größten Gilde in ganz Fireban. Wir tragen sogar unser eigenes Outfit um uns zu Kennzeichnen. ...'
		local Text2 = 'So kannst du sofort sehen, ob jemand ein Mitglied ist oder nicht. Aber nun zu unseren Aufgaben und Interessen. Dazu zähl natürlich das Jagen von allen möglichen Monstern und Kreaturen. ...'
		local Text3 = 'Das machen wir einmal, um unsere Stärke zu demonstrieren und andererseits sorgen wir durch gezieltest töten von Monstern, das Gleichgewichtg aufrecht zu erhalten.'
		story[cid] = selfStory({Text1, Text2, Text3}, cid, 8000)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'join') or msgcontains(msg, 'beitreten') or msgcontains(msg, 'mitglied') or msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, EliteHunterValue) == -1 then
			npcHandler:say('Oh, du willst dich also bewerben, bei der {Elite Hunter Gilde} Mitglied zu werden?',cid)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, EliteHunterValue) == 0 then
			if getPlayerLevel(cid) >= getPlayerStorageValue(cid, 20011) then
				local Text1 = 'Herrvoragend. Ja du jagst wirklich aktiv wie ich sehe. Nun gut, dann spricht nichts mehr dagegen, dass du dich nun als Mitglied der Elite Hunter Gilde bezeichnen kannst. ...'
				local Text2 = 'Du darfst zwar noch nicht unser Outfit tragen, aber du kannst nun jederzeit unsere Guildhall betreten und die NPCs {A} oder {B} nach Missionen fragen. Komme wieder, wenn du den Rang Kundschafter hast.'
				story[cid] = selfStory({Text1, Text2}, cid, 8000)
				setPlayerStorageValue(cid, EliteHunterValue, 1)
				setPlayerStorageValue(cid, 20020, -1)
				setPlayerStorageValue(cid, RANG, 1)
				setPlayerStorageValue(cid, RANG, 1)
				talkState[talkUser] = 0
			else
				npcHandler:say('Oh, du willst dich also bewerben, bei der {Elite Hunter Gilde} Mitglied zu werden?',cid)
				
			
			
			
			end
		
		
		
		
		
		end
	elseif msgcontains(msg, 'ja') and talkState[talkUser] == 1 then
		if getPlayerLevel(cid) >= 20 then
			local Text1 = 'Das ist ja schön, wie sehe bist du auch schon Level 20. Damit hast du den ersten Teil, der Aufnahmeprüfung bestanden. ...'
			local Text2 = 'Für den zweiten Teil, musst du uns beweisen, dass du auch weiterhin aktiv jagst. ...'
			local Text3 = 'Dies tust du, indem du weitere Level machst. Steige um 5 weitere Level auf und komme dann wieder.'
			story[cid] = selfStory({Text1, Text2, Text3}, cid, 8000)
			setPlayerStorageValue(cid, 20020, 1)
			setPlayerStorageValue(cid, EliteHunterValue, 0)
			setPlayerStorageValue(cid, 20011, getPlayerLevel(cid) + 5)	
			talkState[talkUser] = 0
		else
			local Text1 = 'Das ist ja schön, nur leider bist du noch nichtmal Level 20. Das ist das Mindestlevel, dass du haben musst. ...' 
			local Text2 = 'Denn wir wollen nicht, dass unsere Missionen für schwächere Mitglieder zu gefährlich sind. Komm einfach wieder, wenn du Level 20 oder höher bist.'
			story[cid] = selfStory({Text1, Text2}, cid, 8000)
			talkState[talkUser] = 0
		end
	end
	
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

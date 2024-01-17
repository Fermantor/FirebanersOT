local story = {}
 
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

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

npcHandler:setMessage(MESSAGE_GREET, "Hallo |PLAYERNAME|. In was soll ich dich unterrichten? {Vocations}, {Spells}, {Städte}", cid)

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	cancelStory(cid)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'vocation') or msgcontains(msg, 'vocations') then
		npcHandler:say('Nun gut, über welche Vocation möchtest du mehr erfahren? {Knight}, {Paladin}, {Druid} oder {Sorcerer}?', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'spell') or msgcontains(msg, 'spells') then
		npcHandler:say('Tja es tut mir leid, dir das sagen zu müssen, aber manchmal muss selbst ein Magister noch lernen. Dieses Thema werde ich dir wann anders näher erläutern.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'städte') or msgcontains(msg, 'staedte') then
		npcHandler:say('Tja es tut mir leid, dir das sagen zu müssen, aber manchmal muss selbst ein Magister noch lernen. Dieses Thema werde ich dir wann anders näher erläutern.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'knight') then
		npcHandler:say('Der Knight ist wohl die Wichtigste Klasse für ein starkes Team, was ihn aber nicht am stärksten macht. Ein Knight sollte bei starken Monster (fast) immer einen Healer (engl.: Heiler) haben, denn er heilt mit Zaubersprüchen und -tränken allein nicht genug um lange zu überleben. Aber wie wir jetzt schon sehen, gibt es keine wichtigste  Klasse, alle bauen auf einander auf und sollte niemals unterschätzt werden. ', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'paladin') then
		npcHandler:say('Der Paladin ist geschaffen für Angriffe aus der Ferne. Er kann die stärkste Waffe benutzen, den Assassin Star (ATK: 85) und mach somit reichlich Schaden. Da er nicht wenig Hitpoints hat, kann er auch teilweise als Blocker fungieren, und sich dank Ausreichender Heilsprüche auch selber ganz gut heilen. Er ist jedoch immer auf seine Speere, Pfeile, Wurfsterne, etc. angewiesen und verliert somit, am Anfang einer Jagt viel Cap durch Ausreichend Munition. Dies stellt aber auf höheren Leveln ein geringeres Problem da. ', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'sorcerer') then
		npcHandler:say('Wir verwenden hier den Begriff Mage, da Druid und Sorcerer sich zu 80% gleichen und wir sie somit in einen Sack packen. Nur die Zaubersprüche unterscheiden sie. Der Sorcerer ist eher ausgelegt auf Angriffszauber, wohingegen der Druid mehr Heilzauber beherrscht. Sie machen beide am meisten Schaden mit dem Magic Level und somit halt mit Zaubersprüchen. Aufgrund ihrer extrem geringen Anzahl an Hitpoints ist es trotzdem sehr schwer mit einem Mage zu Jagen, da er schnell sterben kann. ', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'druid') then
		npcHandler:say('Wir verwenden hier den Begriff Mage, da Druid und Sorcerer sich zu 80% gleichen und wir sie somit in einen Sack packen. Nur die Zaubersprüche unterscheiden sie. Der Sorcerer ist eher ausgelegt auf Angriffszauber, wohingegen der Druid mehr Heilzauber beherrscht. Sie machen beide am meisten Schaden mit dem Magic Level und somit halt mit Zaubersprüchen. Aufgrund ihrer extrem geringen Anzahl an Hitpoints ist es trotzdem sehr schwer mit einem Mage zu Jagen, da er schnell sterben kann. ', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'mission') then
		if getPlayerStorageValue(cid, 5010) == -1 then
			local Text1 = 'Ah, es ist immer gut, NPCs nach einer Mission zu fragen, da sie meistens Erfahrung und einzigartige Items einbringen ...'
			local Text2 = 'Zufällig habe auch ich eine Mission für dich, sie erfordert jedoch großen Mut und Stärke. Willst du mehr darüber hören?'
			story[cid] = selfStory({Text1, Text2}, cid, 8000)
			talkState[talkUser] = 1
		elseif getPlayerStorageValue(cid, 5010) == 1 then
			npcHandler:say('Ah, bist du hier um mir die pig foot zu geben?',cid)
			talkState[talkUser] = 3
		elseif getPlayerStorageValue(cid, 5010) == 2 then
			npcHandler:say('Hast du die 10 {spider fangs} dabei?',cid)
			talkState[talkUser] = 4
		elseif getPlayerStorageValue(cid, 5010) == 3 then
			npcHandler:say('Hast du die 5 {swamp grass} dabei?',cid)
			talkState[talkUser] = 5
		elseif getPlayerStorageValue(cid, 5010) == 4 then
			npcHandler:say('Hast du die 3 {pelvis bones} dabei?',cid)
			talkState[talkUser] = 6
		elseif getPlayerStorageValue(cid, 5010) == 5 then
			npcHandler:say('Hast du die 2 {orc leather} dabei?',cid)
			talkState[talkUser] = 7
		end
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if talkState[talkUser] == 1 then
			npcHandler:say(
			{
				'Meine Aufgabe für dich besteht aus vielen einzellnen Missionen, die es erfordern, dass du ganz Pantra bereist ... ',
				'In der ersten Mission musst du mir beweisen, dass dir Pantra nicht fremd ist und mir ein paar Items bringen. 10 {spider fangs}, 5 {swamp grass} ... ',
				'3 {pelvis bones}, 2 {orc leather} und eine {pig foot}. Wärst du bereit mir diese Items zu bringen? Die Belohnung ist auch nicht bescheiden.'
			},cid)
			talkState[talkUser] = 2
		elseif talkState[talkUser] == 2 then
			npcHandler:say('Hervoragend, sehr mutig von dir. Fangen wir mit dem einfachsten an, bringe mir zunächst eine {pig foot}.',cid)
			setPlayerStorageValue(cid, 5010, 1)
			talkState[talkUser] = 0
		elseif talkState[talkUser] == 3 then
			if doPlayerRemoveItem(cid, 10610, 1) == TRUE then
				npcHandler:say('Jawohl, genau das meinte ich. Jetzt nur nicht ausruhen. Bring mir als nächstes 10 {spider fangs}.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5010, 2)
			else
				npcHandler:say('Ich weiß nicht was du da hast, aber es ist auf jeden Fall keine {pig foot}. Komm wieder, wenn du eine hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 4 then
			if getPlayerItemCount(cid, 8859) >= 10 then
				doPlayerRemoveItem(cid, 8859, 10) 
				npcHandler:say('Sehr gut, nur weiter so. Als nächstes brauche ich die 5 {swamp grass}.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5010, 3)
			else
				npcHandler:say('Ich weiß nicht was du da hast, aber es sind auf jeden Fall keine 10 {spider fangs}. Komm wieder, wenn du welche hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 5 then
			if getPlayerItemCount(cid, 10603) >= 5 then
				doPlayerRemoveItem(cid, 10603, 5) 
				npcHandler:say('Herrvoragend, bring mir nun 3 {pelvis bones}.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5010, 4)
			else
				npcHandler:say('Ich weiß nicht was du da hast, aber es sind auf jeden Fall keine 5 {swamp grass}. Komm wieder, wenn du welche hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 6 then
			if getPlayerItemCount(cid, 12437) >= 3 then
				doPlayerRemoveItem(cid, 12437, 3) 
				npcHandler:say('Fantastisch du hast es bald geschaft. Bring mir jetzt noch 2 {orc leather}.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5010, 5)
			else
				npcHandler:say('Ich weiß nicht was du da hast, aber es sind auf jeden Fall keine 3 {pelvis bones}. Komm wieder, wenn du welche hast.', cid)
				talkState[talkUser] = 0
			end
		elseif talkState[talkUser] == 7 then
			if getPlayerItemCount(cid, 12435) >= 2 then
				doPlayerRemoveItem(cid, 12435, 2) 
				npcHandler:say('Wunderbar, du hast mir alle Items gebracht, die ich wollte. Hier nimm dieses Stück Kleidung als Belohnung und frag mich bei Zeiten nach einer neuen {Mission}.', cid)
				talkState[talkUser] = 0
				setPlayerStorageValue(cid, 5010, 6)
				doPlayerAddItem(cid, 13540, 1)
			else
				npcHandler:say('Ich weiß nicht was du da hast, aber es sind auf jeden Fall keine 5 {swamp grass}. Komm wieder, wenn du welche hast.', cid)
				talkState[talkUser] = 0
			end
		end
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end




function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	
	if msgcontains(msg, 'job') or msgcontains(msg, 'beruf') or msgcontains(msg, 'berufung') then
		npcHandler:say('Ich bin der Schneider von Bonezone, ich sorge für anständige Kleidung für alle Bewohner. Außerdem bin ich der Vater des Königs {Atlantos}, falls es dich interessiert. Hihi.',cid)
		setPlayerStorageValue(cid, theCrystalOfLove.mission1, 4)
		setPlayerStorageValue(cid, outfits.demonHunterBasic, -1)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "atlantos") or msgcontains(msg, "könig") or msgcontains(msg, "koenig") or msgcontains(msg, "sohn") then
		npcHandler:say({'Mein Sohn Atlantos ist der König von Bonezone, und das jetzt schon gute neun Jahre lang. Ich bin sehr stolz auf ihn, ebenso wie meine Frau {Irelia}. Als wir drei vor vielen Jahren hir her gezogen sind, hat sich Atlantos sofort politisch engagiert. ...',
						'Später ist er dann Vize-König geworden. Als sein Vorgänger starb, ist schließlich er zum König ernannt worden. Das war ein großer Moment für uns alle. Es tut echt gut in diesen alten Erinnerungen zu schwelgen.'},cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'blaue ratte') then
		npcHandler:say('Dieser dreckige Flegel könnte noch mein ganzes Geschäft ruinieren mit seinem Schmuggel. Billige Ware aus billigen Ländern verkauft er! Richtig gehört, ein Schmuggler ist das. Und leider Gottes ein guter noch dazu. Er versteckt sich zumeist irgendwo auf dem Großen Berg westlich von Pulgra, weil ihn dort niemand schnappen kann.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "beatrice") then
		if getPlayerStorageValue(cid, theCrystalOfLove.mission1) == 4 then
			npcHandler:say({'Wie war das? Der Geist von Beatrice hat dich zu mir geschickt? Ich hätte eine Belohnung für dich? Nun, davon wusste ich bisher gar nichts. Allerdings war Beatrice eine gute Freundin, die ich schon in der Kindheit kannte. Wir sind damals gemeinsam nach Bonezone gezogen. ...',
							'Und, dass ihr Geist noch in den Hallen von Fire Hell existiert, war mir nicht neu. Ich war der Freund, der sie damals aufgesucht hat, um ihrem Geist zu berichten, dass Dante gestorben und sein Grab hier in Bonezone mittlerweile versunken sei. Doch den Kristall konnte ich nicht für sie erkämpfen. Dafür bin und war ich zu schwach. ...',
							'Aber, dass du es geschafft hast, den Kristall zu besorgen und ihn in Dantes Grab zu legen, ist unglaublich. Dafür sollst du selbstverständlich deine Belohnung erhalten. Ich werde sie dir hier und jetzt zurechtschneidern. Dürfte ich gerade deine Maße nehmen?'},cid)
			talkState[talkUser] = 1
		end
	elseif msgcontains(msg, "ja") or msgcontains(msg, "yes") then
		if talkState[talkUser] == 1 then
			npcHandler:say('Super! Dann müsste ich nur kurz... nana... eine Nadel hier... die andere hier... und dann noch kurz... FERTIG! Alles passt und sitzt. Du kannst dein neues Outfit jetzt tragen. Damit bist du ein wahrer Demon Jäger.',cid)
			setPlayerStorageValue(cid, theCrystalOfLove.mission1, 5)
			Player(cid):addOutfit(288)
			Player(cid):addOutfit(289)
			setPlayerStorageValue(cid, outfits.questLog, 1)
			setPlayerStorageValue(cid, outfits.demonHunterBasic, 1)
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_MAGIC_RED)
			talkState[talkUser] = 0
		end
	elseif msgcontains(msg, "nein") or msgcontains(msg, "no") then
		if talkState[talkUser] == 1 then
			npcHandler:say('Also willst du kein neues Outfit? Das ist ja komisch.',cid)
			talkState[talkUser] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

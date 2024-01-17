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
		npcHandler:say('Ich hab keine Zeit ein Pläuschchen zu halten. Sag mir nur ob du irgendetwas {tauschen} willst oder nicht.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'tauschen') then
		npcHandler:say('Das ist mein Geschäft, Bursche. Ich tausche nützliche Objekte gegen wertvolle Ware. Das erzählst du aber keinem, klar. Sonst mach ich Hackfleisch aus dir. Tausch einfach gegen mein {Angebot} und halt die Klappe. Dann sind alle glücklich.', cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "Zin'Shenlock") then
		npcHandler:say('In diese Stadt was reinzuschmuggeln ist nahezu unmöglich. Die Sicherheitsvorkehrungen sind dermaßen hoch, da kriegste nicht mal nen unerlaubten Apfel rein.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "watercave") then
		npcHandler:say('Nie davon gehört. Also, willste jetzt was {tauschen}.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "little cotton") then
		npcHandler:say('Kleines Dorf mit guter Ware. Ein Schmuggel aus Little Cotton lohnt immer, vor allem wenns um Juwelen geht.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'gronta') then
		npcHandler:say('Hör mir bloß auf mit dem. Wenn ich dem noch einmal unter die Finger komme, verwandelt der mich wahrscheinlich in nen Dachs, oder so.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'bonezone') then
		npcHandler:say('Die Stadt ist relativ arm, es gibt nur wenig Sicherheitsvorkehrungen, die getroffen werden, um Schmugglern und Dieben Einhalt zu gebieten. Du solltest mal was mitgehen lassen.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'pulgra') then
		npcHandler:say('Dort habe ich meine meisten Kunden, an die ich geschmuggelte Ware übergebe. Die Bezahlung ist lausig, aber die Masse an Aufträgen macht\'s.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "blaue ratte") then
		npcHandler:say('Das ist mein Name, klar? So heiße ich, und so wirst du mich auch nennen. Meinen wirklichen Namen kennen nur 2 Personen auf Fireban, und ich gehöre nicht dazu.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "zappelnde markise") then
		npcHandler:say('Bist du etwa bewandert in unserer Sprache? Achso, du willst wissen, was es heißt. Eine Zappelnde Markise nennen wir Halunken den Steg, an dem ein Boot anlegt. Im übertragenen Sinne meint man mit der Frage "bist du schon auf der zappelnden markise?" also, ob das Boot schon angelegt hat und man wieder an Land ist.',cid)
		talkState[talkUser] = 0
	elseif msgcontains(msg, "schlüssel") or msgcontains(msg, "fluchttunnel") then
		if getPlayerStorageValue(cid, aSecretTunnel.keyValue) == -1 then
			npcHandler:say('Was meinst du? Redest du etwa von dem Fluchttunnel in der geheimen Höhle? Er ist seit Jahren nicht mehr in Gebrauch, keiner kann ihn nutzen. Weil ich den Schlüssel zur verschlossenen Tür habe. Und da du nicht zu uns gehörst, wirst du ihn auch nicht kriegen.',cid)
		else
			npcHandler:say('Ich habe dir den Schlüssel zum Fluchttunnel in der geheimen Höhle gegeben. Ich bitte dich gut Acht darauf zu geben, da sich viele wahrscheinlich die Finger danach lecken. Dieser Tunnel bietet nämlich einen sicheren und schnellen Zugang nach Pulgra.',cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, "schimmernder zahn") then
		if getPlayerStorageValue(cid, aSecretTunnel.keyValue) == -1 then
			npcHandler:say({'Woher kennst du diesen Namen? Wer hat dir was erzählt? Gehörst du etwa doch zu uns? Nein, kann nicht sein. Dann würde ich dich kennen. Zahn war ein Freund von mir. Und er ist tot. Das genügt. Ich möchte nicht darüber sprechen. ...',
							'Aber wenn du diesen Namen kennst, kann ich dir vielleicht doch vertrauen. Denn wie solltest du davon erfahren haben. Nun gut, ich werde dir den Schlüssel überreichen, den nur ich besitze. Den Schlüssel zum Fluchttunnel in der geheimen Höhle. Nutze ihn klug.'},cid)
			local CopperKey = doCreateItemEx(2087, 1)
			doSetItemActionId(CopperKey, aSecretTunnel.keyValue)
			doPlayerAddItemEx(cid, CopperKey)
			setPlayerStorageValue(cid, aSecretTunnel.keyValue, 1)
		else
			npcHandler:say('Du bist hartnäckig, was? Nun, also Zahn war ein ausgesprochen guter Freund von mir. Es schmerzt mich, an ihn zu denken. Er ist bei einer Plünderungsaktion ums Leben gekommen. Kein würdiger Abgang für einen so würdigen Menschen.',cid)
		end
		talkState[talkUser] = 0
	elseif msgcontains(msg, 'angebot') then
		npcHandler:say('Zurzeit ist mein Angebot leider leer, also hau ab.',cid)
		talkState[talkUser] = 0
		npcHandler:releaseFocus(cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

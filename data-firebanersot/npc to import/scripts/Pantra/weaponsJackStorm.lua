local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local function greetCallback(cid)
	local player = Player(cid)
	if player:getStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield) == -1 and player:getLevel() <= 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Herzlich wilkommen auf Pantra |PLAYERNAME|. Du scheinst neu hier zu sein und siehst aus, als könntest du etwas {Hilfe} gebrauchen.")
	elseif player:getStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield) == 1 and player:getLevel() <= 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen zurück, |PLAYERNAME|. Immer noch kein Interesse an meinem {Wooden Shield}?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Willkommen junger Krieger |PLAYERNAME|! Auf meine Waffen ist im Kampf verlass.")
	end	
	return true
end

keywordHandler:addKeyword({"blessed shield"}, StdModule.say, {npcHandler = npcHandler, text = {
"Das Blessed Shield ist ein legendäres Artefakt. Man sagt es wurde vor 1000 Jahren von den Göttern erschaffen, um einen selbst vor den stärksten Monstern und Demons zu schützen. ...",
"Viele haben über die Jahre versucht es zu kopieren, aber der von den Göttern verzauberte Stahl ist einfach zu einzigartig und somit ist es niemandem gelungen. ...",
"Das einzig existierende Blessed Shield wird von Generation zu Generation weitergegeben. Es war im Besitz vieler mächtiger Krieger und Könige. ...",
"Der letzte Bekannte Besitzer war {König Taibaner}, jedoch scheint er es jetzt nicht mehr zu haben, denn in seiner Waffenkammer ist es nicht mehr ausgestellt. ...",
"Wer weiß, wer jetzt der Besitzer ist? Auf jeden Fall trägt dieser eines der mächtigsten Artefakte und ist im Kampg nachezu unbesiegbar. ..."}})
keywordHandler:addKeyword({"taibaner"}, StdModule.say, {npcHandler = npcHandler, text = {
"König Taibaner ist das Oberhaupt von Pulgra. Er hat die Stadt von den Trollen befreit sie komplett neu aufgebaut. ...",
"Er ist ein starker König, aber auch sehr großzügig. Er und seine Untertanen stehen in sehr nahem Kontakt zu uns und schicken uns regelmäßig verschiedenste Dinge."}})
keywordHandler:addKeyword({"sortiement"}, StdModule.say, {npcHandler = npcHandler, text = "Schwerter, Äxte und Clubs. Bei mir findest du alles. Sieh dir einfach meinen {Trade} an."})
keywordHandler:addAliasKeyword({"ware"})
keywordHandler:addAliasKeyword({"axe"})
keywordHandler:addAliasKeyword({"club"})
keywordHandler:addAliasKeyword({"sword"})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local woodenShieldStorage = player:getStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield)
	if msgcontains(msg, "hilfe") or (msgcontains(msg, "wooden shield") and woodenShieldStorage == 1) then
		if woodenShieldStorage == -1 and player:getLevel() <= 3 then
			npcHandler:say({"Meine Waffen und Schilde sind die Besten auf ganz Pantra. Um dir einen Vorgeschmack meiner Ware zu geben würde ich dir ein {Wooden Shield} schenken. Interesse?"}, cid)
			player:setStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield, 1)
			npcHandler.topic[cid] = 1
		elseif woodenShieldStorage == 1 and player:getLevel() <= 3 then
			npcHandler:say("Wie ich dir bereits angeboten habe, würde ich dich mit einem gratis {Wooden Shield} ausstatten. Wie sieht's aus?", cid)
			npcHandler.topic[cid] = 1
		else
			npcHandler:say("Wenn du Hilfe im Kampf brauchst und nach einem neuen Begleiter suchst bin ich der richtige Ansprechpartner. Frag mich einfach nach nem {Trade}", cid)
		end
	elseif msg == "yes" or msg == "ja" then
		if npcHandler.topic[cid] == 1 then
			if player:getSlotItem(CONST_SLOT_RIGHT) ~= nil then
				npcHandler:say("Nanu? Du scheinst ja bereits bestens ausgestattet zu sein. Tut mir leid, aber dann behalte ich dieses Schild lieber für jemanden, der es wirklich braucht. Du kannst dich aber gerne in meinem {Sortiement} umsehen.", cid)
				player:setStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield,2)
				npcHandler.topic[cid] = 0
			elseif player:getFreeCapacity() < 4000 or (player:getFreeBackpackSlots() < 1 and player:getSlotItem(CONST_SLOT_RIGHT) ~= nil) then
				npcHandler:say("Du scheinst schon zu vollgepackt sein. Räum ein bisschen in deinem Inventar auf und schaffe ein wenig Platz. Ich warte hier, keine Sorge.", cid)
				npcHandler.topic[cid] = 0
			else
				player:addItem("wooden shield")
				player:setStorageValue(Storage.Quests.Pantra.Shops.Weapons.WoodenShield,2)
				npcHandler:say("Hier bitte schön. Es ist zwar kein {Blessed Shield}, aber immer noch besser als kein Schild. Schau gerne, ob ich noch mehr nützliches in meinem {Sortiement} für dich habe.", cid)
				npcHandler.topic[cid] = 0
			end
		end
	elseif msgcontains(msg, "wooden shield") then
		npcHandler:say("Ein Wooden Shield ist ein recht schwaches Schild, was sich sehr gut als Einsteigerschild eignet. Wenn du was besseres suchst, findet sich in meinem {Sortiement} bestimmt was.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

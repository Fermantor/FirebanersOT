local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'Blood Preservation'}, 12405, 320)
shopModule:addSellableItem({'Book of Necromantic Rituals'}, 11237, 180) 
shopModule:addSellableItem({'Bony Tail'}, 11194, 210) 
shopModule:addSellableItem({'Bonelord Eye'}, 5898, 80)
shopModule:addSellableItem({'Pelvis Bone'}, 12437, 30) 
shopModule:addSellableItem({'Necromantic Robe'}, 12431, 250) 
shopModule:addSellableItem({'Maxilla'}, 13302, 250)
shopModule:addSellableItem({'Giant Eye'}, 11197, 380)
shopModule:addSellableItem({'Ghoul Snack'}, 12423, 60)
shopModule:addSellableItem({'Elder Bonelord Tentacle'}, 11193, 150)
shopModule:addSellableItem({'Demonic Skeletal Hand'}, 10564, 80) 
shopModule:addSellableItem({'Carniphila Seeds'}, 13303, 550)
shopModule:addSellableItem({'Vampire Teeth'}, 10602, 275)
shopModule:addSellableItem({'Unholy Bone'}, 11233, 480) 

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local player = Player(cid)
	local questStatus = player:getStorageValue(killingInTheNameOfTasks[1].status)
	local questStatus2 = player:getStorageValue(killingInTheNameOfTasks[2].status)
	local killAmount = player:getStorageValue(killingInTheNameOfTasks[1].counterStorage)
	local killAmount2 = player:getStorageValue(killingInTheNameOfTasks[2].counterStorage)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, 'task') then
		if player:getLevel() >= 60 then
			if questStatus == -1 and questStatus2 == -1 then
				npcHandler:say(
				{
					"Was? Wer bist du, dass du glaubst ich bräuchte Hilfe von so einem Wurm wie dir? ...",
					"Ich brauche keine Hilfe! Aber wenn du verzweifelt wünscht, die Anerkennung von Zoltus zu erlangen, so sei es. Aber erwarte nichts von mir. ...",
					"Ich lebte hier einst in Frieden und Einsamkeit, bis diese möchtegern Magier und Cultisten das ganze Land überrannten und sich überall niederließen. ...",
					"Willst du mir helfen, dass ich meinen Frieden wieder zurück bekomme?"
				},cid)
				talkState[talkUser] = 1
			elseif questStatus == 1 then
				if killAmount >= killingInTheNameOfTasks[1].amountToKill then
					npcHandler:say(
					{
						"Du hast nur 4000 Necromancer und Priestess gekillt? Naja, wenigstens hast du etwas Hingabe gezeigt. Vielleicht heißt das ja sogar, dass du einen ihrer sogenannten 'Leader' töten kannst ...",
						"Unter mir in einer kleinen Höhle versteckt sich ein Necromancer namens Necropharus. Ich werde dich mit einem Spruch versehen, dass du seine lächerlich schwache Schutzbarriere durchtreten kannst. ...",
						"Sei dir nur im Klaren, dass das deine einzige Chance ist, seine Hallen zu betreten. Wenn du den Raum verläßt, oder stirbst, kannst du nicht wieder rein. ...",
						"Mal sehen, ob du dich schon traust und bereit bist, dich ihm entgegen zu stellen."
					}, cid)
					player:setStorageValue(killingInTheNameOfTasks[1].counterStorage, -1)
					player:setStorageValue(killingInTheNameOfTasks[1].status, 2)
					talkState[talkUser] = 0
				else 
					npcHandler:say("Was, da bist du schon wieder? Aber du hast ja grade mal " .. killAmount .." Necromancer und Priestess geetötet. Das beeindruckt mich nicht im geringsten.", cid)
					talkState[talkUser] = 0
				end
			elseif questStatus == 2 then
				npcHandler:say("Was willst du hier, geh und tritt Necropharus entgegen. Wenn du dafür nicht manns genug bist, kann ich dir auch nicht helfen.", cid)
				talkState[talkUser] = 0
			elseif questStatus == 3 then
				npcHandler:say(
				{
					"Du hattest also wirklich den Mum diesen Raum zu bereten. Naja, das ist ja eh alles falsche Magie und keine wirkliche Bedrohung. ...",
					"Und was willst du jetzt von mir? Erwartest du jetzt was von mir? Ich sagte dir bereits, dass es für dich keine Belohnung gibt. ...",
					"Dass du hier vor mir stehen darfst und ich dich noch nicht wie eine Fliege zerquetscht habe, ist Belohnung genug. Und jetzt tritt mir aus den Augen."
				}, cid)
				player:setStorageValue(killingInTheNameOfTasks[1].status, 4)
				talkState[talkUser] = 0
			elseif questStatus == 4 or questStatus == -1 then
				if questStatus2 == -1 or questStatus2 == 2 then
					npcHandler:say(
					{
						"Du kannst nicht leben, ohne mir zu dienen, was? Auch wenn du ziemlich nervig bist, bist du doch irgendwie auch nützlich. ...",
						"Führ einfach fort, was du am besten kannst. Necromancer und Priestess töten. 1000 sollten dieses mal reichen. Was meinst du?"
					}, cid)
					talkState[talkUser] = 2
				elseif questStatus2 == 1 then
					if killAmount2 >= killingInTheNameOfTasks[2].amountToKill then
						npcHandler:say(
						{
							"Und weitere 1000 Necromancer, die du dem Erdboden gleich gemacht hast. Die werden sich so schnell nicht davon erholen ...",
							"Ich muss sagen, ich bin tatsächlich zufrieden mit dir. Nimm diese kleine Belohnung dieses mal. Aber bild dir bloß nicht zu viel darauf ein."
						}, cid)
						player:setStorageValue(killingInTheNameOfTasks[2].counterStorage, -1)
						player:setStorageValue(killingInTheNameOfTasks[2].status, 2)
						player:addExperience(400000,true)
						talkState[talkUser] = 0
					else
						npcHandler:say("Ich war schon großzügig, dir diesmal nur 1000 Kills aufzutragen. Dennoch kommst du mit grade mal " .. killAmount2 .." Tötungen daher. Verschwende bitte nicht meine Zeit.", cid)
						talkState[talkUser] = 0
					end
				end
			end
		else
			npcHandler:say("Du willst mir helfen? Du bist ja nichtmal stark genug, auf eigenen Beinen zu stehen. Mach dich nicht lächerlich.", cid)
			talkState[talkUser] = 0
		end
		
	elseif msgcontains(msg, 'ja') or msgcontains(msg, 'yes') then
		if getPlayerLevel(cid) >= 50 then
			if talkState[talkUser] == 1 then
				if questStatus == -1 then
					startKillingTask(player, killingInTheNameOfTasks[1].counterStorage, killingInTheNameOfTasks[1].status)
					npcHandler:say("Du willst? Ich meine... weise Entscheidung. Also dann, zieh los, und strecke so viele von diesen möchtegern Necromancern nieder, wie du kannst.", cid)
					talkState[talkUser] = 0
					npcHandler:releaseFocus(cid)
				end
			elseif talkState[talkUser] == 2 then
				if questStatus2 == -1 or questStatus2 == 2 then
					startKillingTask(player, killingInTheNameOfTasks[2].counterStorage, killingInTheNameOfTasks[2].status)
					player:setStorageValue(killingInTheNameOfTasks[1].status, -1)
					npcHandler:say("Gut, dann geh.", cid)
					talkState[talkUser] = 0
					npcHandler:releaseFocus(cid)
				end
			end
		end
	elseif msgcontains(msg, 'job') then
		npcHandler:say("Ich bin der Necromancer hier in diesem Verließ und kann dir sowohl eine {Addon} Mission, als auch eine {Task} anbieten?", cid)
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
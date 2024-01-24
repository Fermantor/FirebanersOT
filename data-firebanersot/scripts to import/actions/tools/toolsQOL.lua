local ropeTools = {2120, 7731, 10511, 10513, 10515}
local shovelTools = {2554, 5710, 10511, 10513, 10515}
local pickTools = {2553, 10511, 10513, 10515}
local macheteTools = {2420, 2442, 7731, 10511, 10513, 10515}
local scytheTools = {2550,10513}
local toolsQOL = Action()

local function checkForTool(player,toolsTable)
	for i = 1, #toolsTable do
		if player:getItemCount(toolsTable[i]) >= 1 then
			if table.contains({10511, 10513, 10515}, toolsTable[i]) then
				local jammed = math.random(100)
				if jammed == 1 then
					local sTool = player:getItemById(toolsTable[i],true)
					sTool:transform(toolsTable[i]+1)
					player:say("Oh no! Your tool is jammed and can't be used for a minute.", TALKTYPE_MONSTER_SAY)
					sTool:decay()
					player:addAchievementProgress("Bad Timing", 10)
					return false
				end
			end
			return toolsTable[i]
		end
	end
	return false
end

function toolsQOL.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if table.contains(ropeSpots,item.itemid) or table.contains(specialRopeSpots,item.itemid) or table.contains(holeId,item.itemid) then
		--ROPE
		local gotTool = checkForTool(player, ropeTools)
		if gotTool ~= false then
			player:sendTextMessage(MESSAGE_LOOK, 'Using your '.. ItemType(gotTool):getName() ..".")
			return onUseRope(player, item, fromPosition, item, toPosition, isHotkey)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need a rope for that.')
		end
	elseif table.contains(holes,item.itemid) or table.contains(shovelSandSpots, item.itemid) then
		--SHOVEL
		local gotTool = checkForTool(player, shovelTools)
		if gotTool ~= false then
			player:sendTextMessage(MESSAGE_LOOK, 'Using your '.. ItemType(gotTool):getName() ..".")
			return onUseShovel(player, item, fromPosition, item, toPosition, isHotkey)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need a shovel for that.')
		end
	elseif table.contains(pickFloors,item.itemid) then
		--PICK
		local gotTool = checkForTool(player, pickTools)
		if gotTool ~= false then
			player:sendTextMessage(MESSAGE_LOOK, 'Using your '.. ItemType(gotTool):getName() ..".")
			return onUsePick(player, item, fromPosition, item, toPosition, isHotkey)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need a pick for that.')
		end
	elseif table.contains(WILD_GROWTH,item.itemid) or table.contains(JUNGLE_GRASS,item.itemid) then
		--MACHETE
		local gotTool = checkForTool(player, macheteTools)
		if gotTool ~= false then
			player:sendTextMessage(MESSAGE_LOOK, 'Using your '.. ItemType(gotTool):getName() ..".")
			return onUseMachete(player, item, fromPosition, item, toPosition, isHotkey)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need a machete for that.')
		end
	elseif table.contains({2739},item.itemid) then
		--SCYTHE
		local gotTool = checkForTool(player, scytheTools)
		if gotTool ~= false then
			player:sendTextMessage(MESSAGE_LOOK, 'Using your '.. ItemType(gotTool):getName() ..".")
			return onUseScythe(player, player:getItemById(gotTool,true), fromPosition, item, toPosition, isHotkey)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need a scythe for that.')
		end
	end
	return false
end

for i = 1, #ropeSpots do -- rope spots
	toolsQOL:id(ropeSpots[i])
end
for i = 1, #holeId do -- open holes (roping up players and items)
	if holeId[i] ~= 430 then
		toolsQOL:id(holeId[i])
	end
end
for i = 1, #holes do -- shovel holes
	toolsQOL:id(holes[i])
end
for i = 1, #pickFloors do -- pick grounds
	toolsQOL:id(pickFloors[i])
end
for i = 1, #JUNGLE_GRASS do -- shovel holes
	toolsQOL:id(JUNGLE_GRASS[i])
end
for i = 1, #WILD_GROWTH do -- shovel holes
	toolsQOL:id(WILD_GROWTH[i])
end
for i = 1, #shovelSandSpots do -- shovel holes
	toolsQOL:id(shovelSandSpots[i])
end
toolsQOL:id(14435,2739) -- mud (ropespot) & wheat
toolsQOL:register()
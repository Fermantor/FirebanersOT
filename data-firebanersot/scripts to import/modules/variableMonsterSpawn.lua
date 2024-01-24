
local monsterList = {
	[1] = {position = Position(472, 169, 7), monsterTable = {
															{weight = 90, id = 1 , param = {name = "vampire"}},
															{weight = 9, id = 1 , param = {name = "bonebeast"}},
															{weight = 1, id = 1 , param = {name = "mummy"}}
															}},
	[2] = {position = Position(493, 220, 7), monsterTable = {
															{weight = 90, id = 1 , param = {name = "dog"}},
															{weight = 10, id = 1 , param = {name = "cat"}}
															}}
}

local variableMonsterSpawnStartup = GlobalEvent("variableMonsterSpawnStartup")

function variableMonsterSpawnStartup.onStartup(interval, lastExecution)
	for index, params in ipairs(monsterList) do
		local monster = weightedRandomSelect(params.monsterTable)
		local m = Game.createMonster(monster.param.name,params.position,false,true)
		Creature(m:getId()):setStorageValue(5001,5000+index)
		Game.setStorageValue(5000+index,1)
	end
	return true
end

variableMonsterSpawnStartup:register()



local variableMonsterSpawn = GlobalEvent("VariableMonsterSpawn")

function variableMonsterSpawn.onThink(interval, lastExecution)
	for index, params in ipairs(monsterList) do
		if Game.getStorageValue(5000+index) ~= 1 then
			local monster = weightedRandomSelect(params.monsterTable)
			-- addEvent(spawnMonsterNormal,math.random(120,240)*1000,monster.param.name,params.position,5001,5000+index)
			addEvent(spawnMonsterNormal,1000,monster.param.name,params.position,5001,5000+index)
			Game.setStorageValue(5000+index,1)
		end
	end
	return true
end

-- variableMonsterSpawn:interval(60000) -- alle 60 Sekunden ein check
variableMonsterSpawn:interval(600) -- alle 60 Sekunden ein check
variableMonsterSpawn:register()

local varyingSpawn = CreatureEvent("varyingSpawnKill")
function varyingSpawn.onKill(player, creature, lastHit)
	if not player:isPlayer() or not creature:isMonster() or creature:hasBeenSummoned() or creature:isPlayer() then
		return true
	end

	if creature:getStorageValue(5001) > 0 then
		Game.setStorageValue(creature:getStorageValue(5001), 0)
		print("Varying Monster has been killed.")
	end
	return true
end
varyingSpawn:register()


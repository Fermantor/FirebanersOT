
local bossList = {
	[1] = {position = Position(468, 171, 7), boss = "grorlam", delayInDays = 5}, -- grorlam1
	[2] = {position = Position(473, 176, 7), boss = "grorlam", delayInDays = 5}, -- grorlam2
	[3] = {position = Position(468, 172, 7), boss = "orshabaal", delayInDays = 5} -- grorlam1
}

local rareBossSpawnStartUp = GlobalEvent("rareBossSpawnStartUp")
function rareBossSpawnStartUp.onStartup()
	local resultId = db.storeQuery("SELECT IFNULL(MAX(`id`),0) as `maxID` FROM `boss_master_data`")
	local maxID = result.getDataInt(resultId, "maxID")
	for index, params in ipairs(bossList) do
		if maxID < index then
			db.query("INSERT INTO `boss_master_data` (`id`, `name`) SELECT '".. index .."', '".. params.boss .."'")
		end
	end
end
rareBossSpawnStartUp:register()

local rareBossSpawn = GlobalEvent("rareBossSpawn")

function rareBossSpawn.onThink(interval, lastExecution)
	for index, params in ipairs(bossList) do
		local resultId = db.storeQuery([[SELECT 
										CASE
											WHEN `nextspawn` > NOW() THEN '0'
											ELSE '1'
										END AS `canspawn`
										,`spawnchance` FROM `boss_master_data` WHERE `id` = ]] .. index)
		local canspawn = result.getDataInt(resultId, "canspawn")
		local chance = result.getDataInt(resultId, "spawnchance")
		result.free(resultId)
		if canspawn == 1 then -- check if boss can spawn today
			local rand = math.random(10000)
			if rand <= chance then -- check if boss spawns now
				Game.createMonster(params.boss,params.position,false,true) -- creates boss
				db.query([[	UPDATE `boss_master_data` 
							SET `nextspawn` = CAST(DATE_ADD(CAST(NOW() AS DATE), INTERVAL 5 DAY) AS DATETIME)
							,`spawnchance` = 0
							WHERE `id` = ]]..index) -- resets DB entry and sets new spawn day
			else
				if chance < 500 then
					db.query('UPDATE `boss_master_data` SET `spawnchance` = '..chance+1 ..' WHERE `id` = '..index) -- increases chance
				end
			end
		end
	end
	return true
end

rareBossSpawn:interval(5000) -- alle 5 Sekunden ein check
rareBossSpawn:register()


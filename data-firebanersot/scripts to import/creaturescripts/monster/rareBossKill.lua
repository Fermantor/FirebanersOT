local rareBossKill = CreatureEvent("rareBossKill")
function rareBossKill.onKill(player, creature, lastHit)
	if not player:isPlayer() or not creature:isMonster() or creature:hasBeenSummoned() or creature:isPlayer() then
		return true
	end

	if creature:getStorageValue(5002) == 1 then
		db.query("UPDATE `boss_movement` SET `iskilled` = 1 WHERE `iskilled` = 0 AND `name` = '".. creature:getName() .."' AND `spawntime` >= CAST(NOW() as DATE) LIMIT 1")
		print("Rare Boss Monster has been killed.")
	end
	return true
end
rareBossKill:register()
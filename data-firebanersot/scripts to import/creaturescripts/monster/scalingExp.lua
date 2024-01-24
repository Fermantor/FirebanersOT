local bossDespawn = CreatureEvent("scalingExp")

function bossDespawn.onDeath(cid, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	if killer:isPlayer() then
		local player = killer
		local storage = player:getStorageValue(5001)
		player:addExperience(player:getLevel()*math.max(1,storage)*10,true)
		player:setStorageValue(5001,math.max(1,storage+1))
	end
	return true
end

bossDespawn:register()

local bossDespawnTime = 60*60*3 -- 3 hours

local bossDespawn = CreatureEvent("bossDespawn")

function bossDespawn.onThink(creature)
	if creature:getStorageValue(5000) ~= 1 then
		print(creature:getName().." spawned and remove event has registered.")
		creature:setStorageValue(5000,1)
		addEvent(function(cid)
					local creature = Creature(cid)
					if not creature then
						return
					end
					print(creature:getName().." has been removed since it wasn't killed within the time.")
					-- creature:setStorageValue(5000,0)
					creature:getPosition():sendMagicEffect(CONST_ME_POFF)
					creature:remove()
				end					
		, bossDespawnTime*1000,creature:getId())
	end
	return true
end

bossDespawn:register()

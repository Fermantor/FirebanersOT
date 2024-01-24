local position = {
    [1] = {pos = Position(2744, 1604, 1)},
    [2] = {pos = Position(2753, 1604, 1)},
    [3] = {pos = Position(2744, 1613, 1)},
    [4] = {pos = Position(2753, 1613, 1)},
}

local shlorgTeleport = CreatureEvent("shlorgTeleport")
function shlorgTeleport.onThink(creature)
	local chance = math.random(1, 100)
	if chance < 70 then
		if(not creature:isMonster()) then
			return true
		end
		local spawn = position[math.random(4)]
		creature:teleportTo(spawn.pos)
		creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
end
shlorgTeleport:register()

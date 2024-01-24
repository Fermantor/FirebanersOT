local config = {
	heal = true,
	save = true,
	effect = false
}
local skillMilestones = {
	skills = {
		SKILL_AXE,
		SKILL_SWORD,
		SKILL_CLUB,
		SKILL_MAGLEVEL,
		SKILL_DISTANCE
		},
	achievements = {
		["Meet me Halfway"] = 50,
		["Centum Seeker"] = 100,
		["Peek Trained"] = 120
		}
}

local advanceSave = CreatureEvent("AdvanceSave")
function advanceSave.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		if table.contains(skillMilestones.skills,skill) then
			for achiev, level in pairs(skillMilestones.achievements) do
				if not player:hasAchievement(achiev) and newLevel >= level then
					player:addAchievement(achiev)
				end
			end
		end
			
		-- if skill == SKILL_AXE and newLevel >= 100 then
			-- print("Someone achieved Axe Level 100! Yay!")
		-- end
		return true
	end

	if config.effect then
		player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
		player:say('LEVEL UP!', TALKTYPE_MONSTER_SAY)
	end

	if config.heal then
		player:addHealth(player:getMaxHealth())
	end

	if config.save then
		player:save()
	end
	return true
end
advanceSave:register()
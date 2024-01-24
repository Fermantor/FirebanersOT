local pantraAdvance = CreatureEvent("pantraAdvance")
function pantraAdvance.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel ~= 8 or player:getVocation():getId() ~= 0 then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratulations! You are ready to leave this island and choose a vocation now. Go see the Oracle over the academy in Pantra before you advance to level 10!')
	return true
end
pantraAdvance:register()

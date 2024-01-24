local config = {
	{weight = 3500}, -- nothing
	{weight = 3000, id = 7633}, -- giant shimmering pearl (brown)
	{weight = 2000, id = 7632}, -- giant shimmering pearl (blue)
	{weight = 1500, param = {true}} -- squeeze
}

local seaShell = Action()

function seaShell.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.seaShellOpened) == 1 then
		player:say("You have already opened a shell today.", TALKTYPE_MONSTER_SAY)
		return true
	end
	local reward = weightedRandomSelect(config)
	local text = "You found a beautiful pearl."
	if reward.itemid ~= 0 then
		Game.createItem(reward.itemid, 1, player:getPosition())
		player:addAchievementProgress("Shell Seeker",100)
	else
		if reward.param then
			text = "Ouch! You squeezed your fingers."
			doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -200, -200, CONST_ME_DRAWBLOOD)
		else
			text = "Nothing is inside."
		end
	end
	player:say(text, TALKTYPE_MONSTER_SAY)
	-- player:setStorageValue(Storage.seaShellOpened,1)
	item:transform(7553)
	item:decay()
	return true
end

seaShell:id(7552)
seaShell:register()

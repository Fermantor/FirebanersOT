local waterIds = {4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4664, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825, 13547, 13548, 13549, 13550, 13551, 13552, 7236, 10499, 12661}
local fishWaters = {4608, 4609, 4610, 4611, 4612, 4613, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 13547, 13548, 13549}
local transformIds = {[4608] = 4614, [4609] = 4615, [4610] = 4616, [4611] = 4617, [4612] = 4618, [4613] = 4619, [4620] = 4820, [4621] = 4821, [4622] = 4822, [4623] = 4823, [4624] = 4824, [4625] = 4825, [7236] = 7237, [13547] = 13550, [13548] = 13551, [13549] = 13552}
local lootTables = {
	waterElementals = {
		[10499] = { -- water elemental
			{weight = 8926},
			{weight = 520, name = "white pearl"},
			{weight = 296, name = "small sapphire"},
			{weight = 187, name = "small emerald"},
			{weight = 35, id = 7632}, -- giant shimmering pearl (blue)
			{weight = 35, id = 7633}, -- giant shimmering pearl (brown)
			{weight = 2, name = "leviathan's amulet", count = 5}
		},
		[12661] = { -- massive water elemental
			{weight = 8744},
			{weight = 497, name = "white pearl"},
			{weight = 182, name = "small sapphire"},
			{weight = 124, name = "small emerald"},
			{weight = 45, id = 7632},
			{weight = 45, id = 7633},
			{weight = 6, name = "leviathan's amulet", count = 5}
		}
	},
	iceFishing = {
		{weight = 9000, name = "fish"},
		{weight = 600, name = "green perch"},
		{weight = 300, name = "northern pike"},
		{weight = 100, name = "rainbow trout"}
	},
	shimmerFishing = {
		{weight = 9500, name = "fishbone"},
		{weight = 500, name = "shimmer swimmer"}
	},
	normalFishing = {
		{weight = 100, name = "fish"}
	}
	
}
local fishTables = {
	{waterIds = {4608, 4609, 4610, 4611, 4612, 4613, 4620, 4621, 4622, 4623, 4624, 4625}, lootTable = lootTables.normalFishing}, -- normal water tiles
	{waterIds = {13547, 13548, 13549}, lootTable = lootTables.shimmerFishing}, -- dirty water tiles (shimmer swimmer)
	{waterIds = {7236}, lootTable = lootTables.iceFishing} -- ice fishing tile
}

local fishing = Action()

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(waterIds, target.itemid) then
		return false
	end
	-- water elemental fishing
	local targetId = target.itemid
	if table.contains({10499,12661},targetId) then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player.uid then
			player:sendTextMessage(MESSAGE_FAILURE, "You are not the owner.")
			return true
		end
		local fishedTreasure = weightedRandomSelect(lootTables.waterElementals[targetId])
		if fishedTreasure.itemid == 0 then
			player:say("There was just rubbish in it.")
		else
			if fishedTreasure.itemid == 10220 and player:getStorageValue(Storage.LeviathanAmuletFished) ~= 1 then
				player:setStorageValue(Storage.LeviathanAmuletFished,1)
				player:addAchievementProgress("Lucky Devil",2)
			end
			createItem(item,fishedTreasure.itemid,fishedTreasure.count,false)
		end
		target:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
		target:transform(10500)
		target:decay()
		return true
	end
	
	-- all other fishing
	local rewardTable = nil
	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	if table.contains(fishWaters, targetId) then
		player:addSkillTries(SKILL_FISHING, 3)
		if math.random(100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) and player:removeItem("worm", 1) then
			for _, lootTable in pairs(fishTables) do
				if table.contains(lootTable.waterIds, targetId) then
					rewardTable = lootTable.lootTable
					break
				end
			end
			if not rewardTable then
				return true
			end
			fished = weightedRandomSelect(rewardTable).itemid
			if fished == 13546 then
				if player:getStorageValue(Storage.ShimmerSwimmerFished) == 1 then
					print("Can't fish two shimmer swimmer on the same day.")
					fished = 2226
				else
					player:addAchievementProgress("Biodegradable",10)
					player:setStorageValue(Storage.ShimmerSwimmerFished, 1)
				end
			elseif rewardTable == lootTables.iceFishing then
				player:addAchievementProgress("Exquisite Taste",250)
			elseif rewardTable ~= lootTables.shimmerFishing then
				player:addAchievementProgress("Here, Fishy Fishy!",1000)
			end
			createItem(item, fished, 1, false)
			target:transform(transformIds[targetId])
			target:decay()
		end
	end	
	return true
end

fishing:id(2580)
fishing:allowFarUse(true)
fishing:register()


local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(5 * 60 * 60 * 1000)

local config = {
	[7737] = {'orc warrior', 'pirate cutthroat', 'dworc voodoomaster', 'dwarf guard', 'minotaur mage'}, -- common
	[7739] = {'serpent spawn', 'demon', 'juggernaut', 'behemoth', 'ashmunrah'}, -- deluxe
	[9076] = {'quara hydromancer', 'diabolic imp', 'banshee', 'frost giant', 'lich'}, -- uncommon
	[27617] = {'old beholder', 'old bug', 'old wolf', 'old giant spider', 'old male', 'old female'} -- old
}

local costumeBags = Action()

function costumeBags.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local monsterNames = config[item.itemid]
	if not monsterNames then
		return true
	end
	local monster = math.random(#monsterNames)
	local monsterName = monsterNames[monster]
	local monsterType = MonsterType(monsterName)
    player:sendTextMessage(MESSAGE_STATUS, "You transformed into " .. (table.contains({"a","e","i","o","u"},monsterName:sub(1,1)) and "an " or "a ") .. monsterName .. '!')
	player:removeCondition(CONDITION_OUTFIT)
	condition:setOutfit(monsterType:getOutfit())
	player:addCondition(condition)
	player:addAchievementProgress('Masquerader', 10)
	player:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
	-- item:remove()
	return true
end

costumeBags:id(7737, 7739, 9076, 27617)
costumeBags:register()

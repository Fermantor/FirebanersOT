local config = {
	items = {
		{weight = 1000}, -- nothing
		{weight = 1000, name = "gold coin", count = 80, param = {text = "80 gold coins."}},
		{weight = 1000, name = "mana potion", param = {text = "a mana potion."}},
		{weight = 1000, name = "heavily rusted legs", param = {text = "heavily rusted legs."}},
		{weight = 1000, name = "heavily rusted armor", param = {text = "a heavily rusted armor."}},
		{weight = 1000, name = "ham", count = 5, param = {text = "5 ham."}},
		{weight = 1000, name = "brown mushroom", count = 5, param = {text = "5 brown mushrooms."}},
		{weight = 1000, name = "dwarven ring", param = {text = "a dwarven ring."}},
		{weight = 1000, name = "gold coin", count = 50, param = {text = "50 gold coins."}},
		{weight = 1000, name = "health potion", param = {text = "a health potion."}} 
	},
	delay = 1 * 60 * 60 -- 1 hour
}
local crateItems = Action()

function crateItems.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local text = "You found nothing useful."
	if not(player:getStorageValue(Storage.itemCrateCooldown) > os.time()) then
		local reward = weightedRandomSelect(config.items)
		player:setStorageValue(Storage.itemCrateCooldown, os.time()+config.delay)
		if reward.itemid ~= 0 then
			player:addItem(reward.itemid, reward.count)
			text = "You found "..reward.param.text
			player:addAchievementProgress("Free Items!",5)
		end
	end
	player:say(text, TALKTYPE_MONSTER_SAY)
	return true
end

crateItems:id(9661)
crateItems:register()
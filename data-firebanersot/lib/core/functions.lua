function weightedRandomSelect(lootTable)
	-- table = {
		-- {weight = , id = or name =(, count = , param = {})},
		-- {weight = , id = or name =(, count = , param = {})},
	-- }
    local totalWeight = 0
    for _, weight in ipairs(lootTable) do
        totalWeight = totalWeight + weight.weight
    end
	
    local weightSelect = math.random(1, totalWeight)
    local searchingWeight = 0

    for sumdumvar, weight in ipairs(lootTable) do
        searchingWeight = searchingWeight + weight.weight
        if (weightSelect < searchingWeight) then
			print(weight.name, ItemType(weight.name), ItemType(weight.name):getId())
            return {itemid = (weight.id) or (weight.name and ItemType(weight.name):getId()) or 0,count = weight.count or 1, param = weight.param or nil}
        end
    end
end


function createItem(item, newItem, count, removeItem, effect) -- (triggerItem, newItemId, count, effect)
	if removeItem ~= false then
		removeItem = true
	end
	count = count or 1
	local topParent = item:getTopParent()
	if topParent.isItem and (not topParent:isItem() or topParent.itemid ~= 460) then
		local parent = item:getParent()
		if not parent:isTile() and (parent:addItem(newItem, count) or topParent:addItem(newItem, count)) then
		else
			Game.createItem(newItem, count, item:getPosition())
		end
	else
		Game.createItem(newItem, count, item:getPosition())
	end
	if effect then
		doSendMagicEffect(item:getPosition(), effect)
	end
	if removeItem == true then
		item:remove(1)
	end
	return true
end
local config = {
    [ITEM_GOLD_COIN] = {changeTo = ITEM_PLATINUM_COIN},
    [ITEM_PLATINUM_COIN] = {changeBack = ITEM_GOLD_COIN, changeTo = ITEM_CRYSTAL_COIN},
    [ITEM_CRYSTAL_COIN] = {changeBack = ITEM_PLATINUM_COIN},
	changeBack = true
}

local goldConverter = Action()

function goldConverter.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local coin = config[target.itemid]
 
    if not coin then
        return false
    end
 
    local charges = item:getCharges()
	local effect = CONST_ME_HITAREA
    if coin.changeTo and target.type == 100 then
		createItem(target, coin.changeTo, 1, false, effect)
        target:remove()
    elseif coin.changeBack and config.changeBack then
		createItem(target, coin.changeBack, 100, false, effect)
        target:remove(1)
    else
        return false
    end
	item:transform(item:getId(), charges -1)

    if charges == 0 then
        item:remove()
    end

    return true
end

goldConverter:id(26378, 29020)
goldConverter:register()

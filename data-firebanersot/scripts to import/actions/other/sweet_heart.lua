local sweetHeart = Action()

function sweetHeart.onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    if (not player) then
        return false
    end
	local slot = player:getSlotItem(CONST_SLOT_RING)
    if slot and slot.uid == item.uid then
		player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	else
        return false
    end
    return true
end

sweetHeart:id(24324)
sweetHeart:register()

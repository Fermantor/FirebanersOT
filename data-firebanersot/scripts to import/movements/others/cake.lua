local cake = MoveEvent()

function cake.onAddItem(moveitem, tileitem, position)
	-- has to be a candle
	if moveitem.itemid ~= 2048 then
		return true
	end

	moveitem:remove()
	createItem(tileitem, 6280, 1, true, CONST_ME_MAGIC_RED)
	return true
end

cake:type("additem")
cake:id(6279)
cake:register()

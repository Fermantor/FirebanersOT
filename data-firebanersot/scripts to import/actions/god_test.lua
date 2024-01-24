local godTest = Action()

function godTest.onUse(player, item, fromPos, target, toPos, isHotkey)
	spawnMonsterNormal("Crustacea Gigantica",player:getPosition())
	return true
end

godTest:id(10096)
godTest:register()

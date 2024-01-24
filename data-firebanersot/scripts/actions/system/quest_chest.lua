local questChest = Action()

function questChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local reward = Container(item.uid):getItem(index)
	local playerCap = player:getFreeCapacity()
	local questStorage = item.uid
	if item.actionid >= 1000 then
		questStorage = item.actionid
	end
	local count = reward:getCount()
	if player:getStorageValue(questStorage) == -1 then
		if playerCap >= reward:getWeight() then
			player:addItemEx(reward:clone())
			player:setStorageValue(questStorage, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (count > 1 and count or 'a') .. ' ' .. ItemType(reward.itemid):getName() .. (count > 1 and 's.' or '.'))
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found an item weighing ' .. math.floor(reward:getWeight()/100) .. '.' .. (reward:getWeight()%100 == 0 and '00' or reward:getWeight()%100)  .. ' oz, but it\'s too heavy.')
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It is empty. You have already found the' .. (count > 1 and count or '') .. ' ' .. ItemType(reward.itemid):getName() .. (count > 1 and 's here.' or ' here.'))
	end
	return true
end

for i = 1500,5000 do
	questChest:uid(i)
end

questChest:register()
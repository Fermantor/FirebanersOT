local godTest = Action()

function godTest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--[[Rare Loot List
	local str = ""
	local breakline = ""
	local resultId = db.storeQuery("SELECT `player_name`, `itemid`, `time` FROM `rare_drops` ORDER BY `time` DESC LIMIT 10")
	if resultId ~= false then
		repeat
			if str ~= "" then
				breakline = "\n"
			end
			local time = result.getDataInt(resultId, "time")
			local name = result.getDataString(resultId, "player_name")
			local item = ItemType(result.getDataInt(resultId, "itemid")):getName()

			str = str .. breakline .. os.date("[%d.%b.%y-%H:%M] ",time).. name .. " looted ".. item .. "."
		until not result.next(resultId)
		result.free(resultId)
	end
	if str == "" then
			str = "No rares looted so far. Be the first!"
		end
	player:popupFYI("List of all rare drops on Firebaner:\n\n"..str)
	return true
	]]
	print(player:getItemById(10511,true))
	return true
end

godTest:id(5810)
godTest:register()

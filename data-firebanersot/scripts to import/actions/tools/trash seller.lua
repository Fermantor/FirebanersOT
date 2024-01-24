local trashList =
{
	---- Common Drops (21) ~17 items needed ----
	[2382] = {value=1, name="Club", id=1},
	[2379] = {value=2, name="Dagger", id=2},
	[2405] = {value=3, name="Sickle", id=3},
	[2380] = {value=4, name="Hand Axe", id=4},
	[2461] = {value=4, name="Leahter Helmet", id=5},
	[2384] = {value=5, name="Rapier", id=6},
	[2512] = {value=5, name="Wooden Shield", id=7},
	[2420] = {value=6, name="Machete", id=8},
	[2386] = {value=7, name="Axe", id=9},
	[2649] = {value=9, name="Leahter Legs", id=10},
	[2406] = {value=10, name="Short Sword", id=11},
	[2467] = {value=12, name="Leather Armor", id=12},
	[2385] = {value=12, name="Sabre", id=13},
	[2550] = {value=12, name="Scythe", id=14},
	[2468] = {value=15, name="Studded Legs", id=15},
	[2511] = {value=16, name="Brass Shield", id=16},
	[2481] = {value=16, name="Soldier Helmet", id=17},
	[2526] = {value=16, name="Studded Shield", id=18},
	[2458] = {value=17, name="Chain Helmet", id=19},
	[2450] = {value=20, name="Bone Sword", id=20},
	[2482] = {value=20, name="Studded Helmet", id=21},
	---- Uncommon Drops (12/33) ~26 items needed ----
	[2648] = {value=25, name="Chain Legs", id=22},
	[2388] = {value=25, name="Hatchet", id=23},
	[2484] = {value=25, name="Studded Armor", id=24},
	[2376] = {value=25, name="Sword", id=25},
	[2460] = {value=30, name="Brass Helmet", id=26},
	[2398] = {value=30, name="Mace", id=27},
	[2412] = {value=35, name="Katana", id=28},
	[2510] = {value=45, name="Plate Shield", id=29},
	[2478] = {value=49, name="Brass Legs", id=30},
	[2530] = {value=50, name="Copper Shield", id=31},
	[2416] = {value=50, name="Crowbar", id=32},
	[2411] = {value=50, name="Poison Dagger", id=33},
	---- Semi-Rare Drops (10/43) ~34 items needed ----
	[2397] = {value=51, name="Longsword", id=34},
	[2473] = {value=66, name="Viking Helmet", id=35},
	[2464] = {value=70, name="Chain Armor", id=36},
	[2483] = {value=75, name="Scale Armor", id=37},
	[2378] = {value=80, name="Battle Axe", id=38},
	[2509] = {value=80, name="Steel Shield", id=39},
	[2531] = {value=85, name="Viking Shield", id=40},
	[2513] = {value=95, name="Battle Shield", id=41},
	[2525] = {value=100, name="Dwarven Shield", id=42},
	[2394] = {value=100, name="Morning Star", id=43},
	---- Rare Drops (10/53) ~42 items needed ----
	[2647] = {value=115, name="Plate Legs", id=44},
	[2395] = {value=118, name="Carlin Sword", id=45},
	[2417] = {value=120, name="Battle Hammer", id=46},
	[2465] = {value=150, name="Brass Armor", id=47},
	[2459] = {value=150, name="Iron Helmet", id=48},
	[2419] = {value=150, name="Scimitar", id=49},
	[2490] = {value=250, name="Dark Helmet", id=50},
	[2387] = {value=260, name="Double Axe", id=51},
	[3969] = {value=280, name="Horseman Helmet", id=52},
	[2457] = {value=293, name="Steel Helmet", id=53},
	---- Very Rare Drops (6/59) ~47 items needed ----
	[2428] = {value=350, name="Orcish Axe", id=54},
	[2489] = {value=400, name="Dark Armor", id=55},
	[2521] = {value=400, name="Dark Shield", id=56},
	[2381] = {value=400, name="Halberd", id=57},
	[2463] = {value=400, name="Plate Armor", id=58},
	[2377] = {value=450, name="Two Handed Sword", id=59},
}

local trashListWindow =
{
	---- Common Drops (1) ----
	{name="Club", id=1},
	{name="Dagger", id=2},
	{name="Sickle", id=3},
	{name="Hand Axe", id=4},
	{name="Leahter Helmet", id=5},
	{name="Rapier", id=6},
	{name="Wooden Shield", id=7},
	{name="Machete", id=8},
	{name="Axe", id=9},
	{name="Leahter Legs", id=10},
	{name="Short Sword", id=11},
	{name="Leather Armor", id=12},
	{name="Sabre", id=13},
	{name="Scythe", id=14},
	{name="Studded Legs", id=15},
	{name="Brass Shield", id=16},
	{name="Soldier Helmet", id=17},
	{name="Studded Shield", id=18},
	{name="Chain Helmet", id=19},
	{name="Bone Sword", id=20},
	{name="Studded Helmet", id=21},
	---- Uncommon Drops (2) ----
	{name="Chain Legs", id=22},
	{name="Hatchet", id=23},
	{name="Studded Armor", id=24},
	{name="Sword", id=25},
	{name="Brass Helmet", id=26},
	{name="Mace", id=27},
	{name="Katana", id=28},
	{name="Plate Shield", id=29},
	{name="Brass Legs", id=30},
	{name="Copper Shield", id=31},
	{name="Crowbar", id=32},
	{name="Poison Dagger", id=33},
	---- Semi-Rare Drops (3) ----
	{name="Longsword", id=34},
	{name="Viking Helmet", id=35},
	{name="Chain Armor", id=36},
	{name="Scale Armor", id=37},
	{name="Battle Axe", id=38},
	{name="Steel Shield", id=39},
	{name="Viking Shield", id=40},
	{name="Battle Shield", id=41},
	{name="Dwarven Shield", id=42},
	{name="Morning Star", id=43},
	---- Rare Drops (4) ----
	{name="Plate Legs", id=44},
	{name="Carlin Sword", id=45},
	{name="Battle Hammer", id=46},
	{name="Brass Armor", id=47},
	{name="Iron Helmet", id=48},
	{name="Scimitar", id=49},
	{name="Dark Helmet", id=50},
	{name="Double Axe", id=51},
	{name="Horseman Helmet", id=52},
	{name="Steel Helmet", id=53},
	---- Very Rare Drops (5) ----
	{name="Orcish Axe", id=54},
	{name="Dark Armor", id=55},
	{name="Dark Shield", id=56},
	{name="Halberd", id=57},
	{name="Plate Armor", id=58},
	{name="Two Handed Sword", id=59},
}

trashSellerQuest = {baseStorage = 50100, uniqueCounter = 50171, mission1 = 50170} -- Item Storages 40101-40159


local trashSeller = Action()

function trashSeller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- if player:getStorageValue(trashSellerQuest.baseStorage) >= 0 then
		if target.itemid == 12671 then
			local window = "Items sold already: ("..player:getStorageValue(trashSellerQuest.baseStorage).."/59)"
			for _,itemName in ipairs(trashListWindow) do
				if player:getStorageValue(trashSellerQuest.baseStorage+itemName.id) >= 1 then
					window =  window.."\n"..itemName.name..": "..math.max(player:getStorageValue(trashSellerQuest.baseStorage+itemName.id),0)
				end
			end
			player:showTextDialog(12671, window, false)
			return true
		end
		local trash = trashList[target.itemid]
		if not trash then
			return false
		end
		local itemStorage = player:getStorageValue(trashSellerQuest.baseStorage+trash.id)
		target:remove(1)
		player:addMoney(trash.value)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You sold 1x ".. trash.name:lower() .. " for "..trash.value.." gold.")
		if itemStorage == -1 then
			player:setStorageValueUp(trashSellerQuest.baseStorage)
		end
		player:setStorageValue(trashSellerQuest.baseStorage+trash.id,math.max(itemStorage+1,1))
		return true
	-- else
		-- return false
	-- end
end



trashSeller:id(12671)
trashSeller:register()


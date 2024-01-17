local messages =
{
	--[id] = {storage = x, message = ""}
	[1] = {storage = 61100, message = "H�rt mich an! H�rt mich an! Pantra ist von dunklen Demons befallen und das Oracle ist nicht mehr zu erreichen! Vereint eure Kr�fte, um Pantra wieder zu befreien!"},
	[2] = {storage = 61101, message = "H�rt mich an! H�rt mich an! Die Monster auf der Insel der kranken w�ten wieder. Helden formiert euch um sie zur�ck zu treiben!"},
	[3] = {storage = 61102, message = "H�rt mich an! H�rt mich an! FirebanersOT ist wieder online, feiert das und spielt so viel ihr k�nnt!"},
	[4] = {storage = 61103, message = "H�rt mich an! H�rt mich an! Solumix hat heute in seinem Runenshop ein besonderes Angebot. Kauft und verkauft heute zu top Preisen!"},
	[5] = {storage = 61104, message = "H�rt mich an! H�rt mich an! Rashid hat mit seinem Schiff im Hafen von Bonezone angelegt und kauft heute exklusive Items!"},
	[6] = {storage = 61105, message = "H�rt mich an! H�rt mich an! Der Party Club in Pulgra ist heute ge�ffnet. Trefft euch Abends dort und schmei�t eine dicke Party!"},
	[6] = {storage = 61106, message = "H�rt mich an! H�rt mich an! Der Archdemon Morgaroth ist erwacht und w�tet tief unter der Insel der Kranken!"},
	[7] = {storage = 5052, message = "H�rt mich an! H�rt mich an! Die Strahlung um die Feverish Factory ist heute schwach genug, dass man die Insel bereisen kann!"}
	
	
	-- [15] = {storage = 61264, message = "Hear me! Hear me! The witch Wyda seems to be bored. Pay her a visit but sharpen your sword. She might come up with a terrible surprise, are you brave enough to believe your eyes?"}
}
 
local int = 0
function onThink(interval)
	int = int + 1
	if int >= math.random(10, 30) then
		local zuf = math.random(1,#messages)
		if getGlobalStorageValue(messages[zuf].storage) > 0 then
			doCreatureSay(getNpcCid(), messages[zuf].message, TALKTYPE_SAY)
			int = 0
		end
	end
	return true		
end
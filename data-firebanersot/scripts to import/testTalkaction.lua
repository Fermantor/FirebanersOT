local config = {
	{weight = 1618, name = "protective charm", count = 100},
	{weight = 1618, name = "sabretooth", count = 100},
	{weight = 1618, name = "some grimeleech wings", count = 100},
	{weight = 1618, name = "vampire teeth", count = 100},
	{weight = 1618, name = "bloody pincers", count = 100},
	{weight = 1618, name = "piece of dead brain", count = 100},
	{weight = 1618, name = "silencer claws", count = 100},
	{weight = 1618, name = "rope belt", count = 100},
	{weight = 1618, name = "vexclaw talon", count = 100},
}

local testTalkaction = TalkAction("/testtable")

function testTalkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	for _, reward in pairs(config) do
		player:getSlotItem(3):addItem(ItemType(reward.name):getId(), reward.count or 1)
	end
	return true
end

testTalkaction:separator(" ")
testTalkaction:register()

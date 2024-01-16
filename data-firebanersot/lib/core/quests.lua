if not Quests then
	Quests = {
		[1] = {
			name = "Example Quest",
			startStorageId = Storage.Quest.ExampleQuest.Example,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Example Mission #1",
					storageId = Storage.Quest.ExampleQuest.Example,
					missionId = 1,
					startValue = 1,
					endValue = 1,
					description = "Example description.",
				},
				[1] = {
					name = "Example Mission #2",
					storageId = Storage.Quest.ExampleQuest.Example,
					missionId = 1,
					startValue = 1,
					endValue = 2,
					states = {
						[1] = "Example Mission State #1.",
						[2] = "Example Mission State #1.",
					},
				},
				[3] = {
					name = "Example Mission #3",
					storageId = Storage.Quest.ExampleQuest.Example,
					missionId = 1,
					startValue = 1,
					endValue = 1,
					description = function(player)
						return string.format("You have %d/100 points.", (math.max(player:getStorageValue(Storage.Quest.ExampleQuest.Example), 0)))
					end,
				},
			},
		},
	}
end

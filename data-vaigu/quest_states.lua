MissionState = {
	KingOfRatsHQ = {
		ZeroArtifactsCollected = 1,
		AllArtifactsCollected = TableSize(Storage.KingOfRatsHQ.Items),
	},
	TheaterOfCheapThrills = {
		Mission01 = {
			Start = 1,
			FindingCheese = 2,
			Finished = 3,
		},
		Mission02 = {
			Start = 1,
			TakingAssistantTest = 2,
			Finished = 3,
		},
		Mission03 = {
			Start = 1,
			Finished = 4,
		},
		Mission04 = {
			Start = 1,
			Finished = 4,
		},
		Mission05 = {
			Start = 1,
			Finished = 5,
		},
		Mission06 = {
			Start = 1,
			Finished = 5,
		},
		Mission07 = {
			Start = 1,
			Finished = 4,
		},
		Mission08 = {
			Start = 1,
			Finished = 4,
		},
		Mission09 = {
			Start = 1,
			Finished = 4,
		},
		Mission10 = {
			Start = 1,
			Finished = 4,
		},
		Mission11 = {
			Start = 1,
			Finished = 4,
		},
		Mission12 = {
			Start = 1,
			Finished = 3,
		},
	},

}

for _, quest in pairs(MissionState) do
	local nextStateValue = 1
	for key, value in pairs(quest) do
	end
end

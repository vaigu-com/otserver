do
	return
end --38f
local quest = Quest(LOCALIZERS)

quest
	:Storage(function() end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Bigfoot's Burden",
			missions = {
				[921] = {
					name = "Reputation points",
					description = "Current reputation points",
				},
				[932] = {
					name = "Daily Minor: Crystal Keeper",
					description = "Daily Minor: Crystal Keeper Status",
				},
				[934] = {
					name = "Daily Minor: Raiders of the lost Spark",
					description = "Daily Minor: Raiders of the lost Spark Status",
				},
				[937] = {
					name = "Daily Minor Plus: Exterminators",
					description = "Daily Minor Plus: Exterminators Status",
				},
				[940] = {
					name = "Daily Minor Plus: Mushroom Digger",
					description = "Daily Minor Plus: Mushroom Digger Status",
				},
				[948] = {
					name = "Daily Major Advanced: Spores",
					description = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
				},
				[952] = {
					name = "Daily Major Advanced: Yet Another Grinding",
					description = "Gather a grindstone from the lava area and report back.",
				},
				[943] = {
					name = "Daily Major: Matchmaker",
					description = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
				},
				[946] = {
					name = "Daily Major: The Tinker's Bell",
					description = "Daily Major: The Tinker's Bell Status",
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))

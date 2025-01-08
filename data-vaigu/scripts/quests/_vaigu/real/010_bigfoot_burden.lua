--dialogs are in old system
local quest = Quest(LOCALIZERS.BigfootBurden)

quest
	:Storage(function() end)
	:Constant(function() end)
	:Questlog(function()
		table.insert(Quests, {
			name = "Bigfoot's Burden",
			missions = {
				{
					name = "Reputation points",
					storage = 921,
					endValue = 1000,
					description = "Current reputation points",
				},
				{
					name = "Daily Minor: Crystal Keeper",
					storage = 932,
					endValue = 5,
					description = "Daily Minor: Crystal Keeper Status",
				},
				{
					name = "Daily Minor: Raiders of the lost Spark",
					storage = 934,
					endValue = 7,
					description = "Daily Minor: Raiders of the lost Spark Status",
				},
				{
					name = "Daily Minor Plus: Exterminators",
					storage = 937,
					endValue = 10,
					description = "Daily Minor Plus: Exterminators Status",
				},
				{
					name = "Daily Minor Plus: Mushroom Digger",
					storage = 940,
					endValue = 3,
					description = "Daily Minor Plus: Mushroom Digger Status",
				},
				{
					name = "Daily Major Advanced: Spores",
					storage = 948,
					endValue = 4,
					description = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
				},
				{
					name = "Daily Major Advanced: Yet Another Grinding",
					storage = 952,
					endValue = 1,
					description = "Gather a grindstone from the lava area and report back.",
				},
				{
					name = "Daily Major: Matchmaker",
					storage = 943,
					endValue = 2,
					description = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
				},
				{
					name = "Daily Major: The Tinker's Bell",
					storage = 946,
					endValue = 4,
					description = "Daily Major: The Tinker's Bell Status",
				},
			},
		})
	end)
	:Register()

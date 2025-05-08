--dialogs are in old system
local quest = Quest(LOCALIZERS.BigfootsBurden)

quest
	:Storage(function() end)
	:Constant(function()
		SpawnLocks.BigfootsBurden = {
			Warzone1 = SpawnLock(),
			Warzone2 = SpawnLock(),
			Warzone3 = SpawnLock(),
		}
		for _, spawnLock in pairs(SpawnLocks.BigfootsBurden) do
			spawnLock.onSet = function() end
		end
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Bigfoot's Burden",
			localizer = localizer,
			missions = {
				{
					name = "Looking for Gnomerik",
					storage = Storage.BigfootsBurden.QuestLine,
					description = "The dwarf Xelvar has sent you to meet the gnome Gnomerik. \nHe can recruit you to the Bigfoot Company. \nUse the teleporter near Xelvar to enter the gnomish base and start looking for Gnomerik.",
				},
				{
					name = "A New Recruit",
					storage = Storage.BigfootsBurden.QuestLine,
					description = "You have found the gnomish recruiter and are ready to become a Bigfoot.",
				},
				{
					name = "Recruitment: A Test in Gnomology",
					storage = Storage.BigfootsBurden.QuestLine,
					states = {
						[5] = "Pass Gnomerik's test by answering his questions. \nIf you fail to get a high enough score drink a mushroom beer and start again.",
						[6] = "You have passed the gnomish psychology test and can proceed to the medical exam. \nTalk to Gnomespector about your next examination.",
					},
				},
				{
					name = "Recruitment: Medical Examination",
					storage = Storage.BigfootsBurden.QuestLine,
					description = "Walk through the g-ray apparatus for your g-raying.",
				},
				{
					name = "Recruitment: Ear Examination",
					storage = Storage.BigfootsBurden.QuestLine,
					states = {
						[10] = "You have been g-rayed. It has been an ... unexpected experience. Now you are ready for your \near examination. Walk up to doctor Gnomedix and wait for him to finish your ear examination.",
						[11] = "You passed the ear examination. Well, at least most of you did. \nNow talk to Gnomaticus about your next test. ",
					},
				},
				{
					name = "Recruitment: Gnomish Warfare",
					storage = Storage.BigfootsBurden.Shooting,
					minState = 0,
					maxState = 5,
					description = "Hit five targets in a row. Don't hit an innocent target as it will reset your hit counter.",
				},
				{
					name = "Recruitment: Gnomish Warfare",
					storage = Storage.BigfootsBurden.QuestLine,
					minState = 15,
					maxState = 16,
					description = "You are now ready for your endurance test. Talk to Gnomewart about it.",
				},
				{
					name = "Recruitment: Endurance Test",
					storage = Storage.BigfootsBurden.QuestLine,
					minState = 17,
					maxState = 20,
					states = {
						[17] = "Enter the lower chamber for your endurance test. Reach the teleporter north of the hall.",
						[18] = "You have passed the endurance test. Report back to Gnomewart.",
						[19] = "You passed the endurance test and are ready to talk to Gnomelvis about your soul melody.",
					},
				},
				{
					name = "Recruitment: Soul Melody",
					storage = Storage.BigfootsBurden.QuestLine,
					minState = 21,
					maxState = 23,
					states = {
						[21] = "Find your personal soul melody by trial and error. \nCreate the complete soul melody of seven notes and then report to Gnomelvis. Red notes indicate a failure.",
						[22] = "You found your very own soul melody. You should talk to Gnomelvis about it!",
					},
				},
				{
					name = "Recruitment",
					storage = Storage.BigfootsBurden.QuestLineComplete,
					minState = 1,
					maxState = 2,
					description = "You are now a true member of the Bigfoot company.",
				},
				{
					name = "Gnomish War Hero (Warzone 1)",
					storage = Storage.BigfootsBurden.Warzone1Access,
					minState = 1,
					maxState = 2,
					states = {
						[1] = "Deliver the Deathstrike's snippet to gnomission to enter the first warzone for free.",
						[2] = "You may enter the first warzone without using a mission crystal.",
					},
				},
				{
					name = "Gnomish War Hero (Warzone 2)",
					storage = Storage.BigfootsBurden.Warzone2Access,
					minState = 1,
					maxState = 2,
					states = {
						[1] = "Deliver the Gnomevil's hat to gnomission to enter the second warzone for free.",
						[2] = "You may enter the second warzone without using a mission crystal.",
					},
				},
				{
					name = "Gnomish War Hero (Warzone 3)",
					storage = Storage.BigfootsBurden.Warzone3Access,
					minState = 1,
					maxState = 2,
					states = {
						[1] = "Deliver the Abyssador's lash to gnomission to enter the third warzone for free.",
						[2] = "You may enter the third warzone without using a mission crystal.",
					},
				},
				{
					name = "Reputation points",
					storage = Storage.BigfootsBurden.Rank,
					maxState = 10000000,
					description = "Current reputation points",
				},
				{
					name = "Daily Minor: Crystal Keeper",
					storage = Storage.BigfootsBurden.RepairedCrystalCount,
					maxState = 5,
					description = "Daily Minor: Crystal Keeper Status",
				},
				{
					name = "Daily Minor: Raiders of the lost Spark",
					storage = Storage.BigfootsBurden.ExtractedCount,
					maxState = 7,
					description = "Daily Minor: Raiders of the lost Spark Status",
				},
				{
					name = "Daily Minor Plus: Exterminators",
					storage = Storage.BigfootsBurden.ExterminatedCount,
					maxState = 10,
					description = "Daily Minor Plus: Exterminators Status",
				},
				{
					name = "Daily Minor Plus: Mushroom Digger",
					storage = Storage.BigfootsBurden.MushroomCount,
					maxState = 3,
					description = "Daily Minor Plus: Mushroom Digger Status",
				},
				{
					name = "Daily Major Advanced: Spores",
					storage = Storage.BigfootsBurden.SporeCount,
					maxState = 4,
					description = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
				},
				{
					name = "Daily Major Advanced: Yet Another Grinding",
					storage = Storage.BigfootsBurden.GrindstoneStatus,
					maxState = 1,
					description = "Gather a grindstone from the lava area and report back.",
				},
				{
					name = "Daily Major: Matchmaker",
					storage = Storage.BigfootsBurden.MatchmakerStatus,
					maxState = 2,
					description = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
				},
				{
					name = "Daily Major: The Tinker's Bell",
					storage = Storage.BigfootsBurden.GolemCount,
					maxState = 4,
					description = "Daily Major: The Tinker's Bell Status",
				},
			},
		})
	end)
	:Script(function()
		local trophyItemIds = { ItemId.ABYSSADOR_S_LASH, ItemId.GNOMEVIL_S_HAT, ItemId.DEATHSTRIKE_S_SNIPPET }
		local reward = { id = ItemId.MAJOR_CRYSTALLINE_TOKEN, count = 5 }

		local warzoneTrophy = Action()
		function warzoneTrophy.onUse(player, trophyItem, fromPosition, target, toPosition, isHotkey)
			if player:CanAddItems({ reward }) then
				trophyItem:remove()
				player:AddCustomItem(reward)
			end
			return true
		end
		for _, trophyItemId in pairs(trophyItemIds) do
			warzoneTrophy:id(trophyItemId)
		end
		warzoneTrophy:register()
	end)
	:Register()

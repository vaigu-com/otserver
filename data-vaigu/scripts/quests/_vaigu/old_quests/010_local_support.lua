local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.LocalSupport = {
			DamnedRats = 11046,
			BudgetRecycling = 11045,
			LostCrystalBall = 11072,

			UnwantedGuests = 11076,
			Biodegradable = {
				State = 11084,
				Parcel = 11085,
			},

			TwoMarlinQuest = 2050,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Local Support",
			missions = {
				[Storage.LocalSupport.DamnedRats] = {
					name = "Freaking Rats",
					states = {
						[1] = "Walmart wishes she knew how to repel rats. Find out where Gertruda lives. She should know how to craft a rat poison.",
						[2] = "Gertruda asked you to bring her one mouldy cheese.",
						[3] = "Cheese is now poisonous. Bring it to Walmart, so she can repel the rats.",
						[4] = "Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift.",
					},
				},
				[Storage.LocalSupport.BudgetRecycling] = {
					name = "Cheap Recycling",
					states = {
						[1] = "Malkin asked you to bring her 1 piece of cloth of every color.",
						[2] = "Madame Malkin is grateful for your effort, and since now you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth.",
					},
				},
				[Storage.LocalSupport.LostCrystalBall] = {
					name = "Broken Orb",
					states = {
						[1] = "Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly.",
						[2] = "The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing.",
					},
				},
				[Storage.LocalSupport.Biodegradable.State] = {
					name = "Biodegradable",
					states = {
						[1] = "Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west.",
						[2] = "You found the package for Old Postman. Return to him and give it to him.",
						[3] = "You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also deliver Zanet's Box to Old Anon.",
						[4] = "You took the box from Old Postman, which you should deliver to Old Anon.",
					},
				},
				[Storage.LocalSupport.UnwantedGuests] = {
					name = "Unwanted Guests",
					states = {
						[1] = "Bring Brutetamers Staff and Fur Boots to Old Man Frost.",
						[2] = "You completed Old Man Frosts's request.",
					},
				},
				[Storage.LocalSupport.TwoMarlinQuest] = {
					name = "Two Marlins",
					states = {
						[1] = "",
						[2] = "",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))

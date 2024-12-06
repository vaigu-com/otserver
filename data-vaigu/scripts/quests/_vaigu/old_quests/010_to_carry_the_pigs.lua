local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.ToCarryThePigs = {
			BalancedDiet = 11034,

			BeLikeSchwarzenegger = 11033,

			HalfTurnKick = 11035,
			ListTaken = 11036,

			FatMyrrusDiet = 11037,
			Carrot = 11038,

			KitzDominando = 11039,

			Promotion = 11040,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "To Carry the Pigs",
			missions = {
				[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = {
					name = "To be like the Schwarzenegger",
					states = {
						[1] = "Collect these items for me: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth.",
						[2] = "Arni glanced at these teeth, and asked you to find someone who can make them into necklace.",
						[3] = "Madame Malkin gladly made this necklace for Arni.",
						[4] = "In exchange for the teeth necklace, Arni gave u his old armour and a ring.",
					},
				},
				[Storage.ToCarryThePigs.HalfTurnKick] = {
					name = "Half turn Kick",
					states = {
						[1] = "Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment.",
						[2] = "He was right. Now go to the Price Kebab and ask Shivganesh for translation.",
						[3] = "It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker.",
						[4] = "You have received MirkoTown guard hat for your help.",
					},
				},
				[Storage.ToCarryThePigs.BalancedDiet] = {
					name = "A Balanced Diet",
					states = {
						[1] = "Collect 1 slimming carrot for fat Mirek.",
						[2] = "The carrot was dogshit, and u received chocolate slush in for your effort.",
					},
				},
				[Storage.ToCarryThePigs.KitzDominando] = {
					name = "Kitz's Dominando",
					states = {
						[1] = "Arrange a special bow from elf adobe.",
						[2] = "You have received the item from Legolas. Go give it to Kitz.",
						[3] = "Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))

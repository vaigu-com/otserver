local quest = Quest(LOCALIZERS.TheInquisitionQuest)

quest
	:Storage(function()
		Storage.TheInquisition = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			GrofGuard = {},
			KulagGuard = {},
			MilesGuard = {},
			TimGuard = {},
			WalterGuard = {},
			StorkusVampiredust = {},
			EnterTeleport = {},
			Reward = {},
			RewardRoomText = {},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "The Inquisition",
			localizer = localizer,
			missions = {
				{
					name = "Mission 1: Interrogation",
					storage = 1216,
					endValue = 7,
					description = "Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you.",
					states = {
						[1] = "You investigated 1 of 5 guards.",
						[2] = "You investigated 2 of 5 guards.",
						[3] = "You investigated 3 of 5 guards.",
						[4] = "You investigated 4 of 5 guards.",
						[5] = "You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus.",
						[6] = "You investigated all guards.",
					},
				},
				{
					name = "Mission 2: Eclipse",
					storage = 12162,
					endValue = 3,
					description = "Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus.",
					states = {
						[1] = "Find The Witches' Grimoire and bring it to Henricus.",
						[2] = "You already brought The Witches' Grimoire to Henricus.",
					},
				},
				{
					name = "Mission 3: Vampire Hunt",
					storage = 12163,
					endValue = 6,
					description = "Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time.",
					states = {
						[1] = "Go back to Storkus and ask for a mission.",
						[2] = "Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus.",
						[3] = "Kill The Count and bring his ring to Storkus, and then ask for a mission.",
						[4] = "Return to Henricus and tell him that you've finished your job here.",
						[5] = "Get back to Sybir and report your mission to Henricus.",
					},
				},
				{
					name = "Mission 4: The Haunted Ruin",
					storage = 12164,
					endValue = 3,
					description = "Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being.",
					states = {
						[1] = "Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus.",
						[2] = "You already cleaned the abandoned and haunted place, ask Henricus for a new mission.",
					},
				},
				{
					name = "Mission 5: Essential Gathering",
					storage = 12165,
					endValue = 3,
					description = "Henricus wants 20 Demonic Essences as proof of your accomplishments.",
					states = {
						[1] = "Now ask Henricus for an outfit to get the Demon Hunter Outfit.",
						[2] = "You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
					},
				},
				{
					name = "Mission 6: The Demon Ungreez",
					storage = 12166,
					description = "Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels.",
					endValue = 3,
					states = {
						[1] = "You killed Ungreez, report your mission to Henricus.",
						[2] = "You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
					},
				},
				{
					name = "Mission 7: The Shadow Nexus",
					storage = 12167,
					description = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins.",
					endValue = 5,
					states = {
						[1] = "You destroyed the shadow nexus! Get back to Henricus and report your mission.",
						[2] = "Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
						[3] = "You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
						[4] = "You have completed The Inquisition Quest!",
					},
				},
			},
		})
	end)
	:Register()

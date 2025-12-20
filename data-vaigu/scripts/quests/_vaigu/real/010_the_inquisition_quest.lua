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
			RewardRoomAccess = {},
			RewardRoomText = {},
		}
	end)
	:Constant(function()
		QuestState.TheInquisition = {
			Mission01 = {
				TalkToGuards = 1,
			},
		}

		QuestConstants.TheInquisition = {
			GuardsCount = 5,
			GuardsVisitedStorages = {
				Storage.TheInquisition.GrofGuard,
				Storage.TheInquisition.TimGuard,
				Storage.TheInquisition.KulagGuard,
				Storage.TheInquisition.MilesGuard,
				Storage.TheInquisition.WalterGuard,
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "The Inquisition",
			localizer = localizer,
			missions = {
				{
					name = "Mission 1: Interrogation",
					storage = Storage.TheInquisition.Mission01,
					states = {
						[1] = "YOU_INVESTIGATED_N_GUARDS__REPORT_TO_HENRICUS",
					},
					linkedStorages = {
						Storage.TheInquisition.GrofGuard,
						Storage.TheInquisition.TimGuard,
						Storage.TheInquisition.KulagGuard,
						Storage.TheInquisition.MilesGuard,
						Storage.TheInquisition.WalterGuard,
					},
				},
				{
					name = "Mission 2: Eclipse",
					storage = Storage.TheInquisition.Mission02,
					description = "Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus.",
					states = {
						[1] = "Find The Witches' Grimoire and bring it to Henricus.",
						[2] = "You already brought The Witches' Grimoire to Henricus.",
					},
				},
				{
					name = "Mission 3: Vampire Hunt",
					storage = Storage.TheInquisition.Mission03,
					endValue = 6,
					description = "Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time.",
					states = {
						[1] = "Go back to Storkus and ask for a mission.",
						[2] = "Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus.",
						[3] = "Kill The Count and bring his ring to Storkus, and then ask for a mission.",
						[4] = "Return to Storkus and tell him that you've finished your job here.",
						[5] = "Get back to Sybir and report your mission to Henricus.",
					},
				},
				{
					name = "Mission 4: The Haunted Ruin",
					storage = Storage.TheInquisition.Mission04,
					description = "Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being.",
					states = {
						[1] = "Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus.",
						[2] = "You already cleaned the abandoned and haunted place, ask Henricus for a new mission.",
					},
				},
				{
					name = "Mission 5: Essential Gathering",
					storage = Storage.TheInquisition.Mission05,
					description = "Henricus wants 20 Demonic Essences as proof of your accomplishments.",
					states = {
						[1] = "Now ask Henricus for an outfit to get the Demon Hunter Outfit.",
						[2] = "You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
					},
				},
				{
					name = "Mission 6: The Demon Ungreez",
					storage = Storage.TheInquisition.Mission06,
					states = {
						[1] = "Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels.",
						[2] = "You killed Ungreez, report your mission to Henricus.",
					},
				},
				{
					name = "Mission 7: The Shadow Nexus",
					storage = Storage.TheInquisition.Mission07,
					states = {
						[1] = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins.",
						[2] = "You destroyed the shadow nexus! Get back to Henricus and report your mission.",
						[3] = "Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
						[4] = "You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
						[5] = "You have completed The Inquisition Quest!",
					},
				},
			},
		})
	end)
	:Mission(Storage.TheInquisition.Mission01)
	:State(function()
		return QuestState.TheInquisition.Mission01.TalkToGuards,
			QuestFactory.Dialog("Grof, The Guard", {
				[{ "trouble", "klopoty", "mission" }] = {
					text = "I think it'll rain soon and I left some laundry out for drying.",
					requiredState = {
						[Storage.TheInquisition.GrofGuard] = ACCESS_NOT_GRANTED,
					},
					nextState = {
						[Storage.TheInquisition.GrofGuard] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Dialog("Tim, The Guard", {
				[{ "trouble", "klopoty", "mission" }] = {
					text = "Ah, well. Just this morning my new toothbrush fell into the toilet.",
					requiredState = {
						[Storage.TheInquisition.TimGuard] = ACCESS_NOT_GRANTED,
					},
					nextState = {
						[Storage.TheInquisition.TimGuard] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Dialog("Miles, The Guard", {
				[{ "trouble", "klopoty", "mission" }] = {
					text = "I'm fine. There's no trouble at all.",
					requiredState = {
						[Storage.TheInquisition.MilesGuard] = ACCESS_NOT_GRANTED,
					},
					nextState = {
						[Storage.TheInquisition.MilesGuard] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Dialog("Kulag, The Guard", {
				[{ "trouble", "klopoty", "mission" }] = {
					text = "You adventurers become more and more of a pest.",
					requiredState = {
						[Storage.TheInquisition.KulagGuard] = ACCESS_NOT_GRANTED,
					},
					nextState = {
						[Storage.TheInquisition.KulagGuard] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Dialog("Walter, The Guard", {
				[{ "trouble", "klopoty", "mission" }] = {
					text = "I think there is a pickpocket in town.",
					requiredState = {
						[Storage.TheInquisition.WalterGuard] = ACCESS_NOT_GRANTED,
					},
					nextState = {
						[Storage.TheInquisition.WalterGuard] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:Register()

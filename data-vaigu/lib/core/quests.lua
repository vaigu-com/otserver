-- ToDo: github
-- https://vypas.com/d/rme_source.zip

NEXT_QUEST_ID = NEXT_QUEST_ID or 0
function NextQuestId()
	NEXT_QUEST_ID = NEXT_QUEST_ID + 1
	return NEXT_QUEST_ID
end

NEXT_MISSION_ID = NEXT_MISSION_ID or 0
function NextMissionId()
	NEXT_MISSION_ID = NEXT_MISSION_ID + 1
	return NEXT_MISSION_ID
end

TASKS_QUEST_STORAGE = NextQuestId()
DAILY_TASK_STORAGE = NextQuestId()

if not Quests then
	Quests = {}
	--38f 
	--[[
	Quests = {
		[TASKS_QUEST_STORAGE] = {
			name = "Tasks",
			missions = {
				[Storage.Tasks.TaskInfo] = {
					name = "Task informations",
					description = "TASKS_HELP_WINDOW_INFO",
				},
			},
		},
		[DAILY_TASK_STORAGE] = {
			name = "Daily task",
			missions = {
				[Storage.DailyTasks.DailyTaskInfo] = {
					name = "Daily tasks information",
					description = "DAILY_TASKS_HELP_WINDOW_INFO",
				},
			},
		},
		[NextQuestId()] = {
			name = "Arena",
			missions = {
				[301] = {
					name = "First arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel",
				},
				[302] = {
					name = "Second arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire",
				},
				[303] = {
					name = "Third arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator",
				},
				[304] = {
					name = "Fourth arena",
					minState = 1,
					maxState = 2,
					description = "Arena, extreme level.",
				},
			},
		},
		[NextQuestId()] = {
			name = "Bigfoot's Burden",
			missions = {
				[1] = {
					name = "Reputation points",
					storage = 921,
					minState = 0,
					maxState = 1000,
					description = "Current reputation points",
				},
				[2] = {
					name = "Daily Minor: Crystal Keeper",
					storage = 932,
					minState = 0,
					maxState = 5,
					description = "Daily Minor: Crystal Keeper Status",
				},
				[3] = {
					name = "Daily Minor: Raiders of the lost Spark",
					storage = 934,
					minState = 0,
					maxState = 7,
					description = "Daily Minor: Raiders of the lost Spark Status",
				},
				[4] = {
					name = "Daily Minor Plus: Exterminators",
					storage = 937,
					minState = 0,
					maxState = 10,
					description = "Daily Minor Plus: Exterminators Status",
				},
				[5] = {
					name = "Daily Minor Plus: Mushroom Digger",
					storage = 940,
					minState = 0,
					maxState = 3,
					description = "Daily Minor Plus: Mushroom Digger Status",
				},
				[6] = {
					name = "Daily Major Advanced: Spores",
					storage = 948,
					minState = 0,
					maxState = 4,
					description = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
				},
				[7] = {
					name = "Daily Major Advanced: Yet Another Grinding",
					storage = 952,
					minState = 0,
					maxState = 1,
					description = "Gather a grindstone from the lava area and report back.",
				},
				[8] = {
					name = "Daily Major: Matchmaker",
					storage = 943,
					minState = 1,
					maxState = 2,
					description = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
				},
				[9] = {
					name = "Daily Major: The Tinker's Bell",
					storage = 946,
					minState = 0,
					maxState = 4,
					description = "Daily Major: The Tinker's Bell Status",
				},
			},
		},
		[NextQuestId()] = {
			name = "The Ape City",
			missions = {
				[1] = {
					name = "Hairycles Missions",
					storage = 11102,
					minState = 1,
					maxState = 18,
					states = {
						[1] = "Find whisper moss in the dworc settlement and bring it back to Hairycles.",
						[2] = "You have completed the first mission. Hairycles was happy about the whisper moss you gave to him. He might have another mission for you.",
						[3] = "Hairycles asked you to bring him cough syrup from a human settlement. A healer might know more about this medicine.",
						[4] = "You have completed the second mission. Hairycles was happy about the cough syrup you gave to him. He might have another mission for you.",
						[5] = "Hairycles asked you to bring him a magical scroll from the lizard settlement.",
						[6] = "You have completed the third mission. Hairycles appreciated that you brought the scroll to him and will try to read it. Maybe he has another mission for you later.",
						[7] = "Since Hairycles was not able to read the scroll you brought him, he asked you to visit a tomb northwest from Hurghada. Proceed in this tomb until you find an obelisk between red stones and read it.",
						[8] = "You have completed the fourth mission. Hairycles read your mind and can now translate the lizard scroll. He might have another mission for you.",
						[9] = "Hairycles wants to create a life charm for the ape people. He needs a hydra egg since it has strong regenerating powers.",
						[10] = "You have completed the fifth mission. Hairycles attempts to create a might charm for the protection of the ape people. He might have another mission for you later.",
						[11] = "Hairycles need a witches' cap mushroom which is supposed to grow on swamp inhabited by Beholders.",
						[12] = "You have completed the sixth mission. You brought the witches' cap mushroom back to Hairycles. He might have another mission for you.",
						[13] = "Hairycles read that the Lizards are planning to summon the Demon Lizards to help regain their former temple. Perhaps the premature lighting of their firecamp will thwart their plans.",
						[14] = "You have completed the seventh mission. You found a way to prevent the Lizards from opening the hellish gates. Hairycles might have another mission for you.",
						[15] = "The apes now need a symbol of their faith. Find a hair of the giant, holy ape and bring it back. It may be located in caves inhabited by Behemoths.",
						[16] = "You completed the eighth mission. Hairycles gladly accepted the hair of the ape god which you brought him. He told you to have one final mission for you.",
						[17] = "Go into the deepest catacombs under Banuta and destroy the monument of the snake god with the hammer that Hairycles gave to you.",
						[18] = "You successfully destroyed the monument of the snake god. As reward, you can buy sacred statues from Hairycles. If you haven't done so yet, you should also ask him for a shaman outfit.",
					},
				},
			},
		},
		[NextQuestId()] = {
			name = "The Dream Courts",
			missions = {
				[1] = {
					name = "The Dream Courts",
					storage = 12200,
					minState = 1,
					maxState = 5,
					description = "Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town.",
					states = {
						[1] = "Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby.",
						[2] = "Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you.",
						[3] = "You have defeated The Nightmare Beast. Talk about this to Vanys.",
						[4] = "Vanys gifted you with a traditional dream warrior outfit.",
					},
				},
				[2] = {
					name = "Helping of Stricken Soul",
					storage = 12232,
					minState = 1,
					maxState = 4,
					description = "Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar.",
					states = {
						[1] = "You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral.",
						[2] = "You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around...",
						[3] = "You successfully defeated the Faceless Bane.",
					},
				},
				[3] = {
					name = "Empowered Wardstones",
					storage = 12209,
					minState = 0,
					maxState = 8,
					description = "Empowered Wardstones",
				},
				[4] = {
					name = "Documents Read",
					storage = 12214,
					minState = 0,
					maxState = 4,
					description = "Documents Read",
				},
			},
		},
		[NextQuestId()] = {
			name = "Liquid Black",
			missions = {
				[1] = {
					name = "Visitor",
					storage = 24001,
					minState = 2,
					maxState = 5,
					states = {
						[2] = "You have found notes and coordinates. Try to find out what they are for.",
						[3] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
						[4] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
						[5] = "You have found a shortcut to the deeplings' underwater base.",
					},
				},
			},
		},
	}
	]]

end

local function appendQuestData()
	for questId, questData in pairs(Quests) do
		for missionNumber, missionData in pairs(questData.missions) do
			missionData.missionId = missionData.missionId or NextMissionId()
			missionData.minState = missionData.minState or MISSION_START_VALUE
			missionData.maxState = missionData.maxState or #missionData.states
		end
	end
end

--startup appendQuestData() --38f

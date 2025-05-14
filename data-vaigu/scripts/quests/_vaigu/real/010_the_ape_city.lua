local quest = Quest(LOCALIZERS.TheApeCity)

quest
	:Storage(function() end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "The Ape City",
			localizer = localizer,
			missions = {
				{
					name = "Hairycles Missions",
					storage = 11102,
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
		})
	end)
	:Register()

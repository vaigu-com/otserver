local quest = Quest("chester_the_dwarf")
quest
	:Storage(function()
		Storage.ChesterTheDwarf = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			ChesterHouseStairs = NextStorage(),
			Document = NextStorage(),
			CaveTile = NextStorage(),
			GandalfBag = NextStorage(),
			DoorToChesterCompartment = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Chester the Dwarf",
			startStorageId = Storage.ChesterTheDwarf.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Fortune Teller 3000",
					storageId = Storage.ChesterTheDwarf.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "You agreed to help Chester become a TV fortune teller. He will need the following items for his profession: Magic Light Wand, Empty Goldfish Bowl, Magician's Robe, Life Crystal.",
						[2] = "Chester the Dwarf has become a fortune teller, and you received his pickaxe as a reward.",
					},
				},
				[2] = {
					name = "Chester the Turf Accountant",
					storageId = Storage.ChesterTheDwarf.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "You helped Chester the Dwarf with his TV fortune teller career. Ask him later if he needs help in another field.",
						[2] = "Chester the Dwarf entrusted you with a very discreet task. Obtain a new set of documents for him. He directed you to Moustachilles, the leader of the bandits at the camp near Mirkotown.",
						[3] = "You obtained the documents from Ornuld. Now, deliver them to Chester the Dwarf.",
						[4] = "You acquired new documents for Chester the Dwarf, and he rewarded you for it.",
					},
				},
				[3] = {
					name = "Mirko Train Simulator",
					storageId = Storage.ChesterTheDwarf.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "You helped Chester the Dwarf change his identity. Ask him later if he needs help in another field.",
						[2] = "Chester the Dwarf wants to sail away from the continent on his steamship. Find the entrance to the shaft leading to his ship.",
						[3] = "You found the cave that Chester the Dwarf was looking for. Now, return to him with the good news.",
						[4] = "You helped Chester the Dwarf with his life problems. He has started packing to begin anew far, far away from here.",
					},
				},
				[4] = {
					name = "Business Class to the Labour Exchange",
					storageId = Storage.ChesterTheDwarf.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Chester the Dwarf has disappeared from the continent. Or has he? Maybe he hasn't managed to start the steamship underground yet. If possible, catch up to him and stop him.",
						[2] = "Chester gave you Gandalf's lost item. Now, return to the mighty wizard and return his property.",
						[3] = "Gandalf rewarded you for recovering his bag.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.ChesterTheDwarf.Questline] = 7,
			[Storage.ChesterTheDwarf.Mission03] = 3,
		}

		local tile = MoveEvent()

		function tile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local storageVal = player:getStorageValue(Storage.ChesterTheDwarf.Questline)
			if storageVal == 6 then
				player:UpdateStorages(updateStorages)
				player:say(
					player
						:Localizer(Storage.ChesterTheDwarf.Questline)
						:Get("This just might be the place Chester was talking about"),
					TALKTYPE_MONSTER_SAY
				)
			end
			return true
		end

		tile:aid(Storage.ChesterTheDwarf.CaveTile)
		tile:type("stepin")
		tile:register()
	end)
	:Script(function(storageToRequiredState)
		local tile = MoveEvent()

		function tile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValue(Storage.ChesterTheDwarf.Questline) >= 8 then
				player:teleportTo(fromPosition, true)
				player:say(
					player
						:Localizer(Storage.ChesterTheDwarf.Questline)
						:Get("Chester's house is vacant right now. Therefore it would be impolite to tresspass."),
					TALKTYPE_MONSTER_SAY
				)
			end
			return true
		end

		tile:aid(Storage.ChesterTheDwarf.ChesterHouseStairs)
		tile:type("stepin")
		tile:register()
	end)

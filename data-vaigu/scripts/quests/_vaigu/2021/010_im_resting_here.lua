local quest = Quest(LOCALIZERS.ImRestingHere)

quest
	:Storage(function()
		Storage.ImRestingHere = {
			PuzzlesDoneStateBinary = NextStorage(),
			Coffin = NextStorage(),
			LastWill = NextStorage(),
			Corpse = NextStorage(),
		}
		QuestState.ImRestingHere = {
			Mission01 = {
				FindUseForCrowbar = 1,
				FindItemMentionedInLastWill = 2,
				FindOneOfTheSurvivors = 3,
				Finished = 4,
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Im Resting Here",
			missions = {
				[Storage.ImRestingHere.PuzzlesDoneStateBinary] = {
					name = "A Work to Screw up",
					states = {
						[QuestState.ImRestingHere.Mission01.FindUseForCrowbar] = "Grave digger gave you a special crowbar. Try to find a use for it.",
						[QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill] = "You found some kind of last will. Try to find the item mentioned in it.",
						[QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors] = "You found a document that indicates that four people broke into the labyrinth. At least two of them are no longer alive. Try to find one of the survivors.",
						[QuestState.ImRestingHere.Mission01.Finished] = "You found out what happened to one of the survivors.",
					},
				},
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.ImRestingHere = {
			lastWill = {
				id = 637,
				desc = "Bildo's last will",
				text = "[...]this is the part of the will concerning my grandson. Back in 2014 me and my company broke our way into the down syndrome pyramid. When we were deep down there, something grabbed onto Gwindel. In no time, he already fell to his death and was lying in the corner of the pyramid. Unfortunately, he was descending first, thus he was the one using the magical torch. This is the heirloom 'Im entrusting to you. Entrance to the pyramid is located in fuck fuck fuckity fuck. You should remember things like this. The only requirement for you to be able to acquire this part of heritage is being at least 32 years old.\n\nSigned by Bildo\n\nP.S. Chester is a mountebank and swindler",
				aid = Storage.ImRestingHere.LastWill,
			},
			torch = {
				id = 9042,
			},
			contract = {
				id = 2834,
				text = "Contract of service. Signed on the day of 20 IV 2014 in the free city of Hurghada. An agreement between Bildo, Chester the Dwarf, Gwindel and Gandalf. [...]",
			},
			crowbar = {
				id = 3304,
				aid = Storage.ImRestingHere.Coffin,
			},
		}
	end)
	:Mission(Storage.ImRestingHere.PuzzlesDoneStateBinary)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Grave Digger", {
			[{ "mission", "misja" }] = {
				text = "Lately, the well-known businessman Bildo Debicki was buried in the southern cemetery. To honor his passing, I've decided to do something good for the residents of this city and introduce a promotion on {crowbars}. This conversation does not constitute incitement to a crime under the criminal code. The price of one such item is 10 gold pieces.",
			},
			[{ "lom", "lomy", "crowbar", "crowbars" }] = {
				text = "You want to buy special crowbar? It will cost you 10gp. If you were to pry open a lid (like the lid of a can), just click on it. No need to use crowbar - hence its called special.",
			},
			[{ "yes", "tak" }] = {
				text = "Here you are.",
				nextState = {
					[Storage.ImRestingHere.PuzzlesDoneStateBinary] = QuestState.ImRestingHere.Mission01.FindUseForCrowbar,
					[Storage.ImRestingHere.Coffin] = 1,
				},
				requiredMoney = 10,
				textNoRequiredMoney = "What?! Its only 10gps.",
			},
		})
	)
	:State(
		QuestState.ImRestingHere.Mission01.FindUseForCrowbar,
		QuestFactory.StartupItems({
			{ pos = { 5939, 1779, 7 }, id = 2477, aid = Storage.ImRestingHere.Coffin },
			{ pos = { 5938, 1779, 7 }, id = 2476, aid = Storage.ImRestingHere.Coffin },
			{ pos = { 5939, 1779, 7 }, id = 3522, aid = 0 },
			{ pos = { 5938, 1779, 7 }, id = 3526, aid = 0 },
		}),
		QuestFactory.Script(function(missionState)
			local coffinMessages = {
				[1] = "The lid of this coffin won't move at all.",
				[2] = "Doubling your efforts, you managed to move the lid a bit.",
				[3] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
				[4] = "You relocate crowbar to another crevice and, using all you strength, you broke off the lid.",
			}

			local updateStorages = {
				[Storage.ImRestingHere.PuzzlesDoneStateBinary] = QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill,
			}

			local crowbar = Action()
			function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return true
				end

				local useItemId = item:getId()
				if useItemId == 2476 or useItemId == 2477 then
					local translatedError = player:Localizer(Storage.ImRestingHere.Localizer):Get("It wont move without special crowbar.")
					player:say(translatedError, TALKTYPE_MONSTER_SAY)
				end

				local coffinState = player:getStorageValue(Storage.ImRestingHere.Coffin)
				if coffinState > #coffinMessages then
					if player:TryTradeInItems({ QuestKeyItems.ImRestingHere.crowbar }, { QuestKeyItems.ImRestingHere.lastWill }) then
						player:UpdateStorages(updateStorages)
					end
					return
				end

				local message = coffinMessages[coffinState]
				local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get(message)
				player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.ImRestingHere.Coffin, coffinState + 1)
				return true
			end

			crowbar:aid(Storage.ImRestingHere.Coffin)
			crowbar:register()
		end)
	)
	:State(
		QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill,
		QuestFactory.StartupItems({
			{ pos = { 6712, 1408, 13 }, id = 3204, aid = Storage.ImRestingHere.Corpse },
		}),
		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.ImRestingHere.PuzzlesDoneStateBinary] = QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors,
			}

			local coffin = Action()

			function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return true
				end

				if player:TryAddItems({ QuestKeyItems.ImRestingHere.torch, QuestKeyItems.ImRestingHere.contract }) then
					player:UpdateStorages(updateStorages)
					player:addOutfit(574)
					player:addOutfit(575)
					player:AddExperienceWithAnnouncement(30000)
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
				end
				return false
			end

			coffin:aid(Storage.ImRestingHere.Corpse)
			coffin:register()
		end)
	)
	:State(
		QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Listen, I've finished exploring holes, and now I have a different passion. If you want to help me, listen up. Some time ago, I got a job as a TV presenter, and I still have that job. Unfortunately, the salary is not entirely satisfactory. I found out that one of the fortune tellers hosting some show on the network where I work has been quarantined. The station is now looking for a replacement for his position, and I think I'm suited for it - I have a degree in quackery, but I'll need a few props. Are you ready to help me?",
			},
			[{ "yes", "tak" }] = {
				text = "Great. I need a Magic Light Wand to blind viewers with false promises. A Magician's Robe to look like a magician. A crystal ball with a very small hole... just find a round aquarium. Lastly, I need a life crystal. If you gather these items, come back to me.",
				nextState = {
					[Storage.ChesterTheDwarf.PuzzlesDoneStateBinary] = QuestState.ChesterTheDwarf.Mission01.BringMagicItemsToChester,
					[Storage.ImRestingHere.PuzzlesDoneStateBinary] = QuestState.ImRestingHere.Mission01.Finished,
					[Storage.Finished.ImRestingHere] = 1,
				},
				requiredItems = { QuestKeyItems.ImRestingHere.lastWill },
			},
		})
	)

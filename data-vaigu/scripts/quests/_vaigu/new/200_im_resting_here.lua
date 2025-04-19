local quest = Quest(LOCALIZERS.ImRestingHere)

quest
	:Storage(function()
		Storage.ImRestingHere = {
			Mission01 = {},
			Coffin = {},
			LastWill = {},
			Corpse = {},
			Crowbar = {},
			Contract = {},
		}
		QuestState.ImRestingHere = {
			Mission01 = {
				FindUseForCrowbar = 1,
				FindItemMentionedInLastWill = 2,
				FindOneOfTheSurvivors = 3,
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Im Resting Here",
			localizer = localizer,
			missions ={
				{
					name = "A Work to Screw up",
					storage = Storage.ImRestingHere.Mission01,
					states = {
						[QuestState.ImRestingHere.Mission01.FindUseForCrowbar] = "Grave digger gave you a special crowbar. Try to find a use for it.",
						[QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill] = "You found some kind of last will. Try to find the item mentioned in it.",
						[QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors] = "You found a document that indicates that four people broke into the labyrinth. At least two of them are no longer alive. Try to find one of the survivors.",
						[MISSION_FINISHED] = "You found out what happened to one of the survivors.",
					},
				},
			},
		})
	end)
	:Constant(function()
		QuestKeyItems.ImRestingHere = {
			LastWill = {
				id = 637,
				desc = "Bildo's last will",
				key = Storage.ImRestingHere.LastWill,
			},
			MagicTorch = {
				id = 9042,
			},
			Contract = {
				id = 2834,
				key = Storage.ImRestingHere.Contract,
			},
			Crowbar = {
				id = 3304,
				key = Storage.ImRestingHere.Crowbar,
			},
		}
	end)
	:Mission(Storage.ImRestingHere.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
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
						[Storage.ImRestingHere.Mission01] = QuestState.ImRestingHere.Mission01.FindUseForCrowbar,
						[Storage.ImRestingHere.Coffin] = 1,
					},
					rewards = {
						QuestKeyItems.ImRestingHere.Crowbar,
					},
					requiredMoney = 10,
					textNoRequiredMoney = "What?! Its only 10gps.",
				},
			})
	end)
	:State(function()
		return QuestState.ImRestingHere.Mission01.FindUseForCrowbar,
			QuestFactory.Script(function(missionState)
				local coffinMessages = {
					[1] = "The lid of this coffin won't move at all.",
					[2] = "Doubling your efforts, you managed to move the lid a bit.",
					[3] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
					[4] = "You relocate crowbar to another crevice and, using all you strength, you broke off the lid.",
				}

				local updateStorages = {
					[Storage.ImRestingHere.Mission01] = QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill,
				}

				local crowbar = Action()
				function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return true
					end

					if target:getKey() ~= Storage.ImRestingHere.Coffin then
						return true
					end

					local coffinState = player:getStorageValueByKey(Storage.ImRestingHere.Coffin)
					local message = coffinMessages[coffinState]
					if not message then
						return
					end

					local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get(message)
					player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
					player:setStorageValueByKey(Storage.ImRestingHere.Coffin, coffinState + 1)
					return true
				end

				crowbar:key(Storage.ImRestingHere.Crowbar)
				crowbar:register()

				local coffin = Action()
				function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return true
					end

					local coffinState = player:getStorageValueByKey(Storage.ImRestingHere.Coffin)
					if coffinState <= #coffinMessages then
						local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get("The lid of this coffin won't move at all.")
						player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
					elseif player:TryTradeInItems({ QuestKeyItems.ImRestingHere.Crowbar }, { QuestKeyItems.ImRestingHere.LastWill }) then
						player:NextState(updateStorages)
					end

					return true
				end
				coffin:key(Storage.ImRestingHere.Coffin)
				coffin:register()
			end)
	end)
	:State(function()
		return QuestState.ImRestingHere.Mission01.FindItemMentionedInLastWill,
			QuestFactory.Script(function(missionState)
				local bildoLastWill = Action()
				function bildoLastWill.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					SimpleTextDisplay(
						player,
						player:Localizer(LOCALIZERS.ImRestingHere):Get(
							"[...]this is the part of the will concerning my grandson. Back in 2014 me and my company broke our way into the down syndrome pyramid. When we were deep down there, something grabbed onto Gwindel. In no time, he already fell to his death and was lying in the corner of the pyramid. Unfortunately, he was descending first, thus he was the one using the magical torch. This is the heirloom 'Im entrusting to you. Entrance to the pyramid is located in fuck fuck fuckity fuck. You should remember things like this. The only requirement for you to be able to acquire this part of heritage is being at least 32 years old.\n\nSigned by Bildo\n\nP.S. Chester is a mountebank and swindler"
						)
					)
					return false
				end
				bildoLastWill:key(Storage.ImRestingHere.LastWill)
				bildoLastWill:register()

				local nextState = {
					[Storage.ImRestingHere.Mission01] = QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors,
				}

				local pyramidCorpse = Action()
				function pyramidCorpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return true
					end

					if player:TryAddItems({ QuestKeyItems.ImRestingHere.MagicTorch, QuestKeyItems.ImRestingHere.Contract }) then
						player:NextState(nextState)
						player:addOutfit(574)
						player:addOutfit(575)
						AddExperienceWithAnnouncement(player, 30000)
						player:getPosition():sendMagicEffect(CONST_ME_STUN)
					end
					return false
				end
				pyramidCorpse:key(Storage.ImRestingHere.Corpse)
				pyramidCorpse:register()
			end)
	end)
	:State(function()
		return QuestState.ImRestingHere.Mission01.FindOneOfTheSurvivors,
			QuestFactory.Script(function()
				local contract = Action()
				function contract.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					SimpleTextDisplay(player, player:Localizer(LOCALIZERS.ImRestingHere):Get("Contract of service. Signed on the day of 20 IV 2014 in the free city of Hurghada. An agreement between Bildo, Chester the Dwarf, Gwindel and Gandalf. [...]"))
					return false
				end
				contract:key(Storage.ImRestingHere.Contract)
				contract:register()
			end),
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ "mission" }] = {
					text = "Listen, I've finished exploring holes, and now I have a different passion. If you want to help me, listen up. Some time ago, I got a job as a TV presenter, and I still have that job. Unfortunately, the salary is not entirely satisfactory. I found out that one of the fortune tellers hosting some show on the network where I work has been quarantined. The station is now looking for a replacement for his position, and I think I'm suited for it - I have a degree in quackery, but I'll need a few props. Are you ready to help me?",
				},
				[{ "yes", "tak" }] = {
					text = "Great. I need a Magic Light Wand to blind viewers with false promises. A Magician's Robe to look like a magician. A crystal ball with a very small hole... just find a round aquarium. Lastly, I need a life crystal. If you gather these items, come back to me.",
					nextState = {
						[Storage.ChesterTheDwarf.Mission01] = QuestState.ChesterTheDwarf.Mission01.BringMagicItemsToChester,
						[Storage.ImRestingHere.Mission01] = MISSION_FINISHED,
						[Storage.Finished.ImRestingHere] = MISSION_FINISHED,
					},
					requiredItems = {
						QuestKeyItems.ImRestingHere.LastWill,
						QuestKeyItems.ImRestingHere.Contract,
					},
				},
			})
	end)
	:Register()

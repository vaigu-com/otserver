local quest = Quest(LOCALIZERS.FashionistaOnanista)

quest
	:Storage(function()
		Storage.FashionistaOnanista = {
			Mission01 = {},
			BookOfManoeuvers = {},
			Mission02 = {},
			SecretiveLetter = {},
			CokeBag = {},
			SpawnRobBarley = {},
			MetamphetamineCrystal = {},
			Mission03 = {},
			FentBagCyclops = {},
			FentBagTurdstin = {},
			Mission04 = {},
			SpeedCarrot = {},
			CarrotsMade = {},
		}
		QuestState.FashionistaOnanista = {
			Mission01 = {
				AskOcellatusForNewMission = 1,
				BringMedalsToOcellatus = 2,
			},
			Mission02 = {
				AskOcellatusForNewMission = 1,
				AskMoustachillesForNewMission = 2,
				ReadSecretiveLetter = 3,
				BringPotionToRobBarley = 4,
				BringCokeToMoustachilles = 5,
			},
			Mission03 = {
				AskMoustachillesForNewMission = 1,
				SellFentToCyclops = 2,
				SellFentToTurdstin = 3,
				ReportToMoustachilles = 4,
			},
			Mission04 = {
				AskOcellatusForNewMission = 1,
				BringMedalsToOcellatusEndless = 2,
			},
		}
		Storage.BonusMountSpeedStorages = {
			FashionistaMission01BookOfManoeuvers = {},
			FashionistaMission02MetamphetamineCrystal = {},
			FashionistaMission04EndlessMedalsCarrotTurnIns = {},
		}
	end)
	:Constant(function()
		SpawnLocks.FashionistaOnanista = {
			RobBarley = SpawnLock(),
		}
		QuestKeyItems.FashionistaOnanista = {
			BookOfManoeuvers = {
				id = 6533,
				key = Storage.FashionistaOnanista.BookOfManoeuvers,
			},
			SecretiveLetter = {
				id = 3506,
				key = Storage.FashionistaOnanista.SecretiveLetter,
			},
			MetamphetamineCrystal = {
				id = 22694,
				key = Storage.FashionistaOnanista.MetamphetamineCrystal,
			},
			CokeBag = {
				id = 23682,
				key = Storage.FashionistaOnanista.CokeBag,
			},
			FentBagCyclops = {
				id = 6570,
				key = Storage.FashionistaOnanista.FentBagCyclops,
			},
			FentBagTurdstin = {
				id = 6570,
				key = Storage.FashionistaOnanista.FentBagTurdstin,
			},
			SpeedCarrot = {
				id = 3595,
				key = Storage.FashionistaOnanista.SpeedCarrot,
			},
		}
		QuestTopics.FashionistaOnanista = {
			Mission02 = {
				WhoSentYou = NextTopic(),
			},
			Mission03 = {
				ConfirmGiveUpBag = NextTopic(),
				ConfirmBagPrice = NextTopic(),
			},
		}
		QuestActions.FashionistaOnanista = {
			sendSecretiveLetter = function(context)
				local player = context.player
				local inbox = player:getInbox()
				local itemEx = Game.createItem(QuestKeyItems.FashionistaOnanista.SecretiveLetter.id)
				itemEx:setKey(QuestKeyItems.FashionistaOnanista.SecretiveLetter)
				inbox:addItemEx(letter, INDEX_WHEREEVER, FLAG_NOLIMIT)
			end,
		}
		QuestRewards.OutfitsAddons.FashionistaOnanista = {
			Jouster0 = {
				{ outfitId = 1332, addons = 0 },
				{ outfitId = 1331, addons = 0 },
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Fashionista Onanista",
			localizer = localizer,
			missions = {
				{
					name = "Cum Bucket",
					storage = Storage.FashionistaOnanista.Mission01,
					states = {
						[QuestState.FashionistaOnanista.Mission01.AskOcellatusForNewMission] = "Ask Ocellatus about a new mission",
						[QuestState.FashionistaOnanista.Mission01.BringMedalsToOcellatus] = "Bring two medals of honour to Ocellatus.",
						[MISSION_FINISHED] = "Ocellatus gave you his book of marvelous mounted manoeuvers.",
					},
				},
				{
					name = "Wish Upon a Trap Star",
					storage = Storage.FashionistaOnanista.Mission02,
					states = {
						[QuestState.FashionistaOnanista.Mission02.AskOcellatusForNewMission] = "Ask Ocellatus about new mission.",
						[QuestState.FashionistaOnanista.Mission02.AskMoustachillesForNewMission] = "Find Moustachilles, the local trap star.",
						[QuestState.FashionistaOnanista.Mission02.ReadSecretiveLetter] = "Moustachilles asked you to find his lost coke.",
						[QuestState.FashionistaOnanista.Mission02.BringPotionToRobBarley] = "You read an ominous letter. Sender mentioned to bring a bullseye potion to abandoned house, south of Kongo.",
						[QuestState.FashionistaOnanista.Mission02.BringCokeToMoustachilles] = "Bring back the coke bag to Moustachilles.",
						[MISSION_FINISHED] = "Moustachilles rewarded you with a metamphetamine crystal.",
					},
				},
				{
					name = "Anal Cotton",
					storage = Storage.FashionistaOnanista.Mission03,
					states = {
						[QuestState.FashionistaOnanista.Mission03.AskMoustachillesForNewMission] = "Ask Moustachilles about new mission",
						[QuestState.FashionistaOnanista.Mission03.SellFentToCyclops] = "Moustachilles trusted you with his bags of fent. Deliver those to his new clients. Moustachilles didnt tell you their names, but hinted that one is a soccer fan living in the south slums and other has a very big nose. Find the one with big nose first.",
						[QuestState.FashionistaOnanista.Mission03.SellFentToTurdstin] = "Moustachilles trusted you with his bags of fent. Deliver the other bag to second client - the soccer fan. Moustachilles hinted the south slums.",
						[QuestState.FashionistaOnanista.Mission03.ReportToMoustachilles] = "Report to moustachilles and bring him his money.",
						[MISSION_FINISHED] = "You completed this mission.",
					},
				},
				{
					name = "Cum Faucet",
					storage = Storage.FashionistaOnanista.Mission04,
					states = {
						[QuestState.FashionistaOnanista.Mission04.AskOcellatusForNewMission] = "Ask Ocellatus about new mission.",
						[QuestState.FashionistaOnanista.Mission04.BringMedalsToOcellatusEndless] = "WEEKLY_OCELLATUS_MEDAL_QUEST_STATUS",
					},
					linkedStorages = { Storage.FashionistaOnanista.CarrotsMade },
				},
			},
		})
	end)
	:Script(function()
		---@param verbose boolean
		function Player:UpdateMountbonusMovementSpeed(verbose)
			local totalBonus = 0
			for _, key in pairs(Storage.BonusMountSpeedStorages) do
				local bonus = math.max(self:getStorageValueByKey(key), 0)
				totalBonus = totalBonus + bonus
			end

			self:setStorageValueByKey("KEY_MOUNT_BONUS_SPEED", totalBonus)
			if verbose then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You now have a total of :totalBonus: bonus mount movement speed.", { totalBonus = totalBonus }))
			end
		end
	end)
	:Mission(Storage.FashionistaOnanista.Mission01)
	:State(function()
		return QuestState.FashionistaOnanista.Mission01.AskOcellatusForNewMission,
			QuestFactory.Dialog("Ocellatus", {
				[{ GREET, "mission", "misja" }] = {
					text = "Me and my friends are hosting a meat beating competition. We need 10 medals of honour for that. Come back when you have them.",
					nextState = {
						[Storage.FashionistaOnanista.Mission01] = QuestState.FashionistaOnanista.Mission01.BringMedalsToOcellatus,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission01.BringMedalsToOcellatus,
			QuestFactory.Dialog("Ocellatus", {
				[{ "medal" }] = {
					text = "Thanks for your help. Here is your reward.",
					textNoRequiredItems = "Come back with the the medals i asked for.",
					requiredItems = {
						{ id = 5785, count = 2 },
					},
					rewards = {
						QuestKeyItems.FashionistaOnanista.BookOfManoeuvers,
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission01] = MISSION_FINISHED,
						[Storage.FashionistaOnanista.Mission02] = QuestState.FashionistaOnanista.Mission02.AskOcellatusForNewMission,
					},
					outfitRewards = QuestRewards.OutfitsAddons.FashionistaOnanista.Jouster0,
				},
			}),
			QuestFactory.Script(function()
				local bookOfManoeuvers = Action()
				function bookOfManoeuvers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					item:remove()
					player:setStorageValueByKey(Storage.BonusMountSpeedStorages.FashionistaMission01BookOfManoeuvers, 30)
					player:UpdateMountbonusMovementSpeed(true)
				end
				bookOfManoeuvers:key(QuestKeyItems.FashionistaOnanista.BookOfManoeuvers.key)
				bookOfManoeuvers:register()
			end)
	end)
	:Mission(Storage.FashionistaOnanista.Mission02)
	:State(function()
		return QuestState.FashionistaOnanista.Mission02.AskOcellatusForNewMission,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "Do you happen to know the local gang boss, Moustachilles? Recently he lost some of his coke and now is desperate to retreive it. I think you could help him with his troubles.",
					nextState = {
						[Storage.FashionistaOnanista.Mission02] = QuestState.FashionistaOnanista.Mission02.AskMoustachillesForNewMission,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission02.AskMoustachillesForNewMission,
			QuestFactory.Dialog("Moustachilles", {
				[{ "mission", "misja" }] = {
					text = "Who sent you?",
					nextTopic = QuestTopics.FashionistaOnanista.Mission02.WhoSentYou,
				},
				[{ "ocellatus", "oskarek" }] = {
					text = "Alright. In that case i guess i can trust you. One of my man lost two bags of my {coke}. If you were to find it, i will reward you.",
					requiredTopic = QuestTopics.FashionistaOnanista.Mission02.WhoSentYou,
					nextState = {
						[Storage.FashionistaOnanista.Mission02] = QuestState.FashionistaOnanista.Mission02.ReadSecretiveLetter,
					},
					specialActionsOnSuccess = {
						{
							action = QuestActions.FashionistaOnanista.sendSecretiveLetter,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission02.ReadSecretiveLetter,
			QuestFactory.Dialog("Moustachilles", {
				[{ "coke", "kokaina" }] = {
					text = "My last dealer has been missing in action since. I dont know who, if anyone would try to steal from me.",
				},
			}),
			QuestFactory.Script(function()
				local letterText = "I see that you are looking Moustachilles belongings. Follow my instructions and you might be lucky enough to bring it back to him. Bring me a bullseye potion and meet me at the abandoned house, south of Kongo."
				local nextState = {
					[Storage.FashionistaOnanista.Mission02] = QuestState.FashionistaOnanista.Mission02.BringPotionToRobBarley,
				}

				local letterUse = Action()
				function letterUse.onUse(player, item)
					SimpleTextDisplay(player, player:Localizer(LOCALIZERS.FashionistaOnanista):Get(letterText))
					player:NextState(nextState)
					item:remove()
					return true
				end
				letterUse:key(Storage.FashionistaOnanista.SecretiveLetter)
				letterUse:register()
			end)
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission02.BringPotionToRobBarley,
			QuestFactory.Dialog("Rob Barley", {
				[{ GREET, "mission", "misja" }] = {
					text = "Do you have it?",
				},
				[{ "yes", "tak" }] = {
					text = "Alright. Here are your bags. Pleasure doing business..",
					textNoRequiredItems = {
						"Yeah, yeah. Come back when you have it.",
					},
					requiredItems = {
						{ id = 7443 },
					},
					rewards = {
						QuestKeyItems.FashionistaOnanista.CokeBag,
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission02] = QuestState.FashionistaOnanista.Mission02.BringCokeToMoustachilles,
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				local robBarleyLock = SpawnLocks.FashionistaOnanista.RobBarley

				local spawnRobBarley = MoveEvent()
				function spawnRobBarley.onStepIn(creature, item, _, _)
					local player = creature:getPlayer()
					if not player then
						return
					end
					if not player:HasExactMissionState(missionState) then
						return
					end
					if robBarleyLock:IsSet() then
						return
					end

					local robBarley = Game.createNpc("Rob Barley", player:getPosition())
					robBarleyLock:Set(robBarley)
					addEvent(function()
						robBarley:remove()
					end, 60 * 1000)
				end
				spawnRobBarley:type("stepin")
				spawnRobBarley:key(Storage.FashionistaOnanista.SpawnRobBarley)
				spawnRobBarley:register()
			end)
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission02.BringCokeToMoustachilles,
			QuestFactory.Dialog("Moustachilles", {
				[{ "mission", "misja" }] = {
					text = "You did well, here is your reward. If you want to do some more work for me, ask me for a {mission}.",
					requiredItems = {
						QuestKeyItems.FashionistaOnanista.CokeBag,
					},
					rewards = {
						QuestKeyItems.FashionistaOnanista.MetamphetamineCrystal,
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission02] = MISSION_FINISHED,
						[Storage.FashionistaOnanista.Mission03] = QuestState.FashionistaOnanista.Mission03.AskMoustachillesForNewMission,
					},
				},
			}),
			QuestFactory.Script(function()
				local methCrystal = Action()
				function methCrystal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					item:remove()
					player:setStorageValueByKey(Storage.BonusMountSpeedStorages.FashionistaMission02MetamphetamineCrystal, 30)
					player:UpdateMountbonusMovementSpeed(true)
				end
				methCrystal:key(QuestKeyItems.FashionistaOnanista.MetamphetamineCrystal.key)
				methCrystal:register()
			end)
	end)
	:Mission(Storage.FashionistaOnanista.Mission03)
	:State(function()
		return QuestState.FashionistaOnanista.Mission03.AskMoustachillesForNewMission,
			QuestFactory.Dialog("Moustachilles", {
				[{ "mission", "misja" }] = {
					text = "Take those bags and sell them to two of my clients. One is a soccer fan living in southern slums, and other one has biggest nose around. I expect you not to look inside those bags. The rate is 50 platinum coins per bag.",
					rewards = {
						QuestKeyItems.FashionistaOnanista.FentBagCyclops,
						QuestKeyItems.FashionistaOnanista.FentBagTurdstin,
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission03] = QuestState.FashionistaOnanista.Mission03.SellFentToCyclops,
					},
				},
			}),
			QuestFactory.OnUseDeclarations({
				{
					key = QuestKeyItems.FashionistaOnanista.FentBagCyclops.key,
				},
				{
					key = QuestKeyItems.FashionistaOnanista.FentBagTurdstin.key,
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission03.SellFentToCyclops,
			QuestFactory.Dialog("A Sweaty Cyclops", {
				[{ "fent" }] = {
					text = "STOP! POLICE. What do we have there? A fent!? You know what? - leave one bag with me and i didnt see or hear anything. Do we have a deal?",
					nextTopic = QuestTopics.FashionistaOnanista.Mission03.ConfirmGiveUpBag,
				},
				[{ "yes", "tak", "sure", "pewnie", "jasne", "alright", "yeah" }] = {
					text = "Now, get out. I dont want to see you around.",
					requiredTopic = QuestTopics.FashionistaOnanista.Mission03.ConfirmGiveUpBag,
					requiredItems = {
						{ QuestKeyItems.FashionistaOnanista.FentBagCyclops },
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission03] = QuestState.FashionistaOnanista.Mission03.SellFentToTurdstin,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission03.SellFentToTurdstin,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "fent" }] = {
					text = "Finally.. How much platinum' for this?",
					nextTopic = QuestTopics.FashionistaOnanista.Mission03.ConfirmBagPrice,
				},
				[{ "<amount>" }] = {
					text = "Alright, here is the guap, i counted it.",
					requiredTopic = QuestTopics.FashionistaOnanista.Mission03.ConfirmBagPrice,
					requiredItems = {
						{ QuestKeyItems.FashionistaOnanista.FentBagTurdstin },
					},
					specialRequirements = {
						{
							requirement = function(context)
								local amount = tonumber(context.amount)
								if not amount then
									return NO_REQUIREMENT_FAIL_TEXT
								end
								return amount <= 130
							end,
							requiredOutcome = true,
							textFailedRequirement = "What!? Thats way too much. Imma pass.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = function(context)
								context.player:addMoney(tonumber(context.amount) * 100)
							end,
						},
					},
					nextState = {
						[Storage.FashionistaOnanista.Mission03] = QuestState.FashionistaOnanista.Mission03.ReportToMoustachilles,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission03.ReportToMoustachilles,
			QuestFactory.Dialog("Moustachilles", {
				[{ "mission", "misja" }] = {
					text = "Alright! Look like the business is going well. Here is your reward. You should check on Ocellatus, i heard he is doing the meat beating competition again.",
					requiredMoney = 10000,
					rewards = {
						{ id = 25361 },
						{ id = 25360 },
					},
					textNoRequiredMoney = "Come back when you have my money.",
					nextState = {
						[Storage.FashionistaOnanista.Mission03] = MISSION_FINISHED,
						[Storage.FashionistaOnanista.Mission04] = QuestState.FashionistaOnanista.Mission04.AskOcellatusForNewMission,
					},
				},
			})
	end)
	:Mission(Storage.FashionistaOnanista.Mission04)
	:State(function()
		return QuestState.FashionistaOnanista.Mission04.AskOcellatusForNewMission,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "I see you have heard about the umpcoming meat beating competition. Bring me another 10 medals, so we can honour the winners.",
					nextState = {
						[Storage.FashionistaOnanista.Mission04] = QuestState.FashionistaOnanista.Mission04.BringMedalsToOcellatusEndless,
						[Storage.BonusMountSpeedStorages.FashionistaMission04EndlessMedalsCarrotTurnIns] = 0,
						[Storage.FashionistaOnanista.CarrotsMade] = 0,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FashionistaOnanista.Mission04.BringMedalsToOcellatusEndless,
			QuestFactory.Dialog("Ocellatus", {
				[{ "competition", "zawody", "medal" }] = {
					text = "Thanks for your help. For your reward, take this magical carrot.",
					requiredItems = {
						{ id = 5785, count = 10 },
					},
					rewards = {
						QuestKeyItems.FashionistaOnanista.SpeedCarrot,
					},
					requiredState = {
						[Storage.FashionistaOnanista.CarrotsMade] = { max = math.ceil(DAYS_SINCE_START / 7) },
					},
					textNoRequiredState = "Come back next week.",
					nextState = {
						[Storage.FashionistaOnanista.CarrotsMade] = "+1",
					},
				},
			}),
			QuestFactory.Script(function()
				local carrot = Action()
				function carrot.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					item:remove(1)
					player:IncrementStorage(Storage.BonusMountSpeedStorages.FashionistaMission04EndlessMedalsCarrotTurnIns, 20)
					player:UpdateMountbonusMovementSpeed(true)
				end
				carrot:key(QuestKeyItems.FashionistaOnanista.SpeedCarrot.key)
				carrot:register()
			end)
	end)
	:Register()

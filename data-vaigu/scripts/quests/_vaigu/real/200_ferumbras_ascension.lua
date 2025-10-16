local quest = Quest(LOCALIZERS.NONE)

local teleportationRodId = ItemId.TELEPORTATION_ROD
quest
	:Storage(function()
		Storage.FerumbrasAscensionCustom = {
			Mission01 = {},
			MinibossesAccess = {},
			FinalBossAccess = {},
		}
	end)
	:Constant(function()
		QuestState.FerumbrasAscensionCustom = {
			Mission01 = {
				DefeatAllMiniBosses = 1,
				DefeatFerumbras = 2,
			},
		}
		QuestTopics.FerumbrasAscensionCustom = {
			ConfirmWantToHelp = NextTopic(),
			ConfirmTradeInEssences = NextTopic(),
		}

		local allPartsCollected = {
			[Storage.Quest.U10_90.FerumbrasAscension.Razzagorn] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Ragiaz] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Zamulosh] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Mazoran] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Tarbaz] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Shulgrax] = ACCESS_GRANTED,
			[Storage.Quest.U10_90.FerumbrasAscension.Plagirath] = ACCESS_GRANTED,
		}
		local storageToBossName = {}
		for key in pairs(allPartsCollected) do
			local bossName = extractKeySuffix(key)
			storageToBossName[key] = bossName
		end
		QuestConstants.FerumbrasAscensionCustom = {
			AllPartsCollected = allPartsCollected,
			StorageToBossName = storageToBossName,
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Ferumbras Ascension",
			localizer = localizer,
			missions = {
				{
					name = "Ferumbras the Ascendant",
					storage = Storage.FerumbrasAscensionCustom.Mission01,
					states = {
						[QuestState.FerumbrasAscensionCustom.Mission01.DefeatAllMiniBosses] = "Defeat Ruthless Seven minions and transport all Godbreaker parts to Mazarius.",
						[QuestState.FerumbrasAscensionCustom.Mission01.DefeatFerumbras] = "Stop Ferumbras from ascending! Ask Mazarius for directions if you are lost.",
						[MISSION_FINISHED] = "You succesfully stopped Ferumbras' ascension.",
					},
				},
			},
		})
	end)
	:Mission(Storage.FerumbrasAscensionCustom.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Mazarius", {
				[{ GREET }] = {
					text = "Greetings, dear visitor. Please tell me what {brings} you here, to my humble adobe.",
				},
				[{ "brings" }] = {
					text = "Ah, you have heard about my search for experienced help. And indeed your reputation for solving certain {problems} has preceded you.",
				},
				[{ "problems" }] = {
					text = "My problems are, so to say, dire news for the whole world. <sigh> I don't want to confuse you with overly complicated and lengthy stories, so long story {short}..",
				},
				[{ "short" }] = {
					text = "My studies indicate that without all doubt Ferumbras the fiendish is in the process of accumulating nearly godlike powers. We have to stop him.\nTherefore I need you to enter a hellish dimension and acquire the parts of a weapon, the godbreaker, powerful enough to stop him once and for all. Are you willing to help me in this dire mission?",
					nextTopic = QuestTopics.FerumbrasAscensionCustom.ConfirmWantToHelp,
				},
				[{ "yes" }] = {
					text = "Good!, but I need 30 {demonic essences} to exchange with the demonic messenger for a ticket for you to enter the Abodes of Torments.",
					requiredTopic = QuestTopics.FerumbrasAscensionCustom.ConfirmWantToHelp,
				},
				[{ "demonic essence", "essence" }] = {
					text = "Do you have 30 demonic essences to offer to the demonic messenger?",
					nextTopic = QuestTopics.FerumbrasAscensionCustom.ConfirmTradeInEssences,
				},
				[{ "yes" }] = {
					text = "Excellent! This will empower possibilty to create a breach is enough to let you pass into that hellish hiding place. ...",
					requiredItems = {
						{ id = ItemId.DEMONIC_ESSENCE, count = 30 },
					},
					rewards = {
						{ id = teleportationRodId, addToStore = true },
					},
					textNoRequiredItems = "You don't have the demonic essences, back here when you get it.",
					nextState = {
						[Storage.FerumbrasAscensionCustom.Mission01] = QuestState.FerumbrasAscensionCustom.Mission01.DefeatAllMiniBosses,
						[Storage.FerumbrasAscensionCustom.MinibossesAccess] = ACCESS_GRANTED,
					},
					requiredTopic = QuestTopics.FerumbrasAscensionCustom.ConfirmTradeInEssences,
				},
			})
	end)
	:State(function()
		return QuestState.FerumbrasAscensionCustom.Mission01.DefeatAllMiniBosses,
			QuestFactory.Dialog("Mazarius", {
				[{ GREET }] = {
					text = "Ascension is a fascinating topic that dates back to efforts and philosophies of some of the most ancient, and mostly extinct, races which fought in the godwars. ...\nProbably born out of desperation, they extensively researched ways to acquire godhood themselves. ...\nSome of them at least even met with moderate success. But the process is complicated at best, and may vary from race to race or even from one individual to another. ...\nThe theories differ vastly and waxed and waned in popularity over the centuries if not aeons. Even today and in human society there are a number of obscure ascension cults. ...\nSome of them claim that humans are most suitable for ascension because they already own a bit of divinity through Banor's godly spark. Lets see how {ferumbras} does now, shall we?",
					nextState = {
						[Storage.FerumbrasAscensionCustom.Mission01] = QuestState.FerumbrasAscensionCustom.Mission01.DefeatFerumbras,
						[Storage.FerumbrasAscensionCustom.FinalBossAccess] = ACCESS_GRANTED,
					},
					requiredState = {
						QuestConstants.FerumbrasAscensionCustom.AllPartsCollected,
					},
					textNoRequiredState = "Greetings, dear visitor. Please tell me what {brings} you here, to my humble adobe.",
				},
				[{ "brings" }] = {
					text = "To my horror I had to recognise that Ferumbras had already made significant progress, and his final bid for ascension is imminent! ...\nHis power levels are already too high for there to be any hope of stopping him with conventional means. ...\nBut not all is lost yet. During my studies about godhood, I learned that the dark Zathroth himself had created a weapon so powerful that it could actually slay a god. ...\nYet even he deemed this so-called '{godbreaker}' too dangerous, and split it into seven parts. These were at some point entrusted to his powerful minions, known as the Ruthless Seven. ...",
				},
				[{ "godbreaker" }] = {
					text = "For a long time, I thought the godbreaker to be some apocryphal myth. But apparently others had learned about the godbreaker in the aeons past and lusted for its power. ...\nThey had gathered hint after hint - until, ultimately, they were squashed by the Seven or their minions; which only made the leads that hinted at them all the more probable. ...\nWhat Zathroth hoped to accomplish with the creation of such a weapon can only be subject to speculation. Assumedly he already had slain Tibiasula, so the godbreaker might have been even more powerful, more absolute. ...\nHowever, it has to be assumed that in the end the sheer power of his creation scared Zathroth, who had to fear the weapon could one day be used against him. So he disassembled it. ...\nHe kept the parts hidden and guarded, and if the resources can be trusted and my interpretation is right, moved them again and again, never satisfied with a hiding place. In the end he entrusted the parts to the {Ruthless Seven}. ...\nKnowing that they would never, ever allow one of their own to come in possession of all parts. Since then, the parts have been hidden in a {demi-plane} shared by the Seven.",
				},
				[{ "ruthless seven", "Ruthless Seven" }] = {
					text = "Given the internal power plays amongst the Seven, they are the ideal keepers for individual parts of an powerful artefact. Not one of them would allow his compatriots to hold such a power, and neither would trust the other.",
				},
				[{ "demi-plane" }] = {
					text = "It is a place, so to say, not completely of this world. It is separate of, yet strongly connected to, our own world. I would imagine it is quite limited in size and its laws of physics and magic should be roughly the same as ours. ...\nBeing home to a host of demons for a while, I expect it to be a hostile and dangerous environment.",
				},
			})
	end)
	:State(function()
		return QuestState.FerumbrasAscensionCustom.Mission01.DefeatFerumbras,
			QuestFactory.Dialog("Mazarius", {
				[{ GREET }] = {
					text = "Greetings, dear visitor. Please tell me what {brings} you here, to my humble adobe.",
				},
				[{ "ferumbras", "brings" }] = {
					text = "Although already powerful in his own right, it is obvious that his ultimate goal seems to be the ascension to godly powers. ...\nHis whole existence seems to be centred on becoming a name that strikes fear into the heart of men and to become a persistent figure in the minds of humanity. ...\nThis gives him a hold in reality and a kind of mould to fill with his power and conscience. It's also obvious that this kind of belief of the people alone won't be enough to empower him sufficiently. ...\nTherefore he has to tap into other, probably even more sinister power sources. I can't tell what these sources are, but my scrying revealed that he has reached massive amounts of power. He has probably been infusing himself since years. ...\nBy now he is apparently reaching the end circle of his ascension and could make his final move any day.",
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Mazarius", {
			[{ GREET }] = {
				text = "Greetings, dear visitor.",
			},
		})
	end)
	:Script(function()
		local lookEvent = Look()
		function lookEvent.onLook(player, item)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(LOCALIZERS.FerumbrasAscension):Get("TELEPORTATION_ROD_DESCRIPTION"))
			return DONT_SHOW_ONLOOK
		end
		lookEvent:id(teleportationRodId)
		lookEvent:register()

		local toMinibosses = MoveEvent()
		function toMinibosses.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValueByKey(Storage.FerumbrasAscensionCustom.MinibossesAccess) ~= ACCESS_GRANTED then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this portal yet.")
				return true
			end

			return true
		end
		toMinibosses:type("stepin")
		toMinibosses:key(Storage.FerumbrasAscensionCustom.MinibossesAccess)
		toMinibosses:register()

		local toBoss = MoveEvent()
		function toBoss.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValueByKey(Storage.FerumbrasAscensionCustom.FinalBossAccess) ~= ACCESS_GRANTED then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this portal yet.")
				return true
			end

			return true
		end
		toBoss:type("stepin")
		toBoss:key(Storage.FerumbrasAscensionCustom.FinalBossAccess)
		toBoss:register()
	end)
	:Register()

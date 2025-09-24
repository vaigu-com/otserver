local quest = Quest(LOCALIZERS.WayOfTheDruid)

quest
	:Storage(function()
		Storage.WayOfTheDruid = {
			CouncilOfDruids = {},
			CouncilThreeDruidsReward = {},
			CouncilFiveDruidsReward = {},
			SandLock = {},
			LootedWater = {},
			LootedFlower = {},

			DeerSeason = {},
			HunterTreeStump = {},
			RadaghastFirebug = {},
			RadaghastBoat = {},

			TakenBenek = {},
			BenekKnife = {},
			BenekTheWolf = {},

			RudeEviction = {},
			SandniggerMap = {},
			BuriedIncantation = {},

			SecretIngredient = {},
			OrnuldMedicine = {},
			WyrmEgg = {},

			SingingCrystal = {},
		}
		QuestState.WayOfTheDruid = {
			CouncilOfDruids = {
				HelpedOne = 0,
				HelpedTwo = 1,
				HelpedThree = 2,
				HelpedFour = 3,
				HelpedFive = 4,
			},
			DeerSeason = {
				BurnHunterStock = 1,
				ReportToRadaghast = 2,
			},
			TakenBenek = {
				FreeBenek = 1,
				ReportToEstep = 2,
			},
			RudeEviction = {
				FindSandniggerSpell = 1,
				ReportToSandnigger = 2,
			},
			SecretIngredient = {
				AskOrnuldForMedicine = 1,
				FindWyrmEgg = 2,
				BringEggToOrnuld = 3,
				BringMedicineToMundral = 4,
			},
			SingingCrystal = {
				BringCrystalToMalfurion = 1,
			},
		}
		QuestTopics.WayOfTheDruid = {
			AcceptCrystalQuest = NextTopic(),
			AcceptWyrmEggQuest = NextTopic(),
			AcceptDeerSeason = NextTopic(),
			AcceptBenekQuest = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.WayOfTheDruid = {
			SandniggerMap = { id = 22107, key = Storage.WayOfTheDruid.SandniggerMap },
			BenekKnife = { id = 5908, key = Storage.WayOfTheDruid.BenekKnife },
			OrnuldWyrmEgg = { id = 18996, key = Storage.WayOfTheDruid.WyrmEgg },
			OrnuldMedicine = { id = 8819, key = Storage.WayOfTheDruid.OrnuldMedicine },
			RadaghastFirebug = { id = 5467, key = Storage.WayOfTheDruid.RadaghastFirebug },
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "The Way of a Druid",
			localizer = localizer,
			missions = {
				{
					name = "The Council of Druids",
					storage = Storage.WayOfTheDruid.CouncilOfDruids,
					states = {
						[QuestState.WayOfTheDruid.CouncilOfDruids.HelpedOne] = "You helped the first druid. This is the beginning of your journey to become one of them. Find the remaining druid, and provide them with your help.",
						[QuestState.WayOfTheDruid.CouncilOfDruids.HelpedTwo] = "The Mother Nature is watching, and she is cherishing as you helped two of the druids.",
						[QuestState.WayOfTheDruid.CouncilOfDruids.HelpedThree] = "Your efforts induced The Mother Nature to let you gather water from well at the great tree. You have helped three druids so far.",
						[QuestState.WayOfTheDruid.CouncilOfDruids.HelpedFour] = "Your kindness goes a long way, you helped four druids so far. You are now able to gather water from the great tree well.",
						[QuestState.WayOfTheDruid.CouncilOfDruids.HelpedFive] = "You helped all the druids, and you have been introduced to their Council. In addition to being able to gather water from the well you can also harvest a blossom of the Griffinclaw plant, which grows inside the great tree.",
						[MISSION_FINISHED] = "You helped all the druids, and you have been introduced to their Council. In addition to being able to gather water from the well you can also harvest a blossom of the Griffinclaw plant, which grows inside the great tree.",
					},
				},
				{
					name = "Deer Season",
					storage = Storage.WayOfTheDruid.DeerSeason,
					states = {
						[QuestState.WayOfTheDruid.DeerSeason.BurnHunterStock] = "Radaghast asked you to burn down the hunters' stock of wood. This should prove to help a lot of animals to survive during the hunting season.",
						[QuestState.WayOfTheDruid.DeerSeason.ReportToRadaghast] = "You managed to burn down the stock of wood in the hunters' village. Make haste and tell about this to Radaghast.",
						[MISSION_FINISHED] = "Radaghast handed you a slingshot for your help, also he erranded you to help other druids from the council he told you about.",
					},
				},
				{
					name = "Taken: Benek",
					storage = Storage.WayOfTheDruid.TakenBenek,
					states = {
						[QuestState.WayOfTheDruid.TakenBenek.FreeBenek] = "Estep is Wailing since orcs taken his Wolf companion.",
						[QuestState.WayOfTheDruid.TakenBenek.ReportToEstep] = "The wolf has been freed, deliver a good message to Estep.",
						[MISSION_FINISHED] = "Estep handed over this knife in his gratitude.",
					},
				},
				{
					name = "Rude eviction",
					storage = Storage.WayOfTheDruid.RudeEviction,
					states = {
						[QuestState.WayOfTheDruid.RudeEviction.FindSandniggerSpell] = "SandNigger asked you to help him reclaim his secret spell.",
						[QuestState.WayOfTheDruid.RudeEviction.ReportToSandnigger] = "You managed to find and combust the spell, come back to Sandnigger.",
						[MISSION_FINISHED] = "For your kind deed, you have been granted The Lion Amulet.",
					},
				},
				{
					name = "The secret ingredient",
					storage = Storage.WayOfTheDruid.SecretIngredient,
					states = {
						[QuestState.WayOfTheDruid.SecretIngredient.AskOrnuldForMedicine] = "Mundral asked you to get the medicine for his sick pet. You can ask Ornuld for it.",
						[QuestState.WayOfTheDruid.SecretIngredient.FindWyrmEgg] = "Ornuld wishes to have a one wyrm egg. If you manage to do this favor, he will reward you with the medicine.",
						[QuestState.WayOfTheDruid.SecretIngredient.BringEggToOrnuld] = "You found the wyrm's egg, hand it to Ornuld.",
						[QuestState.WayOfTheDruid.SecretIngredient.BringMedicineToMundral] = "Ornuld gave you the medicine in exchange for the wyrm's egg. Report to Mundral now.",
						[MISSION_FINISHED] = "Turn out that Mundral belongs to the Druid Council. He put in a good word to his druid friends and he gifted you with bamboo leaves.",
					},
				},
				{
					name = "The Singing Crystal",
					storage = Storage.WayOfTheDruid.SingingCrystal,
					states = {
						[QuestState.WayOfTheDruid.SingingCrystal.BringCrystalToMalfurion] = "Malfurion is in need of an ice crystal fragment for his experiment.",
						[MISSION_FINISHED] = "For your help, Malfurion gave you a gift.",
					},
				},
			},
		})
	end)
	:Mission(Storage.WayOfTheDruid.CouncilOfDruids)
	:State(function()
		return QuestState.WayOfTheDruid.CouncilOfDruids.HelpedOne,
			QuestFactory.Dialog({ "Radaghast the brown", "Sand Nigger", "Malfurion", "Mundral", "Estep" }, {
				[{ "druid", "druids", "krag", "circle", "druidow", "druidzi" }] = {
					text = "Right, I should explain the context first. The thing is, the world was at peace in the past and we lived together in the jungle as a druid would do, but the times have changed for worse and we were forced to leave our village. Everyone went their own way.\nOnly five of us remain, we meet once a year in a big tree in the jungle. If you prove yourself to be trustworthy, we might let you join us.\nI don't know where the others are now, do your best to find and help them if needed.",
				},
			})
	end)
	:State(function()
		return { min = QuestState.WayOfTheDruid.CouncilOfDruids.HelpedThree },
			QuestFactory.Dialog({ "Radaghast the brown", "Sand Nigger", "Malfurion", "Mundral", "Estep" }, {
				[{ "mission", "misja" }] = {
					text = "For your service to the druids, you may go to our holy tree and fetch a gob of water from the spring.\nOur sacred tree is located in the very heart of the jungle.",
					expReward = 47000,
					requiredState = {
						[Storage.WayOfTheDruid.CouncilThreeDruidsReward] = MISSION_NOT_STARTED,
					},
					nextState = {
						[Storage.WayOfTheDruid.CouncilThreeDruidsReward] = MISSION_FINISHED,
					},
				},
			}),
			QuestFactory.Script(function()
				local waterWell = Action()
				function waterWell.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local localizer = player:Localizer(LOCALIZERS.WayOfTheDruid)
					if player:getStorageValueByKey(Storage.WayOfTheDruid.CouncilOfDruids) < 3 then
						doCreatureSay(player, localizer:Get("You are not worthy to gather the sacred water!"), TALKTYPE_ORANGE_1)
						return
					end
					if player:getStorageValueByKey(Storage.WayOfTheDruid.LootedWater) == MISSION_FINISHED then
						doCreatureSay(player, localizer:Get("You already gathered the sacred water"), TALKTYPE_ORANGE_1)
						return
					end

					player:AddCustomItem({ id = 5938, count = 1 })
					player:getPosition():sendMagicEffect(CONST_ME_WATERCREATURE)
					player:setStorageValueByKey(Storage.WayOfTheDruid.LootedWater, MISSION_FINISHED)
				end
				waterWell:key(Storage.WayOfTheDruid.LootedWater)
				waterWell:register()
			end)
	end)
	:State(function()
		return { min = QuestState.WayOfTheDruid.CouncilOfDruids.HelpedOne, max = QuestState.WayOfTheDruid.CouncilOfDruids.HelpedFour }, QuestFactory.Dialog({ "Radaghast the brown", "Sand Nigger", "Malfurion", "Mundral", "Estep" }, {
			[{ "druid", "druids", "krag", "circle", "druidow", "druidzi" }] = {
				text = "I trust that you can find the remaining druids and help them.",
			},
		})
	end)
	:State(function()
		return { min = QuestState.WayOfTheDruid.CouncilOfDruids.HelpedFive },
			QuestFactory.Dialog({ "Radaghast the brown", "Sand Nigger", "Malfurion", "Mundral", "Estep" }, {
				[{ "mission", "misja" }] = {
					text = "For your service to the druids, you may go to our sacred tree and pick a sample of the Griffinclaw flower.\nOur sacred tree is located in the very heart of the jungle. As a bonus, take this necklace. We welcome you to our community.",
					expReward = 256000,
					rewards = {
						{ id = 5940 },
					},
					requiredState = {
						[Storage.WayOfTheDruid.CouncilFiveDruidsReward] = MISSION_NOT_STARTED,
					},
					nextState = {
						[Storage.WayOfTheDruid.CouncilFiveDruidsReward] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.CouncilOfDruids] = MISSION_FINISHED,
						[Storage.Finished.WayOfTheDruid] = MISSION_FINISHED,
					},
				},
			}),
			QuestFactory.Script(function()
				local flower = Action()
				function flower.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local localizer = player:Localizer(LOCALIZERS.WayOfTheDruid)
					if player:getStorageValueByKey(Storage.WayOfTheDruid.CouncilOfDruids) < 5 then
						doCreatureSay(player, localizer:Get("You are not worthy to gather the sacred flower!"), TALKTYPE_ORANGE_1)
						return
					end
					if player:getStorageValueByKey(Storage.WayOfTheDruid.LootedFlower) == MISSION_FINISHED then
						doCreatureSay(player, localizer:Get("You already gathered the sacred flower"), TALKTYPE_ORANGE_1)
						return
					end

					player:AddCustomItem({ id = 5937, count = 1 })
					toPosition:sendMagicEffect(CONST_ME_CARNIPHILA)
					player:setStorageValueByKey(Storage.WayOfTheDruid.LootedFlower, MISSION_FINISHED)
				end
				flower:key(Storage.WayOfTheDruid.LootedFlower)
				flower:register()
			end)
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog({ "Radaghast the brown", "Sand Nigger", "Malfurion", "Mundral", "Estep" }, {
			[{ "druid", "druids", "krag", "circle", "druidow", "druidzi" }] = {
				text = "Thank you for helping me and the rest of the druids. Now you became one of us.",
			},
		})
	end)
	:Mission(Storage.WayOfTheDruid.DeerSeason)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Radaghast the brown", {
				[{ "mission", "misja" }] = {
					text = "You want to help me? Soon the deer hunting season will start. Those poor animals are in danger! The poachers won't spare anyone.\nI know how we could help them a bit. So can I count on you?",
					nextTopic = QuestTopics.WayOfTheDruid.AcceptDeerSeason,
				},
				[{ "yes", "tak" }] = {
					text = "The best way would be to sneak up into their camp and set fire to wood storage. It should take them a bunch of time to extinguish it and could possibly save some animals.",
					rewards = {
						QuestKeyItems.WayOfTheDruid.RadaghastFirebug,
					},
					requiredTopic = QuestTopics.WayOfTheDruid.AcceptDeerSeason,
					nextState = {
						[Storage.WayOfTheDruid.DeerSeason] = QuestState.WayOfTheDruid.DeerSeason.BurnHunterStock,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.DeerSeason.BurnHunterStock,
			QuestFactory.Script(function()
				local firebug = Action()
				function firebug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if target:getKey() ~= Storage.WayOfTheDruid.HunterTreeStump then
						return
					end

					toPosition:sendMagicEffect(CONST_ME_FIREAREA)
					player:setStorageValueByKey(Storage.WayOfTheDruid.DeerSeason, QuestState.WayOfTheDruid.DeerSeason.ReportToRadaghast)
				end
				firebug:key(Storage.WayOfTheDruid.RadaghastFirebug)
				firebug:register()
			end)
	end)
	:State(function()
		return QuestState.WayOfTheDruid.DeerSeason.ReportToRadaghast,
			QuestFactory.Dialog("Radaghast the brown", {
				[{ "mission", "misja" }] = {
					text = "Great, now they need to gather all the wood again. I thank you in the names of {druids}. If u would like, now I can tell you about our way.\nYou can also use my {boat}, but be careful, there's a island nearby, from which none of the survivors came back wtih life.",
					expReward = 3400,
					rewards = {
						{ id = 5907 },
						{ id = 830 },
					},
					requiredItems = {
						QuestKeyItems.WayOfTheDruid.RadaghastFirebug,
					},
					nextState = {
						[Storage.WayOfTheDruid.CouncilOfDruids] = "+1",
						[Storage.WayOfTheDruid.DeerSeason] = MISSION_FINISHED,
						[Storage.Finished.DeerSeason] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.RadaghastBoat] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED,
			QuestFactory.Dialog("Radaghast the brown", {
				[{ "lodka", "lodz", "boat" }] = {
					text = "I use this boat for fishing only, however it is possible to sail to the Nightmare Island",
				},
			}),
			QuestFactory.Script(function()
				InstantTravel({ positions = { Position(6109, 1688, 7), Position(6122, 1780, 7) }, requiredState = { [Storage.WayOfTheDruid.RadaghastBoat] = ACCESS_GRANTED } }):Register()
			end)
	end)
	:State(function()
		return { neq = MISSION_FINISHED }, QuestFactory.Dialog("Radaghast the brown", {
			[{ "lodka", "lodz", "boat" }] = {
				text = "I won't let you use my boat yet. Not until i see a friend in you.",
			},
		})
	end)
	:Mission(Storage.WayOfTheDruid.RudeEviction)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Sand Nigger", {
				[{ "mission", "misja" }] = {
					text = "Do you want to serve the druids circle? I'm one of them but I prefer desert instead of green lands.\nIf you want to serve us, sneak into the camp in the east, not far from bonebeast peninsula. I was living there but nomads attacked us and I had to move here.\nSomewhere close to the shore I buried a note with spell for summoning an undead bear.\nRemember the spell and burn down the note just in case someone catches you.\nIf you were to struggle you could probably use a {map}. I can give you one if you want.",
				},
				[{ "map", "mapa" }] = {
					text = "Have this map, it should help you.",
					rewards = {
						QuestKeyItems.WayOfTheDruid.SandniggerMap,
					},
					nextState = {
						[Storage.WayOfTheDruid.RudeEviction] = QuestState.WayOfTheDruid.RudeEviction.FindSandniggerSpell,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.RudeEviction.FindSandniggerSpell,
			QuestFactory.Script(function()
				local destination = Position(7123, 1254, 7)
				local map = Action()
				function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local vectorBetween = Vector.BetweenPositions(player:getPosition(), destination)
					local direction = vectorBetween:ToDirectionByAngle()
					local announcement = player:Localizer(LOCALIZERS.Universal):Context({ direction = direction }):Get("GO_IN_DIRECTION")

					doCreatureSay(player, announcement, TALKTYPE_ORANGE_1)
				end
				map:key(Storage.WayOfTheDruid.SandniggerMap)
				map:register()
			end),
			QuestFactory.OnUseDeclarations({
				{
					id = 213,

					key = Storage.WayOfTheDruid.BuriedIncantation,
					nextState = {
						[Storage.WayOfTheDruid.RudeEviction] = QuestState.WayOfTheDruid.RudeEviction.ReportToSandnigger,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.RudeEviction.ReportToSandnigger,
			QuestFactory.Dialog("Sand Nigger", {
				[{ "mission", "misja" }] = {
					text = "The spell is working! In the name of {druid} let me thank you and bestow this amulet upon you.",
					expReward = 12000,
					requiredItems = {
						QuestKeyItems.WayOfTheDruid.SandniggerMap,
					},
					rewards = {
						{ id = 21439 },
					},
					nextState = {
						[Storage.WayOfTheDruid.RudeEviction] = MISSION_FINISHED,
						[Storage.Finished.RudeEviction] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.CouncilOfDruids] = "+1",
					},
					spawnMonstersOnSuccess = {
						{ name = "Undead Cavebear" },
					},
				},
			})
	end)
	:Mission(Storage.WayOfTheDruid.TakenBenek)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Estep", {
				[{ "mission", "misja" }] = {
					text = "It was a nightmare.. Those green beasts came and stole my {benek}.",
				},
				[{ "benek", "benka" }] = {
					text = "Thats my wolf. Orcs stole him and hid somewhere. Would you help me to rescue him?",
					nextTopic = QuestTopics.WayOfTheDruid.AcceptBenekQuest,
				},
				[{ "yes", "tak" }] = {
					text = "Take this knife, surely you will need it. Benek is most likely strangled, use it to free him.",
					requiredTopic = QuestTopics.WayOfTheDruid.AcceptBenekQuest,
					rewards = {
						QuestKeyItems.WayOfTheDruid.BenekKnife,
					},
					nextState = {
						[Storage.WayOfTheDruid.TakenBenek] = QuestState.WayOfTheDruid.TakenBenek.FreeBenek,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.TakenBenek.FreeBenek,
			QuestFactory.Dialog("Estep", {
				[{ "benek", "benka" }] = {
					text = "Thats my wolf. Orcs stole him and hid somewhere. I hope you will succeed rescuing him.",
				},
			}),
			QuestFactory.Script(function()
				local knife = Action()
				function knife.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if target == nil or target:getId() ~= 12369 or target:getKey() ~= Storage.WayOfTheDruid.BenekTheWolf then
						return false
					end

					toPosition:sendMagicEffect(CONST_ME_POFF)
					player:setStorageValueByKey(Storage.WayOfTheDruid.TakenBenek, QuestState.WayOfTheDruid.TakenBenek.ReportToEstep)
				end
				knife:key(Storage.WayOfTheDruid.BenekKnife)
				knife:register()
			end)
	end)
	:State(function()
		return QuestState.WayOfTheDruid.TakenBenek.ReportToEstep,
			QuestFactory.Dialog("Estep", {
				[{ "mission", "misja", "benek", "benka" }] = {
					text = "Did you manage to {help} Benek?",
				},
				[{ "help", "pomoc", "yes", "tak" }] = {
					text = "Thank you so much! If it weren't for you he would be dead for sure, look at how exhausted and injured he is. Luckily, as one of the druids, I have expertise in animal care.\nYou can have the knife and take my wand as a token of my gratitude. Be blessed by the Mother Earth.",
					expReward = 3000,
					requiredItems = {
						QuestKeyItems.WayOfTheDruid.BenekKnife,
					},
					rewards = {
						{ id = 5908 },
						{ id = 3065 },
					},
					nextState = {
						[Storage.WayOfTheDruid.TakenBenek] = MISSION_FINISHED,
						[Storage.Finished.TakenBenek] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.CouncilOfDruids] = "+1",
					},
				},
			})
	end)
	:Mission(Storage.WayOfTheDruid.SecretIngredient)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Mundral", {
				[{ "mission", "misja" }] = {
					text = "Are you coming there to help me?\nThen there is one thing you can do for me. Recently one of my animals got really sick.\nAnd the only medicine I know that could help him is what Ornuld developed. But he doesn't want to help me, seems like he want to see this innocent animal die.\nMaybe you can get this from him, just don't say that I sent you. You can find him in the western part of the jungle, he has his little camp there.",
					nextState = {
						[Storage.WayOfTheDruid.SecretIngredient] = QuestState.WayOfTheDruid.SecretIngredient.AskOrnuldForMedicine,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.SecretIngredient.AskOrnuldForMedicine,
			QuestFactory.Dialog("Ornuld", {
				[{ "medicine", "lekarstwo", "antidote", "lek", "leki" }] = {
					text = "Medicine you said? It won't be as cheap as you think. Well, you can help me, and in return i could give you some. How about that?",
					nextTopic = QuestTopics.WayOfTheDruid.AcceptWyrmEggQuest,
				},
				[{ "yes", "tak", "sure", "pewnie", "ok", "zgadzam", "zgadzam sie" }] = {
					text = "I somewhat and exotic animals collector. One of traders told me about Wyrm's egg.\nGet one for me, please. You can find Wyrm's lair on the mountain to the north from here. Be careful, they dont like anyone coming here let alone stealing one of their brood.",
					nextState = {
						[Storage.WayOfTheDruid.SecretIngredient] = QuestState.WayOfTheDruid.SecretIngredient.FindWyrmEgg,
					},
					requiredTopic = QuestTopics.WayOfTheDruid.AcceptWyrmEggQuest,
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.SecretIngredient.FindWyrmEgg, QuestFactory.OnUseDeclarations({
			{
				key = Storage.WayOfTheDruid.WyrmEgg,
				nextState = {
					[Storage.WayOfTheDruid.SecretIngredient] = QuestState.WayOfTheDruid.SecretIngredient.BringEggToOrnuld,
				},
				rewards = {
					QuestKeyItems.WayOfTheDruid.OrnuldWyrmEgg,
				},
			},
		})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.SecretIngredient.BringEggToOrnuld,
			QuestFactory.Dialog("Ornuld", {
				[{ "mission", "misja" }] = {
					text = "It a bit cracked here and there, but it's still great! I am really grateful to you. Here is the medicine.",
					requiredItems = {
						QuestKeyItems.WayOfTheDruid.OrnuldWyrmEgg,
					},
					expReward = 40000,
					rewards = {
						QuestKeyItems.WayOfTheDruid.OrnuldMedicine,
					},
					nextState = {
						[Storage.WayOfTheDruid.SecretIngredient] = QuestState.WayOfTheDruid.SecretIngredient.BringMedicineToMundral,
					},
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.SecretIngredient.BringMedicineToMundral,
			QuestFactory.Dialog("Mundral", {
				[{ "mission", "misja" }] = {
					text = "Thank you, from the bottom of my heart. My Leon finally will cure up. As one of the {druids} I thank you also of behalf of the forest.",
					expReward = 40000,
					rewards = {
						{ id = 12549 },
					},
					nextState = {
						[Storage.WayOfTheDruid.SecretIngredient] = MISSION_FINISHED,
						[Storage.Finished.SecretIngredient] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.CouncilOfDruids] = "+1",
					},
					requiredItems = {
						QuestKeyItems.WayOfTheDruid.OrnuldMedicine,
					},
				},
			})
	end)
	:Mission(Storage.WayOfTheDruid.SingingCrystal)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Malfurion", {
				[{ "mission", "misja" }] = {
					text = "I need a shard for my experiment, but I can't find the time to get one lately. I would be really grateful if you could bring me one.\nWill you find one for me? I will definitely pay back.",
					nextTopic = QuestTopics.WayOfTheDruid.AcceptCrystalQuest,
				},
				[{ "yes", "tak" }] = {
					text = "Great! Come back if you find one.",
					nextState = {
						[Storage.WayOfTheDruid.SingingCrystal] = QuestState.WayOfTheDruid.SingingCrystal.BringCrystalToMalfurion,
					},
					requiredTopic = QuestTopics.WayOfTheDruid.AcceptCrystalQuest,
				},
			})
	end)
	:State(function()
		return QuestState.WayOfTheDruid.SingingCrystal.BringCrystalToMalfurion,
			QuestFactory.Dialog("Malfurion", {
				[{ "mission", "misja" }] = {
					text = "So shiny, I knew you could do it. Thank you on behalf of {druids}. Please, keep this in return for your kindness.",
					textNoRequiredItems = "Come back when you find a shard.",
					nextState = {
						[Storage.WayOfTheDruid.SingingCrystal] = MISSION_FINISHED,
						[Storage.WayOfTheDruid.CouncilOfDruids] = "+1",
						[Storage.Finished.SingingCrystal] = MISSION_FINISHED,
					},
					expReward = 17000,
					rewards = {
						[16100] = {
							{ id = 7250, count = 2 },
						},
					},
					requiredItems = {
						{ id = 7290 },
					},
				},
			})
	end)
	:Register()

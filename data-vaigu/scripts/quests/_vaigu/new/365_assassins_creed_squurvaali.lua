local quest = Quest(LOCALIZERS.AssassinsCreedSquurvaali)

quest
	:Storage(function()
		Storage.AssassinsCreedSquurvaali = {
			Mission01 = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			GhostChair = NextStorage(),
			HeavenPath = NextStorage(),
			HeavenLastTile = NextStorage(),
			Rewards = { CartSilicon = NextStorage() },
			KeyItems = {
				Palette = NextStorage(),
				Flare = NextStorage(),
				Silicon = NextStorage(),
			},
		}
		QuestState.AssassinsCreedSquurvaali = {
			Mission01 = {
				FindFatherNatanek = 1,
				FindOldrak = 2,
				ReportToGhasstlyPrincess = 3,
			},
			Mission02 = {
				FindMareesha = 1,
				FindArtistPalette = 2,
				CompleteExorcismOnTomek = 3,
				ReturnPaletteToMareesha = 4,
			},
			Mission03 = {
				ReportToGhasstlyPrincess = 1,
				FindVislavShivka = 2,
				FindLambor = 3,
				FindWafers = 4,
				ReturnWafersToLambor = 5,
				BringDeadweightsToLambor = 6,
			},
			Mission04 = {
				GoToHighestMountain = 1,
				FireFlare = 2,
				ReportToGhasstlyPrincess = 3,
				ReportToFatherNatanek = 4,
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Assassins's Creed: Squurva'ali",
			missions = {
				[Storage.AssassinsCreedSquurvaali.Mission01] = {
					name = "The First Step to Heaven",
					states = {
						[QuestState.AssassinsCreedSquurvaali.Mission01.FindFatherNatanek] = "You agreed to help the ghost of the princess. Maybe some clergyman in town can help you.",
						[QuestState.AssassinsCreedSquurvaali.Mission01.FindOldrak] = "Father Natanek told you where to find Oldrak. Maybe he can help you.",
						[QuestState.AssassinsCreedSquurvaali.Mission01.ReportToGhasstlyPrincess] = "Oldrak didn't provide you with a solution, but he mentioned a magical carpet. Return to the princess now.",
						[MISSION_FINISHED] = "You consulted with the ghost of the princess, who suggested you find the nomads' camp.",
					},
				},
				[Storage.AssassinsCreedSquurvaali.Mission02] = {
					name = "The Tailor's Touch",
					states = {
						[QuestState.AssassinsCreedSquurvaali.Mission02.FindMareesha] = "The ghost of the princess suggested asking the nomads for help - after all, the Aladdin stereotype didn't come out of nowhere.",
						[QuestState.AssassinsCreedSquurvaali.Mission02.FindArtistPalette] = "The nomad craftsman agreed to make a carpet for you. You will need 5 spider silk, a red pillow, and the artist palette that GM Tomek stole.",
						[QuestState.AssassinsCreedSquurvaali.Mission02.CompleteExorcismOnTomek] = "Complete the exorcism ritual with Ryan - blame it on Tomek.",
						[QuestState.AssassinsCreedSquurvaali.Mission02.ReturnPaletteToMareesha] = "Ryan gave you the palette stolen by Tomek. Now take it to Mareesha and create the carpet. You will need 5 spider silk, a red pillow, and the artist palette that GM Tomek stole.",
						[MISSION_FINISHED] = "You've crafted the carpet with Mareesha. Now return to the ghost and make further plans.",
					},
				},
				[Storage.AssassinsCreedSquurvaali.Mission03] = {
					name = "Distant Calling",
					states = {
						[QuestState.AssassinsCreedSquurvaali.Mission03.ReportToGhasstlyPrincess] = "You acquired a carpet that doesn't have any special abilities. You can return to the Ghasstly Princess.",
						[QuestState.AssassinsCreedSquurvaali.Mission03.FindVislavShivka] = "Ghasstly Princess insisted that you go to Vislav Shivka for help.",
						[QuestState.AssassinsCreedSquurvaali.Mission03.FindLambor] = "Vislav Shivka directed you to the Djinn, who is located somewhere at the desert.",
						[QuestState.AssassinsCreedSquurvaali.Mission03.FindWafers] = "The Djinn instructed you on where to find the smugglers' base. Try to find something there that might interest him.",
						[QuestState.AssassinsCreedSquurvaali.Mission03.ReturnWafersToLambor] = "You found a box of wafers that Djinn mentioned. Return to him and ask for his help with your task.",
						[QuestState.AssassinsCreedSquurvaali.Mission03.BringDeadweightsToLambor] = "Djinn agreed to help with 'enchanting' the carpet. Now find the missing dead weight, and Djinn will do his job.",
						[MISSION_FINISHED] = "You delivered the materials needed for 'enchanting' the carpet to Djinn. From now on, you will be able to fly from the highest mountain in the Caribbean.",
					},
				},
				[Storage.AssassinsCreedSquurvaali.Mission04] = {
					name = "The Final Stretch",
					states = {
						[QuestState.AssassinsCreedSquurvaali.Mission04.GoToHighestMountain] = "Go to the top of the highest mountain in the Caribbean, get on the enchanted carpet, and...",
						[QuestState.AssassinsCreedSquurvaali.Mission04.FireFlare] = "Standing in front of the cave, ignite the flare given to you by the guardian to help the ghost.",
						[QuestState.AssassinsCreedSquurvaali.Mission04.ReportToGhasstlyPrincess] = "You ignited the flare in front of the ghost's cave. In the meantime, have a conversation with the ghost.",
						[QuestState.AssassinsCreedSquurvaali.Mission04.ReportToFatherNatanek] = "At the moment when the undead king of the crypt was about to finish you, an angel arrived who managed to avoid the traps and teleport you to safety. You don't know his or the king of the crypt's fate. Seek advice from Father Natanek.",
						[MISSION_FINISHED] = "Father Natanek informed you about the dire consequences of the King of the Crypt victory.",
					},
				},
			},
		}
	end)
	:Constant(function()
		ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS = {
			despawnGmTomek = function(context)
				local pos = Position(5564, 1575, 8)
				local tile = Tile(pos)
				local monster = tile:getTopCreature()

				local vortex = nil
				if monster then
					vortex = Game.createItem(7804, 1, pos)
				end
				addEvent(function()
					if monster then
						monster:remove()
						pos:sendMagicEffect(CONST_ME_WATERSPLASH)
					end
				end, 1500)
				addEvent(function()
					if vortex then
						vortex:remove()
					end
				end, 3000)
			end,
			spawnGmTomek = function(context)
				local pos = Position(5564, 1575, 8)
				local tile = Tile(pos)
				local monster = tile:getTopCreature()
				if not monster then
					Game.createNpc("gm tomek", pos, false, false)
				end
			end,
			addCarpetMount = function(context)
				local player = context.player
				player:addMount(66)
			end,
			aunorTeleportOut = function(context)
				local player = context.player
				if player then
					player:teleportTo(Position(5811, 805, 0))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end,
			transformNpcToCryptKingLook = function(context)
				local npc = context.npc
				npc:setOutfit({
					lookType = 12,
					lookHead = 1,
					lookBody = 95,
					lookLegs = 90,
					lookFeet = 90,
					lookAddons = 3,
					lookMount = 0,
				})
				npc:setName("King of The Crypt")
			end,
		}

		QuestKeyItems.AssassinsCreedSquurvaali = {
			MarishaArtistPalette = {
				aid = Storage.AssassinsCreedSquurvaali.KeyItems.Palette,
				id = 14684,
				desc = "Assortment of paints. Can be used to paint any surface",
			},
			SiliconWafersForLambor = {
				aid = Storage.AssassinsCreedSquurvaali.KeyItems.Silicon,
				id = 2469,
				desc = "Box of sillicon wafers. Lambor might be interested in it",
			},
			AunorFlare = {
				aid = Storage.AssassinsCreedSquurvaali.KeyItems.Flare,
				id = 30209,
				desc = "Flare from Aunor. Use it before Ghasstly Princess's cave entrance",
			},
		}
	end)
	:Mission(Storage.AssassinsCreedSquurvaali.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ GREET }] = {
					text = "Hello, traveler. I am the Ghasstly Princess. Do you want to hear my {story}?",
				},
				[{ "story", "historie", "yes", "tak" }] = {
					text = "Once upon a time, I was a beautiful princess. One day, I heard from my brother about approaching armies from the north. I had never heard that our kingdom lost a war, so I didn't {worry} about it.",
				},
				[{ "worry", "przejelam" }] = {
					text = "Yes, this time the day turned out differently for me. That day, while performing my daily routine, I suddenly heard the sound of many trumpets in the distance. I happened to be on one of the higher {towers} at the time.",
				},
				[{ "towers", "tower", "wiezy" }] = {
					text = "When, worried about the sounds from outside, I approached the window, I saw a great barrage of spears and rocks hitting the very center of the tower from which I was looking out. In a moment, the entire floor began to collapse, and I started {falling} with it.",
				},
				[{ "falling", "spadac" }] = {
					text = "That's all I remember. Then I woke up here as a specter. I didn't know that the spirits whose bodies were once mistreated would be unable to move. I've been {waiting} here for a long time for someone to take me to the other side...",
				},
				[{ "waiting", "czekam" }] = {
					text = "But no one comes. Please, will you help me find peace and find someone who will send me to {heaven}?",
				},
				[{ "heaven", "nieba" }] = {
					text = "Thank you, finally someone who wanted to listen to me.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission01] = QuestState.AssassinsCreedSquurvaali.Mission01.FindFatherNatanek,
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				local princess = { name = "Ghasstly Princess", pos = { x = 5682, y = 1408, z = 7 } }

				local chairIn = MoveEvent()

				function chairIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission04)

					if storageVal >= QuestState.AssassinsCreedSquurvaali.Mission04.ReportToFatherNatanek then
						return false
					end
					local monster = Tile(princess.pos):getTopCreature()
					if monster then
						return false
					else
						Game.createNpc(princess.name, princess.pos)
					end
				end

				chairIn:aid(Storage.AssassinsCreedSquurvaali.GhostChair)
				chairIn:register()

				local chairOut = MoveEvent()

				function chairOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					local monster = Tile(princess.pos):getTopCreature()
					if monster and not Tile(fromPosition):getTopCreature() then
						monster:remove()
						Position(princess.pos):sendMagicEffect(CONST_ME_TELEPORT)
					end
				end

				chairOut:aid(Storage.AssassinsCreedSquurvaali.GhostChair)
				chairOut:register()
			end),
			QuestFactory.StartupItems({
				{ pos = { 5685, 1408, 7 }, id = 2355, aid = Storage.AssassinsCreedSquurvaali.GhostChair },
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission01.FindFatherNatanek,
			QuestFactory.Dialog("Father Natanek", {
				[{ "mission", "duch", "Ghasstly Princess", "ghasstly princess" }] = {
					text = "If what you're saying is true - and I have no reason to doubt the words of my faithful |PLAYERNAME| - go to {Oldrak}. He will surely know how to help you.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission01] = QuestState.AssassinsCreedSquurvaali.Mission01.FindOldrak,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission01.FindOldrak,
			QuestFactory.Dialog("Oldrak", {
				[{ "poleciec", "fly" }] = {
					text = "As a mere mortal, you will need a magical carpet for this. It must be a carpet that can float very high above the ground. Humans can produce only one carpet {capable} of such flights: the enchanted carpet of the green one.",
				},
				[{ "zdolny", "capable" }] = {
					text = "Ordinary carpets for 900 rubles can only lift a few meters above the ground. The green carpet, however, can lift itself much higher when it's on a special path. I am unable to create such a carpet, and unfortunately, I don't know if there's anyone in this world who can help you with that.",
				},
				[{ "mission" }] = {
					text = "I understand. You need to go to the Caribbean Island, and from there, from the highest mountain, {fly} straight west. If you don't lose your way, you'll reach Squurva'ali. There you should meet Aunor, he will definitely help you.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission01] = QuestState.AssassinsCreedSquurvaali.Mission01.ReportToGhasstlyPrincess,
					},
				},
			}),
			QuestFactory.Dialog("Father Natanek", {
				[{ "oldrak" }] = {
					text = "Oldrak has currently gone to the steppes. He is teaching the villagers there.",
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission01.ReportToGhasstlyPrincess,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ "mission", "carpet", "dywan" }] = {
					text = "Magic carpets? Who could have knowledge of something like magical carpets? Although... maybe some desert dwellers might know something about it. I don't know what to do myself, maybe the nomads can help you, although they are not experts in magic.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission01] = MISSION_FINISHED,
						[Storage.AssassinsCreedSquurvaali.Mission02] = QuestState.AssassinsCreedSquurvaali.Mission02.FindMareesha,
					},
					expReward = 20000,
				},
			})
	end)
	:Mission(Storage.AssassinsCreedSquurvaali.Mission02)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission02.FindMareesha,
			QuestFactory.Dialog("Mareesha", {
				[{ "mission" }] = {
					text = "Magic carpets? What nonsense. If you want, I can {sew} the green carpet you're talking about, but don't expect any magical abilities.",
				},
				[{ "tailor", "uszyc", "sew" }] = {
					text = "I will need the following: 5 spider silk, 1 red pillow, 1 {artist palette}.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = QuestState.AssassinsCreedSquurvaali.Mission02.FindArtistPalette,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission02.FindArtistPalette,
			QuestFactory.Dialog("Mareesha", {
				[{ "artist palette", "mission" }] = {
					text = "GM Tomek stole the last palette from me. Now he's in Knurow.",
				},
			}),
			QuestFactory.Dialog("Ryan", {
				[{ "mission" }] = {
					text = "I knew you were a thief, come out, Tomek! |PLAYERNAME|, I will need your help in the ritual to expel this thief. In return, I will help you recover the stolen item. And now, we begin: It's all your fault. The {Rat King} will decide your fate!",
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.spawnGmTomek,
						},
					},
				},
				[{ "Rat King", "Krol Szczurow", "King of Rats" }] = {
					text = "Rat King! Psst, now say: {away to the Ratlands}.",
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.spawnGmTomek,
						},
					},
				},
				[{ "away to the Ratlands", "won do szczurolandii" }] = {
					text = "TO THE RATS! SWIRL OF STENCH! It was all {his fault}.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = QuestState.AssassinsCreedSquurvaali.Mission02.CompleteExorcismOnTomek,
						[Storage.TheaterOfCheapThrills.Mission01] = QuestState.TheaterOfCheapThrills.Mission01.AskRomekForMission,
						[Storage.KingOfRatsHQ.Portals.Ryan] = MISSION_FINISHED,
						[Storage.KingOfRatsHQ.Mission01] = MISSION_FINISHED,
					},
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.despawnGmTomek,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission02.CompleteExorcismOnTomek,
			QuestFactory.Dialog("Mareesha", {
				[{ "artist palette", "mission" }] = {
					text = "GM Tomek stole the last palette from me. Now he's in Knurow.",
				},
			}),
			QuestFactory.Dialog("Ryan", {
				[{ "his fault", "jego wina", "mission" }] = {
					text = "And there he goes, sucked and swirled away. Here you go, the palette you were looking for.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = QuestState.AssassinsCreedSquurvaali.Mission02.ReturnPaletteToMareesha,
					},
					rewards = { QuestKeyItems.AssassinsCreedSquurvaali.MarishaArtistPalette },
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission02.ReturnPaletteToMareesha,
			QuestFactory.Dialog("Mareesha", {
				[{ "mission", "tailor", "uszyc", "sew" }] = {
					text = "Here is your carpet.",
					textNoRequiredItems = "Return when you have all the items.",
					requiredItems = {
						{ id = 2395, count = 1 },
						{ id = 5879, count = 5 },
						QuestKeyItems.AssassinsCreedSquurvaali.MarishaArtistPalette,
					},
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = MISSION_FINISHED,
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.ReportToGhasstlyPrincess,
					},
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.addCarpetMount,
						},
					},
				},
			})
	end)
	:Mission(Storage.AssassinsCreedSquurvaali.Mission03)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.ReportToGhasstlyPrincess,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ "mission", "misja" }] = {
					text = "It's wonderful that you managed to get so far. Please, here is my staff. Vislav Shivka manifested itself in my dreams yesterday. He told me to go to... I don't remember who. Maybe it's silly, but you have to ask him about enchanting the carpet.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.FindVislavShivka,
					},
					expReward = 150000,
					rewards = { ExerciseWeaponBox(30) },
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.FindVislavShivka,
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "mission", "dywan", "carpet", "misja", "zaczarowany dywan" }] = {
					text = "Flying rats? Carpets? I see you that you have imbibed a FoV potion. You can ask about those things in the vilage of the most generous {creatures}.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.FindLambor,
					},
				},
			})
	end)
	:Mission(Storage.AssassinsCreedSquurvaali.Mission03)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.FindLambor,
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "istoty", "creatures" }] = {
					text = "Im talking about the {djinn} of course. They will get you drunk, free of charge. And the best thing is you dont have to pay.",
				},
				[{ "djinnach", "djinn" }] = {
					text = "You will find them in Hurghada desert. Can't say i recall anything more because last time i was here they had to tow me back to my home, if you know what i mean..",
				},
			}),
			QuestFactory.Dialog("Lambor", {
				[{ "mission", "carpet", "dywan" }] = {
					text = "Yes, I can perform such a service. If you want me to help you, first you {help} me.",
				},
				[{ "pomozesz", "help", "ok", "okay", "sure" }] = {
					text = "Some time ago, I heard rumors about smuggling silicon wafers. High-ranked heroes and some god raiders were involved in the whole operation. Perhaps the best way to find the smuggling location and thus the warehouse for the goods is to penetrate their structure. To infiltrate their gang, you will have to live among them for weeks, months, years! When they trust you completely, you will be able to learn the storage location... Or you can hack their GPS, just like I did a moment ago. The interesting bit for me is in the underground, where heroes, god raiders, and their pets - bone beasts - have settled. If I believe the readings, it's the same cave where the black knight quest is, but I can't be a hundred percent sure.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.FindWafers,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.FindWafers,
			QuestFactory.Dialog("Lambor", {
				[{ "mission" }] = {
					text = "Some time ago, I heard rumors about smuggling silicon wafers. High-ranked heroes and some god raiders were involved in the whole operation. Perhaps the best way to find the smuggling location and thus the warehouse for the goods is to penetrate their structure. To infiltrate their gang, you will have to live among them for weeks, months, years! When they trust you completely, you will be able to learn the storage location... Or you can hack their GPS, just like I did a moment ago. The interesting bit for me is in the underground, where heroes, god raiders, and their pets - bone beasts - have settled. If I believe the readings, it's the same cave where the black knight quest is, but I can't be a hundred percent sure.",
				},
			}),
			QuestFactory.StartupItems({
				{
					pos = { 6051, 1503, 9 },
					id = 2484,
					actionid = Storage.AssassinsCreedSquurvaali.Rewards.CartSilicon,
					rewards = { QuestKeyItems.AssassinsCreedSquurvaali.SiliconWafersForLambor },
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.ReturnWafersToLambor,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.ReturnWafersToLambor,
			QuestFactory.Dialog("Lambor", {
				[{ "mission" }] = {
					text = "Thanks for your help. Now I will handle your request. I will need 5 dead weights to enchant your carpet. I will place them all on the carpet, which should result in overflow, and the carpet's weight should become negative. Return when you have 5 pieces of dead weight.",
					requiredItems = { QuestKeyItems.AssassinsCreedSquurvaali.SiliconWafersForLambor },
					textNoRequiredItems = "Did you lose a bag somewhere? Well...",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = QuestState.AssassinsCreedSquurvaali.Mission03.BringDeadweightsToLambor,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission03.BringDeadweightsToLambor,
			QuestFactory.Dialog("Lambor", {
				[{ "mission" }] = {
					text = "Please take this carpet. Remember that the flying function only works in specific places, namely on the peaks of the highest mountains. One of these peaks is surely in the Caribbean.",
					requiredItems = { { id = 20202, count = 5 } },
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = MISSION_FINISHED,
						[Storage.AssassinsCreedSquurvaali.Mission04] = QuestState.AssassinsCreedSquurvaali.Mission04.GoToHighestMountain,
					},
					expReward = 500000,
					textNoRequiredItems = "Return when you have exactly 5 dead weight.",
				},
			})
	end)
	:Mission(Storage.AssassinsCreedSquurvaali.Mission04)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission04.GoToHighestMountain,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ "mission" }] = {
					text = "You managed to get the carpet! Now try to go to the top of the mountain that the djinn mentioned. It's my only hope.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local function canEnterPath(player)
					if player:HasExactMissionState(missionState) then
						return true
					end

					if player:getOutfit().lookMount == 689 then
						return true
					end

					return false
				end

				local path = MoveEvent()
				function path.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return false
					end

					if canEnterPath(player) then
						return
					end

					player:teleportTo(fromPosition)
					player:getPosition():sendMagicEffect(CONST_ME_STUN)
					player:say(player:Localizer(Storage.AssassinsCreedSquurvaali.Localizer):Get("A magical force brought you back to the solid ground."), TALKTYPE_MONSTER_SAY)
					return false
				end
				path:aid(Storage.AssassinsCreedSquurvaali.HeavenPath)
				path:register()

				local lastTile = MoveEvent()
				function lastTile.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return false
					end
					-- ToDo: fix position after new map is added
					player:teleportTo(Position(5745, 801, 4), true)
					return true
				end
				lastTile:aid(Storage.AssassinsCreedSquurvaali.HeavenLastTile)
				lastTile:register()
			end),
			QuestFactory.Dialog("Aunor", {
				[{ "mission" }] = {
					text = "As for an ordinary person, it's a great effort and sacrifice for someone you didn't even know. Know that your deeds have been noticed. From now on, we will patrol the land much more closely to find lost souls. Please, take this magical flare. Use the flare at the entrance to the Ghasstly Princess' cave. We will take care of delivering it to us. Meanwhile, unfortunately, I will have to close the heavenly road for you. When your time comes, it will be reopened. I will be {seeing}, adventurer.",
				},
				[{ "seeing", "zegnaj" }] = {
					text = "",
					rewards = { QuestKeyItems.AssassinsCreedSquurvaali.AunorFlare },
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.aunorTeleportOut,
						},
					},
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission04] = QuestState.AssassinsCreedSquurvaali.Mission04.FireFlare,
					},
				},
			}),
			QuestFactory.StartupItems({
				{ pos = { 7223, 1532, 4 }, id = 470, aid = Storage.AssassinsCreedSquurvaali.HeavenPath },
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission04.FireFlare,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ "mission" }] = {
					text = "You should fire the flare outside, not inside, silly.",
				},
			}),
			QuestFactory.StartupItems({
				{ pos = { 5688, 1413, 7 }, id = 15047, aid = Storage.AssassinsCreedSquurvaali.KeyItems.Flare },
			}),
			QuestFactory.Script(function(missionState)
				local updateStorages = {
					[Storage.AssassinsCreedSquurvaali.Mission04] = MISSION_FINISHED,
				}

				local flare = Action()
				function flare.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return
					end

					if item:getId() ~= QuestKeyItems.AssassinsCreedSquurvaali.AunorFlare.id then
						return false
					end

					local groundAid = Tile(player:getPosition()):getGround():getActionId()
					local itemAid = item:getActionId()
					if groundAid ~= itemAid then
						player:say(player:Localizer(Storage.AssassinsCreedSquurvaali.Localizer):Get("You have to be standing just outside the Ghasstly Princess's cave in order to use this flare."), TALKTYPE_MONSTER_SAY)
						return false
					end

					player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
					player:NextState(updateStorages)
					item:remove()
					return true
				end

				flare:aid(Storage.AssassinsCreedSquurvaali.KeyItems.Flare)
				flare:register()
			end)
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission04.ReportToGhasstlyPrincess,
			QuestFactory.Dialog("Ghasstly Princess", {
				[{ GREET }] = {
					text = "Finally, I can end this charade. You, sucker. I'm not a princess, I'm THE undead king your mother warned you about. An angel will arrive shortly, whom I can easily defeat and drain of all his power. You can't do {anything} about it.",
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.transformNpcToCryptKingLook,
						},
					},
				},
				[{ "anything", "nic" }] = {
					text = "",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission04] = QuestState.AssassinsCreedSquurvaali.Mission04.ReportToFatherNatanek,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.teleportToTemple,
						},
					},
					expReward = 500000,
				},
			})
	end)
	:State(function()
		return QuestState.AssassinsCreedSquurvaali.Mission04.ReportToFatherNatanek,
			QuestFactory.Dialog("Father Natanek", {
				[{ "krol krypty", "crypt king", "king of the crypt", "king", "krol" }] = {
					text = "I will be the harbinger of bad news. The Crypt King has managed to regain a portion of power by consuming the essence of a defeated angel. The Crypt King may attempt to regain strength in the Down's Labyrinth. To prevent this, you will need the assistance of Gandalf.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission04] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Register()

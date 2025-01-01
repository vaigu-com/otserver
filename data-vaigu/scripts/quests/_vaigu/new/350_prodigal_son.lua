local quest = Quest(LOCALIZERS.ProdigalSon)

local frediEscort = {
	timeLimitSeconds = 600,
	startAfterSeconds = 2,
	escorteeName = "Fredi Kamionka Escort",
}

quest
	:Storage(function()
		Storage.ProdigalSon = {
			Localizer = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			MetroAccess = NextStorage(),
			MainGateAccess = NextStorage(),
			NorthMinesAccess = NextStorage(),
			TileBeforeChesterCompartment = NextStorage(),
			HammerMaking = { Lever = NextStorage(), Paint = NextStorage() },
			CalculatorMaking = {
				Lever = NextStorage(),
				MetalPile = NextStorage(),
				WoodPile = NextStorage(),
			},
			PliersMaking = { Lever = NextStorage(), MetalPile = NextStorage() },
			AreczekCorpse = NextStorage(),
			AreczekLeaderBed = NextStorage(),
			EristicsBooks = {
				One = NextStorage(),
				Two = NextStorage(),
				Three = NextStorage(),
			},
			EristicsItems = {
				LovePotion = NextStorage(),
				Herbs = NextStorage(),
				SlimmingPot = NextStorage(),
				LoanDocument = NextStorage(),
			},
			SewersLever = NextStorage(),
			DiamondNecklace = NextStorage(),
			LavaSiloMachine = NextStorage(),
			FrediBeer = NextStorage(),
			Blackboard = NextStorage(),
			BlackBoardLever1 = NextStorage(),
			BlackBoardLever2 = NextStorage(),
			PolAccess = NextStorage(),
			Payslip = NextStorage(),
			Train = {
				SelectDestination = NextStorage(),
				FakeMoveTeleport11 = NextStorage(),
				FakeMoveTeleport12 = NextStorage(),
				FakeMoveTeleport13 = NextStorage(),
			},
			TrainDestinations = {
				ToHurghada = NextStorage(),
				ToJanuszex = NextStorage(),
				ToBydgoshch = NextStorage(),
			},
			Rewards = { ToiletSoap = NextStorage() },
			PortalAfterPol = NextStorage(),
		}
		QuestState.ProdigalSon = {
			Mission01 = {
				ChesterSpeakingAboutJanuszex = 1,
				YouAreLookingForJanuszex = 2,
			},
			Mission02 = {
				FindForeman = 1,
				PaintHammers = 2,
				MakingCalculators = 3,
				MakingPliers = 4,
			},
			Mission03 = {
				TalkToHearAboutDuties = 1,
				KillAreczekForSoap = 2,
				AskForNewMission = 3,
				KillAreczekLeader = 4,
				ReportKillngAreczekLeader = 5,
			},
			Mission04 = {
				AskForMission = 1,
				FindingEristicsBooks = 2,
				DupingConferencePeople = 3,
			},
			Mission05 = {
				AskForNewMission = 1,
				FindingDwarfNecklace = 2,
				FoundNecklace_AskForNewMission = 3,
				CheckingOnSilo = 4,
				CheckedOnSilo = 5,
				EscortingFredi = 6,
				AwaitHenryFinishedTalking = 7,
			},
			Mission06 = {
				FindPasswordAndKillImperator = 1,
				KilledImperator = 2,
				ReportToChester = 3,
			},
		}
	end)
	:Constant(function()
		SpawnLocks.ProdigalSon = {
			ArechekLock = SpawnLock(),
		}
		SYN_MARNOTRAWNY_SPECIAL_ACTIONS = {
			setPersonalBlackboardPassword = function(context)
				local player = context.player
				player:setStorageValue(Storage.ProdigalSon.Blackboard, math.random(10 ^ 6, 10 ^ 7 - 1))
			end,
		}

		QuestKeyItems.ProdigalSon = {
			Payslip = {
				id = 2818,
				aid = Storage.ProdigalSon.Payslip,
				desc = "A payslip.",
			},
			BookOne = {
				id = 2816,
				aid = Storage.ProdigalSon.EristicsBooks.One,
				desc = "Eristics for dummies\nPart 3",
			},
			BookTwo = {
				id = 2821,
				aid = Storage.ProdigalSon.EristicsBooks.Two,
				desc = "Eristics for dummies\nPart 5",
			},
			BookThree = {
				id = 2828,
				aid = Storage.ProdigalSon.EristicsBooks.Three,
				desc = "Eristics for dummies\nPart 8",
			},
			SlimmingPot = {
				id = 3465,
				desc = "Every dish cooked in this pot can only make you more slim and fit.",
				aid = Storage.ProdigalSon.EristicsItems.SlimmingPot,
			},
			LovePotion = {
				id = 9173,
				desc = "This smart potion will make you a lovely person.",
				aid = Storage.ProdigalSon.EristicsItems.LovePotion,
			},
			Herbs = {
				id = 12671,
				desc = "Assortment of herbs. They cure cancer within 24 hours.",
				aid = Storage.ProdigalSon.EristicsItems.Herbs,
			},
			LoanDocument = {
				id = 2815,
				desc = "Loan agreement",
				aid = Storage.ProdigalSon.EristicsItems.LoanDocument,
			},
			DiamondNecklace = {
				id = 35607,
				aid = Storage.ProdigalSon.DiamondNecklace,
			},
			FrediBeer = {
				id = 6106,
			},
		}

		local accessobotTopLeft = JANUSZEX_ANCHOR:Moved(57, 13, 1)
		local accessobotDownRight = JANUSZEX_ANCHOR:Moved(60, 16, 1)
		local function accessObotExplosion()
			for i = 250, 5000, 250 do
				addEvent(function()
					IterateBetweenPositions(accessobotTopLeft, accessobotDownRight, function(context)
						local pos = context.pos
						pos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
						local creature = Tile(pos):getTopCreature()
						if creature then
							doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -300, -300, CONST_ME_FIREAREA)
						end
					end)
				end, i)
			end
		end

		SYN_MARNOTRAWNY_SPECIAL_CONDITIONS = {
			frediIsNearby = function(context)
				local npcPos = context.npc:getPosition()
				local topLeft = npcPos:Moved(-7, -7, 0)
				local downRight = npcPos:Moved(7, 7, 0)
				local result = IterateBetweenPositions(topLeft, downRight, function(args2)
					local pos = args2.pos
					local tile = Tile(pos)
					if not tile then
						return false
					end
					local oldCreature = tile:getTopCreature()
					if not oldCreature then
						return false
					end
					if oldCreature:getName():lower() == "fredi kamionka" then
						return true
					end
					return false
				end, { stopCondition = STOP_CONDITIONS.isTrue })
				return result
			end,
			saidCorrectPassword = function(context)
				local player = context.player
				local correctPassword = tostring(player:getStorageValue(Storage.ProdigalSon.Blackboard))
				local saidPassword = context.msg
				if MsgContains(saidPassword, correctPassword) then
					return true
				end

				local npc = context.npc
				if npc:getOutfit().lookHead ~= 83 then
					return
				end
				npc:setOutfit({
					lookType = 875,
					lookHead = 94,
					lookBody = 38,
					lookLegs = 114,
					lookFeet = 114,
					lookAddons = 2,
				})
				addEvent(function()
					npc:setOutfit({
						lookType = 875,
						lookHead = 83,
						lookBody = 38,
						lookLegs = 114,
						lookFeet = 114,
						lookAddons = 2,
					})
				end, 7000)

				addEvent(function()
					accessObotExplosion()
				end, 2000)
			end,
		}
		SYN_MARNOTRAWNY_SPECIAL_ACTIONS = {
			setPersonalBlackboardPassword = function(context)
				local player = context.player
				player:setStorageValue(Storage.ProdigalSon.Blackboard, math.random(10 ^ 6, 10 ^ 7 - 1))
			end,
		}

		PRODIGAL_SON_NORMAL_ITEMS = {
			--hammer
			rawHammer = 3459,
			paint = 7253,
			doneHammer = 3460,
			lever2 = 8911,
			--calculator
			stoneTable = 2346,
			stonePile = 7914,
			woodPile = 7919,
			woodTrash = 3135,
			stoneTrash = 3142,
			westMachine = 842,
			doneCalculator = 8156,
			--plier
			metalPile = 21149,
			metalPiece = 27270,
			southMachine = 845,
			donePliers = 22680,
			toiletSoap = 35595,
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Prodigal Son",
			missions = {
				[Storage.ProdigalSon.Mission01] = {
					name = "01. Work is da poop!",
					states = {
						[QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex] = "Ask Chester for a new mission.",
						[QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex] = "Find the metro leading to workplace designated by Chester.",
						[MISSION_FINISHED] = "You found the metro Chester was talking about. Try to find the work supervisor when you arrive at the next station.",
					},
				},
				[Storage.ProdigalSon.Mission02] = {
					name = "02. Artisan Baker",
					states = {
						[QuestState.ProdigalSon.Mission02.FindForeman] = "Find the work supervisor.",
						[QuestState.ProdigalSon.Mission02.PaintHammers] = "Henry commanded you to start your new job: painting wooden hammers. He asked for 5 pieces.",
						[QuestState.ProdigalSon.Mission02.MakingCalculators] = "Henry gave you a new job: make 5 calculators.",
						[QuestState.ProdigalSon.Mission02.MakingPliers] = "Henry ordered 5 new pliers.",
						[MISSION_FINISHED] = "You completed all of Henry's orders.",
					},
				},
				[Storage.ProdigalSon.Mission03] = {
					name = "03. Cheetos Prank Acedemy",
					states = {
						[QuestState.ProdigalSon.Mission03.TalkToHearAboutDuties] = "Henry promoted you to an assistant position. Ask for your new duties.",
						[QuestState.ProdigalSon.Mission03.KillAreczekForSoap] = "Henry asked you to investigate the ever-shrinking number of towels and soaps in toilets.",
						[QuestState.ProdigalSon.Mission03.AskForNewMission] = "You handed the missing soaps to Henry. Ask him for a new mission.",
						[QuestState.ProdigalSon.Mission03.KillAreczekLeader] = "Areczeks are trying to unionize. Defeat their leader and the union may dissolve.",
						[QuestState.ProdigalSon.Mission03.ReportKillngAreczekLeader] = "Arechek union leader promised to dissolve their union. Report back to Henry.",
						[MISSION_FINISHED] = "Henry is content that you busted the union.",
					},
				},
				[Storage.ProdigalSon.Mission04] = {
					name = "04. Serious business",
					states = {
						[QuestState.ProdigalSon.Mission04.AskForMission] = "Ask Henry for your next mission.",
						[QuestState.ProdigalSon.Mission04.FindingEristicsBooks] = "Find the three books on eristics. Henry lost them allover the place.",
						[QuestState.ProdigalSon.Mission04.DupingConferencePeople] = "Henry granted you the mighty powers of eristics. Try to persuade the customers in conference hall to buy company products.",
						[MISSION_FINISHED] = "Henry thanked you for doing your job.",
					},
				},
				[Storage.ProdigalSon.Mission05] = {
					name = "05. SUPREME",
					states = {
						[QuestState.ProdigalSon.Mission05.AskForNewMission] = "Ask Henry for new mission.",
						[QuestState.ProdigalSon.Mission05.FindingDwarfNecklace] = "Henry asked you to find a gray-haired dwarf corpse.",
						[QuestState.ProdigalSon.Mission05.FoundNecklace_AskForNewMission] = "You gave Henry his lost necklace. Ask him for new mission.",
						[QuestState.ProdigalSon.Mission05.CheckingOnSilo] = "Check the silo state in the lava mines.",
						[QuestState.ProdigalSon.Mission05.CheckedOnSilo] = "You used special machine to check state of the silo content. Report back to Henry.",
						[QuestState.ProdigalSon.Mission05.EscortingFredi] = "Henry told you about a friend stuck on north-eastern mines. Escort him back to Henry.",
						[QuestState.ProdigalSon.Mission05.AwaitHenryFinishedTalking] = "Henry asked you to give him a moment to discuss something with his friend Fredi.",
						[MISSION_FINISHED] = "Henry thanked you for doing your job.",
					},
				},
				[Storage.ProdigalSon.Mission06] = {
					name = "06. Coup d'Passat",
					states = {
						[QuestState.ProdigalSon.Mission06.FindPasswordAndKillImperator] = "Henry told you to find the password to the royal room.",
						[QuestState.ProdigalSon.Mission06.KilledImperator] = "You defeated Pol, the boss-imperator of Januszex. Report to Henry.",
						[QuestState.ProdigalSon.Mission06.ReportToChester] = "Henry finally gave you the payslip you needed. Go back to Chester.",
						[MISSION_FINISHED] = "Im a dog, and you are a flower.\nIf i lift my leg i might give you a shower.",
					},
				},
			},
		}
	end)
	:MonsterEvent(function()
		local areczek = CreatureEvent("HitArechek")
		function areczek.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
			if not creature:isMonster() then
				return primaryDamage, primaryType, secondaryDamage, secondaryType
			end

			if not (creature:getName():lower() == "areczek") then
				return
			end

			if primaryType == COMBAT_HEALING or secondaryType == COMBAT_HEALING then
				return primaryDamage, primaryType, secondaryDamage, secondaryType
			end

			if attacker then
				if primaryDamage > 0 or secondaryDamage > 0 then
					local pos = creature:getPosition()
					creature:remove()
					Game.createMonster("Arechek", pos)
				end
			end
			return primaryDamage, primaryType, secondaryDamage, secondaryType
		end

		areczek:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Arechek calm")
		local monster = {}

		monster.name = "Arechek"
		monster.description = "an Arechek"
		monster.experience = 12000
		monster.outfit = {
			lookType = 1042,
			lookHead = 0,
			lookBody = 97,
			lookLegs = 37,
			lookFeet = 115,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 9000
		monster.maxHealth = 9000
		monster.corpse = 4240
		monster.speed = 250

		monster.faction = FACTION_PLAYER

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 6,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"HitArechek",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 0,
		}

		monster.attacks = {
			{
				name = "combat",
				interval = 2000,
				chance = 100,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = 0,
				maxDamage = -400,
				range = 7,
				shootEffect = CONST_ANI_BURSTARROW,
				target = true,
			},
			{
				name = "combat",
				interval = 6000,
				chance = 22,
				type = COMBAT_HOLYDAMAGE,
				minDamage = -200,
				maxDamage = -900,
				range = 7,
				radius = 4,
				effect = CONST_ME_HOLYAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 4000,
				chance = 12,
				type = COMBAT_HOLYDAMAGE,
				minDamage = -400,
				maxDamage = -900,
				range = 7,
				effect = CONST_ME_HOLYDAMAGE,
				target = true,
			},
			{
				name = "combat",
				interval = 4000,
				chance = 17,
				type = COMBAT_ICEDAMAGE,
				minDamage = -400,
				maxDamage = -900,
				radius = 4,
				effect = CONST_ME_ICEAREA,
				target = false,
			},
		}

		monster.defenses = {
			defense = 86,
			armor = 86,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Pol")
		local monster = {}

		monster.description = "the Pol"
		monster.experience = 150000
		monster.outfit = {
			lookType = 1444,
			lookHead = 0,
			lookBody = 91,
			lookLegs = 0,
			lookFeet = 0,
		}

		monster.health = 30000
		monster.maxHealth = 30000
		monster.race = "blood"
		monster.corpse = 4240
		monster.speed = 250

		monster.changeTarget = {
			interval = 4000,
			chance = 0,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 3,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
			pet = false,
		}

		monster.events = {
			"PolDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 50 },
			{ name = "pol plus beam", interval = 7000, chance = 100, target = false, range = 7 },
			{ name = "pol white black switch", interval = 5000, chance = 100, target = false, range = 7 },
		}

		monster.defenses = {
			defense = 4,
			armor = 1,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType.onAppear = function(monster, creature)
			CreatureStateRegistry:register(monster) --39f change to encounter
			local state = CreatureStateRegistry:getState(monster)
			state.currentColor = 0
			state.penaltyDamage = 0
		end

		mType.onDisappear = function(monster, creature)
			if monster == creature then
				CreatureStateRegistry:unregister(monster)
			end
		end
		mType:register(monster)
	end)
	:Script(function(missionState)
		local nextState = {
			[Storage.ProdigalSon.Mission01] = QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex,
		}

		local requiredChesterState = QuestState.ChesterTheDwarf.Mission04.Finished

		local mainGateTile = MoveEvent()
		function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
			local chesterState = player:getStorageValue(Storage.ChesterTheDwarf.Mission04)
			if chesterState < requiredChesterState then
				return
			end

			local questState = player:getStorageValue(Storage.ProdigalSon.Mission01)
			if questState > MISSION_NOT_STARTED then
				return
			end

			player:NextState(nextState)
		end
		mainGateTile:aid(Storage.ProdigalSon.TileBeforeChesterCompartment)
		mainGateTile:register()
	end)
	:Script(function(missionState)
		local errorMessage = "You don't have permission to go there. Talk to Overseer Henry of Januszex to be granted an entry."
		local function tryEnterAccessTile(actionid, player, fromPosition)
			if not player:isPlayer() then
				return
			end

			if player:getStorageValue(actionid) ~= ACCESS_GRANTED then
				local transaltedMessage = player:Localizer(Storage.ProdigalSon.Localizer):Get(errorMessage)
				player:sendTextMessage(MESSAGE_INFO_DESCR, transaltedMessage)
				player:teleportTo(fromPosition, true)
			end

			return true
		end

		local mainGateTile = MoveEvent()
		function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
			tryEnterAccessTile(Storage.ProdigalSon.MainGateAccess, player, fromPosition)
		end
		mainGateTile:aid(Storage.ProdigalSon.MainGateAccess)
		mainGateTile:register()

		local northMinesTile = MoveEvent()
		function northMinesTile.onStepIn(player, item, toPosition, fromPosition)
			tryEnterAccessTile(Storage.ProdigalSon.NorthMinesAccess, player, fromPosition)
		end
		northMinesTile:aid(Storage.ProdigalSon.NorthMinesAccess)
		northMinesTile:register()
	end)
	--ToDo: add as encounter
	:Script(function(missionState)
		local polEncounterConfig = {
			actionid = Storage.ProdigalSon.PolAccess,
			bossName = "Pol",
			timerStorage = Storage.ProdigalSon.PolAccess,
			cooldown = "weekly",

			leverPosition = JANUSZEX_ANCHOR:Moved(54, 9, -1),
			entranceGrid = {
				topLeft = JANUSZEX_ANCHOR:Moved(54, 10, -1),
				downRight = JANUSZEX_ANCHOR:Moved(54, 13, -1),
			},

			bossPos = Position(7742, 1010, 9),
			enterPos = Position(7742, 1016, 9),
			durationMinutes = 10,
			exitTeleportDestination = JANUSZEX_ANCHOR:Moved(45, 9, 1),
			exitTeleportPosition = JANUSZEX_ANCHOR:Moved(51, -5, -1),
			exitTeleportActionid = Storage.ProdigalSon.PortalAfterPol,
			corner1 = JANUSZEX_ANCHOR:Moved(51, -15, -1),
			corner2 = JANUSZEX_ANCHOR:Moved(59, -4, -1),

			scalingConfig = { hpPerPlayer = 1 },

			requiredStorages = { [Storage.ProdigalSon.PolAccess] = { min = ACCESS_GRANTED } },
		}
		RegisterEncounter(polEncounterConfig)

		local lever = Action()
		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if UseEncounterLever(player, item, polEncounterConfig) then
			end
		end
		lever:aid(Storage.ProdigalSon.PolAccess)
		lever:register()
	end)
	:Mission(Storage.ProdigalSon.Mission01)
	:State(function()
		return QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex,
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ "mission" }] = {
					text = "I now have my eye on a certain Januszex TM. They have their headquarters far to the east. I would start working on my CV, but first, i need to learn more about the working conditions there. I would like to ask you to go there by {train}. They have a special metro line that stops at their company. When you are there, search for building with 'C' marking outside.",
					nextState = {
						[Storage.ProdigalSon.Mission01] = QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex,
						[Storage.ProdigalSon.MetroAccess] = ACCESS_GRANTED,
						[Storage.ProdigalSon.TrainDestinations.ToJanuszex] = ACCESS_GRANTED,
						[Storage.ProdigalSon.TrainDestinations.ToHurghada] = ACCESS_GRANTED,
					},
					specialActionsOnSuccess = {
						{
							action = SYN_MARNOTRAWNY_SPECIAL_ACTIONS.setPersonalBlackboardPassword,
						},
					},
				},
			}),
			QuestFactory.StartupItems({
				{ position = Position(7555, 960, 13), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination }, --Januszex
				{ position = Position(6465, 1123, 14), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination }, --Hurghada
				{ position = Position(7881, 1432, 9), id = 2598, aid = Storage.ProdigalSon.Train.SelectDestination }, --Bydgoshch

				{ position = Position(7637, 1126, 7), id = 436, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7638, 1126, 7), id = 436, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7620, 1067, 12), id = 7756, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7654, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7655, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7656, 1073, 12), id = 429, aid = Storage.ProdigalSon.MainGateAccess },
				{ position = Position(7618, 950, 12), id = 352, aid = Storage.ProdigalSon.NorthMinesAccess },
				{ position = Position(7619, 950, 12), id = 429, aid = Storage.ProdigalSon.NorthMinesAccess },
				{ position = Position(7620, 950, 12), id = 429, aid = Storage.ProdigalSon.NorthMinesAccess },
				{ position = Position(7621, 950, 12), id = 352, aid = Storage.ProdigalSon.NorthMinesAccess },
				{ position = Position(6440, 1125, 14), id = 20712, aid = Storage.ProdigalSon.TileBeforeChesterCompartment },
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex,
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ "train", "pociagiem" }] = {
					text = "Just use the blackboard here to see the schedules of the train.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local travelTimeSeconds = 20
				local aidToDest = {
					[Storage.ProdigalSon.TrainDestinations.ToHurghada] = Position(6461, 1125, 14),
					[Storage.ProdigalSon.TrainDestinations.ToJanuszex] = Position(7550, 962, 13),
					[Storage.ProdigalSon.TrainDestinations.ToBydgoshch] = Position(7877, 1434, 9),
				}
				local aidToName = {
					[Storage.ProdigalSon.TrainDestinations.ToHurghada] = "Hurghada",
					[Storage.ProdigalSon.TrainDestinations.ToJanuszex] = "Januszex",
					[Storage.ProdigalSon.TrainDestinations.ToBydgoshch] = "Bydgoshch",
				}

				local confirmChoice = function(player, button, choice)
					if not choice then
						return true
					end
					if player:getPosition():EuclideanDistance(aidToDest[choice.aid]) < 100 then
						return true
					end

					player:teleportTo(JANUSZEX_MOVING_TRAIN_ANCHOR)
					player:say(player:Localizer(Storage.ProdigalSon.Localizer):Get("TrainMovingTo") .. choice.text, TALKTYPE_MONSTER_SAY)
					addEvent(function()
						if player then
							player:teleportTo(aidToDest[choice.aid])
						end
					end, travelTimeSeconds * 1000)
				end

				local function hasUnlockedDestination(player, aid)
					return player:getStorageValue(aid) == ACCESS_GRANTED
				end

				local nextState = {
					[Storage.ProdigalSon.Mission01] = MISSION_FINISHED,
					[Storage.ProdigalSon.Mission02] = QuestState.ProdigalSon.Mission02.FindForeman,
				}

				local trainTravel = Action()
				function trainTravel.onUse(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return false
					end

					if player:getStorageValue(Storage.ProdigalSon.MetroAccess) ~= ACCESS_GRANTED then
						return true
					end

					if player:HasExactMissionState(missionState) then
						player:NextState(nextState)
					end

					player:ClearConditions()

					local title = player:Localizer(Storage.ProdigalSon.Localizer):Get("ShipTitle")
					local message = player:Localizer(Storage.ProdigalSon.Localizer):Get("ShipMessage")
					local window = ModalWindow({ title = title, message = message })

					for aid in pairs(aidToDest) do
						if hasUnlockedDestination(player, aid) then
							local text = aidToName[aid]
							--local transaltedText = TryGetTranslatedString(player, Storage.PerIustitiaAdAstra.Questline, aidToName[aid])
							local choice = window:addChoice(text)
							choice.aid = aid
						end
					end

					window:addButton(player:Localizer(Storage.ProdigalSon.Localizer):Get("ShipOk"), confirmChoice)
					window:sendToPlayer(player)
					return true
				end

				trainTravel:aid(Storage.ProdigalSon.Train.SelectDestination)
				trainTravel:register()
			end)
	end)
	:Mission(Storage.ProdigalSon.Mission02)
	:State(function()
		return QuestState.ProdigalSon.Mission02.FindForeman, QuestFactory.Dialog("Henry the Foreman", {
			[{ "mission" }] = {
				text = "Are you new here? This will be your first job: paint the topex hammers. Head to the 'A' building first.",
				nextState = {
					[Storage.ProdigalSon.Mission02] = QuestState.ProdigalSon.Mission02.PaintHammers,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission02.PaintHammers,
			QuestFactory.StartupItems({
				{
					pos = { -90, -68, 2 },
					id = PRODIGAL_SON_NORMAL_ITEMS.lever2,
					aid = Storage.ProdigalSon.HammerMaking.Lever,
				},
				{
					pos = { -90, -69, 2 },
					id = PRODIGAL_SON_NORMAL_ITEMS.stoneTable,
					uid = 1000,
					aid = 0,
				},
				{
					pos = { -90, -70, 2 },
					id = PRODIGAL_SON_NORMAL_ITEMS.paint,
					aid = Storage.ProdigalSon.HammerMaking.Paint,
				},
			}, JANUSZEX_ANCHOR),
			QuestFactory.Script(function(missionState)
				local lever = Action()
				function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local sawPos = JANUSZEX_ANCHOR:Moved(-90, -69, 2)
					if Tile(sawPos):getItemById(PRODIGAL_SON_NORMAL_ITEMS.rawHammer) or Tile(sawPos):getItemById(PRODIGAL_SON_NORMAL_ITEMS.doneHammer) then
						return
					end
					local saw = Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.rawHammer, 1, sawPos)
					saw:setActionId(Storage.ProdigalSon.HammerMaking.Lever)
					saw:setUniqueId(1000)

					return true
				end
				lever:aid(Storage.ProdigalSon.HammerMaking.Lever)
				lever:register()

				local paint = Action()
				function paint.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					if target:getId() == PRODIGAL_SON_NORMAL_ITEMS.rawHammer then
						target:remove()
						Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.doneHammer, 1, toPosition)
						toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
					end
					return true
				end
				paint:aid(Storage.ProdigalSon.HammerMaking.Paint)
				paint:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Get to making calculators, you slacker! Go to the 'P' building now.",
					nextState = {
						[Storage.ProdigalSon.Mission02] = QuestState.ProdigalSon.Mission02.MakingCalculators,
					},
					requiredItems = {
						{ id = PRODIGAL_SON_NORMAL_ITEMS.doneHammer, count = 5 },
					},
					textNoRequiredItems = "Bring me five hammers painted metallic.",
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission02.MakingCalculators,
			QuestFactory.StartupItems({
				{
					pos = { -77, 3, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.stonePile,
					aid = Storage.ProdigalSon.CalculatorMaking.MetalPile,
				},
				{
					pos = { -75, 3, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.stonePile,
					aid = Storage.ProdigalSon.CalculatorMaking.MetalPile,
				},
				{
					pos = { -77, 5, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.woodPile,
					aid = Storage.ProdigalSon.CalculatorMaking.WoodPile,
				},
				{
					pos = { -76, 5, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.woodPile,
					aid = Storage.ProdigalSon.CalculatorMaking.WoodPile,
				},
				{
					pos = { -75, 5, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.woodPile,
					aid = Storage.ProdigalSon.CalculatorMaking.WoodPile,
				},
				{
					pos = { -74, 5, -1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.woodPile,
					aid = Storage.ProdigalSon.CalculatorMaking.WoodPile,
				},
				{
					pos = { -75, 4, 1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.westMachine,
					aid = Storage.ProdigalSon.CalculatorMaking.Lever,
				},
			}, JANUSZEX_ANCHOR),
			QuestFactory.Script(function(missionState)
				local metalPile = Action()
				function metalPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.stoneTrash, 1, player:getPosition())
					return true
				end
				metalPile:aid(Storage.ProdigalSon.CalculatorMaking.MetalPile)
				metalPile:register()

				local woodPile = Action()
				function woodPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.woodTrash, 1, player:getPosition())
					return true
				end
				woodPile:aid(Storage.ProdigalSon.CalculatorMaking.WoodPile)
				woodPile:register()

				local lever = Action()
				function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local materialsPos = fromPosition:Moved(-1, -1, 0)
					local materialTile = Tile(materialsPos)
					local wood = materialTile:getItemById(PRODIGAL_SON_NORMAL_ITEMS.woodTrash)
					local metal = materialTile:getItemById(PRODIGAL_SON_NORMAL_ITEMS.stoneTrash)

					if wood and metal then
						wood:remove(1)
						metal:remove(1)
						Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.doneCalculator, 1, materialsPos)
						materialsPos:sendMagicEffect(CONST_ME_LOSEENERGY)
					end
					return true
				end
				lever:aid(Storage.ProdigalSon.CalculatorMaking.Lever)
				lever:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Non-standard work footwear! For that you will go to the 'S' building and take care of plier work order.",
					nextState = {
						[Storage.ProdigalSon.Mission02] = QuestState.ProdigalSon.Mission02.MakingPliers,
					},
					requiredItems = {
						{
							id = PRODIGAL_SON_NORMAL_ITEMS.doneCalculator,
							count = 5,
						},
					},
					textNoRequiredItems = "Should be five calculators! Im still waiting.",
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission02.MakingPliers,
			QuestFactory.StartupItems({
				{
					pos = { -98, -36, 1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.stonePile,
					aid = Storage.ProdigalSon.PliersMaking.MetalPile,
				},
				{
					pos = { -97, -36, 1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.stonePile,
					aid = Storage.ProdigalSon.PliersMaking.MetalPile,
				},
				{
					pos = { -99, -42, 1 },
					id = PRODIGAL_SON_NORMAL_ITEMS.southMachine,
					aid = Storage.ProdigalSon.PliersMaking.Lever,
				},
			}, JANUSZEX_ANCHOR),
			QuestFactory.Script(function(missionState)
				local metalPile = Action()
				function metalPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local metalPiece = Tile(fromPosition):getItemById(PRODIGAL_SON_NORMAL_ITEMS.metalPiece)
					if metalPiece then
						return
					end
					Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.metalPiece, 1, fromPosition)

					return true
				end
				metalPile:aid(Storage.ProdigalSon.PliersMaking.MetalPile)
				metalPile:register()

				local lever = Action()
				function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local metalPiecePos = fromPosition:Moved(-3, 3, 0)
					local metalPiece = Tile(metalPiecePos):getItemById(PRODIGAL_SON_NORMAL_ITEMS.metalPiece)
					if metalPiece then
						metalPiece:remove(1)
						Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.donePliers, 1, player:getPosition())
						fromPosition:sendMagicEffect(CONST_ME_POFF)
					end
					return true
				end
				lever:aid(Storage.ProdigalSon.PliersMaking.Lever)
				lever:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Good job. You just earned your way into the assistant position. You are now granted a permission to use main entrance and exit to the surface.",
					nextState = {
						[Storage.ProdigalSon.Mission02] = MISSION_FINISHED,
						[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.TalkToHearAboutDuties,
						[Storage.ProdigalSon.MainGateAccess] = ACCESS_GRANTED,
					},
					requiredItems = {
						{ id = PRODIGAL_SON_NORMAL_ITEMS.donePliers, count = 5 },
					},
					textNoRequiredItems = "Im still waiting for those pliers.",
				},
			})
	end)
	:Mission(Storage.ProdigalSon.Mission03)
	:State(function()
		return QuestState.ProdigalSon.Mission03.TalkToHearAboutDuties,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ GREET }] = {
					text = "Are you ready to hear about your new {duties}?",
				},
				[{ "duties", "obowiazki", "yes", "tak" }] = {
					text = "I have a hunch that the quantity of our soaps and towels is shrinking at above-average rate. Find out more about this, and remember: not every Arechek is a thief, but every thief is Arechek. Bring me about four of each towel and soap.",
					nextState = {
						[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.KillAreczekForSoap,
					},
				},
			})
	end)
	:MonsterEvent(function(missionState)
		local areczekEnraged = CreatureEvent("AreczekEnragedDeath")
		function areczekEnraged.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			local corpse = Game.createItem(4240, 1, creature:getPosition())
			corpse:setActionId(Storage.ProdigalSon.AreczekCorpse)
			return true
		end
		areczekEnraged:register()

		local corpse = Action()
		function corpse.onUse(player, corpseItem, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if not player:HasExactMissionState(missionState) then
				return false
			end

			corpseItem:remove()
			player:AddCustomItem({ id = PRODIGAL_SON_NORMAL_ITEMS.toiletSoap })
			fromPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			return true
		end
		corpse:aid(Storage.ProdigalSon.AreczekCorpse)
		corpse:register()
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.KillAreczekForSoap,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Those goddamn parasites! This company net profit is barely positive, and they are trying to ruin us!",
					nextState = {
						[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.AskForNewMission,
					},
					requiredItems = {
						{ id = PRODIGAL_SON_NORMAL_ITEMS.toiletSoap, count = 4 },
					},
					textNoRequiredItems = "Actually, bring me just four soaps. I just recalled that there was towel shortage at local walmart when we tried to order them.",
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.AskForNewMission, QuestFactory.Dialog("Henry the Foreman", {
			[{ "mission" }] = {
				text = "A bunch of Areczeks trying to create a worker union. Get rid of their leader, and they will surely yield.",
				nextState = {
					[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.KillAreczekLeader,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.KillAreczekLeader,
			QuestFactory.StartupItems({
				{ pos = { -87, -52, -1 }, id = 710, aid = Storage.ProdigalSon.AreczekLeaderBed },
				{ pos = { -87, -51, -1 }, id = 711, aid = Storage.ProdigalSon.AreczekLeaderBed },
			}, JANUSZEX_ANCHOR),
			QuestFactory.Script(function(missionState)
				local occupiedToEmpty = {
					[710] = 738,
					[711] = 739,
				}
				local emptyToOccupied = SwappedKeyValue(occupiedToEmpty)
				local arechekLock = SpawnLocks.ProdigalSon.ArechekLock

				function SwapNotoriousAreczekBed()
					local bedPositions = {
						northBedPos = JANUSZEX_ANCHOR:Moved(-87, -52, -1),
						southBedPos = JANUSZEX_ANCHOR:Moved(-87, -51, -1),
					}
					for _, pos in pairs(bedPositions) do
						local bed = pos:GetTopItem()
						local oldId = bed:getId()
						local newId = occupiedToEmpty[oldId] or emptyToOccupied[oldId]
						bed:transform(newId)
					end
				end

				local function trySpawnArechekLeader(player)
					if arechekLock:IsSet() then
						return
					end

					Game.createMonster("Notorious Arechek", player:getPosition())
					arechekLock:Set()
					SwapNotoriousAreczekBed()
				end

				local function announceLeaderYielded(fromPosition)
					local spectators = Game.getSpectators(fromPosition, true, true, 7, 7, 5, 5)
					for i = 1, #spectators do
						local translatedMessage = spectators[i]:Localizer(Storage.ProdigalSon.Localizer):Get("Alright! I YIELD! We will disband our union. Now give me some peace, im sick.")
						spectators[i]:say(translatedMessage, TALKTYPE_MONSTER_SAY, true, spectators[i], fromPosition)
					end
				end

				local bed = Action()
				function bed.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					if player:HasHigherMissionState(missionState) then
						announceLeaderYielded(fromPosition)
						return true
					end

					if player:HasExactMissionState(missionState) then
						trySpawnArechekLeader(player)
						return true
					end

					return true
				end
				bed:aid(Storage.ProdigalSon.AreczekLeaderBed)
				bed:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "If i recall correctly, their leader won a cozy bed at a poker table. Its located between A and S buildings.",
				},
			})
	end)
	:MonsterEvent(function(missionState)
		local nextState = {
			[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.ReportKillngAreczekLeader,
		}

		local arechekLock = SpawnLocks.ProdigalSon.ArechekLock

		local notoriousAreczekDeath = CreatureEvent("NotoriousAreczekDeath")
		function notoriousAreczekDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				if not player:HasExactMissionState(missionState) then
					return true
				end
				player:NextState(nextState)
			end)

			arechekLock:Reset()
			SwapNotoriousAreczekBed()
			return true
		end

		notoriousAreczekDeath:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Notorious Arechek")
		local monster = {}

		monster.description = "a Notorious Arechek"
		monster.experience = 70000
		monster.outfit = {
			lookType = 1042,
			lookHead = 0,
			lookBody = 97,
			lookLegs = 37,
			lookFeet = 115,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 20000
		monster.maxHealth = 20000
		monster.corpse = 0
		monster.speed = 250
		monster.race = "undead"

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 6,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"NotoriousAreczekDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 0,
		}

		monster.attacks = {
			{
				name = "combat",
				interval = 2000,
				chance = 100,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = 0,
				maxDamage = -400,
				range = 7,
				shootEffect = CONST_ANI_BURSTARROW,
				target = true,
			},
			{
				name = "combat",
				interval = 6000,
				chance = 22,
				type = COMBAT_HOLYDAMAGE,
				minDamage = -200,
				maxDamage = -900,
				range = 7,
				radius = 4,
				effect = CONST_ME_HOLYAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 4000,
				chance = 12,
				type = COMBAT_HOLYDAMAGE,
				minDamage = -400,
				maxDamage = -900,
				range = 7,
				effect = CONST_ME_HOLYDAMAGE,
				target = true,
			},
			{
				name = "combat",
				interval = 4000,
				chance = 17,
				type = COMBAT_ICEDAMAGE,
				minDamage = -400,
				maxDamage = -900,
				radius = 4,
				effect = CONST_ME_ICEAREA,
				target = false,
			},
		}

		monster.defenses = {
			defense = 86,
			armor = 86,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.ReportKillngAreczekLeader,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Thanks for help. Now i wont have to worry about labour law or some human rights.",
					nextState = {
						[Storage.ProdigalSon.Mission03] = MISSION_FINISHED,
						[Storage.ProdigalSon.Mission04] = QuestState.ProdigalSon.Mission04.AskForMission,
					},
				},
			})
	end)
	:Mission(Storage.ProdigalSon.Mission04)
	:State(function()
		return QuestState.ProdigalSon.Mission04.DupingConferencePeople,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission", "misja" }] = {
					text = "Good job. Now i have a new mission for you. Take a look at the bookshelf behind me. You can find The Art of Eristics there. You are gonna need it for later mission. Also, i need you to find the two other tomes from this series. I lost one in the caves, near the south gate. Other one i accidentally flushed down the toilet, which caused the northern caves to be flooded. There is underwater lift near the temple; go down to the bottom of the sewer and search there.",
					nextState = {
						[Storage.ProdigalSon.Mission04] = QuestState.ProdigalSon.Mission04.AskForMission,
						[Storage.ProdigalSon.Mission04] = QuestState.ProdigalSon.Mission04.FindingEristicsBooks,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission04.FindingEristicsBooks,
			QuestFactory.StartupItems({
				{
					pos = { -50, -5, 1 },
					id = 2438,
					aid = Storage.ProdigalSon.EristicsBooks.One,
					rewards = { QuestKeyItems.ProdigalSon.BookOne },
				},
				{
					pos = { -69, 17, 5 },
					id = 27314,
					aid = Storage.ProdigalSon.EristicsBooks.Two,
					rewards = { QuestKeyItems.ProdigalSon.BookTwo },
				},
				{
					pos = { -47, 166, 4 },
					id = 2473,
					aid = Storage.ProdigalSon.EristicsBooks.Three,
					rewards = { QuestKeyItems.ProdigalSon.BookThree },
				},
				{ pos = { -61, 27, 2 }, id = 9125, aid = Storage.ProdigalSon.SewersLever },
				{ pos = { -61, 27, 5 }, id = 9125, aid = Storage.ProdigalSon.SewersLever },
			}, JANUSZEX_ANCHOR),
			QuestFactory.Script(function(missionState)
				local surfaceZ = JANUSZEX_ANCHOR:Moved(0, 0, 2).z
				local function isOnSurface(pos)
					return pos.z == surfaceZ
				end

				local lever = Action()
				function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					local playerPos = player:getPosition()

					local offsetZ = -3
					if isOnSurface(playerPos) then
						offsetZ = 3
					end

					local newPos = playerPos:Moved(0, 0, offsetZ)
					player:teleportTo(newPos, true)
					newPos:sendMagicEffect(CONST_ME_WATERSPLASH)
					return true
				end
				lever:aid(Storage.ProdigalSon.SewersLever)
				lever:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Alright, there are all the book you need. Now for the real task: we are hosting a party in the conference room. You can find some of our clients here. Try to convince them to take out a loan for one of our 'pristine' products. The books i had you bring to me were in Swahili, so you wouldnt understand a word. And now: I doth grant unto thee ye might of larcraeft.",
					requiredItems = {
						QuestKeyItems.ProdigalSon.BookOne,
						QuestKeyItems.ProdigalSon.BookTwo,
						QuestKeyItems.ProdigalSon.BookThree,
					},
					textNoRequiredItems = "Come back when you are done collecting the books.",
					rewards = {
						QuestKeyItems.ProdigalSon.SlimmingPot,
						QuestKeyItems.ProdigalSon.LovePotion,
						QuestKeyItems.ProdigalSon.Herbs,
					},
					nextState = {
						[Storage.ProdigalSon.Mission04] = QuestState.ProdigalSon.Mission04.DupingConferencePeople,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission04.DupingConferencePeople,
			QuestFactory.Dialog("Conference Dorothy", {
				[{ GREET }] = { text = "Hello." },
				[{ "herbs", "ziola" }] = {
					text = "I'm not superstitous and don't believe in god either. Magical stones and herbs protect me.",
					requiredItems = { QuestKeyItems.ProdigalSon.Herbs },
					rewards = { QuestKeyItems.ProdigalSon.LoanDocument },
				},
			}),
			QuestFactory.Dialog("Conference Dwight", {
				[{ GREET }] = { text = "Hello." },
				[{ "potion", "mikstura" }] = {
					text = "This is something i needed. Here is my singature.",
					requiredItems = { QuestKeyItems.ProdigalSon.LovePotion },
					rewards = { QuestKeyItems.ProdigalSon.LoanDocument },
				},
			}),
			QuestFactory.Dialog("Conference Triss", {
				[{ GREET }] = { text = "Hey." },
				[{ "pot", "garnek" }] = {
					text = "A pot with those properties is what i need. Teacher salary isn't enough even for a single theater ticket. I guess i will have to take out a loan...",
					requiredItems = { QuestKeyItems.ProdigalSon.SlimmingPot },
					rewards = { QuestKeyItems.ProdigalSon.LoanDocument },
				},
			}),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Badass, dude - you got all of them to take out a loan for those >products. You are thereby promoted to senior assistant. Now you can access the main cave system on the north.",
					textNoRequiredItems = "Come back when you are done collecting the loan declarations.",
					requiredItems = {
						{
							id = QuestKeyItems.ProdigalSon.LoanDocument.id,
							aid = QuestKeyItems.ProdigalSon.LoanDocument.aid,
							count = 3,
						},
					},
					nextState = {
						[Storage.ProdigalSon.Mission04] = MISSION_FINISHED,
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.AskForNewMission,
						[Storage.ProdigalSon.NorthMinesAccess] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.AskForNewMission,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "I have a new mission for you. Do you remember when i mentioned that northern caves are now flooded? Officially, everyone was out when the flooding occured, but acutally it was swarming with miners there. It were rush hours when it happened. Arechek lives dont matter, so noone ever investigated it. Later, cave has been ravaged by hostile water-shaped creatures. One of the dwarfs here had something i need now. Try to find his corpse. You can identify him by his gray Beard.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.FindingDwarfNecklace,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.FindingDwarfNecklace,
			QuestFactory.StartupItems({
				{
					pos = { -40, -270, 5 },
					id = 4169,
					aid = Storage.ProdigalSon.DiamondNecklace,
					rewards = { QuestKeyItems.ProdigalSon.DiamondNecklace },
				},
			}, JANUSZEX_ANCHOR),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Yeah, this is the one i was looking for.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.FoundNecklace_AskForNewMission,
					},
					requiredItems = { QuestKeyItems.ProdigalSon.DiamondNecklace },
					textNoRequiredItems = "Grab necklace from that corpse first. Be careful, those monsters are aggressive!",
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.FoundNecklace_AskForNewMission,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "What else could you help me with... hmmm. Well, you check can the lava mines for new finds. Reach the top of one of the silos, and check its state by using the special machine. Also some Arechek reported that he found an abandoned cultivator there. Romek, the King of Rats might be interested in it, so give it a try and find it.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.CheckingOnSilo,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.CheckingOnSilo, QuestFactory.StartupItems({
			{
				pos = { 74, -82, 2 },
				id = 843,
				aid = Storage.ProdigalSon.LavaSiloMachine,
				nextState = {
					[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.CheckedOnSilo,
				},
			},
		}, JANUSZEX_ANCHOR)
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.CheckedOnSilo,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Nothing special, as i thought. Now, you have to help me with something. My friend, Fredi, is currently in the north-eastern mines. I need him here, so try to convince him to come. If he wont move, try to find a distilling machine. Its content will make him move. Fredi is very aggressive when drunk, so be careful.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.EscortingFredi,
					},
				},
			})
	end)
	:State(function()
		return { min = QuestState.ProdigalSon.Mission05.CheckedOnSilo }, QuestFactory.StartupItems({
			{
				pos = JANUSZEX_ANCHOR:Moved(-16, -103, 4),
				id = 11809,
				actionid = Storage.KingOfRatsHQ.Items.Cultivator,
				rewards = { QuestKeyItems.KingOfRatsHQ.Cultivator },
			},
		})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.EscortingFredi,
			QuestFactory.StartupItems({
				{
					pos = { 104, -150, 4 },
					id = 5468,
					aid = Storage.ProdigalSon.FrediBeer,
					nextState = { [Storage.ProdigalSon.FrediBeer] = -1 },
					rewards = { QuestKeyItems.ProdigalSon.FrediBeer },
				},
			}, JANUSZEX_ANCHOR),
			QuestFactory.Dialog("Fredi Kamionka", {
				[{ "mission" }] = {
					text = "Alrigth, lets go.",
					requiredItems = { QuestKeyItems.ProdigalSon.FrediBeer },
					specialActionsOnSuccess = {
						{ action = StartEscortDialog, escortContext = frediEscort },
					},
					textNoRequiredItems = "Give me the booze! Give me the booze!",
				},
			}),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission", "fredi" }] = {
					text = "Good job. Give us a moment now.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.AwaitHenryFinishedTalking,
					},
					specialConditions = {
						{
							condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.frediIsNearby,
							requiredOutcome = true,
							textNoRequiredCondition = "Come back with Fredi.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.despawnEscortee,
							escorteeName = "fredi kamionka monster",
							despawnAfterSeconds = 10,
						},
					},
				},
			})
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Fredi kamionka Escort")
		local monster = {}

		monster.name = "Fredi kamionka"
		monster.description = "a Fredi kamionka"
		monster.experience = 1000
		monster.outfit = { lookType = 1136, lookHead = 95, lookBody = 100, lookLegs = 60, lookFeet = 58, lookAddons = 0 }

		monster.health = 9000
		monster.maxHealth = 9000
		monster.corpse = 4240
		monster.speed = 100

		monster.faction = FACTION_PLAYER

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 0,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 0,
		}

		monster.attacks = {
			{
				name = "combat",
				interval = 2000,
				chance = 100,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = -10,
				maxDamage = -100,
				range = 7,
				shootEffect = CONST_ANI_BURSTARROW,
				target = true,
			},
			{
				name = "combat",
				interval = 6000,
				chance = 35,
				type = COMBAT_HOLYDAMAGE,
				minDamage = -200,
				maxDamage = -900,
				range = 8,
				radius = 4,
				effect = CONST_ME_HOLYAREA,
				target = true,
			},
		}

		monster.defenses = {
			defense = 86,
			armor = 86,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType.onMove = function(monster, _, _, toPosition)
			local rand = math.random(1, 10)
			if rand > 2 then
				return
			end

			local spectators = getSpectators(toPosition, 7, 6, false, false)
			IterateSpectators(spectators, function(cid)
				local creature = Creature(cid)
				if not creature then
					return
				end
				if creature:getName():lower() == "areczek" then
					doTargetCombatHealth(monster, creature, COMBAT_FIREDAMAGE, -1, -1, CONST_ME_NONE)
				end
			end)
		end

		mType:register(monster)
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.AwaitHenryFinishedTalking,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission", "misja" }] = {
					text = "I had a word with my friend Fredi. HE TOLD ME ABOUT HE NEW BMW OUR IMPERATOR IS DRIVING. This goddamn ostentatious thief. You proven yourself reliable. Its time to end him now. To be granted an audience with him, you need to know the password. The password is written on the blackboard, along the cobblestone trail. Not one Arechek is smart enough to figure the workings of the mechanism that reveals it. I cannot leave my position, but you can go and read it. Came back to me when you find it.",
					nextState = {
						[Storage.ProdigalSon.Mission05] = MISSION_FINISHED,
						[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.HenryJustTalkedWithFredi,
						[Storage.ProdigalSon.PolAccess] = ACCESS_GRANTED,
					},
					specialConditions = {
						{
							condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.frediIsNearby,
							requiredOutcome = false,
							textNoRequiredCondition = "Give us a moment.",
						},
					},
				},
			})
	end)
	:Mission(Storage.ProdigalSon.Mission06)
	:State(function()
		return QuestState.ProdigalSon.Mission06.FindPasswordAndKillImperator,
			QuestFactory.Script(function(missionState)
				local gateLever = Action()
				function gateLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local gatePos = JANUSZEX_ANCHOR:Moved(-183, 2, 2)
					local gateTile = Tile(gatePos)
					local gate = gateTile:getItemById(2185)
					if gate then
						gate:remove()
					else
						Game.createItem(2185, 1, gatePos)
					end
					fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
					return true
				end
				gateLever:aid(Storage.ProdigalSon.BlackBoardLever1)
				gateLever:register()

				local waterfallLever = Action()
				function waterfallLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					local waterfallPos = JANUSZEX_ANCHOR:Moved(-174, 5, 5)
					local waterfallTile = Tile(waterfallPos)
					local waterfall = waterfallTile:getItemById(1717)
					if waterfall then
						waterfall:remove()
						addEvent(function()
							Game.createItem(1717, 1, waterfallPos)
						end, 60 * 2 * 1000)
						fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
					end
					return true
				end
				waterfallLever:aid(Storage.ProdigalSon.BlackBoardLever2)
				waterfallLever:register()
			end),
			QuestFactory.StartupItems({
				{ pos = { -174, 5, 5 }, id = 1717, actionid = 0 },
				{ pos = { -193, 1, 3 }, id = 2773, aid = Storage.ProdigalSon.BlackBoardLever1 },
				{ pos = { -182, 1, 3 }, id = 2773, aid = Storage.ProdigalSon.BlackBoardLever2 },
				{ pos = { -174, 5, 5 }, id = 2602, aid = Storage.ProdigalSon.Blackboard, desc = "BLACKBOARD_DESC" },
			}, JANUSZEX_ANCHOR),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Did you find out what is the password? What is it?",
				},
				[{ "yes", "tak" }] = {
					text = "Go and talk with Access-O-Bot in eastern part of the castle. Tell him the password, and he will let you in.",
				},
				[{ ANY_MESSAGE }] = {
					text = "Yeah, thats it! Go and get rid of our imperator!",
					specialConditions = {
						{
							condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.saidCorrectPassword,
							requiredOutcome = true,
							textNoRequiredCondition = "No. Im sure its not the password. Try looking behind the waterfall.",
						},
					},
				},
			}),
			QuestFactory.Dialog("Access-O-Bot", {
				[{ GREET }] = {
					text = "Password:",
				},
				[{ "mission", "misja", "entry", "enter", "wejsc", "passage", "access", "dostep", "teleport" }] = {
					text = "Password:",
				},
				[{ ANY_MESSAGE }] = {
					text = "Correct password. Come in.",
					specialConditions = {
						{
							condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.saidCorrectPassword,
							requiredOutcome = true,
							textNoRequiredCondition = "~BZZT~ WRONG PASSWORD. INITIATE: ERADICATION MODE.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.teleportPlayer,
							pos = JANUSZEX_ANCHOR:Moved(54, 18, -1),
						},
					},
				},
			})
		-- ToDo: add pol monster
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.KilledImperator,
		}

		local polDeath = CreatureEvent("PolDeath")
		function polDeath.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.ProdigalSon.Mission06)
				if storage_val ~= 1 then
					return true
				end
				player:NextState(nextState)
			end)
			return true
		end
		polDeath:register()
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission06.KilledImperator,
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Alright. For all your effort i present to you this legendary payslip. Dont worry, it works outside our company shop.",
					rewards = { QuestKeyItems.ProdigalSon.Payslip },
					nextState = {
						[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.ReportToChester,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission06.ReportToChester,
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ GREET }] = { text = "Did you manage to get the payslip?" },
				[{ "yes", "tak" }] = {
					text = "Thanks for the info. This is your reward for your good job!",
					nextState = {
						[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.Finished,
						[Storage.Finished.ProdigalSon] = MISSION_FINISHED,
					},
					expReward = 2000000,
					rewards = { ExerciseWeaponBox(1500) },
					requiredItems = { QuestKeyItems.ProdigalSon.Payslip },
					textNoRequiredItems = "Come back when you have it.",
				},
			})
	end)
	:Register()

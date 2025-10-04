local quest = Quest(LOCALIZERS.ProdigalSon)

local frediEscort = EscortData({
	timeLimitSeconds = 600,
	startAfterSeconds = 2,
})
EscortRegistry:Register(frediEscort)

quest
	:Storage(function()
		Storage.ProdigalSon = {
			Localizer = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			MainGateAccess = {},
			NorthMinesAccess = {},
			TileBeforeChesterCompartment = {},
			FindJanuszexTile = {},
			HammerMaking = { Lever = {}, Paint = {} },
			CalculatorMaking = {
				Lever = {},
				MetalPile = {},
				WoodPile = {},
			},
			PliersMaking = { Lever = {}, MetalPile = {} },
			ArechekCorpse = {},
			ArechekLeaderBed = {},
			EristicsBooks = {
				One = {},
				Two = {},
				Three = {},
			},
			EristicsItems = {
				LovePotion = {},
				Herbs = {},
				SlimmingPot = {},
				LoanDocument = {},
			},
			SewersLever = {},
			DiamondNecklace = {},
			LavaSiloMachine = {},
			FrediBeer = {},
			Blackboard = {},
			BlackBoardLever1 = {},
			BlackBoardLever2 = {},
			PolAccess = {},
			Payslip = {},
			TrainDestinations = {
				ToHurghada = {},
				ToJanuszex = {},
				ToBydgoshch = {},
			},
			Rewards = { ToiletSoap = {} },
			PortalAfterPol = {},
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
				KillArechekForSoap = 2,
				AskForNewMission = 3,
				KillArechekLeader = 4,
				ReportKillngArechekLeader = 5,
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
				player:setStorageValueByKey(Storage.ProdigalSon.Blackboard, tostring(math.random(10 ^ 6, 10 ^ 7 - 1)))
			end,
		}

		QuestKeyItems.ProdigalSon = {
			Payslip = {
				id = 2818,
				key = Storage.ProdigalSon.Payslip,
				desc = "A payslip.",
			},
			BookOne = {
				id = 2816,
				key = Storage.ProdigalSon.EristicsBooks.One,
				desc = "Eristics for dummies\nPart 3",
			},
			BookTwo = {
				id = 2821,
				key = Storage.ProdigalSon.EristicsBooks.Two,
				desc = "Eristics for dummies\nPart 5",
			},
			BookThree = {
				id = 2828,
				key = Storage.ProdigalSon.EristicsBooks.Three,
				desc = "Eristics for dummies\nPart 8",
			},
			SlimmingPot = {
				id = 3465,
				desc = "Every dish cooked in this pot can only make you more slim and fit.",
				key = Storage.ProdigalSon.EristicsItems.SlimmingPot,
			},
			LovePotion = {
				id = 9173,
				desc = "This smart potion will make you a lovely person.",
				key = Storage.ProdigalSon.EristicsItems.LovePotion,
			},
			Herbs = {
				id = 12671,
				desc = "Assortment of herbs. They cure cancer within 24 hours.",
				key = Storage.ProdigalSon.EristicsItems.Herbs,
			},
			LoanDocument = {
				id = 2815,
				desc = "Loan agreement",
				key = Storage.ProdigalSon.EristicsItems.LoanDocument,
			},
			DiamondNecklace = {
				id = 35607,
				key = Storage.ProdigalSon.DiamondNecklace,
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

		SYN_MARNOTRAWNY_SPECIAL_REQUIREMENTS = {
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
				local correctPassword = tostring(player:getStorageValueByKey(Storage.ProdigalSon.Blackboard))
				local saidPassword = context.msg
				if saidPassword == correctPassword then
					return true
				end

				if context.specialMessageType then
					return
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
				player:setStorageValueByKey(Storage.ProdigalSon.Blackboard, math.random(10 ^ 6, 10 ^ 7 - 1))
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
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Prodigal Son",
			localizer = localizer,
			missions = {
				{
					name = "01. Work is da poop!",
					storage = Storage.ProdigalSon.Mission01,
					states = {
						[QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex] = "Ask Chester for a new mission.",
						[QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex] = "Find the metro leading to workplace designated by Chester.",
						[MISSION_FINISHED] = "You found the metro Chester was talking about. Try to find the work supervisor when you arrive at the next station.",
					},
				},
				{
					name = "02. Artisan Baker",
					storage = Storage.ProdigalSon.Mission02,
					states = {
						[QuestState.ProdigalSon.Mission02.FindForeman] = "Find the work supervisor.",
						[QuestState.ProdigalSon.Mission02.PaintHammers] = "Henry commanded you to start your new job: painting wooden hammers. He asked for 5 pieces.",
						[QuestState.ProdigalSon.Mission02.MakingCalculators] = "Henry gave you a new job: make 5 calculators.",
						[QuestState.ProdigalSon.Mission02.MakingPliers] = "Henry ordered 5 new pliers.",
						[MISSION_FINISHED] = "You completed all of Henry's orders.",
					},
				},
				{
					name = "03. Cheetos Prank Acedemy",
					storage = Storage.ProdigalSon.Mission03,
					states = {
						[QuestState.ProdigalSon.Mission03.TalkToHearAboutDuties] = "Henry promoted you to an assistant position. Ask for your new duties.",
						[QuestState.ProdigalSon.Mission03.KillArechekForSoap] = "Henry asked you to investigate the ever-shrinking number of towels and soaps in toilets.",
						[QuestState.ProdigalSon.Mission03.AskForNewMission] = "You handed the missing soaps to Henry. Ask him for a new mission.",
						[QuestState.ProdigalSon.Mission03.KillArechekLeader] = "Arecheks are trying to unionize. Defeat their leader and the union may dissolve.",
						[QuestState.ProdigalSon.Mission03.ReportKillngArechekLeader] = "Arechek union leader promised to dissolve their union. Report back to Henry.",
						[MISSION_FINISHED] = "Henry is content that you busted the union.",
					},
				},
				{
					name = "04. Serious business",
					storage = Storage.ProdigalSon.Mission04,
					states = {
						[QuestState.ProdigalSon.Mission04.AskForMission] = "Ask Henry for your next mission.",
						[QuestState.ProdigalSon.Mission04.FindingEristicsBooks] = "Find the three books on eristics. Henry lost them allover the place.",
						[QuestState.ProdigalSon.Mission04.DupingConferencePeople] = "Henry granted you the mighty powers of eristics. Try to persuade the customers in conference hall to buy company products.",
						[MISSION_FINISHED] = "Henry thanked you for doing your job.",
					},
				},
				{
					name = "05. SUPREME",
					storage = Storage.ProdigalSon.Mission05,
					states = {
						[QuestState.ProdigalSon.Mission05.AskForNewMission] = "Ask Henry for new mission.",
						[QuestState.ProdigalSon.Mission05.FindingDwarfNecklace] = "Henry asked you to find a gray-haired dwarf corpse.",
						[QuestState.ProdigalSon.Mission05.FoundNecklace_AskForNewMission] = "You gave Henry his lost necklace. Ask him for new mission.",
						[QuestState.ProdigalSon.Mission05.CheckingOnSilo] = "Check the silo state in the lava mines.",
						[QuestState.ProdigalSon.Mission05.CheckedOnSilo] = "You used special machine to check state of the silo content. Report back to Henry.",
						[QuestState.ProdigalSon.Mission05.EscortingFredi] = "Henry told you about a friend stuck on north-eastern mines. EscortData him back to Henry.",
						[QuestState.ProdigalSon.Mission05.AwaitHenryFinishedTalking] = "Henry asked you to give him a moment to discuss something with his friend Fredi.",
						[MISSION_FINISHED] = "Henry thanked you for doing your job.",
					},
				},
				{
					name = "06. Coup d'Passat",
					storage = Storage.ProdigalSon.Mission06,
					states = {
						[QuestState.ProdigalSon.Mission06.FindPasswordAndKillImperator] = "Henry told you to find the password to the royal room.",
						[QuestState.ProdigalSon.Mission06.KilledImperator] = "You defeated Pol, the boss-imperator of Januszex. Report to Henry.",
						[QuestState.ProdigalSon.Mission06.ReportToChester] = "Henry finally gave you the payslip you needed. Go back to Chester.",
						[MISSION_FINISHED] = "Im a dog, and you are a flower.\nIf i lift my leg i might give you a shower.",
					},
				},
			},
		})
	end)
	:MonsterEvent(function()
		local arechekCalmHit = CreatureEvent("HitArechekCalm")
		function arechekCalmHit.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
			if not creature:isMonster() then
				return primaryDamage, primaryType, secondaryDamage, secondaryType
			end

			local healthGain = PredictNetHealthgain(primaryDamage, primaryType, secondaryDamage, secondaryType)
			local currentHealth = creature:getHealth()
			if (currentHealth + healthGain) < creature:getMaxHealth() then
				creature:setType("Arechek Enraged")
			end

			return primaryDamage, primaryType, secondaryDamage, secondaryType
		end
		arechekCalmHit:register()

		local arechekEnragedSelfHeal = CreatureEvent("HealArechekEnraged")
		function arechekEnragedSelfHeal.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
			if not creature:isMonster() then
				return primaryDamage, primaryType, secondaryDamage, secondaryType
			end

			local healthGain = PredictNetHealthgain(primaryDamage, primaryType, secondaryDamage, secondaryType)
			local currentHealth = creature:getHealth()
			if (currentHealth + healthGain) >= creature:getMaxHealth() then
				creature:setType("Arechek Calm")
			end

			return primaryDamage, primaryType, secondaryDamage, secondaryType
		end
		arechekEnragedSelfHeal:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Arechek Enraged")
		local monster = {}

		monster.name = "Arechek"
		monster.description = "an Arechek"
		monster.experience = 9900
		monster.outfit = {
			lookType = 1042,
			lookHead = 0,
			lookBody = 97,
			lookLegs = 37,
			lookFeet = 115,
			lookAddons = 3,
			lookMount = 0,
		}

		monster.raceId = 2585
		monster.Bestiary = {
			class = "Human",
			race = BESTY_RACE_HUMAN,
			toKill = 500,
			FirstUnlock = 25,
			SecondUnlock = 250,
			CharmsPoints = 50,
			Stars = 5,
			Occurrence = 0,
			Locations = "Arechek is your usual Januszex inhabitant.",
		}

		monster.health = 7500
		monster.maxHealth = 7500
		monster.speed = 250
		monster.corpse = 111

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

		monster.events = {
			"ArechekEnragedDeath",
			"HealArechekEnraged",
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
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700, effect = CONST_ME_DRAWBLOOD },
			{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -400, range = 7, shootEffect = CONST_ANI_BURSTARROW, target = true },
			{ name = "combat", interval = 6000, chance = 22, type = COMBAT_HOLYDAMAGE, minDamage = -200, maxDamage = -900, range = 7, radius = 4, effect = CONST_ME_HOLYAREA, target = true },
			{ name = "combat", interval = 4000, chance = 12, type = COMBAT_HOLYDAMAGE, minDamage = -400, maxDamage = -900, range = 7, effect = CONST_ME_HOLYDAMAGE, target = true },
			{ name = "combat", interval = 4000, chance = 17, type = COMBAT_ICEDAMAGE, minDamage = -400, maxDamage = -900, radius = 4, effect = CONST_ME_ICEAREA, target = false },
		}

		monster.defenses = {
			defense = 86,
			armor = 86,
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 10, maxDamage = 220, effect = CONST_ME_MAGIC_BLUE, target = false },
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
		local mType = Game.createMonsterType("Arechek calm")
		local arechekBase = Game.createMonsterType("Arechek")
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
			"HitArechekCalm",
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
		arechekBase:register(monster)
	end)
	:Script(function(missionState)
		local nextState = {
			[Storage.ProdigalSon.Mission01] = QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex,
		}

		local mainGateTile = MoveEvent()
		function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
			local chesterState = player:getStorageValueByKey(Storage.ChesterTheDwarf.Mission03)
			if chesterState ~= MISSION_FINISHED then
				return
			end

			local questState = player:getStorageValueByKey(Storage.ProdigalSon.Mission01)
			if questState > MISSION_NOT_STARTED then
				return
			end

			player:NextState(nextState)
		end
		mainGateTile:key(Storage.ProdigalSon.TileBeforeChesterCompartment)
		mainGateTile:register()
	end)
	:Script(function(missionState)
		local errorMessage = "You don't have permission to go there. Talk to Overseer Henry of Januszex to be granted an entry."
		local function tryEnterAccessTile(actionid, player, fromPosition)
			if not player:isPlayer() then
				return
			end

			if player:getStorageValueByKey(actionid) ~= ACCESS_GRANTED then
				local transaltedMessage = player:Localizer(LOCALIZERS.ProdigalSon):Get(errorMessage)
				player:sendTextMessage(MESSAGE_INFO_DESCR, transaltedMessage)
				player:teleportTo(fromPosition, true)
			end

			return true
		end

		local mainGateTile = MoveEvent()
		function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
			tryEnterAccessTile(Storage.ProdigalSon.MainGateAccess, player, fromPosition)
		end
		mainGateTile:key(Storage.ProdigalSon.MainGateAccess)
		mainGateTile:register()

		local northMinesTile = MoveEvent()
		function northMinesTile.onStepIn(player, item, toPosition, fromPosition)
			tryEnterAccessTile(Storage.ProdigalSon.NorthMinesAccess, player, fromPosition)
		end
		northMinesTile:key(Storage.ProdigalSon.NorthMinesAccess)
		northMinesTile:register()
	end)
	:EncounterData(function()
		local polEncounter = EncounterData({
			displayName = "Pol",
			encounterId = "Pol",
			bossName = "Pol",

			requiredState = { [Storage.ProdigalSon.PolAccess] = ACCESS_GRANTED },

			lockoutExpiryTime = LOCKOUT_EXPIRY_TIME.WEEKLY,
			lockoutTriggerCriterion = LOCKOUT_TRIGGER_CRITERION.ON_KILL,
		})

		function polEncounter:beforeStart()
			self.sameTileDamage = 30
		end

		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
		combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)

		local damagingTilesScope = polEncounter:GetEventScope():Get("DamagingTiles")
		local wrongTiles = GlobalEvent(damagingTilesScope)
		function wrongTiles.onThink()
			if not polEncounter:IsActive() then
				return true
			end

			local damage = polEncounter.sameTileDamage
			combat:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0)

			local participants = polEncounter:GetEncounterZone():getPlayers()
			local boss = polEncounter:GetBossObject()
			local correctGroundId = boss:getPosition():GetGroundId()
			local atLeastOneFail = false
			for _, player in pairs(participants) do
				local groundId = player:getPosition():GetGroundId()
				if groundId == correctGroundId then
					atLeastOneFail = true
					combat:execute(boss, { pos = player:getPosition(), type = 2 })
				end
			end

			if atLeastOneFail then
				polEncounter.sameTileDamage = polEncounter.sameTileDamage + 10
			end
			return true
		end
		wrongTiles:interval(2000)
		wrongTiles:register()

		EncounterDataRegistry:Register(polEncounter)
	end)
	:MonsterEvent(function()
		local plusArea = createCombatArea(AREA_PLUS5)
		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		combat:setArea(plusArea)
		combat:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

		local spell = Spell("instant")

		function spell.onCastSpell(creature, var)
			do
				return
			end
			if not creature or not creature:isMonster() then
				return true
			end
			var.pos = creature:getPosition()
			for i = 1, 10, 0.5 do
				addEvent(function()
					combat:execute(creature, var)
				end, i * 1000)
			end
			return true
		end

		spell:name("pol plus beam")
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(true)
		spell:needDirection(true)
		spell:register()
	end)
	:Mission(Storage.ProdigalSon.Mission01)
	:State(function()
		return QuestState.ProdigalSon.Mission01.ChesterSpeakingAboutJanuszex,
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ "mission" }] = {
					text = "I now have my eye on a certain Januszex TM. They have their headquarters far to the east. I would start working on my CV, but first, i need to learn more about the working conditions there. I would like to ask you to go there by {train}. They have a special metro line that stops at their company. When you are there, search for building with 'C' marking outside.",
					nextState = {
						[Storage.ProdigalSon.Mission01] = QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex,
						[Storage.ProdigalSon.TrainDestinations.ToJanuszex] = ACCESS_GRANTED,
					},
					specialActionsOnSuccess = {
						{
							action = SYN_MARNOTRAWNY_SPECIAL_ACTIONS.setPersonalBlackboardPassword,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission01.YouAreLookingForJanuszex,
			QuestFactory.Dialog("Chester the Dwarf", {
				[{ "train", "pociagiem" }] = {
					text = "Just ask the conductor to see the schedules of the train.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.ProdigalSon.Mission01] = MISSION_FINISHED,
					[Storage.ProdigalSon.Mission02] = QuestState.ProdigalSon.Mission02.FindForeman,
				}

				local grantFoundJanuszexTile = MoveEvent()
				function grantFoundJanuszexTile.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return
					end

					player:NextState(nextState)
				end
				grantFoundJanuszexTile:key(Storage.ProdigalSon.FindJanuszexTile)
				grantFoundJanuszexTile:register()
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
					saw:setKey(Storage.ProdigalSon.HammerMaking.Lever)
					saw:setUniqueId(1000)

					return true
				end
				lever:key(Storage.ProdigalSon.HammerMaking.Lever)
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
				paint:key(Storage.ProdigalSon.HammerMaking.Paint)
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
			QuestFactory.Script(function(missionState)
				local metalPile = Action()
				function metalPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.stoneTrash, 1, player:getPosition())
					return true
				end
				metalPile:key(Storage.ProdigalSon.CalculatorMaking.MetalPile)
				metalPile:register()

				local woodPile = Action()
				function woodPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.woodTrash, 1, player:getPosition())
					return true
				end
				woodPile:key(Storage.ProdigalSon.CalculatorMaking.WoodPile)
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
				lever:key(Storage.ProdigalSon.CalculatorMaking.Lever)
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
				metalPile:key(Storage.ProdigalSon.PliersMaking.MetalPile)
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
				lever:key(Storage.ProdigalSon.PliersMaking.Lever)
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
						[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.KillArechekForSoap,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.KillArechekForSoap,
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
	:MonsterEvent(function()
		local arechekEnraged = CreatureEvent("ArechekEnragedDeath")
		function arechekEnraged.onDeath(creature, corpse, killer)
			if not creature or not creature:isMonster() then
				return true
			end
			if not killer:isPlayer() then
				return false
			end

			if killer:getStorageValueByKey(Storage.ProdigalSon.Mission03) ~= QuestState.ProdigalSon.Mission03.KillArechekForSoap then
				return false
			end

			local soap = Game.createItem(PRODIGAL_SON_NORMAL_ITEMS.toiletSoap, 1, creature:getPosition())
			return true
		end
		arechekEnraged:register()
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.AskForNewMission, QuestFactory.Dialog("Henry the Foreman", {
			[{ "mission" }] = {
				text = "A bunch of Arecheks trying to create a worker union. Get rid of their leader, and they will surely yield.",
				nextState = {
					[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.KillArechekLeader,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission03.KillArechekLeader,
			QuestFactory.Script(function(missionState)
				local occupiedToEmpty = {
					[710] = 738,
					[711] = 739,
				}
				local emptyToOccupied = SwappedKeyValue(occupiedToEmpty)
				local arechekLock = SpawnLocks.ProdigalSon.ArechekLock

				function SwapNotoriousArechekBed()
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

					arechekLock:Set(Game.createMonster("Notorious Arechek", player:getPosition()))
					SwapNotoriousArechekBed()
				end

				local function announceLeaderYielded(fromPosition)
					local spectators = Game.getSpectators(fromPosition, true, true, 7, 7, 5, 5)
					for i = 1, #spectators do
						local translatedMessage = spectators[i]:Localizer(LOCALIZERS.ProdigalSon):Get("Alright! I YIELD! We will disband our union. Now give me some peace, im sick.")
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
				bed:key(Storage.ProdigalSon.ArechekLeaderBed)
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
			[Storage.ProdigalSon.Mission03] = QuestState.ProdigalSon.Mission03.ReportKillngArechekLeader,
		}

		local arechekLock = SpawnLocks.ProdigalSon.ArechekLock

		local NotoriousArechekDeath = CreatureEvent("NotoriousArechekDeath")
		function NotoriousArechekDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.ProdigalSon.Mission03) ~= QuestState.ProdigalSon.Mission03.KillArechekLeader then
					return true
				end
				player:NextState(nextState)
			end)

			arechekLock:Reset()
			SwapNotoriousArechekBed()
			return true
		end

		NotoriousArechekDeath:register()
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
			"NotoriousArechekDeath",
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
		return QuestState.ProdigalSon.Mission03.ReportKillngArechekLeader,
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
		return QuestState.ProdigalSon.Mission04.AskForMission,
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
			QuestFactory.OnUseDeclarations({
				{

					id = 2438,
					key = Storage.ProdigalSon.EristicsBooks.One,
					rewards = { QuestKeyItems.ProdigalSon.BookOne },
				},
				{

					id = 27314,
					key = Storage.ProdigalSon.EristicsBooks.Two,
					rewards = { QuestKeyItems.ProdigalSon.BookTwo },
				},
				{

					id = 2473,
					key = Storage.ProdigalSon.EristicsBooks.Three,
					rewards = { QuestKeyItems.ProdigalSon.BookThree },
				},
			}),
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
				lever:key(Storage.ProdigalSon.SewersLever)
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
				[{ "potion", "mikstura", "love", "milosc" }] = {
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
							key = QuestKeyItems.ProdigalSon.LoanDocument.key,
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
	:Mission(Storage.ProdigalSon.Mission05)
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
			QuestFactory.OnUseDeclarations({
				{

					id = 4169,
					key = Storage.ProdigalSon.DiamondNecklace,
					rewards = { QuestKeyItems.ProdigalSon.DiamondNecklace },
				},
			}),
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
		return QuestState.ProdigalSon.Mission05.CheckingOnSilo, QuestFactory.OnUseDeclarations({
			{
				key = Storage.ProdigalSon.LavaSiloMachine,
				nextState = {
					[Storage.ProdigalSon.Mission05] = QuestState.ProdigalSon.Mission05.CheckedOnSilo,
				},
			},
		})
	end)
	:State(function()
		return { min = QuestState.ProdigalSon.Mission05.CheckingOnSilo }, QuestFactory.OnUseDeclarations({
			{
				key = Storage.KingOfRatsHQ.ArtifactContainer.Cultivator,
				rewards = { QuestKeyItems.KingOfRatsHQ.Cultivator },
			},
		})
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
		return { min = QuestState.ProdigalSon.Mission05.CheckingOnSilo }, QuestFactory.OnUseDeclarations({
			{
				id = 11809,
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Cultivator,
				rewards = { QuestKeyItems.KingOfRatsHQ.Cultivator },
			},
		})
	end)
	:State(function()
		return QuestState.ProdigalSon.Mission05.EscortingFredi,
			QuestFactory.OnUseDeclarations({
				{
					id = 5468,
					key = Storage.ProdigalSon.FrediBeer,
					nextState = { [Storage.ProdigalSon.FrediBeer] = -1 },
					rewards = { QuestKeyItems.ProdigalSon.FrediBeer },
				},
			}),
			QuestFactory.Dialog("Fredi Kamionka", {
				[{ "mission" }] = {
					text = "Alrigth, lets go.",
					requiredItems = { QuestKeyItems.ProdigalSon.FrediBeer },
					specialRequirements = {
						{ requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.canStartEscort, escort = frediEscort, requiredOutcome = true },
					},
					specialActionsOnSuccess = {
						{ action = SPECIAL_ACTIONS_UNIVERSAL.startEscort, escort = frediEscort },
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
					specialRequirements = {
						{
							requirement = SYN_MARNOTRAWNY_SPECIAL_REQUIREMENTS.frediIsNearby,
							requiredOutcome = true,
							textFailedRequirement = "Come back with Fredi.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.freezeEscortee,
							escort = frediEscort,
							despawnAfterSeconds = 10,
						},
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.despawnEscortee,
							escort = frediEscort,
							despawnAfterSeconds = 10,
						},
					},
				},
			})
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Fredi Kamionka EscortData")
		local monster = {}

		monster.name = "Fredi Kamionka"
		monster.description = "a Fredi Kamionka"
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
				if creature:getName():lower() == "arechek calm" then
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
						[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.FindPasswordAndKillImperator,
						[Storage.ProdigalSon.PolAccess] = ACCESS_GRANTED,
					},
					specialRequirements = {
						{
							requirement = SYN_MARNOTRAWNY_SPECIAL_REQUIREMENTS.frediIsNearby,
							requiredOutcome = false,
							textFailedRequirement = "Give us a moment.",
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
				gateLever:key(Storage.ProdigalSon.BlackBoardLever1)
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
						fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
					else
						Game.createItem(1717, 1, waterfallPos)
						fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
					end
					return true
				end
				waterfallLever:key(Storage.ProdigalSon.BlackBoardLever2)
				waterfallLever:register()

				local blackboardLook = Look()
				function blackboardLook.onLook(player, item)
					player:sendTextMessage(MESSAGE_LOOK, player:getStorageValueByKey(Storage.ProdigalSon.Blackboard))
					return DONT_SHOW_ONLOOK
				end
				blackboardLook:key(Storage.ProdigalSon.Blackboard)
				blackboardLook:register()
			end),
			QuestFactory.Dialog("Henry the Foreman", {
				[{ "mission" }] = {
					text = "Did you find out what is the password? What is it?",
				},
				[{ "yes", "tak" }] = {
					text = "Go and talk with Access-O-Bot in eastern part of the castle. Tell him the password, and he will let you in.",
				},
				[{ ANY_MESSAGE }] = {
					text = "Yeah, thats it! Go and get rid of our imperator!",
					specialRequirements = {
						{
							requirement = SYN_MARNOTRAWNY_SPECIAL_REQUIREMENTS.saidCorrectPassword,
							requiredOutcome = true,
							textFailedRequirement = "No. Im sure its not the password. Try looking behind the waterfall.",
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
				[{ "<password>" }] = {
					text = "Correct password. Come in.",
					specialRequirements = {
						{
							requirement = SYN_MARNOTRAWNY_SPECIAL_REQUIREMENTS.saidCorrectPassword,
							requiredOutcome = true,
							textFailedRequirement = "~BZZT~ WRONG PASSWORD. INITIATE: ERADICATION MODE.",
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

		mType:register(monster)
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.ProdigalSon.Mission06] = QuestState.ProdigalSon.Mission06.KilledImperator,
		}

		local polDeath = CreatureEvent("PolDeath")
		function polDeath.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValueByKey(Storage.ProdigalSon.Mission06)
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
						[Storage.ProdigalSon.Mission06] = MISSION_FINISHED,
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

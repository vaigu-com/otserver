local quest = Quest(LOCALIZERS.PerIustitiaAdAstra)

quest
	:Storage(function()
		Storage.PerIustitiaAdAstra = {
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			KeyItems = {
				CatalyticConverter = NextStorage(),
				EngineBlueprint = NextStorage(),
				Map1 = NextStorage(),
				Map2 = NextStorage(),
				Map3 = NextStorage(),
				FuelRod = NextStorage(),
				RocketFuel = NextStorage(),
				SwaggerCrate = NextStorage(),
				OfficerId = NextStorage(),
				HugoRecipe = NextStorage(),
				LecinaHammer = NextStorage(),
			},
			AstralJanusSpawnTile = NextStorage(),
			KuzniaAccess = NextStorage(),
			CpnDoor = NextStorage(),
			BuyFuelRodAccess = NextStorage(),
			HelpedRubelstein = NextStorage(),
			RubelsteinChecksum = NextStorage(),
			MysteriousChest = NextStorage(),
			HammerUse = NextStorage(),
			RukcaAccess = NextStorage(),
			SaltyTile = NextStorage(),
			DeeplingTile = NextStorage(),
			MovingStarTile = NextStorage(),
			ShipControl = {
				StartTravelWheel = NextStorage(),
				ChangeNextDestination = NextStorage(),
				Exit = NextStorage(),
				Enter = NextStorage(),
				Current = NextStorage(),
				Next = NextStorage(),
				FuelLevel = NextStorage(),
				FlightTimer = NextStorage(),
				RodMelter = NextStorage(),
				FuelRefillLever = NextStorage(),
			},
			ShipDestinations = {
				FuelShop = NextStorage(),
				Deeplings = NextStorage(),
				Ganymede = NextStorage(),
				HugoTarPlanet = NextStorage(),
				HugoBeachPlanet = NextStorage(),
			},
		}
		QuestState.PerIustitiaAdAstra = {
			Mission01 = {
				HeadToHighestMountain = 1,
				TalkWithAstralJanus = 2,
				FindUshaaYanForge = 3,
				CollectShipParts = 4,
				FindEnginePlansAndMaps = 5,
			},
			Mission02 = {
				BoardShipInDeeplingTemple = 1,
				LookAroundYourShip_FindSwagger = 2,
				FindSwaggerCrate = 3,
				ReturnCrateToSwagger = 4,
			},
			Mission03 = {
				InvestigateNewPlanet = 1,
				GrabKeysFromUpperRoomLocker = 2,
				BringDocumentsToRubelstein = 3,
				TalkToOfficerOnTop = 4,
				YouSavedRubelstein = 5,
				YouBetrayedRubelstein = 6,
			},
			Mission04 = {
				FindHugo = 1,
				FindHugoDrinkRecipe = 2,
				BringRecipeToHugo = 3,
				FindHammer_RepairPipes = 4,
				ReportRepairToHugo = 5,
				FindOldChest = 6,
				ReportChestToHugo = 7,
				AskHugoForMission = 8,
			},
			Mission05 = {
				FindBeachLurker = 1,
				ReportToHugo = 2,
				ReportToAstralJanus = 3,
			},
		}
		QuestTopics.PerIustitiaAdAstra = {
			AcceptJanusFirstMission = NextTopic(),
			TalkAboutRubelstein = NextTopic(),
		}
	end)
	:Constant(function()
		SpawnLocks.PerIustitiaAdAstra = {
			AstralJanus = SpawnLock(),
		}
		local penatlyRoomPos = HUGO_TAR_PLANET_ANCHOR:Moved(-12, 5, 1)

		PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS = {
			officerCaughtYou = function(context)
				local player = context.player
				if player then
					player:teleportTo(penatlyRoomPos)
					penatlyRoomPos:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
				end
			end,
		}

		QuestKeyItems.PerIustitiaAdAstra = {
			CatalyticConverter = {
				id = 21761,
				aid = Storage.PerIustitiaAdAstra.KeyItems.CatalyticConverter,
			},
			EngineBlueprint = {
				id = 2822,
				aid = Storage.PerIustitiaAdAstra.KeyItems.EngineBlueprint,
				desc = "Rocket engine blueprint. Qasim might have a use for it",
			},
			Map1 = {
				id = 2823,
				aid = Storage.PerIustitiaAdAstra.KeyItems.Map1,
				desc = "Galactic map fragment. Qasim requested three of those",
			},
			Map2 = {
				id = 2823,
				aid = Storage.PerIustitiaAdAstra.KeyItems.Map2,
				desc = "Galactic map fragment. Qasim requested three of those",
			},
			Map3 = {
				id = 2823,
				aid = Storage.PerIustitiaAdAstra.KeyItems.Map3,
				desc = "Galactic map fragment. Qasim requested three of those",
			},
			FuelRod = { id = 7752, desc = "Fissile fuel rod" },
			RocketFuel = { id = 24948, aid = Storage.PerIustitiaAdAstra.KeyItems.RocketFuel, desc = "Rocket fuel" },
			SwagierCrate = {
				id = 2471,
				aid = Storage.PerIustitiaAdAstra.KeyItems.SwaggerCrate,
				desc = "Crate of rods. Recipient: Swagger",
			},
			OfficerId = {
				id = 3507,
				text = "Name: Friedrich Knopf \nNationality: Kuuyvdoobie",
			},
			HugoRecipe = {
				id = 2815,
				aid = Storage.PerIustitiaAdAstra.KeyItems.HugoRecipe,
				desc = "Booty Sweat Lean recipe",
			},
			LecinaHammer = {
				id = 3460,
				aid = Storage.PerIustitiaAdAstra.HammerUse,
				desc = "P0W3R H4MM3R MK3. Collectible - not for professional use",
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Per Iustitia Ad Astra",
			missions = {
				[Storage.PerIustitiaAdAstra.Mission01] = {
					name = "01. Beyond the Justice",
					states = {
						[QuestState.PerIustitiaAdAstra.Mission01.HeadToHighestMountain] = "Go to the highest mountain in the Kraiby and look for someone Romek mentioned.",
						[QuestState.PerIustitiaAdAstra.Mission01.TalkWithAstralJanus] = "Astral Janus told you about a new threat. Proceed talking to gain more information.",
						[QuestState.PerIustitiaAdAstra.Mission01.FindUshaaYanForge] = "Head to the Usha'Yaan forge and find Qasim.",
						[QuestState.PerIustitiaAdAstra.Mission01.CollectShipParts] = "Collect all the starship parts mentioned by Qasim.",
						[QuestState.PerIustitiaAdAstra.Mission01.FindEnginePlansAndMaps] = "You collected ship parts requested by Qasim. Now try finding jet engine plans and three star maps.",
						[MISSION_FINISHED] = "Qasim catapulted your ship to the orbit. Try to board it through teleporting device.",
					},
				},
				[Storage.PerIustitiaAdAstra.Mission02] = {
					name = "02. Cosmo Petrol Natural",
					states = {
						[QuestState.PerIustitiaAdAstra.Mission02.BoardShipInDeeplingTemple] = "Board your ship through unlicensed teleporting device in deepling temple.",
						[QuestState.PerIustitiaAdAstra.Mission02.LookAroundYourShip_FindSwagger] = "You found a place where you can board your ship. Try too look around.",
						[QuestState.PerIustitiaAdAstra.Mission02.FindSwaggerCrate] = "Help Swagger find his lost crate. He sent information about ganymede to your ship.",
						[QuestState.PerIustitiaAdAstra.Mission02.ReturnCrateToSwagger] = "Your found Swagger crate. Return to him now.",
						[MISSION_FINISHED] = "You returned crate to Swagger.",
					},
				},
				[Storage.PerIustitiaAdAstra.Mission03] = {
					name = "03. Bobsleigh to Oven",
					states = {
						[QuestState.PerIustitiaAdAstra.Mission03.InvestigateNewPlanet] = "Swagger told you about some men transporting *REDACTED* to hugo cottage house. Investgiate that.",
						[QuestState.PerIustitiaAdAstra.Mission03.GrabKeysFromUpperRoomLocker] = "You found Rubelstein in prison cell. He asked you to grab keys from locker on upper floor.",
						[QuestState.PerIustitiaAdAstra.Mission03.BringDocumentsToRubelstein] = "You found identity document in wardrobe. Report back to rubelstein.",
						[QuestState.PerIustitiaAdAstra.Mission03.TalkToOfficerOnTop] = "Try to talk to officer on top of the tower.",
						[QuestState.PerIustitiaAdAstra.Mission03.YouSavedRubelstein] = "You talked to the officer and saved Rubelstein. Now ask Klaus about the mission.",
						[QuestState.PerIustitiaAdAstra.Mission03.YouBetrayedRubelstein] = "You talked to the officer and betrayed Rubelstein. Now ask Klaus about the mission.",
						[MISSION_FINISHED] = "Head to Hugo planet and tell him about the mission you have been assigned.",
					},
				},
				[Storage.PerIustitiaAdAstra.Mission04] = {
					name = "04. Put on the 3D glasses",
					states = {
						[QuestState.PerIustitiaAdAstra.Mission04.FindHugo] = "Find hugo on his planet and tell him about Ubefabrik plans.",
						[QuestState.PerIustitiaAdAstra.Mission04.FindHugoDrinkRecipe] = "Find Hugo recipe for his favourite drink.",
						[QuestState.PerIustitiaAdAstra.Mission04.BringRecipeToHugo] = "You found Hugo's recipe. Report back to him.",
						[QuestState.PerIustitiaAdAstra.Mission04.FindHammer_RepairPipes] = "Find hammer in Lecina shithole and repair pipe is castle sewers.",
						[QuestState.PerIustitiaAdAstra.Mission04.ReportRepairToHugo] = "You repaired the faulty sewer pipe. Report back to hugo",
						[QuestState.PerIustitiaAdAstra.Mission04.FindOldChest] = "Hugo told you to search the basement of his castle and find and open special chest.",
						[QuestState.PerIustitiaAdAstra.Mission04.ReportChestToHugo] = "You opened the magic chest. Report back to Hugo.",
						[QuestState.PerIustitiaAdAstra.Mission04.AskHugoForMission] = "Hugo told you that you can keep the experience you got from chest. Ask him for new mission.",
						[MISSION_FINISHED] = "Hugo asked you to deal with something lurking in southern beach.",
					},
				},
				[Storage.PerIustitiaAdAstra.Mission05] = {
					name = "05. I Don't Brush My Teeth. How Did You Know?",
					states = {
						[QuestState.PerIustitiaAdAstra.Mission05.FindBeachLurker] = "Hugo asked you to deal with something lurking in southern beach.",
						[QuestState.PerIustitiaAdAstra.Mission05.ReportToHugo] = "You killed the monster menacing the beach. Report to Hugo.",
						[QuestState.PerIustitiaAdAstra.Mission05.ReportToAstralJanus] = "Your job is finished. Report to Astral Janus.",
						[MISSION_FINISHED] = "You completed this chapter.",
					},
				},
			},
		}
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Ali baba door")
		local monster = {}

		monster.description = "a fire field"
		monster.experience = 0
		monster.outfit = { lookType = 305, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 500
		monster.maxHealth = 500
		monster.race = "undead"
		monster.speed = 10
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 10 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 20,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = true,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = { interval = 4999, chance = 10 }

		monster.loot = {}

		monster.attacks = {}

		monster.defenses = { defense = 25, armor = 25 }

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 100 },
			{ type = COMBAT_ICEDAMAGE, percent = 100 },
			{ type = COMBAT_HOLYDAMAGE, percent = 100 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		local toInside = USHAYAAN_FORGE_ANCHOR:Moved(0, 18, -1)
		local toOutside = USHAYAAN_FORGE_ANCHOR:Moved(0, 20, -1)

		local function isPlayerOnTeleportableTile(playerPos)
			return playerPos == toInside or playerPos == toOutside
		end

		mType.onSay = function(listener, talker, type, message)
			if message:lower() == "ali baba" then
				local listenerPos = listener:getPosition()
				local talkerPos = talker:getPosition()

				if not isPlayerOnTeleportableTile(talkerPos) then
					return
				end

				if talkerPos.y < listenerPos.y then
					talker:teleportTo(toOutside)
					toOutside:sendMagicEffect(CONST_ME_TELEPORT)
				elseif talkerPos.y > listenerPos.y then
					talker:teleportTo(toInside)
					toInside:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		end

		mType.onAppear = function(monster, creature)
			monster:setOutfit({ lookTypeEx = 470 })
		end
		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Ruk'ca Maw")
		local monster = {}

		monster.description = "a Ruk'ca Maw"
		monster.experience = 500000
		monster.outfit = {
			lookType = 364,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 120000
		monster.maxHealth = 120000
		monster.race = "blood"
		monster.corpse = 11429
		monster.speed = 400
		monster.manaCost = 0

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
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"RukcaDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -400 },
			{ name = "rukca eating", interval = 1000, chance = 100, minDamage = 0, maxDamage = 0, target = false },
			{
				name = "rukca hunger rage",
				interval = 1000,
				chance = 100,
				minDamage = -100,
				maxDamage = -300,
				target = false,
			},
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			CreatureStateRegistry:register(monster)
			local state = CreatureStateRegistry:getState(monster)
			state.rukcaIsHungry = false
			state.nextMealTime = os.time() + 10
		end

		mType.onDisappear = function(monster, creature)
			if monster == creature then
				CreatureStateRegistry:unregister(monster)
			end
		end
		mType:register(monster)
	end)
	:MonsterEvent(function()
		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
		combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
		local function tryCatchPlayers(creature)
			local currentDirection = creature:getDirection()
			local nextDirection = currentDirection
			nextDirection = nextDirection + (-1) ^ math.random(0, 1)
			nextDirection = nextDirection % 4

			creature:setDirection(nextDirection)
		end

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			tryCatchPlayers(creature)
			return combat:execute(creature, var)
		end

		spell:name("hugo house guard turn")
		spell:words(NextSpellId())
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(true)
		spell:register()

		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
		combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)

		local seeingRange = 2
		local seeingRadius = 1

		local function tryCatchPlayers(guard)
			local lookingDirection = guard:getDirection()
			local lookingVector = Vector.FromDirection(lookingDirection, seeingRange)

			local guardPos = guard:getPosition()
			local gazeCenter = guardPos:Moved(lookingVector)
			local gazeCorner1, gazeCorner2 = gazeCenter:GetBoundariesByRadius(seeingRadius)

			IterateBetweenPositions(gazeCorner1, gazeCorner2, function(context)
				local playerPos = context.pos
				local player = playerPos:GetTopCreature()
				if not (player and player:isPlayer()) then
					return
				end
				PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS.officerCaughtYou({ player = player })
			end)
		end

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			tryCatchPlayers(creature)
			return combat:execute(creature, var)
		end

		spell:name("hugo house guard scan")
		spell:words(NextSpellId())
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(true)
		spell:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Hugo House Guard")
		local monster = {}

		monster.description = "a Hugo House Guard"
		monster.experience = 0
		monster.outfit = {
			lookType = 1460,
			lookHead = 41,
			lookBody = 96,
			lookLegs = 96,
			lookFeet = 96,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 20000
		monster.maxHealth = 20000
		monster.race = "blood"
		monster.corpse = 7637
		monster.speed = 0
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 0,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = false,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
			{ name = "hugo house guard scan", interval = 1000, chance = 100, minDamage = 0, maxDamage = 0 },
			{ name = "hugo house guard turn", interval = 5000, chance = 100, minDamage = 0, maxDamage = 0 },
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
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = false },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Mission(Storage.PerIustitiaAdAstra.Mission01)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission01.HeadToHighestMountain,
		QuestFactory.Dialog("GM Romek", {
			[{ ANY_MESSAGE }] = {
				text = "As i said, go to the Caribbean.",
			},
		}),
		QuestFactory.Dialog("Astral Janus", {
			[{ GREET }] = {
				text = "Test test one two. Hello Petrus, can you hear me? What an irony... Alright, to the point: Thanks to the power of my justice and with the help of the King of Rats, Tomek, I managed to gather all the fragments of my soul back together. These fragments traveled through the endless cosmos, but I found them all and merged them. I was trapped in that state for what seemed like ages. During that time, I managed to shed my human shell. Wait... who am I?",
			},
			[{ "szczur krolow", "rat of kings" }] = {
				text = "Rat of Kings... Yes, I used to be called that. But I'm no longer the Rat of Kings. I am Astral Janus, and I have a {mission} for you!",
				nextTopic = QuestTopics.PerIustitiaAdAstra.AcceptJanusFirstMission,
			},
			[{ "mission", "misje", "misja" }] = {
				text = "Our latest target is a notorious businessman known for supporting literal fascists. He's hiding in one of his bases in space. You won't be able to reach him by conventional means, so you can start by going to the Usha'Yaan Forge. They specialize in manufacturing various spacecraft-like products.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.TalkWithAstralJanus,
				},
				requiredTopic = QuestTopics.PerIustitiaAdAstra.AcceptJanusFirstMission,
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 7320, 1477, 0 }, id = 2000, aid = Storage.PerIustitiaAdAstra.AstralJanusSpawnTile },
		}),
		QuestFactory.Script(function(missionState)
			--local astralJanus = { name = "", pos = Position(5839, 790, 0) }
			local astralJanusPos = Position(7320, 1475, 0)
			local astralJanusLock = SpawnLocks.PerIustitiaAdAstra.AstralJanus

			local astralJanus = {}
			local tileIn = MoveEvent()
			function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				local mission01State = player:getStorageValue(Storage.PerIustitiaAdAstra.Mission01)
				local mission05State = player:getStorageValue(Storage.PerIustitiaAdAstra.Mission05)

				if mission01State == -MISSION_NOT_STARTED then
					return false
				end
				if mission01State > QuestState.PerIustitiaAdAstra.Mission01.CollectShipParts and mission05State < QuestState.PerIustitiaAdAstra.Mission05.ReportToAstralJanus then
					return false
				end
				if mission05State == MISSION_FINISHED then
					return false
				end

				if astralJanusLock:IsSet() then
					return
				end
				astralJanus = Game.createNpc("Astral Janus", astralJanusPos, false, false)
				astralJanusLock:Set()
			end

			tileIn:aid(Storage.PerIustitiaAdAstra.AstralJanusSpawnTile)
			tileIn:register()

			local tileOut = MoveEvent()

			function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end
				if astralJanusLock:IsSet() then
					astralJanus:remove()
					astralJanusLock:Reset()
				end
			end

			tileOut:aid(Storage.PerIustitiaAdAstra.AstralJanusSpawnTile)
			tileOut:register()
		end)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission01.TalkWithAstralJanus,
		QuestFactory.Dialog("Astral Janus", {
			[{ "mission", "misja" }] = {
				text = "The Usha'Yaan Forge located in the deepest chasms in the dwarven caves on Hurghada. To gain access to the forge, you need to know a special {codeword} and recite it in ancient dwarven just outside the entrance on the third Sunday of the leap year. Although I'm not entirely sure about the last requirements. Inside, you'll find Qasim the blacksmith, who will tell you how to craft a new spaceship.",
			},
			[{ "codeword", "haslo", "password" }] = {
				text = "Qasim, also known to many as Cassim, once had a younger brother, who, against his wishes, tried to enter the Usha'Yaan Forge. He didn't know the password when he was near the sealed doors. Suddenly, an opportunity arose - he overheard his brother and a few accomplices heading for the forge. He hid behind nearby rocks, right by the lava lake. Everyone there is accustomed to high temperatures, so the position he found himself in wasn't too uncomfortable. Eventually, he managed to eavesdrop on the password. And the password is... Well, all I know is that his younger brother now was one of the only people who know this password.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.FindUshaaYanForge,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission01.FindUshaaYanForge,
		QuestFactory.Dialog("Astral Janus", {
			[{ "name", "imie", "mission", "misja" }] = {
				text = "I can't really remember his name.. I think it was something like Al..?",
			},
			[{ "ali baba" }] = {
				text = "Yes! That what his name exactly.",
			},
		}),
		QuestFactory.Dialog("Ali Baba", {
			[{ "qasim", "cassim", "mission", "misja", "password", "haslo" }] = {
				text = "So you would like to know the password? I can {reveal} it for a small fee of 3 transferable coins. I really need that gold converter..",
			},
			[{ "reveal", "sprzedac" }] = {
				text = "The password is 'Ali Baba', same as my name. Hope this helps.",
				specialConditions = {
					{
						condition = SPECIAL_CONDITIONS_UNIVERSAL.hasTransferableCoins,
						requiredOutcome = true,
						coins = 15,
						textNoRequiredCondition = "Come back with 15 coins.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.removeTransferableCoins, coins = 3 },
				},
			},
		}),
		QuestFactory.Dialog("Qasim", {
			[{ "mission" }] = {
				text = "This will be one of the largest {orders} I've ever received during my life. I'll be able to start working on this project right away.",
			},
			[{ "orders", "zamowien" }] = {
				text = "Start by gathering the materials needed to build the spaceship: 20 Gear Wheels, 3 Huge Chunks of Crude Iron, 1 {Glooth Converter}, 3 Gold Ingots, 1 Spark Sphere, 50 Wood, 5 Gearwheel Chains.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.CollectShipParts,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission01.CollectShipParts,
		QuestFactory.StartupItems({
			{
				pos = { 5650, 1165, 13 },
				id = 16182,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.CatalyticConverter,
				rewards = {
					QuestKeyItems.PerIustitiaAdAstra.CatalyticConverter,
				},
			},
		}),
		QuestFactory.Dialog("Qasim", {
			[{ "Glooth Converter" }] = {
				text = "Finding such a device won't be easy. It's possible it will be where Glooth creatures are created. Try your luck in the underground swamps.",
			},
			[{ "mission" }] = {
				text = "Good job. I'm getting ready to work on the spaceship. In the meantime, I suggest you start looking for star maps. You'll need them for navigation in space. You'll probably find some map pieces in the city of Bydgoschch, Maioorka. I heard rumors about some witches hiding their map in the ruined chapel, south of maioorka. I think three pieces should be enough for starters. You should also find rocket engine plans. They fell into the hands of the mysterious magician, who allied with outlaws on the north east from Maioor'ka. Now he refuses to share this piece crucial piece. You'll need to acquire both the maps and the engine blueprint for me so I can properly install the rocket propulsion in your vehicle.",
				requiredItems = {
					{ id = 8775, count = 20 },
					{ id = 5892, count = 3 },
					QuestKeyItems.PerIustitiaAdAstra.CatalyticConverter,
					{ id = 9058, count = 3 },
					{ id = 23518, count = 1 },
					{ id = 5901, count = 50 },
					{ id = 21170, count = 5 },
				},
				textNoRequiredItems = "As I said, I need: 20 Gear Wheels, 3 Huge Chunks of Crude Iron, 1 {Glooth Converter}, 3 Gold Ingots, 1 Spark Sphere, 50 Wood, 5 Gearwheel Chains.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.FindEnginePlansAndMaps,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission01.FindEnginePlansAndMaps,
		QuestFactory.StartupItems({
			{
				position = Position(7611, 1065, 6),
				id = 853,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.EngineBlueprint,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.EngineBlueprint },
			},
			{
				position = Position(7957, 1517, 4),
				id = 2438,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.Map1,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.Map1 },
			},
			{
				position = Position(7321, 1269, 5),
				id = 6367,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.Map2,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.Map2 },
			},
			{
				position = Position(7302, 1086, 7),
				id = 2435,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.Map3,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.Map3 },
			},
		}),
		QuestFactory.Dialog("Qasim", {
			[{ "mission" }] = {
				text = "Alright, that's everything I needed. I'll send your spaceship into orbit with a special catapult shortly. I'd have you sit inside it right now, but it's too dangerous. You'll be able to access it through the unlicensed teleporter in the deepling base. Besides, I found this item in my warehouse. If I remember correctly, it's one of the components of rocket fuel. You can produce the fuel by using an atomic splitter on the fuel rod. I've placed this device on your spaceship. You'll also find a remote depot there. I think it will come in handy.",
				requiredItems = {
					QuestKeyItems.PerIustitiaAdAstra.Map1,
					QuestKeyItems.PerIustitiaAdAstra.Map2,
					QuestKeyItems.PerIustitiaAdAstra.Map3,
					QuestKeyItems.PerIustitiaAdAstra.EngineBlueprint,
				},
				textNoRequiredItems = "I'll need engine blueprints. Also, you'll need to have some basic knowledge of astronomy, so have three sky map pieces with you. Without them, you won't get far.",
				rewards = { QuestKeyItems.PerIustitiaAdAstra.FuelRod },
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission01] = MISSION_FINISHED,
					[Storage.PerIustitiaAdAstra.Mission02] = QuestState.PerIustitiaAdAstra.Mission02.BoardShipInDeeplingTemple,
					[Storage.PerIustitiaAdAstra.ShipControl.FuelLevel] = 0,
					[Storage.PerIustitiaAdAstra.ShipControl.Current] = Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings,
					[Storage.PerIustitiaAdAstra.ShipControl.Next] = Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings,
				},
			},
		})

end
)	:Mission(Storage.PerIustitiaAdAstra.Mission02)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission02.BoardShipInDeeplingTemple,
		QuestFactory.Dialog("Qasim", {
			[{ "mission" }] = {
				text = "Flights within a given system require only the power of mana. For intergalactic travel, you'll need rocket fuel. Therefore, you'll need to find a refueling station that sells such fuel. I've included the coordinates of a CPN-sponsored one in the ship's navigation. Good luck!",
			},
		}),
		QuestFactory.StartupItems({
			{ position = DEEPLING_TEMPLE_ANCHOR, id = 8279, aid = Storage.PerIustitiaAdAstra.DeeplingTile },
			{ position = DEEPLING_TEMPLE_ANCHOR:Moved(0, -1, 0), id = 8282, actionid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = FUEL_SHOP_ANCHOR:Moved(-2, 0, 0), id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = GANYMEDE_ANCHOR:Moved(3, 2, 0), id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = HUGO_TAR_PLANET_ANCHOR:Moved(-27, -62, -2), id = 8282, actionid = Storage.PerIustitiaAdAstra.ShipControl.Enter },

			{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -39, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(-4, -35, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(4, -35, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
			{ position = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -30, -5), id = 15469, aid = Storage.PerIustitiaAdAstra.ShipControl.Enter },
		}),
		QuestFactory.StartupItems({
			{ pos = { 17, 6, -1 }, id = 8282, aid = Storage.PerIustitiaAdAstra.ShipControl.Exit },
			{ pos = { 23, 8, -1 }, id = 20788, aid = Storage.PerIustitiaAdAstra.ShipControl.StartTravelWheel },
			{ pos = { 20, 6, -1 }, id = 752, actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination },
			{ pos = { 21, 6, -1 }, id = 753, actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination },
			{ pos = { 21, 6, -1 }, id = 752, actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination },
			{ pos = { 22, 6, -1 }, id = 753, actionid = Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination },
			{ pos = { 12, 5, -2 }, id = 21125, aid = Storage.PerIustitiaAdAstra.ShipControl.FuelRefillLever },
			{ pos = { 16, 10, -1 }, id = 19389, aid = Storage.PerIustitiaAdAstra.ShipControl.RodMelter },
		}, STARSHIP_ANCHOR),

		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.PerIustitiaAdAstra.Mission02] = QuestState.PerIustitiaAdAstra.Mission02.LookAroundYourShip_FindSwagger,
				[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = ACCESS_GRANTED,
				[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = ACCESS_GRANTED,
			}

			local deeplingTile = MoveEvent()
			function deeplingTile.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				if player:getStorageValue(Storage.PerIustitiaAdAstra.Mission01) == 6 then
					player:NextState(updateStorages)
				end
			end

			deeplingTile:aid(Storage.PerIustitiaAdAstra.DeeplingTile)
			deeplingTile:register()
		end),
		QuestFactory.Script(function(missionState)
			local shipPos = STARSHIP_ANCHOR:Moved(15, 6, -1)

			local blockage = {}

			local function removeBlockage(position)
				for _, item in pairs(blockage[position:ToString()]) do
					item:remove()
				end
				blockage = {}
			end

			local function spawnBlockage(centerPos)
				local posString = centerPos:ToString()
				blockage[posString] = {}
				for i = -1, 1 do
					for j = -1, 1 do
						local item = Game.createItem(2187, 1, centerPos:Moved(i, j, 0))
						table.insert(blockage[posString], item)
					end
				end
			end

			local function sendShipEnterCountdown(player)
				for i = 1, 3 do
					addEvent(function()
						if player then
							player:say(4 - i, TALKTYPE_MONSTER_SAY)
						end
					end, i * 1000)
				end
			end

			local enterShipTile = MoveEvent()
			function enterShipTile.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				if player:getStorageValue(Storage.PerIustitiaAdAstra.Mission01) < 7 then
					return false
				end

				sendShipEnterCountdown(player)

				spawnBlockage(toPosition)
				addEvent(function()
					if player then
						player:teleportTo(shipPos)
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
						toPosition:sendMagicEffect(CONST_ME_POFF)
					end
					removeBlockage(toPosition)
				end, 4000)
			end

			enterShipTile:aid(Storage.PerIustitiaAdAstra.ShipControl.Enter)
			enterShipTile:register()
		end),
		QuestFactory.Script(function(missionState)
			local Monitor = Action()
			function Monitor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				if not player:TryTradeInItems({ QuestKeyItems.PerIustitiaAdAstra.FuelRod }, { QuestKeyItems.PerIustitiaAdAstra.RocketFuel }) then
					player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("You don't have any fuel rods."), TALKTYPE_MONSTER_SAY)
					return
				end

				player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("Rod synthesis successful."), TALKTYPE_MONSTER_SAY)

				return true
			end

			Monitor:aid(Storage.PerIustitiaAdAstra.ShipControl.RodMelter)
			Monitor:register()
		end),
		QuestFactory.Script(function(missionState)
			local function refillFuel(player)
				local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
				player:IncrementStorage(fuelStorage)
			end

			local function sendFuelStatus(player)
				local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
				local fuelLevel = player:getStorageValue(fuelStorage)
				player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("Current fuel tank status: ") .. fuelLevel, TALKTYPE_MONSTER_SAY)
			end

			local valve = Action()
			function valve.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				if not player:TryRemoveItems({ QuestKeyItems.PerIustitiaAdAstra.RocketFuel }) then
					player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("You dont have any fuel."), TALKTYPE_MONSTER_SAY)
					sendFuelStatus(player)
					return
				end

				player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("You refilled the fuel tank."), TALKTYPE_MONSTER_SAY)
				refillFuel(player)
				sendFuelStatus(player)

				local trickle = Game.createItem(5662, 1, item:getPosition():Moved(2, 2, 0))
				addEvent(function()
					trickle:remove()
				end, 1000)
				return true
			end

			valve:aid(Storage.PerIustitiaAdAstra.ShipControl.FuelRefillLever)
			valve:register()

			local fuel = Action()
			function fuel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				return false
			end

			fuel:aid(Storage.PerIustitiaAdAstra.KeyItems.RocketFuel)
			fuel:register()
		end),
		QuestFactory.Script(function(missionState)
			local aidToDestName = {
				[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = "ShipDestCpn",
				[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = "ShipDestDeepling",
				[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = "ShipDestGanymede",
				[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = "ShipDestHugoTarPlanet",
				[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = "ShipDestHugoBeachPlanet",
			}

			local destinationStorageToPosition = {
				[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = FUEL_SHOP_ANCHOR:Moved(2, 0, 0),
				[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = DEEPLING_TEMPLE_ANCHOR:Moved(0, 1, 0),
				[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = GANYMEDE_ANCHOR:Moved(-3, 0, 0),
				[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = HUGO_TAR_PLANET_ANCHOR:Moved(-24, -62, -2),
				[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -35, -5),
			}

			local function getDestination(aid)
				local toPos = destinationStorageToPosition[aid]
				if not toPos then
					return false
				end
				return toPos
			end

			local exitDevice = MoveEvent()

			function exitDevice.onStepIn(player, _, _, _)
				if not player:isPlayer() then
					return false
				end

				local aid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current)
				local toPos = getDestination(aid)
				if not toPos then
					return
				end

				player:teleportTo(toPos)
				toPos:sendMagicEffect(CONST_ME_TELEPORT)
			end

			exitDevice:aid(Storage.PerIustitiaAdAstra.ShipControl.Exit)
			exitDevice:register()

			local function hasUnlockedDestination(player, destinationStorage)
				if player:getStorageValue(destinationStorage) ~= -1 then
					return true
				end
				return false
			end

			local manaCostPercentage = 0.4
			local maxManaCostFlat = 1000
			local function errorIfCannotChargeForTravel(player, aid)
				if aid == Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop or aid == Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede then
					local manaCostFlat = manaCostPercentage * player:getMaxMana()
					if manaCostFlat > maxManaCostFlat then
						manaCostFlat = maxManaCostFlat
					end

					if player:getMana() < manaCostFlat then
						return false, player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipCantAffordMana")
					end
					player:addMana(-manaCostFlat)
					return true
				end

				local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
				if player:getStorageValue(fuelStorage) < 1 then
					return false, player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipCantAffordFuel")
				end
				player:IncrementStorage(fuelStorage, -1)
				return true
			end

			local confirmChoice = function(player, button, choice)
				if not choice then
					return true
				end
				player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next, choice.aid)
				player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipLocationLocked") .. choice.text, TALKTYPE_MONSTER_SAY)
			end

			local nextDestinationSetter = Action()
			function nextDestinationSetter.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				local title = player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipTitle")
				local message = player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipMessage")

				local window = ModalWindow({ title = title, message = message })

				local nextDestAid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
				for aid in pairs(destinationStorageToPosition) do
					if hasUnlockedDestination(player, aid) then
						local transaltedText = player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get(aidToDestName[aid])
						if aid == nextDestAid then
							transaltedText = "* " .. transaltedText .. " *"
						end
						local choice = window:addChoice(transaltedText)
						choice.aid = aid
					end
				end

				window:addButton(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipOk"), confirmChoice)

				window:sendToPlayer(player)
				return true
			end

			nextDestinationSetter:aid(Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination)
			nextDestinationSetter:register()

			local starshipXsize = 37
			local starshipYsize = 18
			local mainShipCorners = {
				topLeft = Position(STARSHIP_ANCHOR),
				downRight = Position(STARSHIP_ANCHOR:Moved(starshipXsize - 1, starshipYsize - 1, 0)),
			}

			local starshipsOffset = 26
			local baseSpeed = 100
			local baseDelay = 500 * 70 / 100
			local movingStars = {
				topLeft = mainShipCorners.topLeft:Moved(1, -starshipsOffset * 1, 0),
				downRight = mainShipCorners.downRight:Moved(0, -starshipsOffset * 1, 0),
				rate = 0.5,
				stars = {},
			}

			local randomStarsParams = { { id = 0, weight = 99 }, { id = 3249, weight = 1 } }
			local randomToStarId = {}

			local function initializeStarIdWeights()
				local sumSoFar = 1
				for _, starParams in pairs(randomStarsParams) do
					for _ = 1, starParams.weight do
						randomToStarId[sumSoFar] = starParams.id
						sumSoFar = sumSoFar + 1
					end
					sumSoFar = starParams.weight
				end
			end

			local currentMoveToLoopId = 0
			local flightTimerLoopStarted = false

			local function moveToLoop(topLeft, downRight, delay, stars, moveToLoopId)
				if currentMoveToLoopId ~= moveToLoopId then
					return
				end
				if not flightTimerLoopStarted then
					return
				end
				for _, monster in pairs(stars) do
					monster:move(DIRECTION_WEST)
				end
				addEvent(function()
					moveToLoop(topLeft, downRight, delay, stars, moveToLoopId)
				end, delay)
			end

			local function flightTimerLoop()
				if os.time() > getGlobalStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer) then
					flightTimerLoopStarted = false
					return
				end
				addEvent(function()
					flightTimerLoop()
				end, 1000)
			end

			local function tryStartFlightTimerLoop()
				if flightTimerLoopStarted then
					return
				end
				currentMoveToLoopId = currentMoveToLoopId + 1
				flightTimerLoopStarted = true
				flightTimerLoop()
				moveToLoop(movingStars.topleft, movingStars.downRight, movingStars.delay, movingStars.stars, currentMoveToLoopId)
			end

			local function getRandomStarId()
				return randomToStarId[math.random(1, #randomToStarId)]
			end

			local function clearOldStars()
				IterateBetweenPositions(movingStars.topLeft, movingStars.downRight, function(context)
					local i = 1
					local pos = context.pos
					local starMonsterOld = pos:GetTopCreature()
					while starMonsterOld and i < 5 do
						if starMonsterOld then
							starMonsterOld:remove()
						else
							return
						end
						starMonsterOld = pos:GetTopCreature()
						i = i + 1
					end
				end)
				movingStars.stars = {}
			end

			local function initializeStarMonsters()
				movingStars.delay = baseDelay / movingStars.rate
				movingStars.speed = baseSpeed * movingStars.rate
				IterateBetweenPositions(movingStars.topLeft, movingStars.downRight, function(context)
					local itemId = getRandomStarId()
					if itemId ~= 0 then
						local pos = context.pos
						local starMonster = Game.createMonster("Moving Star", pos)
						table.insert(movingStars.stars, starMonster)
						starMonster:setSpeed(movingStars.speed)
						doSetItemOutfit(starMonster, itemId, 24 * 60 * 60 * 1000)
					end
				end)
				currentMoveToLoopId = 0
			end

			local starsInitialized = false
			local function tryInitializeStars()
				if starsInitialized then
					return false
				end
				starsInitialized = true
				initializeStarIdWeights()
				clearOldStars()
				initializeStarMonsters()
			end

			local travelTime = 12 * 1000
			local function startTravel(player)
				player:teleportTo(player:getPosition():Moved(0, -starshipsOffset, 0))
				addEvent(function()
					player:teleportTo(player:getPosition():Moved(0, starshipsOffset, 0))
				end, travelTime)
			end

			local shipWheel = Action()
			function shipWheel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				local shipNextStorageValue = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
				local shipCurrentStorageValue = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current)
				if shipNextStorageValue == shipCurrentStorageValue then
					player:say(player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipAlreadyAtDestination"), TALKTYPE_MONSTER_SAY)
					return true
				end

				local success, chargingErrorMessage = errorIfCannotChargeForTravel(player, shipNextStorageValue)
				if not success then
					player:say(chargingErrorMessage, TALKTYPE_MONSTER_SAY)
					return false
				end

				tryInitializeStars()

				local nextDestAid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
				setGlobalStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer, os.time() + travelTime / 1000)
				player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer, os.time() + travelTime / 1000)
				player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current, nextDestAid)
				tryStartFlightTimerLoop()
				startTravel(player)

				local transaltedString = player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get("ShipJustStartedTravel")
				local nextName = aidToDestName[nextDestAid]
				local translatedName = player:Localizer(LOCALIZERS.PerIustitiaAdAstra):Get(nextName)
				player:say(transaltedString .. translatedName, TALKTYPE_MONSTER_SAY)
				return true
			end

			shipWheel:aid(Storage.PerIustitiaAdAstra.ShipControl.StartTravelWheel)
			shipWheel:register()
		end)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission02.LookAroundYourShip_FindSwagger,
		QuestFactory.Dialog("Swagger", {
			[{ "fuel", "paliwo", "mission" }] = {
				text = "Do you need fuel? Of course - I sell ready-to-use rocket fuel. The current {exchange rate} is 50,000 crystal coins for 100 liters.",
			},
			[{ "rates", "przelicznik", "exchange rate" }] = {
				text = "If my fuel prices don't suit you, I can sell you a {raw} fuel rod instead.",
			},
			[{ "raw", "surowy" }] = {
				text = "Wait a moment, these rods were stolen from me recently by some clever thieves. I think they were flying towards Ganymede moon. That place is known for its numerous mountain peaks. Most of the mountains and rocks are too dangerous and steep to hide in. The bandits hide in the valleys of the Vaux Maich mountains. I've sent the moon's location to your ship.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission02] = QuestState.PerIustitiaAdAstra.Mission02.FindSwaggerCrate,
					[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = ACCESS_GRANTED,
				},
			},
		}),
		QuestFactory.Script(function(missionState)
			local leftDoorPos = FUEL_SHOP_ANCHOR:Moved(-1, -19, 0)

			local closedDoor = { [14159] = { 0, 0, 0 }, [20435] = { 0, 0, 0 }, [1612] = { 0, 0, 0 }, [20429] = { 0, 1, 0 } }

			local noDoors = 2

			local function openCloseDoor(close, door)
				local show = close and -1 or 0
				local hide = close and 0 or -1
				for i = 0, noDoors - 1 do
					for id, offset in pairs(door) do
						local origin = leftDoorPos:Moved(offset):Moved(i, 0, show)
						local destination = leftDoorPos:Moved(offset):Moved(i, 0, hide)
						local item = Tile(origin):getItemById(id)
						if not item then
							return
						end
						item:moveTo(destination)
					end
				end
			end

			local doorCurentlyOpening = false

			local openingTime

			local function tryCloseDoor()
				if os.clock() > openingTime then
					doorCurentlyOpening = false
					openCloseDoor(true, closedDoor)
				else
					addEvent(function()
						tryCloseDoor()
					end, 1000)
				end
			end

			local beforeCpnDoor = MoveEvent()
			function beforeCpnDoor.onStepIn(player, _, _, _)
				openingTime = os.clock() + 4
				if doorCurentlyOpening then
					return
				end
				doorCurentlyOpening = true

				openCloseDoor(false, closedDoor)
				tryCloseDoor()
			end

			beforeCpnDoor:aid(Storage.PerIustitiaAdAstra.CpnDoor)
			beforeCpnDoor:register()
		end)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission02.FindSwaggerCrate,
		QuestFactory.Dialog("Swagger", {
			[{ ANY_MESSAGE }] = {
				text = "I don't know what kind of gigachads those thieves must have been to move a crate of that weight.",
			},
		}),
		QuestFactory.StartupItems({
			{
				pos = { 6, 92, 0 },
				id = 11810,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.SwaggerCrate,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.SwagierCrate },
				nextState = { [Storage.PerIustitiaAdAstra.Mission02] = QuestState.PerIustitiaAdAstra.Mission02.ReturnCrateToSwagger },
			},
		}, GANYMEDE_ANCHOR)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission02.ReturnCrateToSwagger,
		QuestFactory.Dialog("Swagger", {
			[{ "mission" }] = {
				text = "Thanks for your help. In return, I can give you one rod. Be careful; they're very heavy! I can sell you more rods for a small fee of 1000 gp each. One more thing: recently, Sad Gentlemen turned up at my station. From an overheard conversation, I learned that they're involved in transporting REDACTED to Hugo Boss's summer cottage.",
				requiredItems = {
					QuestKeyItems.PerIustitiaAdAstra.SwagierCrate,
				},
				rewards = { QuestKeyItems.PerIustitiaAdAstra.FuelRod },
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission02] = MISSION_FINISHED,
					[Storage.PerIustitiaAdAstra.Mission03] = QuestState.PerIustitiaAdAstra.Mission03.InvestigateNewPlanet,
					[Storage.PerIustitiaAdAstra.BuyFuelRodAccess] = ACCESS_GRANTED,
					[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = ACCESS_GRANTED,
				},
			},
		})

end
)	:Mission(Storage.PerIustitiaAdAstra.BuyFuelRodAccess)
:State(
function()
return 
		ACCESS_GRANTED,
		QuestFactory.Dialog("Swagger", {
			[{ "fuel", "rod", "paliwo", "pret" }] = {
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.openTradeWindow },
				},
			},
		})

end
)	:Mission(Storage.PerIustitiaAdAstra.Mission03)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission03.InvestigateNewPlanet,
		QuestFactory.Dialog("Rubelstein", {
			[{ GREET }] = {
				text = "Boss, can you spare something to eat? Maybe I could have some {spam} from your inbox?",
			},
			[{ "spam" }] = {
				text = "Thanks, I feel better now. I see you managed to escape from the leather traders' prison. If you want to help me get out of here, I suggest you go to the coachman's room and find something that might be useful to me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission03.GrabKeysFromUpperRoomLocker,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission03.GrabKeysFromUpperRoomLocker,
		QuestFactory.Dialog("Rubelstein", {
			[{ "mission" }] = {
				text = "Go to the coachman's room now. There are probably various keys and uniforms stored there. It's on the upper floors of this building.",
			},
		}),
		QuestFactory.StartupItems({
			{
				pos = { -39, -17, -2 },
				id = 17355,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.OfficerId,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.OfficerId },
				nextState = { [Storage.PerIustitiaAdAstra.Mission05] = QuestState.PerIustitiaAdAstra.Mission03.BringDocumentsToRubelstein },
			},
		}, HUGO_TAR_PLANET_ANCHOR)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission03.BringDocumentsToRubelstein,
		QuestFactory.Dialog("Rubelstein", {
			[{ "mission" }] = {
				text = "So, one of the soldiers left their ID document in the dressing room... Maybe you can use that information to convince the main {guard} to release me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission03] = QuestState.PerIustitiaAdAstra.Mission03.TalkToOfficerOnTop,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission03.TalkToOfficerOnTop,
		QuestFactory.Dialog("Rubelstein", {
			[{ "straznika", "guard", "mission" }] = {
				text = "Head to the second building on this planet. The main guard, Klaus Schwab, likes to get some fresh air at the top of the tower. Try to negotiate my release with him. Oh, and watch out for the other guards. They won't be as understanding if they see someone in civilian clothes. Also you should only talk to Knopf in his own language, otherwise he will see though charade.",
			},
		}),
		QuestFactory.Dialog("Klaus Schwab", {
			[{ GREET }] = { text = "Identifiziere dich, Soldat!" },
			[{ "Friedrich Knopf", "friedrich knopf" }] = {
				text = "Lieutenant, warum ist deine Nase so klein? Dennoch. Haben wir einen Hinrichtungsbefehl auf Rubelstein bestatigt?",
				nextTopic = QuestTopics.PerIustitiaAdAstra.TalkAboutRubelstein,
			},
			[{ "yes", "no", "tak", "nie", "mission" }] = {
				text = "Eine kleine Betruger... Wachen, zu den Waffen!",
				specialActionsOnSuccess = {
					{
						action = PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS.officerCaughtYou,
					},
				},
			},
			[{ "ja", "jawohl", "doch" }] = {
				text = "Wir werden ihn hinrichten lassen. Vielen Dank fur Ihre Zusammenarbeit. Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
				requiredTopic = QuestTopics.PerIustitiaAdAstra.TalkAboutRubelstein,
				expReward = 600 * 1000,
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission03.YouBetrayedRubelstein,
				},
			},
			[{ "nein", "kein", "nicht", "nee", "nich" }] = {
				text = "Alles in Ordnung, obwohl wir vor einigen Tagen einen Sicherheitsverstoss hatten und den Fluchtigen immer noch nicht finden konnen. Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
				requiredTopic = QuestTopics.PerIustitiaAdAstra.TalkAboutRubelstein,
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission03.YouSavedRubelstein,
					[Storage.PerIustitiaAdAstra.HelpedRubelstein] = ACCESS_GRANTED,
				},
			},
		})

end
):State(
function()
return 
		{
			min = QuestState.PerIustitiaAdAstra.Mission03.YouSavedRubelstein,
			max = QuestState.PerIustitiaAdAstra.Mission03.YouBetrayedRubelstein,
		},
		QuestFactory.Dialog("Klaus Schwab", {
			[{ GREET }] = {
				text = "Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
			},
			[{ "mission", "Mission" }] = {
				text = "Uberbringe diese Information an Hugo Boss in seiner Zentrale: 'Wir haben einen Bauplan fur eine experimentelle {Uberfabrik} entwickelt'.",
			},
			[{ "uberfabrik", "Uberfabrik" }] = {
				text = "Ich habe den Ort des Hugo Boss-Hauptquartiers an Ihr Schiff geschickt.",
				nextState = {
					[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = ACCESS_GRANTED,
					[Storage.PerIustitiaAdAstra.Mission03] = MISSION_FINISHED,
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.FindHugo,
				},
			},
		})

end
)	:Mission(Storage.PerIustitiaAdAstra.Mission04)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.FindHugo,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ GREET }] = { text = "Guten tag. Was hast du zu sagen?" },
			[{ ANY_MESSAGE }] = {
				text = "I'll tell you that your German is terrible. I served with Friedrich Knopf, i knew Friedrich Knopf, Friedrich Knopf was a friend of mine. My dear, are not Friedrich Knopf. So what are you looking for here?",
			},
			[{ "uberfabrik" }] = {
				text = "So you stole the identity of one of my employees to work for me? I hire anyone anyway. Alright, I have a first task for you: the new bartender doesn't know how to make my favorite drink. Find my recipe for 'Booty Sweat Lean' so he knows exactly what ingredients to use. You'll find a chest with recipes on the top floor of the library. Just photocopy the recipe and come back to me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.FindHugoDrinkRecipe,
				},
				requiredItems = {
					QuestKeyItems.PerIustitiaAdAstra.OfficerId,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.FindHugoDrinkRecipe,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "Unfortunately, I lost the key to the library. I'm afraid you'll have to find another way to get upstairs and find that {recipe}. Maybe try being a Spider-Man.",
			},
		}),
		QuestFactory.StartupItems({
			{
				pos = { 20, -84, -6 },
				id = 2482,
				actionid = Storage.PerIustitiaAdAstra.KeyItems.HugoRecipe,
				rewards = { QuestKeyItems.PerIustitiaAdAstra.HugoRecipe },
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.BringRecipeToHugo,
				},
			},
		}, HUGO_BEACH_PLANET_ANCHOR)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.BringRecipeToHugo,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "przepis", "recipe", "mission" }] = {
				text = "Very well done! I have another task for you. You've probably noticed that the castle is overrun by partygoers. They're no nobles, so they don't know how to behave. They recently damaged part of the castle in the east wing. I hired no one other than Boguslaw Lecina to repair it. Now, not only do I have a damaged wall, but there are also grooves from the sanding. Or maybe it's just residue from his cigarettes that settled on the wall? It's not important. Find his toolbox and take one hammer from it. Then go to the waterworks and loosen the valve in the lower part. There's so much mess and I dont even know what else, that we can't flush corpses down the toilet anymore.",
				requiredItems = { QuestKeyItems.PerIustitiaAdAstra.HugoRecipe },
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.FindHammer_RepairPipes,
				},
				textNoRequiredItems = "Come back when you've obtained the recipe for my favorite drink.",
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.FindHammer_RepairPipes,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "I have another task for you. You've probably noticed that the castle is overrun by partygoers. They're no nobles, so they don't know how to behave. They recently damaged part of the castle in the east wing. I hired no one other than Boguslaw Lecina to repair it. Now, not only do I have a damaged wall, but there are also grooves from the sanding. Or maybe it's just residue from his cigarettes that settled on the wall? It's not important. Find his toolbox and take one hammer from it. Then go to the waterworks and loosen the valve in the lower part. There's so much mess and I dont even know what else, that we can't flush corpses down the toilet anymore.",
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 17, -68, -5 }, id = 30304, actionid = Storage.PerIustitiaAdAstra.KeyItems.LecinaHammer, rewards = { QuestKeyItems.PerIustitiaAdAstra.LecinaHammer } },
			{ pos = { -10, -133, 6 }, id = 20787, aid = Storage.PerIustitiaAdAstra.HammerUse },
		}, HUGO_BEACH_PLANET_ANCHOR),
		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.ReportRepairToHugo,
			}

			local hammerId = QuestKeyItems.PerIustitiaAdAstra.LecinaHammer.id
			local pipeId = 20787

			local item = Action()
			function item.onUse(player, hammer, fromPosition, pipe, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end
				if hammer:getId() ~= hammerId then
					return false
				end

				if pipe:getId() ~= pipeId then
					return false
				end

				if pipe:getActionId() ~= hammer:getActionId() then
					return false
				end

				if player:getStorageValue(Storage.PerIustitiaAdAstra.Mission01) ~= 20 then
					return false
				end

				pipe:getPosition():sendMagicEffect(CONST_ME_POFF)
				player:NextState(updateStorages)
				hammer:remove()
				return true
			end

			item:aid(Storage.PerIustitiaAdAstra.HammerUse)
			item:register()
		end)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.ReportRepairToHugo,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ GREET }] = {
				text = "You did well. Listen, there's a very old room in the castle's basement, and inside it, there's an even older chest. One of my great-grandfathers left it there. The chest is enchanted, so it can't be opened just like that. I think it will open on its own if you solve the riddle. If you manage to open it, come back to me and report what you found inside.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.FindOldChest,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.FindOldChest,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "My great-grandmother, a witch, once mentioned that to open the chest, I would need some runes. I don't know anything about magic, so I can't help you with that.",
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 16, -78, 2 }, id = 2472, aid = Storage.PerIustitiaAdAstra.MysteriousChest },
		}, HUGO_BEACH_PLANET_ANCHOR),
		QuestFactory.Script(function(missionState)
			local runeId = 3164
			local failDmg = 500

			local function canOpenChest(player, toPosition)
				if player:getStorageValue(Storage.PerIustitiaAdAstra.Mission01) ~= 22 then
					return false
				end

				local runePos = toPosition:Moved(2, 0, 0)
				local rune = Tile(runePos):getItemById(runeId)
				if not rune then
					return false
				end

				runePos:sendMagicEffect(CONST_ME_POFF)
				rune:remove()
				return true
			end

			local nextState = {
				[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.ReportChestToHugo,
			}

			local mysteriousChest = Action()
			function mysteriousChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				if not canOpenChest(player, toPosition) then
					doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -failDmg, -failDmg, CONST_ME_LOSEENERGY)
					Game.createMonster("Old Giant Spider", fromPosition)
					return false
				end

				player:NextState(nextState)
				player:addExperience(250 * 1000, true)
				player:getPosition():sendMagicEffect(CONST_ME_BLUE_ENERGY_SPARK)
				return true
			end

			mysteriousChest:aid(Storage.PerIustitiaAdAstra.MysteriousChest)
			mysteriousChest:register()
		end)

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.ReportChestToHugo,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ GREET }] = { text = "So, did you manage to find anything?" },
			[{ "experience", "doswiadczenie", "level", "poziom", "mission" }] = {
				text = "Oh, that old man! What's this much of experience points worths in these times... You can keep them.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = QuestState.PerIustitiaAdAstra.Mission04.AskHugoForMission,
				},
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission04.AskHugoForMission,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "I have one more thing you can help me with. I heard that people who visit the southern archipelago disappear under mysterious circumstances. Investigate this matter.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission04] = MISSION_FINISHED,
					[Storage.PerIustitiaAdAstra.Mission05] = QuestState.PerIustitiaAdAstra.Mission05.FindBeachLurker,
					[Storage.PerIustitiaAdAstra.RukcaAccess] = ACCESS_GRANTED,
				},
			},
		})

end
)	:Mission(Storage.PerIustitiaAdAstra.Mission05)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission05.FindBeachLurker,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "As I said, beachgoers have been disappearing in the southern archipelago. Try looking there.",
			},
		}),
		QuestFactory.StartupItems({
			{ pos = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 81, 0), id = 7804, aid = Storage.PerIustitiaAdAstra.RukcaAccess },
		}),
		QuestFactory.StartupItems({
			{ pos = { -31, -1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -30, 0, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -32, 1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -29, 1, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -30, 2, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -32, 3, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
			{ pos = { -31, 3, 0 }, id = 22694, aid = Storage.PerIustitiaAdAstra.SaltyTile },
		}, RUKCA_ANCHOR),
		QuestFactory.Script(function(missionState)
			local vortex = MoveEvent()

			function vortex.onStepIn(player, _, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				local storageVal = player:getStorageValue(Storage.PerIustitiaAdAstra.RukcaAccess)
				if storageVal ~= ACCESS_GRANTED then
					return true
				end

				local toPos = toPosition:Moved(0, 0, 1)
				player:teleportTo(toPos, true)
				toPos:sendMagicEffect(CONST_ME_WATERSPLASH)
			end

			vortex:aid(Storage.PerIustitiaAdAstra.RukcaAccess)
			vortex:register()
		end)

end
)	:MonsterEvent(function()
		local updateStorages = {
			[Storage.PerIustitiaAdAstra.Mission05] = QuestState.PerIustitiaAdAstra.Mission05.ReportToHugo,
		}

		local rukca = CreatureEvent("RukcaDeath")

		function rukca.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.PerIustitiaAdAstra.Mission05) ~= QuestState.PerIustitiaAdAstra.Mission05.FindBeachLurker then
					return true
				end
				player:setStorageValue(updateStorages, QuestState.PerIustitiaAdAstra.Mission05.ReportToHugo)
			end)
			return true
		end

		rukca:register()
	end)
	:MonsterEvent(function()
		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
		combat:setArea(createCombatArea(AREA_CIRCLE5X5V2))

		local rageBaseDamage = 100
		local rageCurrentDamage = 100

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var)
			local rukcaState = CreatureStateRegistry:getState(creature)
			if rukcaState.rukcaIsHungry then
				rageCurrentDamage = rageCurrentDamage + 70
				combat:setFormula(COMBAT_FORMULA_DAMAGE, -rageCurrentDamage, 0, -rageCurrentDamage, 0)
				return combat:execute(creature, var)
			end

			rageCurrentDamage = rageBaseDamage
		end

		spell:name("rukca hunger rage")
		spell:words(NextSpellId())
		spell:needTarget(false)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(false)
		spell:register()

		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

		local function tryEatBabySeal(centerPos)
			local eatenBaby = IterateBetweenPositions(centerPos:Moved(-2, -2, 0), centerPos:Moved(2, 2, 0), function(context)
				local pos = context.pos
				local babySeal = Tile(pos):getItemById(7178)
				if babySeal then
					pos:sendMagicEffect(CONST_ME_DRAWBLOOD)
					babySeal:remove()
					return true
				end
			end, { stopCondition = STOP_CONDITIONS.isTrue })
			return eatenBaby
		end

		local function canEat(rukcaState)
			if os.time() > rukcaState.nextMealTime then
				return true
			else
				return false
			end
		end

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			local rukcaState = CreatureStateRegistry:getState(creature)
			if not canEat(rukcaState) then
				return
			end

			if not tryEatBabySeal(creature:getPosition()) then
				rukcaState.rukcaIsHungry = true
			else
				rukcaState.rukcaIsHungry = false
				rukcaState.nextMealTime = os.time() + 10
			end
			return combat:execute(creature, var)
		end

		spell:name("rukca eating")
		spell:words(NextSpellId())
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(true)
		spell:register()
	end)
:State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission05.ReportToHugo,
		QuestFactory.Dialog("Hugo BoSS", {
			[{ "mission" }] = {
				text = "Thank you for your help. I think I have a suitable reward for you. Perhaps you'll be interested in an ancient artifact I lost somewhere in the northern dump. You can keep it if you find it.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission05] = QuestState.PerIustitiaAdAstra.Mission05.ReportToAstralJanus,
				},
			},
		})

end
):State(
function()
return 
		{ min = QuestState.PerIustitiaAdAstra.Mission05.ReportToAstralJanus },
		QuestFactory.StartupItems({
			{
				pos = HUGO_BEACH_PLANET_ANCHOR:Moved(67, -150, 0),
				id = 3503,
				uid = 1000,
				aid = Storage.KingOfRatsHQ.Items.Antigone,
				rewards = { QuestKeyItems.KingOfRatsHQ.Antigone },
			},
			{ --trick parcel
				pos = HUGO_BEACH_PLANET_ANCHOR:Moved(67, -150, 0),
				id = 3504,
				aid = 0,
				uid = 0,
			},
		})

end
):State(
function()
return 
		QuestState.PerIustitiaAdAstra.Mission05.ReportToAstralJanus,
		QuestFactory.Dialog("Astral Janus", {
			[{ "mission", "misja" }] = {
				text = "Good job. Thanks to you, there's more justice in this world. Here's your reward. Now go back to Tomek. He said he has a problem with his old hag.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Mission05] = MISSION_FINISHED,
					[Storage.BigKlamoty.Mission01] = 1,
				},
				rewards = { ExerciseWeaponBox(5000) },
			},
		})

end
)	:Register()

---39f add rukca encounter
do
	return
end
QuestFactory.Script(function(missionState)
	local starLeftStepIn = MoveEvent()

	function starLeftStepIn.onStepIn(creature, _, _, _)
		local pos = creature:getPosition()
		local toPos = pos:Moved(36, 0, 0)

		creature:teleportTo(toPos)
	end

	starLeftStepIn:aid(Storage.PerIustitiaAdAstra.MovingStarTile)
	starLeftStepIn:register()
end)
QuestFactory.Script(function(missionState)
	local rukcaConfig = {
		actionid = Storage.PerIustitiaAdAstra.RukcaAccess,
		bossName = "Ruk'ca Maw",
		timerStorage = Storage.PerIustitiaAdAstra.RukcaAccess,
		cooldown = "weekly",

		leverPosition = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 87, 1),
		entranceGrid = {
			topLeft = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 83, 1),
			downRight = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 86, 1),
		},

		bossPos = RUKCA_ANCHOR:Moved(44, 22, 0),
		enterPos = RUKCA_ANCHOR:Moved(46, 24, 0),
		durationMinutes = 5,
		exitTeleportDestination = RUKCA_ANCHOR:Moved(-21, -11, -1),
		corner1 = RUKCA_ANCHOR:Moved(-37, -17, 0),
		corner2 = RUKCA_ANCHOR:Moved(53, 32, 0),

		requiredStorages = {
			[Storage.PerIustitiaAdAstra.RukcaAccess] = { min = ACCESS_GRANTED },
		},
		cannotEnterDuring = true,
	}
	RegisterEncounter(rukcaConfig)

	local originalSealCage

	local sealCagePositions = {
		RUKCA_ANCHOR:Moved(3, 1, 0),
		RUKCA_ANCHOR:Moved(10, -15, 0),
		RUKCA_ANCHOR:Moved(20, -6, 0),
		RUKCA_ANCHOR:Moved(15, 9, 0),
		RUKCA_ANCHOR:Moved(36, 11, 0),
		RUKCA_ANCHOR:Moved(34, 26, 0),
		RUKCA_ANCHOR:Moved(-6, 12, 0),
		RUKCA_ANCHOR:Moved(-17, 9, 0),
		RUKCA_ANCHOR:Moved(-24, 2, 0),
	}

	local cages = ItemExList()

	local function tryRemoveBabySealCages()
		cages:Remove()
	end

	local function initializeBabySealCages()
		for _, destination in pairs(sealCagePositions) do
			cages:AddMultiple(originalSealCage:Copied(destination))
		end
	end

	local function startEncounter()
		tryRemoveBabySealCages()
		initializeBabySealCages()
	end
	local rukcaLever = Action()

	function rukcaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if UseEncounterLever(player, item, rukcaConfig) then
			startEncounter()
		end
	end

	rukcaLever:aid(rukcaConfig.actionid)
	rukcaLever:register()

	local rukcaEncounterInit = GlobalEvent("RukcaEncounterInit")
	function rukcaEncounterInit.onStartup()
		originalSealCage = ItemExList():Area(RUKCA_ANCHOR:Moved(-1, 26, 0), RUKCA_ANCHOR:Moved(0, 27, 0))
	end
	rukcaEncounterInit:register()
end)
QuestFactory.Script(function(missionState)
	local dmg = 20000

	local saltyTile = MoveEvent()

	function saltyTile.onStepIn(creature, _, _, _)
		if creature:getName():lower() == "ruk'ca maw" then
			doTargetCombatHealth(0, creature, COMBAT_POISONDAMAGE, -dmg, -dmg, CONST_ME_STUN)
		end
	end

	saltyTile:aid(Storage.PerIustitiaAdAstra.SaltyTile)
	saltyTile:register()
end)

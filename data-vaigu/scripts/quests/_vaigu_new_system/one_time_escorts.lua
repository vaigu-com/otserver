local quest = Quest("one_time_escorts")
quest
	:Storage(function()
		Storage.OneTimeEscorts = { MegaDragonCliffs = NextStorage() }
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Fiufiu Escort")
		local monster = {}

		monster.name = "Fiufiu"
		monster.description = "Fiufiu"
		monster.experience = 1000
		monster.outfit = {
			lookType = 129,
			lookHead = 116,
			lookBody = 53,
			lookLegs = 97,
			lookFeet = 116,
			lookAddons = 0,
			lookMount = 0,
		}

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

		mType:register(monster)
	end)
	:Script(function(storageToRequiredState)
		local internalNpcName = "Fiufiu"
		local npcType = Game.createNpcType(internalNpcName)
		local npcConfig = {}

		npcConfig.name = internalNpcName
		npcConfig.description = internalNpcName

		npcConfig.health = 100
		npcConfig.maxHealth = npcConfig.health
		npcConfig.walkInterval = 2000
		npcConfig.walkRadius = 2

		npcConfig.outfit = {
			lookType = 129,
			lookHead = 116,
			lookBody = 53,
			lookLegs = 97,
			lookFeet = 116,
			lookAddons = 0,
			lookMount = 0,
		}
		npcConfig.flags = { floorchange = false }

		local keywordHandler = KeywordHandler:new()
		local npcHandler = NpcHandler:new(keywordHandler)

		npcType.onThink = function(npc, interval)
			npcHandler:onThink(npc, interval)
		end

		npcType.onAppear = function(npc, creature)
			npcHandler:onAppear(npc, creature)
		end

		npcType.onDisappear = function(npc, creature)
			npcHandler:onDisappear(npc, creature)
		end

		npcType.onMove = function(npc, creature, fromPosition, toPosition)
			npcHandler:onMove(npc, creature, fromPosition, toPosition)
		end

		npcType.onSay = function(npc, creature, type, message)
			npcHandler:onSay(npc, creature, type, message)
		end

		npcType.onCloseChannel = function(npc, creature)
			npcHandler:onCloseChannel(npc, creature)
		end

		local escortContext = {
			timeLimitSeconds = 600,
			startAfterSeconds = 2,
			destinationPos = Position(7595, 1527, 7),
			requiredState = {
				[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
			},
			nextState = {
				[Storage.OneTimeEscorts.MegaDragonCliffs] = 2,
			},
			escorteeName = "FiuFiu Escort",
			localizerName = Storage.OneTimeEscorts.MegaDragonCliffs,
			finishMessage = "Thanks",
			rewards = nil,
			expReward = 1000 * 10,
			minDistanceEscorteeAndDestination = 20,
		}

		local config = {
			[Storage.OneTimeEscorts.MegaDragonCliffs] = {
				[-1] = {
					[{ GREET }] = {
						text = "You have to help me, i need to get out of here. Are you ready to go now?",
						nextState = {
							[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
						},
					},
				},
				[1] = {
					[{ GREET }] = {
						text = "You have to help me, i need to get out of here. Are you ready to go now?",
					},
					[{ "yes", "tak" }] = {
						text = "Lets go!",
						specialActionsOnSuccess = {
							{
								action = StartEscortDialog,
								escortContext = escortContext,
							},
						},
					},
				},
			},
		}

		local function greetCallback(npc, creature, type, message)
			InitializeResponses(creature, config, npcHandler, npc)
			return true
		end

		local function creatureSayCallback(npc, creature, type, msg)
			if not npcHandler:checkInteraction(npc, creature) then
				return false
			end
			return TryResolveDialog(creature, msg, config, npcHandler, npc)
		end

		npcHandler:setCallback(CALLBACK_GREET, greetCallback)
		npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

		npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
		npcType:register(npcConfig)
	end)
	:Script(function(storageToRequiredState)
		local escortContext = {
			timeLimitSeconds = 600,
			startAfterSeconds = 2,
			npcRespawnPos = Position(7428, 1423, 5),
			destinationPos = Position(7595, 1527, 7),
			requiredState = {
				[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
			},
			nextState = {
				[Storage.OneTimeEscorts.MegaDragonCliffs] = 2,
			},
			npcName = "FiuFiu",
			escorteeName = "FiuFiu Escort",
			localizerName = Storage.OneTimeEscorts.MegaDragonCliffs,
			finishMessage = "Thanks",
			rewards = nil,
			expReward = 1000 * 10,
			minDistanceEscorteeAndDestination = 20,
		}

		local tileAboveNpc = MoveEvent()
		function tileAboveNpc.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return
			end

			local questState = player:getStorageValue(Storage.OneTimeEscorts.MegaDragonCliffs)
			if questState ~= 1 then
				return
			end

			local escortNpc = escortContext.npcRespawnPos:GetFirstNpcInRadius(3, escortContext.npcName)
			if escortNpc then
				return
			end

			escortContext.npc = escortNpc
			StartEscortDialog(escortContext, player)

			return true
		end
		tileAboveNpc:type("stepin")
		tileAboveNpc:aid(Storage.OneTimeEscorts.MegaDragonCliffs)
		tileAboveNpc:register()

		local megaDragonCliffsEscort = GlobalEvent("megaDragonCliffsEscort")
		function megaDragonCliffsEscort.onStartup()
			Game.createNpc(escortContext.npcName, escortContext.npcRespawnPos)
		end
		megaDragonCliffsEscort:register()
	end)

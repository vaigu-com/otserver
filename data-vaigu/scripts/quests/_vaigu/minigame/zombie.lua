local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Script(function()
		local zombieMinigame = 	MinigameData({
			minigameName = "Zombie",
			competitionType = MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING,
			requiredPlayers = 1,
		})
		Minigames.Zombie = zombieMinigame

		local function createMonsterWithGraphicAnnouncement(context)
			context.effectEnum = context.effectEnum or CONST_ME_TELEPORT

			for i = 1, context.effectsCount or 2 do
				addEvent(function()
					context.position:sendMagicEffect(context.effectEnum)
				end, i * context.delayBetweenEffectsSeconds * 1000)
			end

			addEvent(function()
				Game.createMonster(context.monsterName, context.position, nil, true)
			end, (context.effectsCount + 1) * context.delayBetweenEffectsSeconds * 1000)
		end
		zombieMinigame.beforeStart = function() end

		local zombieCreationContext = {
			monsterName = "Zombie Minigame",
			effectsCount = 2,
			effectEnum = CONST_ME_TELEPORT,
			delayBetweenEffectsSeconds = 1,
		}
		local gameAreaZone = zombieMinigame:GetGameAreaZone()

		local gameLoop = GlobalEvent(Minigames.Zombie:GetEventScope():Get("ZombieSpawner"))
		function gameLoop.onThink()
			if not Minigames.Zombie:IsActive() then
				return GLOBAL_EVENT_OK
			end

			if Minigames.Zombie:GetLifetime() < 5 then
				return GLOBAL_EVENT_OK
			end

			zombieCreationContext.position = gameAreaZone:randomPosition()
			createMonsterWithGraphicAnnouncement(zombieCreationContext)
			return GLOBAL_EVENT_OK
		end
		gameLoop:interval(5000)
		gameLoop:register()

		local startEvent = TalkAction("!zombie")

		function startEvent.onSay(player, words, param)
			local status = zombieMinigame:TryStartLobbyFast()
			return false
		end
		startEvent:separator(" ")
		startEvent:groupType("tutor")
		startEvent:register()
	end)
	:MonsterEvent(function()
		local healthPercentagePerSwing = 0.09
		local zombieMelee = Combat()
		zombieMelee:setParameter(COMBAT_PARAM_TYPE, COMBAT_NEUTRALDAMAGE)
		function onGetFormulaValues(creature, target)
			if not target then
				return
			end
			target:addHealth(-math.floor(target:getMaxHealth() * healthPercentagePerSwing))
			return true
		end

		zombieMelee:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValues")

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			return zombieMelee:execute(creature, var)
		end

		spell:name("minigame zombie melee swing")
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Zombie Minigame")
		local monster = {}

		monster.name = "Zombie"
		monster.description = "a zombie"
		monster.experience = 280
		monster.outfit = {
			lookType = 311,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.Bestiary = {
			class = "Undead",
			race = BESTY_RACE_UNDEAD,
			toKill = 1000,
			FirstUnlock = 50,
			SecondUnlock = 500,
			CharmsPoints = 25,
			Stars = 3,
			Occurrence = 0,
			Locations = "Cemetery Quarter, Drefia, Vampire Castle, Treasure Island, Isle of Evil, Upper Spike.",
		}

		monster.health = 50000
		monster.maxHealth = 50000
		monster.race = "undead"
		monster.corpse = 8961
		monster.speed = 40
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 80,
			health = 10,
			damage = 10,
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
			runHealth = 0,
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

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "Mst.... klll....", yell = false },
			{ text = "Whrrrr... ssss.... mmm.... grrrrl", yell = false },
			{ text = "Dnnnt... cmmm... clsrrr....", yell = false },
			{ text = "Httt.... hmnnsss...", yell = false },
		}

		monster.loot = {}

		monster.attacks = {
			{ name = "minigame zombie melee swing", interval = 1000, chance = 100, range = 1, target = true },
		}

		monster.defenses = {
			defense = 15,
			armor = 20,
			mitigation = 0.83,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, perent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, perent = 0 },
			{ type = COMBAT_EARTHDAMAGE, perent = 0 },
			{ type = COMBAT_FIREDAMAGE, perent = 0 },
			{ type = COMBAT_LIFEDRAIN, perent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, perent = 0 },
			{ type = COMBAT_ICEDAMAGE, perent = 0 },
			{ type = COMBAT_HOLYDAMAGE, perent = 0 },
			{ type = COMBAT_DEATHDAMAGE, perent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = false },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Register()

local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Storage(function()
		Storage.Meteor = {
			PlayerPerks = {
				BonusSpeed = {},
			},
			StepIns = {
				BonusSpeed = {},
				Heal = {},
			},
		}
	end)
	:Constant(function()
		QuestConstants.Meteor = {
			HEAL_AMOUNT_PERCENT = 0.15,
			PERK_LIFETIME_SECONDS = 6000,
			PERK_EFFECT_INTERVAL_MS = 700,

			BONUS_SPEED_DEFAULT = 0,

			BONUS_SPEED_MAX = 15,

			PERK_APPEAR_CHANCE_PERCENT = 10,
			SPEED_PERK_CHANCE_PERCENT = 80,
			PERK_ID = 9586,
			PERK_ID_INVISIBLE = 8065,

			METEOR_INTERVAL_DEFAULT = 1100,
			METEOR_INTERVAL_REDUCTION_PER_SECOND = 10,
			METEOR_INTERVAL_MINIMUM = 60,

			BIG_METEOR_CHANCE_PERCENT = 80,

			METEOR_ID = 1772,
			FIRE_REMNANT_SMALL_ID = 2120,
			ORANGE_REMNANT_ID = 2132,
		}
	end)
	:Script(function()
		Minigames.Meteor = MinigameData({
			minigameName = "Meteor",
			competitionType = MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING,
			requiredPlayers = 1,
			meteorInterval = QuestConstants.Meteor.METEOR_INTERVAL_DEFAULT,
		})

		local meteorAppearOffset = 4
		local impactDelayMs = (meteorAppearOffset + 1) * 60
		local warningDelayMs = impactDelayMs + 3 * 1000
		local explosionDelayMs = warningDelayMs + 1 * 1000

		local impactCombat = Combat()
		impactCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NEUTRALDAMAGE)
		impactCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
		impactCombat:setArea(createCombatArea(AREA_PLUS1))
		local healthPercentagePerImpact = 0.09
		function meteorEventImpact__onGetFormulaValues(creature, target)
			if not target then
				return
			end
			target:addHealth(-math.floor(target:getMaxHealth() * healthPercentagePerImpact))
			return true
		end
		impactCombat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "meteorEventImpact__onGetFormulaValues") --CALLBACK_PARAM_TARGETTILE

		local healthPercentagePerExplosion = 0.32
		local explosionCombat = Combat()
		explosionCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
		explosionCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NEUTRALDAMAGE)
		explosionCombat:setArea(createCombatArea(AREA_CIRCLE_EUCLIDEAN_5X5))
		function meteorEventExplosion__onGetFormulaValues(creature, target)
			if not target then
				return
			end
			target:addHealth(-math.floor(target:getMaxHealth() * healthPercentagePerExplosion))
			return true
		end
		explosionCombat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "meteorEventExplosion__onGetFormulaValues") --CALLBACK_PARAM_TARGETTILE

		local function meteorImpact(pos, meteorMonster)
			impactCombat:execute(meteorMonster, Variant(pos))
			Game.createItem(QuestConstants.Meteor.FIRE_REMNANT_SMALL_ID, 1, pos):decay()
		end

		local function meteorWarning(pos)
			pos:sendMagicEffect(CONST_ME_HITBYFIRE)
		end

		local function startHeartEffect(itemUid, position, startTime)
			local function tick()
				local item = Item(itemUid)
				if not item then
					return
				end

				if os.mtime() - startTime >= QuestConstants.Meteor.PERK_LIFETIME_SECONDS then
					item:remove()
					return
				end

				position:sendMagicEffect(CONST_ME_HEARTS)
				addEvent(tick, HEART_EFFECT_INTERVAL)
			end

			addEvent(tick, QuestConstants.Meteor.PERK_EFFECT_INTERVAL_MS)
		end
		local function startSpeedEffect(itemUid, position, startTime)
			local function tick()
				local item = Item(itemUid)
				if not item then
					return
				end

				if os.mtime() - startTime >= QuestConstants.Meteor.PERK_LIFETIME_SECONDS then
					item:remove()
					return
				end

				position:sendMagicEffect(CONST_ME_GREEN_FIREWORKS)
				addEvent(tick, HEART_EFFECT_INTERVAL)
			end

			addEvent(tick, QuestConstants.Meteor.PERK_EFFECT_INTERVAL_MS)
		end

		local function tryCreateRandomPerk(pos)
			if math.random(1, 100) > QuestConstants.Meteor.PERK_APPEAR_CHANCE_PERCENT then
				return
			end

			if math.random(1, 100) < QuestConstants.Meteor.SPEED_PERK_CHANCE_PERCENT then
				local item = Game.createItem(QuestConstants.Meteor.PERK_ID_INVISIBLE, 1, pos)
				item:setKey(Storage.Meteor.StepIns.BonusSpeed)
				startSpeedEffect(item:getUniqueId(), pos, os.time())
			else
				local item = Game.createItem(QuestConstants.Meteor.PERK_ID_INVISIBLE, 1, pos)
				item:setKey(Storage.Meteor.StepIns.Heal)
				startHeartEffect(item:getUniqueId(), pos, os.time())
			end
		end

		local function meteorExplosion(pos, meteorMonster)
			explosionCombat:execute(meteorMonster, Variant(pos))
			meteorMonster:remove()
			tryCreateRandomPerk(pos)
		end

		MONSTER_BUFFER_POSITION_METEOR = {}
		local function spawnMeteorBig()
			local impactPos = Minigames.Meteor:GetGameAreaZone():randomPosition()
			local topLeftCorner = impactPos:Moved(-meteorAppearOffset, -meteorAppearOffset, 0)
			local meteorMonster = Game.createMonster("Meteor Minigame Monster", MONSTER_BUFFER_POSITION_METEOR, nil, true)
			meteorMonster:teleportTo(topLeftCorner)
			for i = 1, meteorAppearOffset do
				addEvent(function()
					meteorMonster:move(DIRECTION_SOUTHEAST)
				end, i * 60)
			end
			addEvent(function()
				meteorMonster:setSpeed(0)
			end, meteorAppearOffset * 60 + 30)

			addEvent(function()
				meteorImpact(impactPos, meteorMonster)
			end, impactDelayMs)
			addEvent(function()
				meteorWarning(impactPos)
			end, warningDelayMs)
			addEvent(function()
				meteorExplosion(impactPos, meteorMonster)
			end, explosionDelayMs)
		end

		local smallMeteorCombat = Combat()
		smallMeteorCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
		smallMeteorCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
		smallMeteorCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
		local function spawnMeteorSmall()
			local impactPos = Minigames.Meteor:GetGameAreaZone():randomPosition()
			local travelStartPosition = impactPos:Moved(-meteorAppearOffset, -meteorAppearOffset, 0)
			local meteorMonster = Game.createMonster("Meteor Minigame Monster Invisible", MONSTER_BUFFER_POSITION_METEOR, nil, true)
			meteorMonster:teleportTo(travelStartPosition)
			smallMeteorCombat:execute(meteorMonster, Variant(impactPos))
			Game.createItem(QuestConstants.Meteor.ORANGE_REMNANT_ID, 1, impactPos):decay()
			meteorMonster:remove()
		end

		local function meteorSpawnLoop()
			if not Minigames.Meteor:IsActive() then
				return
			end
			if math.random(1, 100) < QuestConstants.Meteor.BIG_METEOR_CHANCE_PERCENT then
				spawnMeteorBig()
			else
				spawnMeteorSmall()
			end
			addEvent(meteorSpawnLoop, Minigames.Meteor.meteorInterval)
		end

		local gameLoop = GlobalEvent(Minigames.Meteor:GetEventScope():Get("MeteorIntervalDecrease"))
		function gameLoop.onThink()
			if not Minigames.Meteor:IsActive() then
				return GLOBAL_EVENT_OK
			end

			Minigames.Meteor.meteorInterval = math.max(Minigames.Meteor.meteorInterval - QuestConstants.Meteor.METEOR_INTERVAL_REDUCTION_PER_SECOND, QuestConstants.Meteor.METEOR_INTERVAL_MINIMUM)

			return GLOBAL_EVENT_OK
		end
		gameLoop:interval(1000)
		gameLoop:register()

		Minigames.Meteor.beforeStart = function()
			MONSTER_BUFFER_POSITION_METEOR = Zone(Minigames.Meteor:GetScope():Get("MonsterBuffer")):getSinglePosition()
			healPerkLocations = {}
			meteorInterval = QuestConstants.Meteor.METEOR_INTERVAL_DEFAULT
			local participants = Minigames.Meteor:GetLobbyZone():getPlayers()
			for _, participant in pairs(participants) do
				participant:setStorageValueByKey(Storage.Meteor.PlayerPerks.BonusSpeed, QuestConstants.Meteor.BONUS_SPEED_DEFAULT)
			end

			meteorSpawnLoop()
		end
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Meteor Minigame Monster")
		local monster = {}

		monster.description = "a meteor"
		monster.experience = 0
		monster.outfit = {
			lookTypeEx = QuestConstants.Meteor.METEOR_ID,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 500
		monster.maxHealth = 500
		monster.race = "undead"
		monster.speed = 700
		monster.manaCost = 0

		monster.flags = {
			summonable = false,
			attackable = false,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 0,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = true,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

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
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Meteor Minigame Monster Invisible")
		local monster = {}

		monster.description = "a meteor"
		monster.experience = 0
		monster.outfit = {
			lookType = 305,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 500
		monster.maxHealth = 500
		monster.race = "undead"
		monster.speed = 0
		monster.manaCost = 0

		monster.flags = {
			summonable = false,
			attackable = false,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 0,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = true,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

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
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		local permaInvis = Condition(CONDITION_INVISIBLE)
		permaInvis:setParameter(CONDITION_PARAM_TICKS, -1)

		mType.onSpawn = function(monster, creature)
			monster:addCondition(permaInvis)
		end

		mType:register(monster)
	end)
	:Script(function()
		local playerStorageToMaximum = {
			[Storage.Meteor.PlayerPerks.BonusSpeed] = QuestConstants.Meteor.BONUS_SPEED_MAX,
		}
		local playerStorageToMessage = {
			[Storage.Meteor.PlayerPerks.BonusSpeed] = "You now move faster!",
		}
		local playerStorageToMagicEffect = {
			[Storage.Meteor.PlayerPerks.BonusSpeed] = CONST_ME_GREEN_ENERGY_SPARK,
		}
		local function tryIncrementBombermanStorage(player, storage)
			local maxValue = playerStorageToMaximum[storage]
			local incrementedValue = player:getStorageValueByKey(storage) + 1
			local nextValue = math.min(maxValue, incrementedValue)
			player:setStorageValueByKey(storage, nextValue)

			if incrementedValue > maxValue then
				player:sendTextMessage(MESSAGE_LOOK, "You already have maximum bonus for this perk.")
			elseif incrementedValue <= maxValue then
				player:sendTextMessage(MESSAGE_LOOK, playerStorageToMessage[storage])
				player:getPosition():sendMagicEffect(playerStorageToMagicEffect[storage])
			end
			return nextValue
		end

		local speedBuff = MoveEvent()
		function speedBuff.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local nextValue = tryIncrementBombermanStorage(player, Storage.Meteor.PlayerPerks.BonusSpeed)
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, Minigames.Bomberman:GetFixedSpeed() + nextValue * 10)
			player:SetMinigameFixedSpeed()
			item:remove()
			return true
		end
		speedBuff:key(Storage.Meteor.StepIns.BonusSpeed)
		speedBuff:type("stepin")
		speedBuff:register()

		local heal = MoveEvent()
		function heal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			player:addHealth(player:getMaxHealth() * QuestConstants.Meteor.HEAL_AMOUNT_PERCENT)
			item:remove()
			return true
		end
		heal:key(Storage.Meteor.StepIns.Heal)
		heal:type("stepin")
		heal:register()
	end)
	:Script(function()
		local startEvent = TalkAction("!meteor")
		function startEvent.onSay(player, words, param)
			Minigames.Meteor:TryStartLobbyFast()
			return false
		end
		startEvent:separator(" ")
		startEvent:groupType("tutor")
		startEvent:register()
	end)
	:Register()

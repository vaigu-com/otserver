local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Storage(function()
		Storage.VisLuxVersus = {
			PlayerPerks = {
				VisLuxLength = {},
				BonusSpeed = {},
			},
			StepIns = {
				BonusSpeed = {},
				BonusLength = {},
			},
			VisLuxCooldown = {},
		}
	end)
	:Constant(function()
		QuestConstants.VisLuxVersus = {
			VIS_LUX_COOLDOWN_SECONDS = 2,

			BOMB_IS_ACTIVE = 1,
			BOMB_IS_INACTIVE = -1,

			VISLUX_LENGTH_DEFAULT = 5,
			BOMB_MAX_ACTIVE_DEFAULT = 1,
			BONUS_SPEED_DEFAULT = 0,

			VISLUX_MAX_LENGTH = 8,
			BOMB_MAX_ACTIVE = 5,
			BONUS_SPEED_MAX = 5,

			BOMB_DURATION_MS = 2000,

			BLOCKAGE_ID = 25577,
			BOMB_ID = 27492,
			PERK_ID = 9586,
			CRATE_VALUABLE_ID = 2478,
			CRATE_NORMAL_ID = 2471,
			PERK_SPAWNER_ID = 1996,

			SOLID_WALL_IDS = {
				17130,
				17098,
				17125,
				17100,
			},

			PERK_APPEAR_CHANCE_PERCENT = 50,
		}
		QuestConstants.VisLuxVersus.CLEARABLE_IDS = {
			QuestConstants.VisLuxVersus.PERK_ID,
			QuestConstants.VisLuxVersus.CRATE_NORMAL_ID,
			QuestConstants.VisLuxVersus.BLOCKAGE_ID,
			--QuestConstants.VisLuxVersus.CRATE_VALUABLE_ID,
		}
		QuestConstants.VisLuxVersus.EXPLODABLE_IDS = {
			QuestConstants.VisLuxVersus.CRATE_NORMAL_ID,
			QuestConstants.VisLuxVersus.BLOCKAGE_ID,
			--QuestConstants.VisLuxVersus.CRATE_VALUABLE_ID,
		}
	end)
	:Script(function()
		Minigames.VisLuxVersus = MinigameData({
			minigameName = "VisLuxVersus",
			competitionType = MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING,
			requiredPlayers = 1,
		})
		MONSTER_BUFFER_POSITION_VISLUXVERSUS = {}

		local function clearRoom()
			local gameAreaCorner1, gameAreaCorner2 = Zone(Minigames.VisLuxVersus:GetScope():Get("GameAreaCorners")):getCorners()
			local gameArea = Area(gameAreaCorner1, gameAreaCorner2)
			ItemExList():Area(gameArea):FilterByIds(QuestConstants.VisLuxVersus.CLEARABLE_IDS):Remove()
			CreatureList():Area(gameArea):FilterByMonster():ForEach(function(monster)
				monster:remove()
			end)
		end

		local function emplaceChestsBlockages()
			local gameAreaCorner1, gameAreaCorner2 = Zone(Minigames.VisLuxVersus:GetScope():Get("GameAreaCorners")):getCorners()
			local stonePositionsCorner1, stonePositionsCorner2 = Zone(Minigames.VisLuxVersus:GetScope():Get("ChestPositionsCorners")):getCorners()
			local vectorBetween1 = stonePositionsCorner1:VectorBetween(gameAreaCorner1)
			local vectorBetween2 = stonePositionsCorner2:VectorBetween(gameAreaCorner2)
			if vectorBetween1 ~= vectorBetween2 then
				logger.warn("[bomberman.beforeStart][emplaceStones] vectors between game area and stone positions room arent identical!")
			end

			ItemExList():Area(Area(stonePositionsCorner1, stonePositionsCorner2)):FilterById(QuestConstants.VisLuxVersus.CRATE_NORMAL_ID):Copied(vectorBetween1):ForEach(function(item)
				item:setKey(IMMOVABLE_KEY)
				Game.createItem(QuestConstants.VisLuxVersus.BLOCKAGE_ID, 1, item:getPosition())
			end)
		end

		Minigames.VisLuxVersus.beforeStart = function()
			clearRoom()
			emplaceChestsBlockages()

			local perkSpawnerPositions = {}
			local perkSpawners = ItemExList():Positions(Minigames.VisLuxVersus:GetGameAreaZone():getPositions()):FilterById(QuestConstants.VisLuxVersus.PERK_SPAWNER_ID):Get()
			for _, perkSpanwner in pairs(perkSpawners) do
				local pos = perkSpanwner:getPosition()
				table.insert(perkSpawnerPositions, pos)
			end
			Minigames.VisLuxVersus.PerkSpawnerPositions = perkSpawnerPositions

			MONSTER_BUFFER_POSITION_VISLUXVERSUS = Zone(Minigames.VisLuxVersus:GetScope():Get("MonsterBuffer")):getSinglePosition()
			local participants = Minigames.VisLuxVersus:GetLobbyZone():getPlayers()
			for _, participant in pairs(participants) do
				participant:setStorageValueByKey(Storage.VisLuxVersus.PlayerPerks.VisLuxLength, QuestConstants.VisLuxVersus.VISLUX_LENGTH_DEFAULT)
				participant:setStorageValueByKey(Storage.VisLuxVersus.PlayerPerks.BonusSpeed, QuestConstants.VisLuxVersus.BONUS_SPEED_DEFAULT)
			end
		end
	end)
	:Script(function()
		local playerStorageToMaximum = {
			[Storage.VisLuxVersus.PlayerPerks.BonusSpeed] = QuestConstants.VisLuxVersus.BONUS_SPEED_MAX,
			[Storage.VisLuxVersus.PlayerPerks.VisLuxLength] = QuestConstants.VisLuxVersus.VISLUX_MAX_LENGTH,
		}
		local playerStorageToMessage = {
			[Storage.VisLuxVersus.PlayerPerks.BonusSpeed] = "You now move faster!",
			[Storage.VisLuxVersus.PlayerPerks.VisLuxLength] = "Your vis lux is one tile longer!",
		}
		local playerStorageToMagicEffect = {
			[Storage.VisLuxVersus.PlayerPerks.BonusSpeed] = CONST_ME_GREEN_ENERGY_SPARK,
			[Storage.VisLuxVersus.PlayerPerks.VisLuxLength] = CONST_ME_BLUE_ENERGY_SPARK,
		}
		local function tryIncrementVisLuxVersusStorage(player, storage)
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

			local playerBonus = tryIncrementVisLuxVersusStorage(player, Storage.VisLuxVersus.PlayerPerks.BonusSpeed)
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, Minigames.VisLuxVersus:GetFixedSpeed() + playerBonus * 10)
			player:SetMinigameFixedSpeed()
			item:remove()
			return true
		end
		speedBuff:key(Storage.VisLuxVersus.StepIns.BonusSpeed)
		speedBuff:type("stepin")
		speedBuff:register()

		local activeBombsCountBuff = MoveEvent()
		function activeBombsCountBuff.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			tryIncrementVisLuxVersusStorage(player, Storage.VisLuxVersus.PlayerPerks.VisLuxLength)
			item:remove()
			return true
		end
		activeBombsCountBuff:key(Storage.VisLuxVersus.StepIns.BonusLength)
		activeBombsCountBuff:type("stepin")
		activeBombsCountBuff:register()
	end)
	:Script(function()
		local function tryCreatePerkStepIn(pos)
			local roll = math.random(1, 100)
			if roll < QuestConstants.VisLuxVersus.PERK_APPEAR_CHANCE_PERCENT then
				Game.createItem(QuestConstants.VisLuxVersus.PERK_ID, 1, pos):setKey(table.random(Storage.VisLuxVersus.StepIns))
			end
		end

		local healthPercentagePerImpact = 0.55

		visLuxCombats = {}
		local visLuxLengthToArea = {
			[1] = AREA_BEAM2,
			[2] = AREA_BEAM3,
			[3] = AREA_BEAM4,
			[4] = AREA_BEAM5,
			[5] = AREA_BEAM6,
			[6] = AREA_BEAM7,
			[7] = AREA_BEAM8,
			[8] = AREA_BEAM9,
		}

		for visLuxLength = 1, QuestConstants.VisLuxVersus.VISLUX_MAX_LENGTH do
			function visLuxHit__onGetFormulaValues(creature, target)
				if not target then
					return
				end

				target:addHealth(-math.floor(target:getMaxHealth() * healthPercentagePerImpact))
				return true
			end

			local combat = Combat()
			combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_UNDEFINEDDAMAGE)
			combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
			local area = visLuxLengthToArea[visLuxLength]
			combat:setArea(createCombatArea(area, AREADIAGONAL_WAVE7))
			combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "visLuxHit__onGetFormulaValues") --CALLBACK_PARAM_TARGETTILE
			visLuxCombats[visLuxLength] = combat
		end

		local function calculateLengthBeforeBloackageOrBox(playerPos, direction, visLuxLength)
			local vector = Vector.FromDirection(direction)
			for i = 1, visLuxLength do
				local nextAffectedPos = playerPos:MovedByVector(vector:Scaled(i))
				local destroyableItems = ItemExList():Pos(nextAffectedPos):FilterByIds(QuestConstants.VisLuxVersus.EXPLODABLE_IDS)
				if destroyableItems:Count() > 0 then
					tryCreatePerkStepIn(nextAffectedPos)
					nextAffectedPos:sendMagicEffect(CONST_ME_ENERGYAREA)
					nextAffectedPos:sendMagicEffect(CONST_ME_POFF)
					destroyableItems:Remove()
					return i - 1
				end
				local solidWalls = ItemExList():Pos(nextAffectedPos):FilterByIds(QuestConstants.VisLuxVersus.SOLID_WALL_IDS)
				if solidWalls:Count() > 0 then
					return i - 1
				end
			end

			return visLuxLength
		end

		local function castVisLux(player)
			local visLuxLength = player:getStorageValueByKey(Storage.VisLuxVersus.PlayerPerks.VisLuxLength)
			local direction = player:getDirection()
			local playerPos = player:getPosition()
			local lengthBeforeBlockageOrBox = calculateLengthBeforeBloackageOrBox(playerPos, direction, visLuxLength)

			local combat = visLuxCombats[lengthBeforeBlockageOrBox]

			local hiddenMonster = Game.createMonster("VisLuxVersus Minigame Monster Invisible", MONSTER_BUFFER_POSITION_VISLUXVERSUS, nil, true)
			hiddenMonster:teleportTo(playerPos)
			if combat then
				combat:execute(hiddenMonster, Variant(playerPos:MovedInDirection(direction, 1)))
			end
			hiddenMonster:remove()
		end

		local placeBombSay = TalkAction("!vis")
		function placeBombSay.onSay(player, words, param)
			if not Minigames.VisLuxVersus:isInZone(player:getPosition()) then
				return false
			end

			if not player:isLockoutExpired(Storage.VisLuxVersus.VisLuxCooldown) then
				doCreatureSay(player, "You cannot cast vis lux yet.", TALKTYPE_ORANGE_1)
				return
			end

			castVisLux(player)
			player:setStorageValueByKey(Storage.VisLuxVersus.VisLuxCooldown, os.time() + QuestConstants.VisLuxVersus.VIS_LUX_COOLDOWN_SECONDS)
			return true
		end
		placeBombSay:groupType("normal")
		placeBombSay:register()

		local startEvent = TalkAction("!visluxversus")
		function startEvent.onSay(player, words, param)
			local status = Minigames.VisLuxVersus:TryStartLobbyFast()
			return false
		end
		startEvent:separator(" ")
		startEvent:groupType("tutor")
		startEvent:register()

		local gameLoop = GlobalEvent(Minigames.VisLuxVersus:GetEventScope():Get("PerkSpawners"))
		function gameLoop.onThink()
			if not Minigames.VisLuxVersus:IsActive() then
				return GLOBAL_EVENT_OK
			end

			if Minigames.VisLuxVersus:GetLifetime() < 30 then
				return GLOBAL_EVENT_OK
			end

			for _, pos in pairs(Minigames.VisLuxVersus.PerkSpawnerPositions) do
				local perkBox = pos:GetItemById(QuestConstants.VisLuxVersus.PERK_ID)
				if not perkBox then
					tryCreatePerkStepIn(pos)
				end
			end
			return GLOBAL_EVENT_OK
		end
		gameLoop:interval(30000)
		gameLoop:register()

		local rimMonsterZones = {
			[1] = Zone("Minigames-VisLuxVersus-Ring1"),
			[2] = Zone("Minigames-VisLuxVersus-Ring2"),
			[3] = Zone("Minigames-VisLuxVersus-Ring3"),
			[4] = Zone("Minigames-VisLuxVersus-Ring4"),
		}

		local gameLoop = GlobalEvent(Minigames.VisLuxVersus:GetEventScope():Get("RimMonstersSpawners"))
		function gameLoop.onThink()
			if not Minigames.VisLuxVersus:IsActive() then
				return GLOBAL_EVENT_OK
			end

			local gameLifetime = Minigames.VisLuxVersus:GetLifetime()
			if gameLifetime < 60 then
				return GLOBAL_EVENT_OK
			end
			for i, zone in pairs(rimMonsterZones) do
				if gameLifetime >= i * 60 then
					Game.createMonster("VisLuxVersus Minigame Monster Rim", zone:randomPosition())
				end
			end

			return GLOBAL_EVENT_OK
		end
		gameLoop:interval(30000)
		gameLoop:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("VisLuxVersus Minigame Monster Invisible")
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
			hostile = true,
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
	:Monster(function()
		local antiStallMissiles = Combat()
		antiStallMissiles:setParameter(COMBAT_PARAM_TYPE, COMBAT_UNDEFINEDDAMAGE)
		antiStallMissiles:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
		function onGetFormulaValues(boss, target)
			target:addHealth(-math.floor(target:getMaxHealth() * 0.3))
			return true
		end
		antiStallMissiles:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValues")
		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			return antiStallMissiles:execute(creature, var)
		end
		spell:name("vis lux versus anti stall projectiles")
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(true)
		spell:register()

		local mType = Game.createMonsterType("VisLuxVersus Minigame Monster Rim")
		local monster = {}

		monster.description = "a mummy"
		monster.experience = 0
		monster.outfit = {
			lookType = 65,
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
		monster.speed = 50
		monster.manaCost = 0

		monster.flags = {
			summonable = false,
			attackable = false,
			hostile = true,
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

		monster.attacks = {
			{ name = "vis lux versus anti stall projectiles", interval = 1000, chance = 100, range = 1, target = true },
		}

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
	:Register()

local quest = Quest("four_act_tragedy")
quest
	:Storage(function()
		Storage.FourActTragedy = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			Mission07 = NextStorage(),
			Mission08 = NextStorage(),
			Portals = {
				ToRetro = NextStorage(),
				ToPresent = NextStorage(),
				AfterKraken = NextStorage(),
				ToKolumb = NextStorage(),
				AfterSkurwiwij = NextStorage(),
				AfterZulSzczurow = NextStorage(),
			},
			Rewards = {
				GrazynaCore = NextStorage(),
				Fanfare = NextStorage(),
				Powder = NextStorage(),
				TimmyBag = NextStorage(),
				SlippersChest = NextStorage(),
			},
			RetroKnurowoAccess = NextStorage(),
			FanfareLever = NextStorage(),
			WawelDragonAccess = NextStorage(),
			KrakenAccess = NextStorage(),
			SlippersTorch = NextStorage(),
			SkurwiwijAccess = NextStorage(),
			SkurwiwijDoor = NextStorage(),
			GrazhenaDoor = NextStorage(),
			ZulSzczurowAccess = NextStorage(),
			CultScroll = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Four Act Tragedy",
			startStorageId = Storage.FourActTragedy.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "01. Dodge those compensation claims",
					storageId = Storage.FourActTragedy.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Romek mentioned you should as him for mission.",
						[2] = "Go to HF-P/X agent - turdstin.",
						[3] = "Return to romek and talk to him about HF-P/X case.",
						[4] = "Romek sent you to Knurow. Try to find a way to go back in time there.",
					},
				},
				[2] = {
					name = "02. Bottom tex_L",
					storageId = Storage.FourActTragedy.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 6,
					states = {
						[1] = "Find someone who can show you around.",
						[2] = "Timmy asked you to find his equipment that was stolen by bandits.",
						[3] = "You found timmy belongings. Return to him and give them back.",
						[4] = "Timmy needs elvish dust to perform his magic. Try finding it on nearby mountain.",
						[5] = "Timmy told you that he will already have helped you in the future. Go back to Romek.",
						[6] = "You told romek about Timmy work.",
					},
				},
				[3] = {
					name = "03. Master Baitor",
					storageId = Storage.FourActTragedy.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Romek asked you to buy him a beer at nearby Lewiatan.",
						[2] = "You defeated the kraken. Go back to Romek.",
						[3] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
					},
				},
				[4] = {
					name = "04. Non omnis moriar",
					storageId = Storage.FourActTragedy.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
						[2] = "You found the Bribeslippers. Report back to Romek.",
						[3] = "Romek told you to follow the trail leading to the frog cult altar. Search the northern kongo.",
					},
				},
				[5] = {
					name = "05. Enqueued for a Genocide",
					storageId = Storage.FourActTragedy.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Romek told you where to start looking for frog cult altar.",
						[2] = "You defeated the Skurwiwij. Report back to Romek.",
						[3] = "Ask Xena for possible usage for Grazhenacore.",
					},
				},
				[6] = {
					name = "06. Sic transit gloria mundi",
					storageId = Storage.FourActTragedy.Mission06,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Ask Xena for possible usage for Grazhenacore.",
						[2] = "Try to find Grazhena deep under Hero caves.",
						[3] = "Rat Bum ran away to his cave. Chase him!",
						[4] = "You defeated the Rat Bum. Go back to Romek.",
						[5] = "You helped Romek in dealing with Rat Bum. He rewarded you for your effort.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local beastId = nil

		local spawnPos = RETRO_KNUROWO_ANCHOR:Moved(-26, -28, 6) -- 38f85df67705e9e59ab4b44bc8590644
		local fanfareSacrificePos = RETRO_KNUROWO_ANCHOR:Moved(-29, -34, 6):Moved(-2, 0, 0)

		local panpipeLever = Action()
		function panpipeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			if Creature(beastId) then
				return
			end

			local fanfare = Tile(fanfareSacrificePos):getItemById(TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.fanfare.id)

			if not fanfare then
				return false
			end
			if player:getStorageValue(Storage.FourActTragedy.Questline) ~= 5 then
				return false
			end

			beastId = Game.createMonster("Wawel Dragon", spawnPos):getId()
			player:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
			return true
		end

		panpipeLever:aid(Storage.FourActTragedy.FanfareLever)
		panpipeLever:register()
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.FourActTragedy.Questline] = 10,
			[Storage.FourActTragedy.Mission03] = 2,
		}

		local theKraken = CreatureEvent("TheKrakenKill")

		function theKraken.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.FourActTragedy.Questline)
				if storage_val ~= 9 then
					return true
				end
				player:UpdateStorages(updateStorages)
			end)
			return true
		end

		theKraken:register()
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.FourActTragedy.Questline] = 14,
			[Storage.FourActTragedy.Mission05] = 2,
		}

		local skurwiwijDeath = CreatureEvent("SkurwiwijDeath")
		function skurwiwijDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.FourActTragedy.Questline)
				if storage_val ~= 13 then
					return true
				end
				player:UpdateStorages(updateStorages)
			end)

			local deathPos = creature:getPosition()

			local corpse = Game.createItem(18021, 1, deathPos)
			corpse:setActionId(Storage.FourActTragedy.Rewards.GrazynaCore)
			corpse:setUniqueId(1000)
			return true
		end

		skurwiwijDeath:register()
	end)
	:MonsterEvent(function()
		local wawelDragon = CreatureEvent("WawelDragonDeath")

		function wawelDragon.onDeath(creature)
			local deathPos = creature:getPosition()
			local corpse = Game.createItem(31649, 1, deathPos)
			corpse:setActionId(Storage.FourActTragedy.Rewards.TimmyBag)
			return true
		end

		wawelDragon:register()
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.FourActTragedy.Questline] = 18,
			[Storage.FourActTragedy.Mission06] = 4,
		}

		local zulSzczurowDeath = CreatureEvent("ZulSzczurowDeath")

		function zulSzczurowDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.FourActTragedy.Questline)
				if storage_val ~= 17 then
					return true
				end
				player:UpdateStorages(updateStorages)
			end)

			return true
		end

		zulSzczurowDeath:register()
	end)
	:Script(function(storageToRequiredState)
		KRAKEN_ENCOUNTER_DATA = {
			actionid = Storage.FourActTragedy.KrakenAccess,
			bossName = "The Kraken",
			timerStorage = Storage.FourActTragedy.KrakenAccess,
			cooldown = "weekly",

			leverPosition = KRAKEN_ANCHOR:Moved(-5, 0, 0),
			leverId = 938,
			entranceGrid = { topLeft = KRAKEN_ANCHOR:Moved(-4, -1, 0), downRight = KRAKEN_ANCHOR:Moved(-3, 1, 0) },

			bossPos = KRAKEN_ANCHOR:Moved(-47, -19, 0),
			enterPos = KRAKEN_ANCHOR:Moved(-46, 0, 0),
			durationMinutes = 10,
			exitTeleportDestination = KRAKEN_ANCHOR:Moved(-297, -51, 2),
			exitTeleportPosition = KRAKEN_ANCHOR:Moved(-53, -23, 0),
			exitTeleportActionid = Storage.FourActTragedy.Portals.AfterKraken,
			corner1 = KRAKEN_ANCHOR:Moved(-58, -30, 0),
			corner2 = KRAKEN_ANCHOR:Moved(-33, 3, 0),

			scalingConfig = { hpPerPlayer = 1 },

			requiredStorages = { [Storage.FourActTragedy.KrakenAccess] = 1 },

			fightningPlatformPositions = {
				topLeft = KRAKEN_ANCHOR:Moved(-58, -30, 0),
				downRight = KRAKEN_ANCHOR:Moved(-33, -8, 0),
				entrance = KRAKEN_ANCHOR:Moved(-47, -15, 0),
			},
			fightingShipPositions = {
				topLeft = KRAKEN_ANCHOR:Moved(-52, -1, 0),
				downRight = KRAKEN_ANCHOR:Moved(-45, 1, 0),
			},
		}
		RegisterEncounter(KRAKEN_ENCOUNTER_DATA)

		local function startEncounter()
			Game.createMonster("Ship health", KRAKEN_ANCHOR:Moved(-49, 0, 0))
			Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-52, -1, 0))
			Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-44, 0, 0))
		end

		local krakenLever = Action()
		function krakenLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if UseEncounterLever(player, item, KRAKEN_ENCOUNTER_DATA) then
				startEncounter()
			end
		end
		krakenLever:aid(KRAKEN_ENCOUNTER_DATA.actionid)
		krakenLever:register()
	end)
	:Script(function(storageToRequiredState)
		local toModern = Position(5513, 1554, 7)
		local toRetro = RETRO_KNUROWO_ANCHOR:Moved(-63, -9, 0) -- 38f85df67705e9e59ab4b44bc8590644
		local toKolumb = Position(5909, 1233, 6)

		local tpToRetro = MoveEvent()
		function tpToRetro.onStepIn(player, item, position, fromPosition)
			if not player:isPlayer() then
				return true
			end

			if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= 1 then
				return false
			end
			player:teleportTo(toRetro)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		tpToRetro:type("stepin")
		tpToRetro:aid(Storage.FourActTragedy.Portals.ToRetro)
		tpToRetro:register()

		local tpToModern = MoveEvent()
		function tpToModern.onStepIn(player, item, position, fromPosition)
			if not player:isPlayer() then
				return true
			end

			if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= 1 then
				return false
			end
			player:teleportTo(toModern)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		tpToModern:type("stepin")
		tpToModern:aid(Storage.FourActTragedy.Portals.ToPresent)
		tpToModern:register()

		local tpToKolumb = MoveEvent()
		function tpToKolumb.onStepIn(player, item, position, fromPosition)
			if not player:isPlayer() then
				return true
			end

			player:teleportTo(toKolumb)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		tpToKolumb:type("stepin")
		tpToKolumb:aid(Storage.FourActTragedy.Portals.ToKolumb)
		tpToKolumb:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Ship health")
		local monster = {}

		monster.description = "Ship health"
		monster.experience = 0
		monster.outfit = {
			lookType = 276,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 30000
		monster.maxHealth = 30000
		monster.race = "undead"
		monster.speed = 0
		monster.manaCost = 220

		monster.changeTarget = {
			interval = 3717,
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
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = 0 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 100 },
			{ type = COMBAT_HOLYDAMAGE, percent = 100 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = false },
			{ type = "bleed", condition = false },
		}

		local function setOutfit(creature, itemId)
			local condition = Condition(CONDITION_OUTFIT)
			condition:setTicks(15 * 60 * 1000)
			condition:setOutfit({ lookTypeEx = itemId })
			creature:addCondition(condition)
		end

		mType.onAppear = function(monster, creature)
			setOutfit(monster, 4940)
		end

		mType:register(monster)
	end)
	:EncounterFight(function()
		local pylonFlam = "pylonFlam"
		local pylonVis = "pylonVis"
		local pylons = {
			[pylonFlam] = {
				power = 0,
				pos = SKURWIWIJ_ANCHOR:Moved(9, 2, 0),
				verticalTextureId = 5066,
				horizontalTextureId = 5064,
				name = pylonFlam,
				magicEffect = CONST_ME_FIREAREA,
			},
			[pylonVis] = {
				power = 0,
				pos = SKURWIWIJ_ANCHOR:Moved(9, 12, 0),
				verticalTextureId = 5069,
				horizontalTextureId = 5068,
				name = pylonVis,
				magicEffect = CONST_ME_ENERGYHIT,
			},
		}

		local function resetPylons()
			for _, pylonData in pairs(pylons) do
				pylonData.power = 0
			end
		end

		local encounter = Encounter("skurwiwij-lair", {
			timeToSpawnMonsters = "1000ms",
			bossName = "Skurwiwij",
			bossPosition = SKURWIWIJ_ANCHOR:Moved(6, 6, 0),
			zoneArea = {
				SKURWIWIJ_ANCHOR:Moved(0, 0, 0),
				SKURWIWIJ_ANCHOR:Moved(21, 17, 0),
			},
		})

		function encounter:onReset()
			encounter:removeMonsters()
		end

		function encounter:beforeStart()
			resetPylons()
			self.pylons = pylons
			self.lastPylon = self.pylons[pylonFlam]
			self.explosionsCount = 0
			self.baseExplosionDamage = 200
			self.damagePerConsecutiveExplosion = 50
		end

		encounter:addSpawnMonsters({
			{
				name = encounter.bossName,
				positions = {
					encounter.bossPosition,
				},
				spawn = function(monster)
					encounter.skurwiwij = monster
				end,
			},
		})

		encounter:addRemoveMonsters()
		encounter:startOnEnter()
		encounter:register()

		local channelPowerInterval = 400
		local empowerPylons = GlobalEvent("encounter.skurwiwij-lair.empower-pylons")
		function empowerPylons.onThink()
			if not encounter:isActive() then
				return true
			end
			if not encounter.skurwiwij then
				return true
			end

			local skurwiwijPos = encounter.skurwiwij:getPosition()
			local closestPylon = {}
			local closestPylonDistance = 999
			for pylonName, pylonData in pairs(pylons) do
				local distance = pylonData.pos:EuclideanDistance(skurwiwijPos)
				if distance <= closestPylonDistance then
					closestPylonDistance = distance
					closestPylon = pylonData
				end
			end

			if encounter.lastPylon ~= closestPylon then
				TriggerPylonExplosion(encounter.lastPylon)
				encounter.lastPylon = closestPylon
				closestPylon.power = closestPylon.power + 1
			end
			closestPylon.pos:DrawLine(
				encounter.skurwiwij:getPosition(),
				closestPylon.verticalTextureId,
				closestPylon.horizontalTextureId,
				channelPowerInterval
			)

			return true
		end
		empowerPylons:interval(channelPowerInterval)
		empowerPylons:register()

		local function tryDamagePlayer(pos, damage)
			local tile = Tile(pos)
			if not tile then
				return
			end
			local creature = tile:getTopCreature()
			if not creature then
				return
			end
			if creature:isPlayer() or creature:getMaster() then
				doTargetCombatHealth(0, creature, COMBAT_PHYSICALDAMAGE, -damage, -damage, CONST_ME_NONE)
			end
		end

		local function drawDamagingSqm(pos, damage, magicEffect)
			pos:sendMagicEffect(magicEffect)
			tryDamagePlayer(pos, damage)
		end

		local function drawDamagingSqms(pos, x, y, damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 + x, 0 + y, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 + y, 0 + x, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 - y, 0 + x, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 - x, 0 + y, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 - x, 0 - y, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 - y, 0 - x, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 + y, 0 - x, 0), damage, magicEffect)
			drawDamagingSqm(pos:Moved(0 + x, 0 - y, 0), damage, magicEffect)
		end

		local function drawDamagingRing(radius, centerPos, damage, magicEffect)
			local x = radius
			local y = 0
			local decision = 1 - x
			while y <= x do
				drawDamagingSqms(centerPos, x, y, damage, magicEffect)
				y = y + 1
				if decision <= 0 then
					decision = decision + 2 * y + 1
				else
					x = x - 1
					decision = decision + 2 * (y - x) + 1
				end
			end
		end

		local pylonExplosionMaxRadius = 13
		local pylonExplosionsInterval = 500
		local function drawPylonExplosion(i, pos, damage, magicEffect)
			if i > pylonExplosionMaxRadius then
				return
			end
			drawDamagingRing(i, pos, damage, magicEffect)
			i = i + 1
			addEvent(function()
				drawPylonExplosion(i, pos, damage, magicEffect)
			end, pylonExplosionsInterval)
		end

		function TriggerPylonExplosion(pylon)
			local damage = encounter.baseExplosionDamage
				+ encounter.damagePerConsecutiveExplosion * encounter.explosionsCount
			if pylon.power < 25 then
				damage = damage * 2
			end
			pylon.power = 0

			drawPylonExplosion(0, pylon.pos, damage, pylon.magicEffect)
			encounter.explosionsCount = encounter.explosionsCount + 1
		end
	end)
	:EncounterLever(function()
		local skurwiwijLever = {
			encounterName = "skurwiwij-lair",

			lockoutTime = LOCKOUT_TIME.WEEKLY,
			lockoutType = LOCKOUT_TYPE.ON_KILL,

			entranceTiles = {
				{ pos = Position(6577, 557, 9), destination = Position(6546, 543, 9) },
				{ pos = Position(6578, 557, 9), destination = Position(6547, 543, 9) },
				{ pos = Position(6579, 557, 9), destination = Position(6548, 543, 9) },
				{ pos = Position(6580, 557, 9), destination = Position(6549, 543, 9) },
			},

			exitTpDestination = Position(6582, 557, 9),
			exitTpPosition = SKURWIWIJ_ANCHOR:Moved(19, 9, 0),

			-- ToDo: hp and (slight) damage scaling
			-- scalingConfig = { hpPerPlayer = 1 },

			requiredState = { [Storage.FourActTragedy.SkurwiwijAccess] = 1 },
		}

		EncounterLever(skurwiwijLever):position(Position(6576, 557, 9)):register()
	end)
	:Script(function(storageToRequiredState)
		local slippersTp = Action()
		function slippersTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.FourActTragedy.Questline)
			if storageVal < 11 or 12 < storageVal then
				return false
			end

			local playerPos = player:getPosition()
			if playerPos.x > item:getPosition().x then
				player:teleportTo(playerPos:Moved(-2, 0, 0))
			elseif playerPos.x < item:getPosition().x then
				player:teleportTo(playerPos:Moved(2, 0, 0))
			end
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		slippersTp:aid(Storage.FourActTragedy.SlippersTorch)
		slippersTp:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Wawel Dragon")
		local monster = {}

		monster.description = "a Wawel Dragon"
		monster.experience = 4999
		monster.outfit = {
			lookType = 1190,
			lookHead = 143,
			lookBody = 2,
			lookLegs = 94,
			lookFeet = 94,
		}

		monster.health = 3500
		monster.maxHealth = 3500
		monster.speed = 100
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 3500,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 70,
			health = 10,
			damage = 10,
			random = 10,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = true,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 20,
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

		monster.events = {
			"WawelDragonDeath",
		}

		monster.voices = {
			interval = 4999,
			chance = 10,
		}

		monster.loot = {
			{ name = "demonic essence", chance = 100000, maxCount = 2 },
			{ id = 4086, chance = 100000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -420 },
			{
				name = "combat",
				interval = 1245,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -180,
				maxDamage = -220,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 1787,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -180,
				maxDamage = -220,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 1345,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -180,
				length = 8,
				spread = 3,
				effect = CONST_ME_FIREAREA,
				target = false,
			},
			{
				name = "combat",
				interval = 1962,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -180,
				length = 8,
				spread = 3,
				effect = CONST_ME_FIREAREA,
				target = false,
			},
			{
				name = "firefield",
				interval = 2000,
				chance = 40,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				target = true,
			},
		}

		monster.defenses = {
			defense = 25,
			armor = 25,
			{
				name = "combat",
				interval = 2000,
				chance = 25,
				type = COMBAT_HEALING,
				minDamage = 100,
				maxDamage = 500,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = -10 },
			{ type = COMBAT_HOLYDAMAGE, percent = -25 },
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
		local zulSzczurowEncounter = {
			actionid = Storage.FourActTragedy.ZulSzczurowAccess,
			bossName = "Zul Szczurow",
			timerStorage = Storage.FourActTragedy.ZulSzczurowAccess,
			cooldown = "weekly",

			leverPosition = ZUL_SZCZUROW_ANCHOR:Moved(0, -7, 0),
			entranceGrid = {
				topLeft = ZUL_SZCZUROW_ANCHOR:Moved(0, -6, 0),
				downRight = ZUL_SZCZUROW_ANCHOR:Moved(0, -3, 0),
			},

			bossPos = ZUL_SZCZUROW_ANCHOR:Moved(-3, -9, 1),
			enterPos = ZUL_SZCZUROW_ANCHOR:Moved(11, 1, 1),
			durationMinutes = 10,
			exitTeleportDestination = ZUL_SZCZUROW_ANCHOR:Moved(0, 0, 0),
			exitTeleportPosition = ZUL_SZCZUROW_ANCHOR:Moved(-8, 8, 1),
			exitTeleportActionid = Storage.FourActTragedy.Portals.AfterZulSzczurow,
			corner1 = ZUL_SZCZUROW_ANCHOR:Moved(-13, 12, 1),
			corner2 = ZUL_SZCZUROW_ANCHOR:Moved(16, -17, 1),

			scalingConfig = { hpPerPlayer = 1 },

			requiredStorages = { [Storage.FourActTragedy.ZulSzczurowAccess] = 1 },
		}
		RegisterEncounter(zulSzczurowEncounter)

		local function startEncounter()
			Game.createMonster("Zul zulow", ZUL_SZCZUROW_ANCHOR:Moved(1, -8, 1))
		end

		local zulLever = Action()
		function zulLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if UseEncounterLever(player, item, zulSzczurowEncounter) then
				startEncounter()
			end
		end
		zulLever:aid(zulSzczurowEncounter.actionid)
		zulLever:register()
	end)
	:MonsterEvent(function()
		local zulZulowDeath = CreatureEvent("ZulZulowDeath")
		function zulZulowDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			local deathPos = creature:getPosition()
			local name = creature:getName()

			addEvent(function()
				for _ = 1, 2 do
					Game.createMonster(name, deathPos)
				end
			end, 1500)
			return true
		end

		zulZulowDeath:register()
	end)

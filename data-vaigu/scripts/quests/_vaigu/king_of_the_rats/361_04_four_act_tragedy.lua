local quest = Quest(LOCALIZERS.FourActTragedy)

quest
	:Storage(function()
		Storage.FourActTragedy = {
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
		QuestState.FourActTragedy = {
			Mission01 = {
				AskRomekForMission = 1,
				NegotiateWithTurdstin = 2,
				ReportToRomek = 3,
			},
			Mission02 = {
				FindSomeoneInKnurow = 1,
				FindTimmyEquipment = 2,
				ReturnEquipmentToTimmy = 3,
				FindMagicDust = 4,
				ReportToRomek = 5,
			},
			Mission03 = {
				FindAndKillLewiatan = 1,
				ReportToRomek = 2,
			},
			Mission04 = {
				FindBribeslippers = 1,
				BringSlippersToRomek = 2,
				FindAndKillSkurwiwij = 3,
				ReportToRomek = 4,
			},
			Mission05 = {
				FindXena = 1,
				FindGrazhena = 2,
				KillRatBum = 3,
				ReportToRomek = 4,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.FourActTragedy = {
			TimmyPowder = {
				id = 6548,
				aid = Storage.FourActTragedy.Rewards.Powder,
				desc = "Elvish dust. Timmy might be needing this",
			},
			TimmyBag = {
				id = 3141,
				aid = Storage.FourActTragedy.Rewards.TimmyBag,
				desc = "Timmy belongings. He might be needing them",
			},
			Fanfare = {
				id = 2954,
				desc = "Mysterius instrument. Most curious monsters can it allure. Put it down on the stone and play...",
			},
			GrazynaCore = {
				id = 20342,
				aid = Storage.FourActTragedy.Rewards.GrazynaCore,
				desc = "Grazhena Core i3",
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Four Act Tragedy",
			missions = {
				[Storage.FourActTragedy.Mission01] = {
					name = "01. Dodge those compensation claims",
					states = {
						[QuestState.FourActTragedy.Mission01.AskRomekForMission] = "Romek mentioned you should as him for mission.",
						[QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin] = "Go to HF-P/X agent - turdstin.",
						[QuestState.FourActTragedy.Mission01.ReportToRomek] = "Return to romek and talk to him about HF-P/X case.",
						[MISSION_FINISHED] = "Romek sent you to Knurow. Try to find a way to go back in time there.",
					},
				},
				[Storage.FourActTragedy.Mission02] = {
					name = "02. Bottom tex_L",
					states = {
						[QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow] = "Find someone who can show you around.",
						[QuestState.FourActTragedy.Mission02.FindTimmyEquipment] = "Timmy asked you to find his equipment that was stolen by bandits.",
						[QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy] = "You found timmy belongings. Return to him and give them back.",
						[QuestState.FourActTragedy.Mission02.FindMagicDust] = "Timmy needs elvish dust to perform his magic. Try finding it on nearby mountain.",
						[QuestState.FourActTragedy.Mission02.ReportToRomek] = "Timmy told you that he will already have helped you in the future. Go back to Romek.",
						[MISSION_FINISHED] = "You told romek about Timmy work.",
					},
				},
				[Storage.FourActTragedy.Mission03] = {
					name = "03. Master Baitor",
					states = {
						[QuestState.FourActTragedy.Mission03.FindAndKillLewiatan] = "Romek asked you to buy him a beer at nearby Lewiatan.",
						[QuestState.FourActTragedy.Mission03.ReportToRomek] = "You defeated the kraken. Go back to Romek.",
						[MISSION_FINISHED] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
					},
				},
				[Storage.FourActTragedy.Mission04] = {
					name = "04. Non omnis moriar",
					states = {
						[QuestState.FourActTragedy.Mission04.FindBribeslippers] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
						[QuestState.FourActTragedy.Mission04.BringSlippersToRomek] = "You found the Bribeslippers. Report back to Romek.",
						[QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij] = "Romek told you to follow the trail leading to the frog cult altar. Search the northern kongo.",
						[QuestState.FourActTragedy.Mission04.ReportToRomek] = "You defeated the Skurwiwij. Report back to Romek.",
						[MISSION_FINISHED] = "Ask Xena for possible usage of Grazhenacore.",
					},
				},
				[Storage.FourActTragedy.Mission05] = {
					name = "06. Sic transit gloria mundi",
					states = {
						[QuestState.FourActTragedy.Mission05.FindXena] = "Ask Xena for possible usage of Grazhenacore.",
						[QuestState.FourActTragedy.Mission05.FindGrazhena] = "Try to find Grazhena deep under Hero caves.",
						[QuestState.FourActTragedy.Mission05.KillRatBum] = "Rat Bum ran away to his cave. Chase him!",
						[QuestState.FourActTragedy.Mission05.ReportToRomek] = "You defeated the Rat Bum. Go back to Romek.",
						[MISSION_FINISHED] = "You helped Romek in dealing with Rat Bum. He rewarded you for your effort.",
					},
				},
			},
		}
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.ReportToRomek,
		}

		local krakenDeath = CreatureEvent("TheKrakenDeath")

		function krakenDeath.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.FourActTragedy.Mission03) ~= QuestState.FourActTragedy.Mission03.FindAndKillLewiatan then
					return true
				end

				player:NextState(nextState)
			end)
			return true
		end

		krakenDeath:register()
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
	:Monster(function()
		local mType = Game.createMonsterType("Skurwiwij")
		local monster = {}

		monster.description = "a Skurwiwij"
		monster.experience = 50000
		monster.outfit = {
			lookType = 544,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 10000
		monster.maxHealth = 10000
		monster.race = "undead"
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

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.events = {
			"SkurwiwijDeath",
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
			{ name = "skurwiwij energy missile", interval = 2100, chance = 100, minDamage = 0, maxDamage = 0, target = true },
			{ name = "skurwiwij fire missile", interval = 2000, chance = 100, minDamage = 0, maxDamage = 0, target = true },
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
			{ type = "bleed", condition = true },
		}

		mType:register(monster)
	end)
	:EncounterData(function()
		print("Quest:EncounterData", "skurwiwij")
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

		local skurwiwijEncounter = EncounterData({
			timeToSpawnMonsters = "3000ms",
			bossName = "Skurwiwij",
			bossPosition = SKURWIWIJ_ANCHOR:Moved(6, 6, 0),
			zoneArea = {
				SKURWIWIJ_ANCHOR:Moved(0, 0, 0),
				SKURWIWIJ_ANCHOR:Moved(21, 17, 0),
			},
			encounterName = EncounterNames.SkurwiwijLair,

			lockoutTime = LOCKOUT_TIME.WEEKLY,
			lockoutType = LOCKOUT_TYPE.ON_KILL,

			leverPosition = Position(6576, 557, 9),
			entranceTiles = {
				{ pos = Position(6577, 557, 9), destination = Position(6546, 543, 9) },
				{ pos = Position(6578, 557, 9), destination = Position(6547, 543, 9) },
				{ pos = Position(6579, 557, 9), destination = Position(6548, 543, 9) },
				{ pos = Position(6580, 557, 9), destination = Position(6549, 543, 9) },
			},

			exitTpDestination = Position(6582, 557, 9),
			exitTpPosition = SKURWIWIJ_ANCHOR:Moved(19, 9, 0),

			requiredState = { [Storage.FourActTragedy.SkurwiwijAccess] = { min = ACCESS_GRANTED } },
		})

		function skurwiwijEncounter:onReset()
			skurwiwijEncounter:removeMonsters()
		end

		function skurwiwijEncounter:beforeStart()
			resetPylons()
			self.pylons = pylons
			self.lastPylon = self.pylons[pylonFlam]
			self.explosionsCount = 0
			self.baseExplosionDamage = 200
			self.damagePerConsecutiveExplosion = 50
		end

		skurwiwijEncounter:addSpawnMonsters({
			{
				name = skurwiwijEncounter.bossName,
				positions = {
					skurwiwijEncounter.bossPosition,
				},
				spawn = function(monster)
					ActiveEncounterRegistry:MapCreature(skurwiwijEncounter, monster)
				end,
			},
		})

		skurwiwijEncounter:addRemoveMonsters()
		skurwiwijEncounter:startOnEnter()
		skurwiwijEncounter:register()

		local channelPowerInterval = 400
		local empowerPylons = GlobalEvent("encounter.skurwiwij-lair.empower-pylons")
		function empowerPylons.onThink()
			if not skurwiwijEncounter:isActive() then
				return true
			end
			if not skurwiwijEncounter.skurwiwij then
				return true
			end

			local skurwiwijPos = skurwiwijEncounter.skurwiwij:getPosition()
			local closestPylon = {}
			local closestPylonDistance = 999
			for pylonName, pylonData in pairs(pylons) do
				local distance = pylonData.pos:EuclideanDistance(skurwiwijPos)
				if distance <= closestPylonDistance then
					closestPylonDistance = distance
					closestPylon = pylonData
				end
			end

			if skurwiwijEncounter.lastPylon ~= closestPylon then
				TriggerPylonExplosion(skurwiwijEncounter.lastPylon)
				skurwiwijEncounter.lastPylon = closestPylon
				closestPylon.power = closestPylon.power + 1
			end
			closestPylon.pos:DrawLine(skurwiwijEncounter.skurwiwij:getPosition(), closestPylon.verticalTextureId, closestPylon.horizontalTextureId, channelPowerInterval)

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
			local damage = skurwiwijEncounter.baseExplosionDamage + skurwiwijEncounter.damagePerConsecutiveExplosion * skurwiwijEncounter.explosionsCount
			if pylon.power < 25 then
				damage = damage * 2
			end
			pylon.power = 0

			drawPylonExplosion(0, pylon.pos, damage, pylon.magicEffect)
			skurwiwijEncounter.explosionsCount = skurwiwijEncounter.explosionsCount + 1
		end
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
	:Mission(Storage.FourActTragedy.Mission01)
	:State(
		QuestState.FourActTragedy.Mission01.AskRomekForMission,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission", "zadanie" }] = {
				text = "Before I forget - the reward for the previous task: {axe}, {sword}, {mace}, {bow}, {rod}, {wand} (exercise weapon).",
			},
			[{ "axe", "sword", "mace", "bow", "rod", "wand" }] = {
				text = "Ehh... before I tell you what's next, we need to deal with the HF-P/X insurance agent. You probably know him - they call him Turdstin.",
				nextState = {
					[Storage.FourActTragedy.Mission01] = QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin,
				},
				rewards = { ExerciseWeaponBox(3000) },
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Turdstin lives in the slums, Mirko. His life professions include homelessness, MGTOW, collecting cans, and being an insurance agent.",
			},
		}),
		QuestFactory.Dialog("xXxTurdstinxXx", {
			[{ "mission" }] = {
				text = "Good day person |PLAYERNAME|. We are here to {discuss} compensation claims related to the 'accident' in which Mr. HF-P/X was injured.",
			},
			[{ "omowic", "discuss" }] = {
				text = "According to our information, you {was} the main cause of the accident that resulted in Mr. HF-P/X's injuries.",
			},
			[{ "byl", "was" }] = {
				text = "In that case, please send the documents, and our team of specialists shh butt butt butt kshhhh. Oh, damn, my throat recorder broke. Umm... okay, I was lying about the insurance. But understand me - ever since the emperor took my lands, I have to fight for them, which has made me even more homeless.",
				nextState = {
					[Storage.FourActTragedy.Mission01] = QuestState.FourActTragedy.Mission01.ReportToRomek,
				},
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission01.ReportToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Well, hes just the smartest person in the world. Okay, let's not waste any more time. After HF-P/X's death, a time-delayed mechanism was activated, which opened a portal to the past. Now immigrants are flooding in from everywhere. Go to the portal in Knurow and head to the Knurow of the past. Find someone there who will help you with the task of stopping the influx of immigrants.",
				nextState = {
					[Storage.FourActTragedy.Mission01] = MISSION_FINISHED,
					[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow,
					[Storage.FourActTragedy.RetroKnurowoAccess] = ACCESS_GRANTED,
				},
			},
		})
	)
	:Mission(Storage.FourActTragedy.Mission02)
	:State(
		QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "I told you to use the portal in Knurow, although I don't remember exactly where it was located. Something tells me it was somewhere along the shore...",
			},
		}),
		QuestFactory.Dialog("Woody", {
			[{ "portal", "teleport", "retro", "past", "przeszlosc" }] = {
				text = "Back when i was young we sat around the fireplace and we could teleport anywhere using power of our imagination.",
			},
		}),
		QuestFactory.Dialog("Timmy", {
			[{ "mission" }] = {
				text = "It seems I got lost in the corridors of time. I have vague memories from the future that I am a bouncer in my hometown. I think I could help you with the immigrant influx, but first, I need to reconcile with my present self. Find my equipment stolen by bandits, and I will help you.",
				nextState = {
					[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindTimmyEquipment,
					[Storage.FourActTragedy.WawelDragonAccess] = ACCESS_GRANTED,
				},
			},
		}),
		QuestFactory.Script(function(missionState)
			local toModern = Position(5513, 1554, 7)
			local toRetro = RETRO_KNUROWO_ANCHOR:Moved(-63, -9, 0)

			local tpToRetro = MoveEvent()
			function tpToRetro.onStepIn(player, item, position, fromPosition)
				if not player:isPlayer() then
					return true
				end

				if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= ACCESS_GRANTED then
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

				if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= ACCESS_GRANTED then
					return false
				end
				player:teleportTo(toModern)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end

			tpToModern:type("stepin")
			tpToModern:aid(Storage.FourActTragedy.Portals.ToPresent)
			tpToModern:register()
		end),
		QuestFactory.StartupItems({
			{ pos = { 5514, 1555, 7 }, id = 2000, aid = Storage.FourActTragedy.Portals.ToRetro },
		}),
		QuestFactory.StartupItems({
			{ pos = { -62, -8, 0 }, id = 2000, aid = Storage.FourActTragedy.Portals.ToPresent },
		}, RETRO_KNUROWO_ANCHOR)
	)
	:State(
		QuestState.FourActTragedy.Mission02.FindTimmyEquipment,
		QuestFactory.Dialog("Timmy", {
			[{ "mission" }] = {
				text = "I don't know where they moved my stuff to.",
			},
		}),
		QuestFactory.Script(function(missionState)
			local beastId = nil

			local spawnPos = RETRO_KNUROWO_ANCHOR:Moved(-26, -28, 6)
			local fanfareSacrificePos = RETRO_KNUROWO_ANCHOR:Moved(-29, -34, 6):Moved(-2, 0, 0)

			local panpipeLever = Action()
			function panpipeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end
				if Creature(beastId) then
					return
				end

				local fanfare = Tile(fanfareSacrificePos):getItemById(QuestKeyItems.FourActTragedy.Fanfare.id)

				if not fanfare then
					return false
				end
				if player:getStorageValue(Storage.FourActTragedy.Mission01) ~= 5 then
					return false
				end

				beastId = Game.createMonster("Wawel Dragon", spawnPos):getId()
				player:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
				return true
			end

			panpipeLever:aid(Storage.FourActTragedy.FanfareLever)
			panpipeLever:register()
		end),
		QuestFactory.StartupItems({
			{
				id = 31649,
				actionid = Storage.FourActTragedy.Rewards.TimmyBag,
				rewards = { QuestKeyItems.FourActTragedy.TimmyBag },
				nextState = {
					[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy,
				},
			},
		}),
		QuestFactory.StartupItems({
			{
				pos = { -8, -15, 6 },
				id = 11809,
				actionid = Storage.FourActTragedy.Rewards.Fanfare,
				rewards = { QuestKeyItems.FourActTragedy.Fanfare },
			},
			{ pos = { -29, -34, 6 }, id = 2773, aid = Storage.FourActTragedy.FanfareLever },
			{ pos = { -24, -23, 6 }, id = 7723, aid = Storage.FourActTragedy.WawelDragonAccess },
		}, RETRO_KNUROWO_ANCHOR)
	)
	:State(
		QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy,
		QuestFactory.Dialog("Timmy", {
			[{ "mission" }] = {
				text = "Thank you, that's mine. Okay, now I'm going back to the {present}!",
				requiredItems = {
					QuestKeyItems.FourActTragedy.TimmyBag,
				},
				textNoRequiredItems = "Are you sure you didn't lose any of my stuff along the way?",
				nextState = {
					[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindMagicDust,
				},
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission02.FindMagicDust,
		QuestFactory.Dialog("Timmy", {
			[{ "mission", "present", "terazniejszosci" }] = {
				text = "Tell Tomek that I will deal with those refugees as soon as I can. Actually, I've already dealt with them. Yeah, the paradoxes of time travel. And one more thing: the person responsible for convincing immigrants to use the HF-P/X portal was none other than Rat Bum.",
				requiredItems = {
					QuestKeyItems.FourActTragedy.TimmyPowder,
				},
				textNoRequiredItems = "My magic doesn't seem to work. We'll need elven spells. Go to the elves' rock and get some magical powder that I can use for the ritual. Watch out for the dormant Soros foundations. I've seen that they too got lost in this world.",
				nextState = {
					[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.ReportToRomek,
				},
			},
		}),
		QuestFactory.StartupItems({
			{
				pos = { 61, 21, -1 },
				id = 4073,
				actionid = Storage.FourActTragedy.Rewards.Powder,
				rewards = {
					QuestKeyItems.FourActTragedy.TimmyPowder,
				},
			},
		}, RETRO_KNUROWO_ANCHOR)
	)
	:State(
		QuestState.FourActTragedy.Mission02.ReportToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "So, it's Rat Bum. Hmm, but in the memes, it said that Rat Bum can't do anything. I know his origin. I would like to tell you where to find him, but currently, he is protected by a narrative armor. So, I suggest you go get some beer at Lewiatan now.",
				nextState = {
					[Storage.FourActTragedy.Mission02] = MISSION_FINISHED,
					[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.FindAndKillLewiatan,
					[Storage.FourActTragedy.KrakenAccess] = ACCESS_GRANTED,
				},
			},
		})
	)
	:Mission(Storage.FourActTragedy.Mission03)
	:State(
		QuestState.FourActTragedy.Mission03.FindAndKillLewiatan,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "If you don't know where to find the nearest Lewiatan, ask Christopher Columbus.",
			},
		}),
		QuestFactory.Script(function(missionState)
			local toKolumb = Position(5909, 1233, 6)

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
		end),
		QuestFactory.StartupItems({
			{ pos = { 5977, 1178, 6 }, id = 1949, aid = Storage.FourActTragedy.Portals.ToKolumb },
		}),
		QuestFactory.Script(function(missionState)
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

				requiredStorages = { [Storage.FourActTragedy.KrakenAccess] = { min = ACCESS_GRANTED } },

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
	)
	:MonsterEvent(function()
		local nextState = {
			[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.ReportToRomek,
		}

		local skurwiwijDeath = CreatureEvent("SkurwiwijDeath")
		function skurwiwijDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.FourActTragedy.Mission01) ~= QuestState.FourActTragedy.Mission03.FindAndKillLewiatan then
					return true
				end

				player:NextState(nextState)
			end)

			local deathPos = creature:getPosition()

			local corpse = Game.createItem(18021, 1, deathPos)
			corpse:setActionId(Storage.FourActTragedy.Rewards.GrazynaCore)
			corpse:setUniqueId(1000)
			return true
		end

		skurwiwijDeath:register()
	end)
	:State(
		QuestState.FourActTragedy.Mission03.ReportToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "But I wasn't talking about some monster, just that shop on the corner. During that time, I went to Walmart to get heineken because I couldn't wait for you. Now, back to the point. I recalled this old story: people from the northeast whisper about certain {slippers} that Rat Bum nibbled on. They say he tried to steal them from his Master, who, under the influence of slippers, descended into the abyss of corruption. The prophecy was funded by the Ministry of State Security of the People's Republic of China.",
			},
			[{ "slippers", "kapciach" }] = {
				text = "Rumors have it that after the death of the aforementioned ruler, the slippers were buried with him. However, it is unknown where this burial place is. As I mentioned, all rumors about the origin of the slippers started with the inhabitants of the northern lands. I think it could be Rats collaborating with banshees. Search the corridors of their base. If you manage to find these slippers, based on the tooth pattern that bit the front part of the boot, we will find a matching profile on onlyfangs.com.",
				nextState = {
					[Storage.FourActTragedy.Mission03] = MISSION_FINISHED,
					[Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.FindBribeslippers,
				},
			},
		})
	)
	:Mission(Storage.FourActTragedy.Mission04)
	:State(
		QuestState.FourActTragedy.Mission04.FindBribeslippers,
		QuestFactory.Dialog("GM Romek", { [{ "mission" }] = {
			text = "Ruins are located in the northern part of Kongo",
		} }),
		QuestFactory.StartupItems({
			{ pos = { 6966, 664, 13 }, id = 2943, aid = Storage.FourActTragedy.SlippersTorch },
		}),
		QuestFactory.StartupItems({
			{
				pos = { 6962, 664, 14 },
				id = 1983,
				actionid = Storage.FourActTragedy.Rewards.SlippersChest,
				uid = 1000,
				rewards = { QuestKeyItems.KingOfRatsHQ.Bribeslippers },
				nextState = { [Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.BringSlippersToRomek },
				desc = "Rest is peace\n~Followers of The Frog Cult",
			},
		}),
		QuestFactory.Script(function(missionState)
			local slippersTp = Action()
			function slippersTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				local storageVal = player:getStorageValue(Storage.FourActTragedy.Mission01)
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
	)
	:State(
		QuestState.FourActTragedy.Mission04.BringSlippersToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Did you find anything about slippers owner?",
			},
			[{
				"oltarz weza",
				"oltarz",
				"waz",
				"weza",
				"frog cult",
				"frog",
				"cult",
			}] = {
				text = "Try to search in the underground ruins in the Kongo. This place was inhabited long ago by medusas, hydras, and other writhing creatures, and it is overgrown with foul flora. An ideal place for an altar for serpentine gods.",
				nextState = {
					[Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij,
					[Storage.FourActTragedy.SkurwiwijAccess] = ACCESS_GRANTED,
					[Storage.FourActTragedy.SkurwiwijDoor] = ACCESS_GRANTED,
				},
			},
			[{ ANY_MESSAGE }] = {
				text = "Your eyes will open when mine are long closed",
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij,
		QuestFactory.StartupItems({
			{ pos = { 6581, 557, 9 }, id = 5131, aid = Storage.FourActTragedy.SkurwiwijDoor },
		})
	)
	:State(
		QuestState.FourActTragedy.Mission04.ReportToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Grazhena Core? Hmm... My mother Xena once belonged to a rural housewives club. Ask her if she knows more about this object. She is the leader of the feminists. Maybe you've already met her.",
				requiredItems = {
					QuestKeyItems.FourActTragedy.GrazynaCore,
				},
				removeRequiredItems = false,
				textNoRequiredItems = "Skurwiwij had Grazhenacore, and you lost it? Come back when you find your lost item.",
				nextState = {
					[Storage.FourActTragedy.Mission04] = MISSION_FINISHED,
					[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.FindXena,
				},
			},
		})
	)
	:Mission(Storage.FourActTragedy.Mission05)
	:State(
		QuestState.FourActTragedy.Mission05.FindXena,
		QuestFactory.Dialog("Xe'na", {
			[{ "mission", "grazhenacore", "grazynacore", "grazyna", "grazhena" }] = {
				requiredItems = {
					QuestKeyItems.FourActTragedy.GrazynaCore,
				},
				textNoRequiredItems = "Come back when you have Grazhenacore with you.",
				text = "The existence of cancercontent is necessary if we want to maintain the balance of the universe. The cringe factory of rural housewives' kept our world at rest until recently when Grazhena Core was stolen. I will now take Grazhenacore from you. Try to find Grazhena in the prison. Self-proclaimed heroes from the eastern part of the city have locked her in the depths of their dungeons. Now she is forced to live among nightmare creatures.",
				nextState = {
					[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.FindGrazhena,
					[Storage.FourActTragedy.GrazhenaDoor] = ACCESS_GRANTED,
				},
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission05.FindGrazhena,
		QuestFactory.StartupItems({
			{ pos = { 6005, 1386, 12 }, id = 5131, aid = Storage.FourActTragedy.GrazhenaDoor },
		}),
		QuestFactory.Dialog("Grazhena", {
			[{ GREET }] = {
				text = "They locked me in here and blocked the exit with magical doors that I can't pass in my current state. You know what? Something is {itching} me here.",
			},
			[{ "itchy", "swedzi", "itching" }] = {
				text = "It's Rat Bum! I have Rat Bum in my pants! When I pull him out, he jumps back in. {Help} me deal with him!",
			},
			[{ "help", "pomoz" }] = {
				text = "He jumped out! You must have scared him! He jumped into that hole, which is too small for a human. There's some hole in front of my cell. Perhaps it leads to the same cave where that rascal fled!",
				nextState = {
					[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.KillRatBum,
					[Storage.FourActTragedy.ZulSzczurowAccess] = ACCESS_GRANTED,
				},
			},
		})
	)
	:State(
		QuestState.FourActTragedy.Mission05.KillRatBum,
		QuestFactory.Dialog("Grazhena", { [{ "mission" }] = {
			text = "Cave entrance is just before the cell. Im gonna wait here.",
		} }),
		QuestFactory.StartupItems({
			{
				id = 18021,
				actionid = Storage.FourActTragedy.Rewards.GrazynaCore,
				rewards = { QuestKeyItems.FourActTragedy.GrazynaCore },
			},
		})
	)
	:EncounterData(function()
		local ratbumLever = {
			encounterName = "zul-szczurow-lair",

			lockoutTime = LOCKOUT_TIME.WEEKLY,
			lockoutType = LOCKOUT_TYPE.ON_KILL,

			entranceTiles = {
				{ pos = ZUL_SZCZUROW_ANCHOR:Moved(0, -6, 0), destination = ZUL_SZCZUROW_ANCHOR:Moved(9, 1, 1) },
				{ pos = ZUL_SZCZUROW_ANCHOR:Moved(0, -5, 0), destination = ZUL_SZCZUROW_ANCHOR:Moved(10, 1, 1) },
				{ pos = ZUL_SZCZUROW_ANCHOR:Moved(0, -4, 0), destination = ZUL_SZCZUROW_ANCHOR:Moved(11, 1, 1) },
				{ pos = ZUL_SZCZUROW_ANCHOR:Moved(0, -3, 0), destination = ZUL_SZCZUROW_ANCHOR:Moved(12, 1, 1) },
			},

			exitTpDestination = ZUL_SZCZUROW_ANCHOR:Moved(0, 0, 0),
			exitTpPosition = ZUL_SZCZUROW_ANCHOR:Moved(-8, 8, 1),

			-- ToDo: hp and (slight) damage scaling
			-- scalingConfig = { hpPerPlayer = 1 },

			requiredState = { [Storage.FourActTragedy.ZulSzczurowAccess] = ACCESS_GRANTED },
		}

		--39f
		--Encounter(ratbumLever):Register()
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.FourActTragedy.Mission06] = QuestState.FourActTragedy.Mission05.ReportToRomek,
		}

		local zulSzczurowDeath = CreatureEvent("ZulSzczurowDeath")

		function zulSzczurowDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.FourActTragedy.Mission05) ~= QuestState.FourActTragedy.Mission05.KillRatBum then
					return true
				end
				player:NextState(updateStorages)
			end)

			return true
		end

		zulSzczurowDeath:register()
	end)
	:State(
		QuestState.FourActTragedy.Mission05.ReportToRomek,
		QuestFactory.Dialog("Grazhena", {
			[{ "mission" }] = {
				text = "I'll now return to the village and meet my friends from my club. Thank you for your help.",
			},
		}),
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Thanks for your help. Here's your reward for completing the task: {axe}, {sword}, {mace}, {bow}, {rod}, {wand} (exercise weapon).",
			},
			[{ "axe", "sword", "mace", "bow", "rod", "wand" }] = {
				text = "If you have a moment, go to the summit of the highest mountain in the Caribbean. You might find someone there whom you once knew.",
				nextState = {
					[Storage.FourActTragedy.Mission06] = MISSION_FINISHED,
					[Storage.Finished.FourActTragedy] = MISSION_FINISHED,
					[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.HeadToHighestMountain,
					[Storage.FourActTragedy.GrazhenaDoor] = MISSION_NOT_STARTED,
				},
				rewards = { ExerciseWeaponBox(3500) },
			},
		})
	)
	:Register()

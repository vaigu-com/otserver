local quest = Quest("three_sramatians_and_the_dragon")
quest
	:Storage(function()
		Storage.ThreeSramatiansAndTheDragon = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			Mission07 = NextStorage(),
			Mission08 = NextStorage(),
			Mission09 = NextStorage(),
			Mission10 = NextStorage(),
			HfpxAccess = NextStorage(),
			GoldblumTrap = NextStorage(),
			Fireplaces = {
				Hive = NextStorage(),
				Lagoon = NextStorage(),
				Souleater = NextStorage(),
				WaterWell = NextStorage(),
				Hairycles = NextStorage(),
				Hellspawns = NextStorage(),
			},
			Rewards = {
				Rum = NextStorage(),
				DeepCrystal = NextStorage(),
				Rune1 = NextStorage(),
				Rune2 = NextStorage(),
				Rune3 = NextStorage(),
			},
			AbandonedFireplace = NextStorage(),
			VampireCityTrap = NextStorage(),
			RatOfKingsTile = NextStorage(),
			Portals = { AfterHfpx = NextStorage() },
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "The Three Sramatians and the Dragon",
			startStorageId = Storage.ThreeSramatiansAndTheDragon.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "01. Hither and Thither",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 1,
					states = {
						[1] = "And the men went along the road into the woods,\nWith an average pace,\nHumility will come for them in due time,\nEnter the bottom text here.",
					},
				},
				[2] = {
					name = "02. Fungus Magnum",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "I think the company went north through the gate of Mirkotown. From there, they went east, into the forest of cretin. In the forest, there is a secret passage through the caves of disgusting trolls. They might have used it. ~GM Romek",
						[2] = "You correctly answered Goldblum's riddle. Now give him your best puzzle.",
						[3] = "Respiciens post te, hominem\nmemento te; cave, ne cadas",
					},
				},
				[3] = {
					name = "03. Follow OSHA Standards",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Goldblum said that Bilbeus's company might be around the hive.",
						[2] = "Ask Bilbeus how you can join their company.",
						[3] = "Find a box of rum in the pirate village nearby.",
						[4] = "You found rum for Bilbeus. Return to him and suggest that he indulge himself.",
						[5] = "An unworthy act for a Welder\nThe King will probably put his balls in blender",
					},
				},
				[4] = {
					name = "04. Delirium Tremens",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Find the company's camp in the western steppes.",
						[2] = "You found the camp, but the company has already moved on. They might have settled in the nearest human town.",
						[3] = "Now it's time to search for valuable renewable resources for the Recycling Father.",
					},
				},
				[5] = {
					name = "05. Aqua Inaestimabilis",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 6,
					states = {
						[1] = "Bilbeus came up with the idea to steal wine from the vampires. New wine deliveries appear at the docks not only on Sundays at noon.",
						[2] = "Find a way to escape the dungeons, then locate Gertrude.",
						[3] = "Gertrude told you that the company went to the desert. The Djinn Lord - Jannah'ma might help you find them.",
						[4] = "Jannah'ma demanded dragon meat in exchange for information about your companions.",
						[5] = "Jannah'ma indicated that the company is by the old mine, where wyverns nest.",
						[6] = "An old unjust tyrant dragged me into trouble again.",
					},
				},
				[6] = {
					name = "06. Shepherd of Rats",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission06,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Bilbeus mentioned that you should head to the nomad's rock.",
						[2] = "The Nomad asked for a favor - he wants a crystal from the depths.",
						[3] = "Return to Bilbo and tell him what you learned from the nomad.",
						[4] = "Fing\nfurious\nup to the sky, the SKY\nTO HELL,\nUUU",
					},
				},
				[7] = {
					name = "07. Nasty Neighbor Abominable Cravings",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission07,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Go to the lizard people's village and find the ancient artifact.",
						[2] = "Bilbeus mentioned earlier that they will stop at Hairycles's place.",
						[3] = "Bilbeus wants to repay Hairycles for the information he provided. Bring some bananas to Bilbeus.",
						[4] = "Sheeit, it's awesome.",
					},
				},
				[8] = {
					name = "08. Follow the Odor of Opulence",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission08,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Bilbeus indicated that they are heading to the Temple of Hellspawn.",
						[2] = "Find three magic runes to unlock the doors deep inside the temple.",
						[3] = "I saw a snail crawling along the edge of a razor. It's my dream. My nightmare born from hell. It plods, crawls along the devilishly sharp razor edge. And it doesn't die.",
					},
				},
				[9] = {
					name = "09. Artificial Intelligence and Euthanasia",
					storageId = Storage.ThreeSramatiansAndTheDragon.Mission09,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "The Rat of Kings took the runes from you and unsealed the door. Now find HF-P/X.",
						[2] = "Return to the Rat of Kings and tell him about the battle.",
						[3] = "The Rat of Kings had a heart attack upon hearing about so many wrecked Passats. Now, go back to Romek.",
						[4] = "Greed consumed you\nAbove creativity, attention-seeking\nAbove reason, fame\nProfit to the bottom, the worthy are hunted\nLack of a healthy foundation.\nYou killed my child in horror\nThe end of the world is coming.\nCanary, Russia, Bitcoins, Ameno.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.ThreeSramatiansAndTheDragon.Questline] = 8,
			[Storage.ThreeSramatiansAndTheDragon.Mission04] = 2,
		}

		local FirePlace = Action()
		function FirePlace.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) ~= 7 then
				return false
			end
			player:UpdateStorages(updateStorages)
			return true
		end

		FirePlace:aid(Storage.ThreeSramatiansAndTheDragon.AbandonedFireplace)
		FirePlace:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Enchanted Hellspawn")
		local monster = {}

		monster.description = "an enchanted hellspawn"
		monster.experience = 9000
		monster.outfit =
			{ lookType = 322, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 5500
		monster.maxHealth = 5500
		monster.race = "fire"
		monster.corpse = 9009
		monster.speed = 344
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 15 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

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

		monster.light = { level = 0, color = 0 }

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -352 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -175,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREATTACK,
				target = false,
			},
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{
				name = "combat",
				interval = 2000,
				chance = 10,
				type = COMBAT_HEALING,
				minDamage = 120,
				maxDamage = 230,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 15,
				speedChange = 270,
				effect = CONST_ME_MAGIC_RED,
				target = false,
				duration = 4999,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 70 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 30 },
			{ type = COMBAT_HOLYDAMAGE, percent = -90 },
			{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
		local goldBlumTrap = MoveEvent()

		function goldBlumTrap.onStepIn(player, item, position, fromPosition)
			if not player:isPlayer() then
				return true
			end

			if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) < 1 then
				return false
			end
			player:teleportTo(player:getPosition():Moved(0, 0, 1))
			player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
			return true
		end

		goldBlumTrap:type("stepin")
		goldBlumTrap:aid(Storage.ThreeSramatiansAndTheDragon.GoldblumTrap)
		goldBlumTrap:register()
	end)
	:Script(function(storageToRequiredState)
		local hfpxConfig = {
			actionid = Storage.ThreeSramatiansAndTheDragon.HfpxAccess,
			bossName = "Operator HF-P/X",
			timerStorage = Storage.ThreeSramatiansAndTheDragon.HfpxAccess,
			cooldown = "weekly",

			leverPosition = Position(6799, 552, 12),
			entranceGrid = {
				topLeft = Position(6795, 552, 12),
				downRight = Position(6798, 552, 12),
			},
			exitTeleportDestination = Position(6796, 554, 12),
			exitTeleportPosition = Position(6789, 548, 13),
			exitTeleportActionid = Storage.ThreeSramatiansAndTheDragon.Portals.AfterHfpx,

			bossPos = Position(6791, 550, 13),
			enterPos = Position(6801, 556, 13),
			durationMinutes = 10,
			corner1 = ANCHOR:Moved(0, 0, 0),
			corner2 = ANCHOR:Moved(15, 11, 0),

			requiredStorages = {
				[Storage.ThreeSramatiansAndTheDragon.HfpxAccess] = 1,
			},
		}
		RegisterEncounter(hfpxConfig)

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return UseEncounterLever(player, item, hfpxConfig)
		end

		lever:aid(hfpxConfig.actionid)
		lever:register()
	end)
	:MonsterEvent(function()
		local storages = {
			[Storage.ThreeSramatiansAndTheDragon.Questline] = 23,
			[Storage.ThreeSramatiansAndTheDragon.Mission09] = 2,
		}

		local hfpx = CreatureEvent("HfpxKill")

		function hfpx.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline)
				if storageVal ~= 22 then
					return true
				end
				player:UpdateStorages(storages)
			end)
			return true
		end

		hfpx:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Jan Kockodan")
		local monster = {}

		monster.description = "Jan Kockodan"
		monster.experience = 8000
		monster.outfit = {
			lookType = 4,
			lookHead = 91,
			lookBody = 3,
			lookLegs = 33,
			lookFeet = 92,
			lookAddons = 1,
			lookMount = 0,
		}

		monster.health = 5700
		monster.maxHealth = 5700
		monster.race = "blood"
		monster.corpse = 22023
		monster.speed = 280
		monster.manaCost = 392

		monster.changeTarget = { interval = 4000, chance = 20 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = true,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 100, maxDamage = -666 }, -- bleed
			{
				name = "condition",
				type = CONDITION_BLEEDING,
				interval = 2000,
				chance = 60,
				minDamage = -150,
				maxDamage = -225,
				radius = 5,
				effect = CONST_ME_HOLYAREA,
				shootEffect = CONST_ANI_THROWINGKNIFE,
				target = true,
			},
		}

		monster.defenses = {
			defense = 50,
			armor = 35,
			{
				name = "combat",
				interval = 3717,
				chance = 15,
				type = COMBAT_HEALING,
				minDamage = 220,
				maxDamage = 280,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 10 },
			{ type = COMBAT_FIREDAMAGE, percent = 10 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 10 },
			{ type = COMBAT_DEATHDAMAGE, percent = -10 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Runic Hellspawn")
		local monster = {}

		monster.description = "a runic hellspawn"
		monster.experience = 9000
		monster.outfit =
			{ lookType = 322, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 5500
		monster.maxHealth = 5500
		monster.race = "fire"
		monster.corpse = 9009
		monster.speed = 344
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 15 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

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

		monster.light = { level = 0, color = 0 }

		monster.voices = {}
		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -352 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -175,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREATTACK,
				target = false,
			},
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{
				name = "combat",
				interval = 2000,
				chance = 10,
				type = COMBAT_HEALING,
				minDamage = 120,
				maxDamage = 230,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 15,
				speedChange = 270,
				effect = CONST_ME_MAGIC_RED,
				target = false,
				duration = 4999,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 70 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 30 },
			{ type = COMBAT_HOLYDAMAGE, percent = -90 },
			{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
		local hive = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hive
		local lagoon = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Lagoon
		local souleater = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Souleater
		local waterWell = Storage.ThreeSramatiansAndTheDragon.Fireplaces.WaterWell
		local hairycles = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hairycles
		local hellspawns = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hellspawns

		local spawnTimer = 1000 * 2 * 60

		local companyMembersNames = {
			"Moorin the second of the copper cowbell",
			"Brallin of the beech wall unit",
			"Guseppe Four Cheeses",
			"Bilbeus",
		}
		local aidToCompany = { [hive] = nil, [lagoon] = nil, [souleater] = nil, [waterWell] = nil }

		local aidToRequiredState = {
			[hive] = { min = 3, max = 6 },
			[lagoon] = { min = 8, max = 8 },
			[souleater] = { min = 10, max = 10 },
			[waterWell] = { min = 13, max = 16 },
			[hairycles] = { min = 18, max = 19 },
			[hellspawns] = { min = 20, max = 22 },
		}

		local litFireplaceId = 2000
		local unlitFireplaceId = 1997

		local function hasRequiredState(player, aid)
			local questState = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline)

			local states = aidToRequiredState[aid]
			local min = states.min
			local max = states.max
			return min <= questState and questState <= max
		end

		local function SpawnCompany(aid, fireplace)
			aidToCompany[aid] = {}
			local members = {}
			local pos = fireplace:getPosition()
			for _, name in pairs(companyMembersNames) do
				local member = Game.createNpc(name, pos)
				if member then
					member:setMasterPos(Position(pos))
					members[#members + 1] = member
				end
			end

			aidToCompany[aid] = members

			fireplace:transform(litFireplaceId)
			addEvent(function()
				fireplace:transform(unlitFireplaceId)
				fireplace:setActionId(aid)
				for _, member in pairs(aidToCompany[aid]) do
					member:remove()
				end
				aidToCompany[aid] = nil
			end, spawnTimer)
		end

		local function companyAlreadySpawnedAtAid(aid)
			return aidToCompany[aid] ~= nil
		end

		local fire = Action()
		function fire.onUse(player, fireplace, fromPosition, target, toPosition, isHotkey)
			local aid = fireplace:getActionId()
			if companyAlreadySpawnedAtAid(aid) then
				return false
			end
			if not hasRequiredState(player, aid) then
				return false
			end
			SpawnCompany(aid, fireplace)
			return true
		end

		for _, storage in pairs(Storage.ThreeSramatiansAndTheDragon.Fireplaces) do
			fire:aid(storage)
		end
		fire:register()
	end)
	:Script(function(storageToRequiredState)
		local szczurKrolowConfig = {
			name = "rat of kings",
			pos = Position(6792, 558, 11),
		}

		local tileIn = MoveEvent()

		function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline)

			if storageVal < 21 or storageVal > 23 then
				return false
			end

			local pos = szczurKrolowConfig.pos
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local monster = tile:getTopCreature()
			if monster then
				return false
			else
				Game.createNpc(szczurKrolowConfig.name, pos, false, false)
				pos:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		tileIn:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
		tileIn:register()

		local tileOut = MoveEvent()

		function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			local pos = szczurKrolowConfig.pos
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local monster = tile:getTopCreature()
			if
				monster
				and not Tile(fromPosition):getTopCreature()
				and string.lower(monster:getName()) == "rat of kings"
			then
				monster:remove()
				pos:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		tileOut:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
		tileOut:register()
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			Storage.ThreeSramatiansAndTheDragon.Questline,
			Storage.ThreeSramatiansAndTheDragon.Mission05,
		}

		local cagePos = Position(6206, 918, 9)

		local vampireKidnapping = MoveEvent()

		function vampireKidnapping.onStepIn(player, item, position, fromPosition)
			if not player:isPlayer() then
				return true
			end

			if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) ~= 9 then
				return false
			end
			player:teleportTo(cagePos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:IncrementStorages(updateStorages)
			return true
		end

		vampireKidnapping:type("stepin")
		vampireKidnapping:aid(Storage.ThreeSramatiansAndTheDragon.VampireCityTrap)
		vampireKidnapping:register()
	end)

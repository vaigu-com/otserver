local quest = Quest("safety_and_occupational_hygiene")
quest
	:Storage(function()
		Storage.SafetyAndOccupationalHygiene = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			Spawns = { Petrus = NextStorage() },
			KrolTile = NextStorage(),
			Portals = { ToMagicianTown = NextStorage(), ToPetrus = NextStorage() },
			Ytong = NextStorage(),
			Scp420Document = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Safety and Occupational Hygiene",
			startStorageId = Storage.SafetyAndOccupationalHygiene.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "01. Avast ye, scallywag!",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "Find Turdstin - he might know where the Rat of Kings is.",
						[3] = "Try to convince Xe'na to remove the cuckcurse from Turdstin.",
						[4] = "Xe'na refused to help Turdstin. Go back to him and deliver the news.",
						[5] = "Chorus of Januses:\nIn our homeland, injustices abound,\nNo one will erase them with a hand,\nBut no one is a blood relative here:\nWe'll drain it from our chests and mold it.",
					},
				},
				[2] = {
					name = "02. Eww. Am I the only one there to hate the womyn?",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Turdstin thanked you for the information that the only way to find the Rat of Kings is by listening to the Januses' choir. Talk to him again for a new mission.",
						[2] = "Turdstin asked for your help in collecting cans.",
						[3] = "Chorus of Januses:\nWhen the evening stars extinguish their flame,\nBefore I put the metal detector in the box,\nI offer my prayers,\nTo God the Father and the Son.\nLet's screw over the neighbor!",
					},
				},
				[3] = {
					name = "03. Vicinities Lost",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Turdstin mentioned that he will need assistance.",
						[2] = "Turdstin needs help with the Emperor's workers and hooligans.",
						[3] = "Chorus of Januses:\nUnclean forces threaten you,\nLet us gain fame, oh Christ!\nMatthew, Brian insulted us!\nWe'll lift the burden of the cross!",
					},
				},
				[4] = {
					name = "04. Very Important Posts",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Turdstin mentioned that he might have a new task for you.",
						[2] = "Turdstin found a fake premium account on 4chan. Try to bribe Xe'na.",
						[3] = "Your mother, grandmother, and sister - they are all insane\nOn the eastern borders, there's a path cursed upon a name\nDragons and others were brought there by a rocket\nTo avoid looking like a fool, keep a salmon in your pocket.",
					},
				},
				[5] = {
					name = "05. Hydrofoils with Seasoning",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "You handed over the premium account to Xe'na. And now...",
						[2] = "You fed the exhausted Rat of Kings. Now ask him about the mission.",
						[3] = "Chorus of Januses:\nGrant us some heavenly grace!\nLet us kill Peter in return!\nShow your love to others\nTo us - JUSTICE!",
					},
				},
				[6] = {
					name = "06. Crinjeux",
					storageId = Storage.SafetyAndOccupationalHygiene.Mission06,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "The Rat of Kings told you that Petrus Ciemiezca is on the peak of the magician's rocks to the northeast of Mirkotown.",
						[2] = "You defeated Petrus Ciemiezca. Find the Ytong of Power. It must be hidden somewhere in the tower.",
						[3] = "You found the Ytong of Power. Now, return to the Rat of Kings.",
						[4] = "The Rat of Kings revealed information to you about the looming threat- HF-P/X. Go back to Romek and hear his opinion on the matter.",
						[5] = "Chorus of Januses:\nI want to go to the only place on Earth,\nWhere the darkness no longer matters,\nTo the beings who accept my abilities as divinely,\nTo them I aspire, only to my justice.\nThere is one small place on Earth for me,\nWhere nothing else matters beyond the mushroom from the grout,\nI escape there with all my justice,\nI believe in you, I believe in my Brother-in-law.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local tileIn = MoveEvent()

		function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline)

			if storageVal < 11 then
				return false
			end

			if storageVal > 15 then
				return false
			end

			local toPos = fromPosition:Moved(-1, -1, 1)
			player:teleportTo(toPos)
		end

		tileIn:aid(Storage.SafetyAndOccupationalHygiene.KrolTile)
		tileIn:register()
	end)
	:MonsterEvent(function()
		local storages = {
			[Storage.SafetyAndOccupationalHygiene.Questline] = 14,
			[Storage.SafetyAndOccupationalHygiene.Mission06] = 2,
		}

		local petrusDeath = CreatureEvent("petrusDeath")
		function petrusDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			Game.setStorageValue(Storage.SafetyAndOccupationalHygiene.Spawns.Petrus, 0)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline)
				if storage_val ~= 13 then
					return true
				end
				player:UpdateStorages(storages)
			end)
			return true
		end

		petrusDeath:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Petrus Ciemiezca")
		local monster = {}

		monster.description = "a Petrus Ciemiezca"
		monster.experience = 3717
		monster.outfit = {
			lookType = 130,
			lookHead = 77,
			lookBody = 123,
			lookLegs = 114,
			lookFeet = 114,
			lookAddons = 1,
			lookMount = 0,
		}

		monster.health = 1500
		monster.maxHealth = 1500
		monster.race = "blood"
		monster.corpse = 18246
		monster.speed = 230
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 3717,
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
			targetDistance = 4,
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"petrusDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.summon = {
			maxSummons = 1,
			summons = {
				{ name = "energy elemental", chance = 10, interval = 2000, count = 1 },
			},
		}

		monster.voices = {}

		monster.loot = {
			{ name = "red tome", chance = 300 },
			{ name = "candlestick", chance = 21465 },
			{ name = "piggy bank", chance = 60 },
			{ name = "small sapphire", chance = 1435 },
			{ name = "gold coin", chance = 29340, maxCount = 80 },
			{ name = "talon", chance = 1395 },
			{ name = "stone skin amulet", chance = 330 },
			{ name = "poison dagger", chance = 248 },
			{ name = "cherry", chance = 16720, maxCount = 4 },
			{ name = "bread", chance = 8172 },
			{ name = "dark mushroom", chance = 4181 },
			{ name = "assassin star", chance = 1589, maxCount = 4 },
			{ name = "assassin star", chance = 1559, maxCount = 4 },
			{ name = "great mana potion", chance = 4749 },
			{ name = "great health potion", chance = 5189 },
			{ name = "lightning robe", chance = 1000 },
			{ name = "luminous orb", chance = 510 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -10 },
			{
				name = "combat",
				interval = 2000,
				chance = 50,
				type = COMBAT_ENERGYDAMAGE,
				minDamage = -90,
				maxDamage = -110,
				range = 7,
				shootEffect = CONST_ANI_ENERGY,
				target = false,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 10,
				type = COMBAT_MANADRAIN,
				minDamage = 0,
				maxDamage = -60,
				range = 7,
				target = false,
			},
			{
				name = "energyfield",
				interval = 2000,
				chance = 30,
				range = 7,
				radius = 2,
				shootEffect = CONST_ANI_ENERGY,
				target = true,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 30,
				type = COMBAT_ENERGYDAMAGE,
				minDamage = -50,
				maxDamage = -130,
				length = 8,
				spread = 3,
				effect = CONST_ME_BIGCLOUDS,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 25,
				speedChange = -600,
				range = 7,
				effect = CONST_ME_MAGIC_RED,
				target = false,
				duration = 17720,
			},
		}

		monster.defenses = {
			defense = 20,
			armor = 20,
			{
				name = "combat",
				interval = 2000,
				chance = 80,
				type = COMBAT_HEALING,
				minDamage = 20,
				maxDamage = 50,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = -5 },
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
		local portal = MoveEvent()

		function portal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getActionId()])
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		for _, actionId in pairs(Storage.SafetyAndOccupationalHygiene.Portals) do
			portal:aid(actionId)
		end
		portal:type("stepin")
		portal:register()

		local portalUse = Action()

		function portalUse.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getActionId()])
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		for _, actionId in pairs(Storage.SafetyAndOccupationalHygiene.Portals) do
			portalUse:aid(actionId)
		end
		portalUse:register()
	end)
	:Script(function(storageToRequiredState)
		local document = Action()
		function document.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local aid = item:getActionId()
			local translatedText =
				player:Localizer(nil):Get(item:getAttribute(ITEM_ATTRIBUTE_TEXT), { player = player, aid = aid })
			SimpleTextDisplay(player, item, translatedText)
			return true
		end

		document:aid(Storage.SafetyAndOccupationalHygiene.Scp420Document)
		document:register()
	end)
	:Script(function(storageToRequiredState)
		local tile = MoveEvent()

		function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			if player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline) ~= 13 then
				return
			end

			local aid = item:getActionId()
			if Game.getStorageValue(aid) == 1 then
				return
			end
			if Game.createMonster("petrus ciemiezca", player:getPosition()) then
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				Game.setStorageValue(aid, 1)
			end
		end

		tile:aid(Storage.SafetyAndOccupationalHygiene.Spawns.Petrus)
		tile:register()
	end)

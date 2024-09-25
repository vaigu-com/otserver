local quest = Quest("theater_of_cheap_thrills")
quest
	:Storage(function()
		Storage.TheaterOfCheapThrills = {
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
			Mission11 = NextStorage(),
			Mission12 = NextStorage(),
			Current = NextStorage(),
			PlusShapePuzzle = {
				Tile = NextStorage(),
				MachineNorth = NextStorage(),
				MachineCenter = NextStorage(),
				MachineWest = NextStorage(),
				Book = NextStorage(),
			},
			Rewards = { Cheese = NextStorage() },
			Spawns = {
				MissPizza = NextStorage(),
				Robercik = NextStorage(),
				JuerdoTitsgo = NextStorage(),
			},
			BrazilMap = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Theater of Cheap Thrills",
			startStorageId = Storage.TheaterOfCheapThrills.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "01. Vitat Iustitia",
					storageId = Storage.TheaterOfCheapThrills.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Many people ask: Who is this King of Rats and what's the deal? That's when I tell them, 'You stinker, go to Ratland and see for yourself. The King of Rats! Lets go! Yeehaw!",
						[2] = "Romek assigned you the task of finding mature cheese in the pirates' hideout.",
						[3] = "Chorus of Januses: A strange trumpet will spread a sound, fire will coagulate, the light will dim, and the world's history will turn to dust. From the trees of eternity, leaves will fall on the Judge's dreadful coming to bear witness to the Psalmist.",
					},
				},
				[2] = {
					name = "02. I'm Not a Rat's Fugue",
					storageId = Storage.TheaterOfCheapThrills.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Romek has offered you a position as his assistant. However, you must first pass a fair test.",
						[2] = "Pass the fair test to become the King of Rats assistant.",
						[3] = "Chorus of Januses: My radiance will pierce the Darkness, My brilliance will scatter the Shadows, ~Your father drunkard after a case of beers.",
					},
				},
				[3] = {
					name = "03. Good Day, Mrs. Pitca",
					storageId = Storage.TheaterOfCheapThrills.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Romek needs help with a new task. Go to him.",
						[2] = "Defeat Romek's supposed enemy, Mrs. Pitca.",
						[3] = "You defeated Mrs. Pitca, now return to Romek.",
						[4] = "Chorus of Januses: MU-MU-MURDERER! MU-MU-UUUU-MURDERER! MU-murderer! MUU-MURDERER!",
					},
				},
				[4] = {
					name = "04. Vanitas vanitatum et omnia vanitas",
					storageId = Storage.TheaterOfCheapThrills.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Romek needs help with a new task. Go to him.",
						[2] = "Romek mentioned that Grave Digger might know how to remove curses. Try to get the necessary information from him.",
						[3] = "You found a book that can help Romek. Return to him and give it to him.",
						[4] = "Chorus of Januses: Let us rejoice, brothers! Enough of tears! Our victory is complete! To the fighters, honor, to the fallen, respect! Let the earth carry a laudatory song! We poured sweat and blood But our glory is against the enemy! Although each of us has lost much, Let us rejoice, brothers! It's time for victory!",
					},
				},
				[5] = {
					name = "05. Ham from under the Rug",
					storageId = Storage.TheaterOfCheapThrills.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Romek needs help with a new task. Go to him.",
						[2] = "Romek has assigned you the task of catering his kebab party.",
						[3] = "Shivganesh needs three garlic heads and payment for making the kebabs.",
						[4] = "Shivganesh has promised to deliver the kebabs on time. Deliver the good news to Romek.",
						[5] = "Chorus of Januses: How great is the peace gained by one who does not heed what a neighbor says, does, or thinks, but only what they themselves do, to be just and godly.",
					},
				},
				[6] = {
					name = "06. Holiday Camp, you know where",
					storageId = Storage.TheaterOfCheapThrills.Mission06,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "Organize a camp for Romek's son, Kitz. Arni will assist you with this task.",
						[3] = "Inform Kitz that his trip is ready.",
						[4] = "You have completed the task for Romek. Return to him now for your reward.",
						[5] = "Chorus of Januses: Peace on all peaks. In leaves, in valleys Nothing.",
					},
				},
				[7] = {
					name = "07. King of Rats' Gambit",
					storageId = Storage.TheaterOfCheapThrills.Mission07,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "GM Romek is afraid for his life. Try to find Robercik before he finds Romek.",
						[3] = "You defeated the cunning Robercik. Return to Romk for your reward.",
						[4] = "Chorus of Januses: I was sent to break the chains of justice. This time, he will perish along with his soul.",
					},
				},
				[8] = {
					name = "08. The Art That of Just",
					storageId = Storage.TheaterOfCheapThrills.Mission08,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "GM Romek will be waiting for donations until his death. It's better to support him.",
						[3] = "GM Romek has accepted your donation. Return to him when the festival is over.",
						[4] = "Chorus of Januses: Iuvenes inconsiderate patrum suorum errata repetunt. Canem me rape cum cacat.",
					},
				},
				[9] = {
					name = "09. Abyssal Chasms of Decadence",
					storageId = Storage.TheaterOfCheapThrills.Mission09,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "GM Romek is starting a new minecraft server. Tell Wilson, a frequent visitor to old school servers, about Romek's known scams and acts of corruption.",
						[3] = "You tipped off Wilson. Now return to Romek and observe his reaction.",
						[4] = "Chorus of Januses: The human form is above spider filth. Cunning is a virtue; the king of rats is a coward.",
					},
				},
				[10] = {
					name = "10. Cocoa Intruder",
					storageId = Storage.TheaterOfCheapThrills.Mission10,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "GM Romek instructed you to find the map of the leader of the southern Orcs.",
						[3] = "You obtained information about the location of Brazil. Pass the gathered information to Romek.",
						[4] = "Chorus of Januses: Honor the deceased - a worthy act. But breaking the law, striking down the government, you drunk on your own sins!",
					},
				},
				[11] = {
					name = "11. The Work of Destruction",
					storageId = Storage.TheaterOfCheapThrills.Mission11,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "GM Romek needs help with a new problem, go to him.",
						[2] = "You learned that King Juerdo Titsgo is ddosing Romek's server. He should be hiding in the vicinity of Brazilian Rats' Land. Knock him out so that Romek can run the server peacefully.",
						[3] = "You gave Juerdo a beating. Return to Romek for your reward.",
						[4] = "Chorus of Januses: He will be the patron of chances! For the work of destruction in a good cause is holy, like the work of creation. The king renounced his word - become a king and perish. When faith and freedom escape from people.",
					},
				},
				[12] = {
					name = "12. Forever and Ever Ytong",
					storageId = Storage.TheaterOfCheapThrills.Mission12,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "The lives of the rats are in danger! Hurry to Romek.",
						[2] = "Romek has ordered you to commit ratocide. Carry out his will and don't ask questions.",
						[3] = "Chorus of Januses: We won't leave the land where we were born! It's written in our atlases! Justice will come in a stench! Do you know who ran over whom on the zebra crossing? Three Januses sing soprano: The time for trials has come! Give us a knife! Give us a knife! Our rich neighbor won't be! Go on, cut! Go on, cut! fat Janus the Baritone: LET'S KILL THEM!",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.TheaterOfCheapThrills.Questline] = 30,
			[Storage.TheaterOfCheapThrills.Mission10] = 3,
		}

		local map = Action()

		function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if player:getStorageValue(Storage.TheaterOfCheapThrills.Mission10) ~= 2 then
				return
			end

			player:UpdateStorages(updateStorages)
			return true
		end

		map:aid(Storage.TheaterOfCheapThrills.BrazilMap)
		map:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Juerdo Titsgo")
		local monster = {}

		monster.description = "Juerdo Titsgo"
		monster.experience = 4999
		monster.outfit = {
			lookType = 56,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 4000
		monster.maxHealth = 3717
		monster.race = "blood"
		monster.corpse = 5964
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			illusionable = false,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"JuerdoDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.summon = {
			maxSummons = 10,
			summons = {
				{ name = "Snake", chance = 50, interval = 2000, count = 4 },
				{ name = "Cobra", chance = 50, interval = 2000, count = 3 },
				{ name = "Wyvern", chance = 20, interval = 2000, count = 3 },
			},
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -140 },
			{
				name = "combat",
				interval = 2000,
				chance = 70,
				type = COMBAT_ENERGYDAMAGE,
				minDamage = -130,
				maxDamage = -60,
				range = 1,
				shootEffect = CONST_ANI_ENERGY,
				target = false,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 40,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -70,
				range = 7,
				radius = 7,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 60,
				type = COMBAT_LIFEDRAIN,
				minDamage = -130,
				maxDamage = -50,
				length = 8,
				spread = 0,
				effect = CONST_ME_PURPLEENERGY,
				target = false,
			},
		}

		monster.defenses = {
			defense = 15,
			armor = 15,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 15 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 15 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 15 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:MonsterEvent(function()
		local storages = { Storage.TheaterOfCheapThrills.Questline, Storage.TheaterOfCheapThrills.Mission11 }

		local juerdoDeath = CreatureEvent("JuerdoDeath")
		function juerdoDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			Game.setStorageValue(Storage.TheaterOfCheapThrills.Spawns.JuerdoTitsgo, 0)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.TheaterOfCheapThrills.Mission11)
				if storage_val ~= 2 then
					return true
				end
				player:IncrementStorages(storages, 1)
			end)
			return true
		end

		juerdoDeath:register()
	end)
	:MonsterEvent(function()
		local storages = {
			Storage.TheaterOfCheapThrills.Questline,
			Storage.TheaterOfCheapThrills.Mission03,
		}

		local pitcaDeath = CreatureEvent("PitcaDeath")
		function pitcaDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			Game.setStorageValue(Storage.TheaterOfCheapThrills.Spawns.MissPizza, 0)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.TheaterOfCheapThrills.Mission03)
				if storage_val ~= 2 then
					return true
				end
				player:IncrementStorages(storages, 1)
			end)
			return true
		end

		pitcaDeath:register()
	end)
	:MonsterEvent(function()
		local storages = { Storage.TheaterOfCheapThrills.Questline, Storage.TheaterOfCheapThrills.Mission07 }

		local robercikDeath = CreatureEvent("RobercikDeath")
		function robercikDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			Game.setStorageValue(Storage.TheaterOfCheapThrills.Spawns.Robercik, 0)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.TheaterOfCheapThrills.Mission07)
				if storage_val ~= 2 then
					return true
				end
				player:IncrementStorages(storages, 1)
			end)
			return true
		end

		robercikDeath:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Miss Pitca")
		local monster = {}

		monster.description = "Miss Pitca"
		monster.experience = 100
		monster.outfit = {
			lookType = 156,
			lookHead = 94,
			lookBody = 78,
			lookLegs = 97,
			lookFeet = 114,
			lookAddons = 1,
			lookMount = 0,
		}

		monster.health = 300
		monster.maxHealth = 300
		monster.race = "undead"
		monster.corpse = 0
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			illusionable = false,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"PitcaDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -30 },
		}

		monster.defenses = {
			defense = 15,
			armor = 15,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 15 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 15 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 15 },
		}

		monster.immunities = {
			{ type = "outfit", condition = false },
		}

		mType:register(monster)
	end)
	:Script(function(storageToRequiredState)
		local function areAllMachinePillarsLit(machineConfigs)
			for _, machineConfig in pairs(machineConfigs) do
				local pos = machineConfig.pillar.pos
				local litId = machineConfig.pillar.litId
				if not Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId) then
					return false
				end
			end
			return true
		end

		local function unlitAllMachinePillars(machineConfigs)
			for _, machineConfig in pairs(machineConfigs) do
				local pos = machineConfig.pillar.pos
				local unlitId = machineConfig.pillar.unlitId
				local litId = machineConfig.pillar.litId
				Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId):transform(unlitId)
			end
		end

		local tileBeforeBook = MoveEvent()

		function tileBeforeBook.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			local machineConfigs = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.aidToMachineConfig
			if not areAllMachinePillarsLit(machineConfigs) then
				return
			end

			unlitAllMachinePillars(machineConfigs)

			local litBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.lit
			local unlitBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.unlit
			local pos = LIBRUM_VORTEX_ANCHOR:Moved(TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.pos)
			local bookStand = Tile(pos):getItemById(unlitBookId)
			bookStand:transform(litBookId)

			player:say(
				player
					:Localizer(Storage.TheaterOfCheapThrills.Questline)
					:Get("The book has been unsealed. You have one minute before its closed."),
				TALKTYPE_MONSTER_SAY
			)
			addEvent(function()
				bookStand:transform(unlitBookId)
			end, 60 * 1000)
			return true
		end

		tileBeforeBook:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Book)
		tileBeforeBook:type("stepin")
		tileBeforeBook:register()

		--book reward is defined in krol_szczurow_hub/_startup.luaa
	end)
	:Script(function(storageToRequiredState)
		local function getConfigByAid(aid)
			return TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.aidToMachineConfig[aid]
		end

		local function resetArea(config)
			IterateBetweenPositions(config.topLeft, config.downRight, function(context)
				local pos = context.pos
				local ground = Tile(pos):getGround()
				local groundId = ground:getId()
				local unlitId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[groundId]
				if unlitId then
					Tile(pos):getItemById(groundId):transform(unlitId)
				end
				return true
			end)
		end

		local function isPuzzleCompleted(config)
			return IterateBetweenPositions(config.topLeft, config.downRight, function(context)
				local pos = context.pos
				local groundId = Tile(pos):getGround():getId()
				if TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[groundId] then
					return false
				end
				return true
			end, { stopCondition = STOP_CONDITIONS.isFalse })
		end

		local function lightUpPillar(config)
			local tile = Tile(LIBRUM_VORTEX_ANCHOR:Moved(config.pillar.pos))
			local item = tile:getItemById(config.pillar.unlitId)
			if item then
				item:transform(config.pillar.litId)
			end
		end

		local device = Action()
		function device.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local config = getConfigByAid(item:getActionId())
			if not isPuzzleCompleted(config) then
				resetArea(config)
				fromPosition:sendMagicEffect(CONST_ME_POFF)
				return false
			end
			resetArea(config)
			fromPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

			lightUpPillar(config)
			return true
		end

		device:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineNorth)
		device:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineWest)
		device:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineCenter)
		device:register()
	end)
	:Script(function(storageToRequiredState)
		local function swapTile(pos)
			local tile = Tile(pos):getGround()
			local anyid = tile.itemid
			local nextid = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[anyid]
				or TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[anyid]

			if tile then
				tile:transform(nextid)
			end
		end

		local function swapNearby(pos)
			swapTile(Position(pos.x + 0, pos.y + 0, pos.z + 0))
			swapTile(Position(pos.x + 1, pos.y + 0, pos.z + 0))
			swapTile(Position(pos.x + 0, pos.y + 1, pos.z + 0))
			swapTile(Position(pos.x - 1, pos.y + 0, pos.z + 0))
			swapTile(Position(pos.x + 0, pos.y - 1, pos.z + 0))
		end

		local plus = MoveEvent()

		function plus.onAddItem(moveitem, tileitem, toPosition)
			if moveitem.itemid ~= 3031 then
				return false
			end

			moveitem:remove()
			swapNearby(toPosition)
		end

		plus:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Tile)
		plus:type("additem")
		plus:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Robercik")
		local monster = {}

		monster.description = "Robercik"
		monster.experience = 1245
		monster.outfit = {
			lookType = 97,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 729
		monster.maxHealth = 729
		monster.race = "blood"
		monster.corpse = 18190
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			illusionable = false,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"RobercikDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {
			{ name = "gold coin", chance = 67740, maxCount = 100 },
			{ id = 3123, chance = 8986 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = 0,
				maxDamage = -30,
				range = 4,
				shootEffect = CONST_ANI_THROWINGKNIFE,
				target = false,
			},
		}

		monster.defenses = {
			defense = 15,
			armor = 15,
			{ name = "invisible", interval = 2000, chance = 10, effect = CONST_ME_MAGIC_BLUE },
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 15 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 15 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 15 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Script(function(storageToRequiredState)
		local tile = MoveEvent()

		function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			local aid = item:getActionId()
			if not player:isPlayer() then
				return false
			end

			if not (player:getStorageValue(Storage.TheaterOfCheapThrills.Mission11) == 2) then
				return
			end

			if Game.getStorageValue(aid) == 1 then
				return
			end

			if Game.createMonster("juerdo titsgo", player:getPosition()) then
				Game.setStorageValue(aid, 1)
			end
		end

		tile:aid(Storage.TheaterOfCheapThrills.Spawns.JuerdoTitsgo)
		tile:register()
	end)
	:Script(function(storageToRequiredState)
		local tile = MoveEvent()

		function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if player:getStorageValue(Storage.TheaterOfCheapThrills.Mission03) ~= 2 then
				return
			end

			local aid = item:getActionId()
			if Game.getStorageValue(aid) == 1 then
				return
			end
			if Game.createMonster("Miss Pitca", player:getPosition()) then
				Game.setStorageValue(aid, 1)
			end
		end

		tile:aid(Storage.TheaterOfCheapThrills.Spawns.MissPizza)
		tile:register()
	end)
	:Script(function(storageToRequiredState)
		local tile = MoveEvent()

		function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			local aid = item:getActionId()
			if not player:isPlayer() then
				return false
			end

			if not (player:getStorageValue(Storage.TheaterOfCheapThrills.Mission07) == 2) then
				return
			end

			if Game.getStorageValue(aid) == 1 then
				return
			end

			if Game.createMonster("Robercik", player:getPosition()) then
				Game.setStorageValue(aid, 1)
			end
		end

		tile:aid(Storage.TheaterOfCheapThrills.Spawns.Robercik)
		tile:register()
	end)

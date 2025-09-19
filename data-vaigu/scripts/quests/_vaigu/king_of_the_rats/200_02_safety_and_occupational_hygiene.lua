local quest = Quest(LOCALIZERS.SafetyAndOccupationalHygiene)

quest
	:Storage(function()
		Storage.SafetyAndOccupationalHygiene = {
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			KrolTile = {},
			Portals = { ToMagicianTown = {}, ToPetrus = {} },
			Ytong = {},
			Scp420Document = {},
			PetrusSpawn = {},
		}
		QuestState.SafetyAndOccupationalHygiene = {
			Mission01 = {
				AskRomekForMission = 1,
				AskTurdstinForKingLocation = 2,
				ConvinceXenaToLiftTheCurse = 3,
				ReportToTurdstin = 4,
			},
			Mission02 = {
				AskTurdstinForFirstMission = 1,
				CollectCansForTurdstin = 2,
				DealWithEmperorHooligans = 3,
				AskForNewMission = 4,
				BribeXena = 5,
			},
			Mission03 = {
				FindRatOfKings = 1,
				AskRatOfKingsForMission = 2,
				KillPetrus = 3,
				ReportToRatOfKings = 4,
				ReportToRomek = 5,
			},
		}
	end)
	:Constant(function()
		SpawnLocks.SafetyAndOccupationalHygiene = {
			Petrus = SpawnLock(),
		}
		BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_REQUIREMENTS = {
			timeIsNight = function(context)
				local timeOfDay = getTibiaTimerDayOrNight()
				if timeOfDay == "night" then
					return true
				end
				return false
			end,
		}

		QuestKeyItems.SafetyAndOccupationalHygiene = {
			GrazhenaDocument = {
				id = 2815,
				text = "scp420text",
				addToStore = false,
			},
		}

		BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS = {
			turdstinAttack = function(context)
				local pos = context.player:getPosition()
				SpawnMonstersAtPos("Gang Member", pos, 1)
				addEvent(function()
					SpawnMonstersAtPos("Gang Member", pos, 1)
				end, 5 * 1000)
				addEvent(function()
					SpawnMonstersAtPos("Gang Member", pos, 2)
					if BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_REQUIREMENTS.timeIsNight() == false then
						SpawnMonstersAtPos("Crazed Beggar", pos, 1)
					end
				end, 1000 * 15)

				addEvent(function()
					local player = context.player
					if player then
						player:NextState({
							[Storage.SafetyAndOccupationalHygiene.Mission02] = QuestState.SafetyAndOccupationalHygiene.Mission02.AskForNewMission,
						})
					end
				end, 1000 * 15)
			end,
			feministCake = function(context)
				local player = context.player
				if not player then
					return
				end
				if player:HasItems({ { id = 6277 } }) then
					player:RemoveItems({ { id = 6277 } })
					return
				end

				local pos = player:getPosition()
				local feminists = {}
				for _ = 1, 3 do
					local monster = Game.createMonster("Witch", pos)
					monster:setOutfit({
						lookType = 932,
						lookHead = 91,
						lookBody = 1,
						lookLegs = 94,
						lookFeet = 122,
						lookAddons = 0,
						lookMount = 0,
					})
					feminists[#feminists + 1] = monster
				end
				addEvent(function()
					for _, feminist in pairs(feminists) do
						if Creature(feminist) then
							Creature(feminist):remove()
						end
					end
				end, 1000 * 40)
			end,
		}

		BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS = {
			[Storage.SafetyAndOccupationalHygiene.Portals.ToMagicianTown] = MIRKO_MAGICIANS_ANCHOR:Moved(17, 12, -5),
			[Storage.SafetyAndOccupationalHygiene.Portals.ToPetrus] = PETRUS_CIEMIEZCA_ANCHOR:Moved(0, 0, 0),
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Safety and Occupational Hygiene",
			localizer = localizer,
			missions = {
				{
					name = "01. Dragee Turdee",
					storage = Storage.SafetyAndOccupationalHygiene.Mission01,
					states = {
						[QuestState.SafetyAndOccupationalHygiene.Mission01.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.SafetyAndOccupationalHygiene.Mission01.AskTurdstinForKingLocation] = "Find Turdstin - he might know where the Rat of Kings is.",
						[QuestState.SafetyAndOccupationalHygiene.Mission01.ConvinceXenaToLiftTheCurse] = "Try to convince Xe'na to remove the cuckcurse from Turdstin.",
						[QuestState.SafetyAndOccupationalHygiene.Mission01.ReportToTurdstin] = "Xe'na refused to help Turdstin. Go back to him and deliver the news.",
						[MISSION_FINISHED] = "Chorus of Januses:\nIn our homeland, injustices abound,\nNo one will erase them with a hand,\nBut no one is a blood relative here:\nWe'll drain it from our chests and mold it.",
					},
				},
				{
					name = "02. Eww. Am I the only one there to hate the womyn?",
					storage = Storage.SafetyAndOccupationalHygiene.Mission02,
					states = {
						[QuestState.SafetyAndOccupationalHygiene.Mission02.AskTurdstinForFirstMission] = "Turdstin thanked you for the information that the only way to find the Rat of Kings is by listening to the Januses' choir. Talk to him again for a new mission.",
						[QuestState.SafetyAndOccupationalHygiene.Mission02.CollectCansForTurdstin] = "Turdstin asked for your help in collecting cans.",
						[QuestState.SafetyAndOccupationalHygiene.Mission02.DealWithEmperorHooligans] = "Turdstin needs help with the Emperor's workers and hooligans.",
						[QuestState.SafetyAndOccupationalHygiene.Mission02.AskForNewMission] = "Ask Turdstin for a new mission.",
						[QuestState.SafetyAndOccupationalHygiene.Mission02.BribeXena] = "Turdstin found a fake premium account on 4chan. Try to bribe Xe'na.",
						[MISSION_FINISHED] = "Your mother, grandmother, and sister - they are all insane\nOn the eastern borders, there's a path cursed upon a name\nDragons and others were brought there by a rocket\nTo avoid looking like a fool, keep a salmon in your pocket.",
					},
				},
				{
					name = "03. Crinjeux",
					storage = Storage.SafetyAndOccupationalHygiene.Mission03,
					states = {
						[QuestState.SafetyAndOccupationalHygiene.Mission03.FindRatOfKings] = "You handed over the premium account to Xe'na. And now...",
						[QuestState.SafetyAndOccupationalHygiene.Mission03.AskRatOfKingsForMission] = "You fed the exhausted Rat of Kings. Now ask him about the mission.",
						[QuestState.SafetyAndOccupationalHygiene.Mission03.KillPetrus] = "The Rat of Kings told you that Petrus Ciemiezca is on the peak of the magician's rocks to the northeast of Mirkotown.",
						[QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRatOfKings] = "You defeated Petrus Now, return to the Rat of Kings.",
						[QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRomek] = "The Rat of Kings revealed information to you about the looming threat: HF-P/X. Go back to Romek and hear his opinion on the matter.",
						[MISSION_FINISHED] = "Chorus of Januses:\nI want to go to the only place on Earth,\nWhere the darkness no longer matters,\nTo the beings who accept my abilities as divinely,\nTo them I aspire, only to my justice.\nThere is one small place on Earth for me,\nWhere nothing else matters beyond the mushroom from the grout,\nI escape there with all my justice,\nI believe in you, I believe in my Brother-in-law.",
					},
				},
			},
		})
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.SafetyAndOccupationalHygiene.Mission03] = QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRatOfKings,
		}

		local petrusDeath = CreatureEvent("petrusDeath")
		local lock = SpawnLocks.SafetyAndOccupationalHygiene.Petrus
		function petrusDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			lock:Reset()
			onDeathForDamagingPlayers(creature, function(creature, player)
				local missionState = player:getStorageValueByKey(Storage.SafetyAndOccupationalHygiene.Mission03)
				if missionState ~= QuestState.SafetyAndOccupationalHygiene.Mission03.KillPetrus then
					return true
				end
				player:NextState(nextState)
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
	:Mission(Storage.SafetyAndOccupationalHygiene.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Script(function(missionState)
				local portal = MoveEvent()

				function portal.onStepIn(creature, item, position, fromPosition)
					local player = creature:getPlayer()
					if not player then
						return true
					end

					player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getKey()])
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				for _, actionId in pairs(Storage.SafetyAndOccupationalHygiene.Portals) do
					portal:key(actionId)
				end
				portal:type("stepin")
				portal:register()

				local portalUse = Action()
				function portalUse.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
					local player = creature:getPlayer()
					if not player then
						return true
					end

					player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getKey()])
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end
				for _, actionId in pairs(Storage.SafetyAndOccupationalHygiene.Portals) do
					portalUse:key(actionId)
				end
				portalUse:register()
			end)
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission01.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission" }] = {
					text = "Thank you for your help with the last task. I have now achieved justice on the level of a true Rat King. Therefore, I think I am worthy of entrusting you with a new task. Go to Turdstin, a member of the MGTOW clan. Anticipating your question: yes, he is disabled. However, it's possible that he knows how to locate the Rat of Kings.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission01] = QuestState.SafetyAndOccupationalHygiene.Mission01.AskTurdstinForKingLocation,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission01.AskTurdstinForKingLocation,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission" }] = {
					text = "Turdstin lives on the southern beach of Mirkotown.",
				},
			}),
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "Maybe I have some information about this Rat, but it certainly won't be free. I am the most important person in the world because I belong to the MGTOW order, and of all people, I loathe women the most, as they ruin this world. Go to their village and convince them to acknowledge our superiority and remove their cuckurse.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission01] = QuestState.SafetyAndOccupationalHygiene.Mission01.ConvinceXenaToLiftTheCurse,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission01.ConvinceXenaToLiftTheCurse,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "Amazon leader lives in the western mountains.",
				},
			}),
			QuestFactory.Dialog("Xe'na", {
				[{ "cuckurse", "cucklatwa" }] = {
					text = "Hmm... no. I won't remove the curse from him. Tell him that he would first have to stop being such a misogynist and a white capitalist.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission01] = QuestState.SafetyAndOccupationalHygiene.Mission01.ReportToTurdstin,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission01.ReportToTurdstin,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission", "cuckurse", "cucklatwa" }] = {
					text = "Oh god, what a foolish woman. Objectively and impartially, I conclude that I belong to the most repressed social group. Be that as it may, let's leave it for now. You mentioned the Rat of Kings earlier. The only way to find him is to listen carefully to the chorus of januses. They rarely say anything sensible, so you'll have to decide for yourself what is nonsense and what will lead you to the Rat.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission01] = MISSION_FINISHED,
						[Storage.SafetyAndOccupationalHygiene.Mission02] = QuestState.SafetyAndOccupationalHygiene.Mission02.AskTurdstinForFirstMission,
					},
				},
			})
	end)
	:Mission(Storage.SafetyAndOccupationalHygiene.Mission02)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission02.AskTurdstinForFirstMission,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "I am currently collecting cans that may still contain a certain amount of volts. Bring me about 100 small used vials, and I will reward you.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission02] = QuestState.SafetyAndOccupationalHygiene.Mission02.CollectCansForTurdstin,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission02.CollectCansForTurdstin,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "Here is your reward. Come back in some time, preferably in the evening.",
					requiredItems = {
						any = {
							{ id = 285, count = 100 },
							{ id = 284, count = 100 },
							{ id = 283, count = 100 },
						},
					},
					textNoRequiredItems = "Come back when you have collected 100 small vials.",
					expReward = 30000,
					rewards = { ExerciseWeaponBox(500) },
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission02] = QuestState.SafetyAndOccupationalHygiene.Mission02.DealWithEmperorHooligans,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission02.DealWithEmperorHooligans,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "That damn emperor took away my rights to the land where I collected cans. I won't let him get away with it, and I certainly won't let the new masters feel safe here. Come here at night because that's when the bums sleep. We'll ambush the invaders then, and maybe we won't wake up all the bums. Ask me about {attack} if you're ready.",
				},
				[{ "attack", "atak" }] = {
					text = "Oh wow, they are swarming!",
					specialActionsOnSuccess = {
						{
							action = BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS.turdstinAttack,
						},
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission02.AskForNewMission,
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission" }] = {
					text = "I didn't expect this. The group of local bums from this beach, under the leadership of their chief, got upset, so someone else will now take their cans on a massive scale. Anyway, thanks for your help.\nHere is your reward.\nA while ago, I found a premium account on 4chan - all thanks to my metal detector. Someone must have thrown it away. And rightly so, because it doesn't work. But the Amazons probably don't know that. Try to bribe them with this account to get rid of my cuckurse.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission02] = QuestState.SafetyAndOccupationalHygiene.Mission02.BribeXena,
					},
					rewards = { ExerciseWeaponBox(400) },
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission02.BribeXena,
			QuestFactory.Dialog("Xe'na", {
				[{ "mission", "cucklatwa", "cuckurse", "curse", "klatwa" }] = {
					text = "Your offer sounds reasonable. After all, I won't have to watch those cursed ads anymore. I hope you have an offering in the form of cake for the mighty Miroslawa. If not, better have it with you. Nevertheless, I'm ready for the {exchange}.",
				},
				[{ "exchange", "wymiane" }] = {
					text = "Actually, such a curse doesn't exist. But don't tell him that, or he'll get upset. But to avoid being a total fraud, I'll give you this scroll of feminazi knowledge instead.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission02] = MISSION_FINISHED,
						[Storage.SafetyAndOccupationalHygiene.Mission03] = QuestState.SafetyAndOccupationalHygiene.Mission03.FindRatOfKings,
					},
					rewards = {
						QuestKeyItems.SafetyAndOccupationalHygiene.GrazhenaDocument,
					},
					specialActionsOnSuccess = {
						{
							action = BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS.feministCake,
						},
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				local document = Action()
				function document.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local key = item:getKey()
					local translatedText = player:Localizer(LOCALIZERS.SafetyAndOccupationalHygiene):Get(item:getAttribute(ITEM_ATTRIBUTE_TEXT), { player = player, key = key })
					SimpleTextDisplay(player, translatedText)
					return true
				end

				document:key(Storage.SafetyAndOccupationalHygiene.Scp420Document)
				document:register()
			end)
	end)
	:Mission(Storage.SafetyAndOccupationalHygiene.Mission03)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission03.FindRatOfKings,
			QuestFactory.Dialog("Rat of Kings", {
				[{ GREET }] = {
					text = "Eeeuuu... eating... even... hydrofoils with sauce...",
				},
				[{ ANY_MESSAGE }] = {
					text = "Thanks, I feel better now. So, did Tomek send you? Ask me about {mission}, and I'll guide you as soon as I regain my strength.",
					requiredItems = { { id = 3579, count = 1 } },
					textNoRequiredItems = "Uhh....",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission03] = QuestState.SafetyAndOccupationalHygiene.Mission03.AskRatOfKingsForMission,
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				local tileIn = MoveEvent()

				function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					local state = player:getStorageValueByKey(Storage.SafetyAndOccupationalHygiene.Mission03)
					if state < QuestState.SafetyAndOccupationalHygiene.Mission03.FindRatOfKings then
						return false
					end
					if state > QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRatOfKings then
						return false
					end

					local toPos = fromPosition:Moved(-1, -1, 1)
					player:teleportTo(toPos)
				end

				tileIn:key(Storage.SafetyAndOccupationalHygiene.KrolTile)
				tileIn:register()
			end)
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission03.AskRatOfKingsForMission,
			QuestFactory.Dialog("Rat of Kings", {
				[{ "mission", "misje" }] = {
					text = "I think I know why Tomek sent you here. He wants you to defeat the menacing wizard who threatens the lives of Mirkotown's residents. It's a noble and just cause. I'm talking, of course, about Petrus The Tyrant, who wields the Ytong of Power forged in the shadows of the darkest asshole. You'll find his hideout at the top of the magician's tower northeast of Mirkotown.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission03] = QuestState.SafetyAndOccupationalHygiene.Mission03.KillPetrus,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission03.KillPetrus,
			QuestFactory.Dialog("Rat of Kings", {
				[{ "mission", "petrus" }] = {
					text = "Petrus has his hideout at the top of the eastern tower on the magician's rock.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local tile = MoveEvent()

				local lock = SpawnLocks.SafetyAndOccupationalHygiene.Petrus
				function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return
					end

					if lock:IsSet() then
						return
					end

					lock:Set(Game.createMonster("petrus ciemiezca", player:getPosition()))
				end

				tile:key(Storage.SafetyAndOccupationalHygiene.PetrusSpawn)
				tile:register()
			end)
	end)
	:State(function()
		return { min = QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRatOfKings }, QuestFactory.OnUseDeclarations({
			{ key = Storage.KingOfRatsHQ.ArtifactContainer.Ytong, rewards = { QuestKeyItems.KingOfRatsHQ.Ytong } },
		})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRatOfKings,
			QuestFactory.Dialog("Rat of Kings", {
				[{ "mission" }] = {
					text = "So, this is the end of Petrus' reign. Let me now tell you about another threat that slumbers deep in the underground of Kongo. It's an ancient creature sent by aliens to enslave humanity by undermining the authority of the King of Rats. Its name is HF-P/X. You shouldn't go on this journey alone. Ask Tom if he knows anyone who would like to accompany you.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission03] = QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRomek,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SafetyAndOccupationalHygiene.Mission03.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission" }] = {
					text = "Thank you for your help with the task and for the information from the Rat of Kings. Come back to me after some time, and I will tell you about the fate of someone close to me who wanted to defeat HF-P/X. Although his motivations were somewhat unusual.",
					nextState = {
						[Storage.SafetyAndOccupationalHygiene.Mission03] = MISSION_FINISHED,
						[Storage.ThreeSramatiansAndTheDragon.Mission01] = QuestState.ThreeSramatiansAndTheDragon.Mission01.TalkToRomek,
						[Storage.Finished.SafetyAndOccupationalHygiene] = MISSION_FINISHED,
					},
					rewards = { ExerciseWeaponBox(1337) },
				},
			})
	end)
	:Register()

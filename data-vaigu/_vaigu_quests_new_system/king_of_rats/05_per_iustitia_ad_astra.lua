local quest = Quest("desert_quest_one")
quest
	:Storage(function()
		Storage.PerIustitiaAdAstra = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			Mission07 = NextStorage(),
			Rewards = {
				Converter = NextStorage(),
				EngineBlueprint = NextStorage(),
				Map1 = NextStorage(),
				Map2 = NextStorage(),
				Map3 = NextStorage(),
				FuelRod = NextStorage(),
				RocketFuel = NextStorage(),
				SwagierCrate = NextStorage(),
				RubelsteinScroll = NextStorage(),
				OfficerId = NextStorage(),
				HugoRecipe = NextStorage(),
				LecinaHammer = NextStorage(),
			},
			JanuszTile = NextStorage(),
			KuzniaAccess = NextStorage(),
			CpnDoor = NextStorage(),
			BuyFuelRodAccess = NextStorage(),
			HelpedRubelstein = NextStorage(),
			RubelsteinChecksum = NextStorage(),
			MysteriousChest = NextStorage(),
			HammerUse = NextStorage(),
			RukcaAccess = NextStorage(),
			SaltyTile = NextStorage(),
			DeeplingTile = NextStorage(),
			MovingStarTile = NextStorage(),
			ShipControl = {
				StartTravelWheel = NextStorage(),
				ChangeNextDestination = NextStorage(),
				Exit = NextStorage(),
				Enter = NextStorage(),
				Current = NextStorage(),
				Next = NextStorage(),
				FuelLevel = NextStorage(),
				FlightTimer = NextStorage(),
				RodMelter = NextStorage(),
				FuelRefillLever = NextStorage(),
			},
			ShipDestinations = {
				FuelShop = NextStorage(),
				Deeplings = NextStorage(),
				Ganymede = NextStorage(),
				HugoTarPlanet = NextStorage(),
				HugoBeachPlanet = NextStorage(),
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Per Iustitia Ad Astra",
			startStorageId = Storage.PerIustitiaAdAstra.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "01. Beyond the Justice",
					storageId = Storage.PerIustitiaAdAstra.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Go to the highest mountain in the Kraiby and look for someone Romek mentioned.",
						[2] = "Astral Janus told you about a new threat. Proceed talking to gain more information.",
						[3] = "Astral Janus mentioned that you should start by fiding Usha'Yaan forge.",
					},
				},
				[2] = {
					name = "02. So-called Life",
					storageId = Storage.PerIustitiaAdAstra.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Head to the Usha'Yaan forge and find Qasim.",
						[2] = "Collect all the starship parts mentioned by Qasim.",
						[3] = "You collected ship parts requested by Qasim. Now try finding jet engine plans and three star maps.",
						[4] = "Qasim catapulted your ship to the orbit. Try to board it through teleporting device.",
					},
				},
				[3] = {
					name = "03. Cosmo Petrol Natural",
					storageId = Storage.PerIustitiaAdAstra.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Board your ship through unlicensed teleporting device in deepling temple.",
						[2] = "You found a place where you can board your ship. Try too look around.",
						[3] = "Help Swagger find his lost crate. He sent information about ganymede to your ship.",
						[4] = "Your found Swagger crate. Return to him now.",
						[5] = "You returned crate to Swagger.",
					},
				},
				[4] = {
					name = "04. Bobsleigh to Oven",
					storageId = Storage.PerIustitiaAdAstra.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 7,
					states = {
						[1] = "Swagger told you about some men transporting *REDACTED* to hugo cottage house. Investgiate that.",
						[2] = "You found Rubelstein in prison cell. He asked you to grab keys from locker on upper floor.",
						[3] = "You found identity document in wardrobe. Report back to rubelstein.",
						[4] = "Try to talk to officer on top of the tower.",
						[5] = "You talked to the officer and saved Rubelstein. Now ask Klaus about the mission.",
						[6] = "You talked to the officer and betrayed Rubelstein. Now ask Klaus about the mission.",
						[7] = "Head to Hugo planet and tell him about the mission you have been assigned.",
					},
				},
				[5] = {
					name = "05. Put on the 3D glasses",
					storageId = Storage.PerIustitiaAdAstra.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 10,
					states = {
						[1] = "Find hugo on his planet and tell him about Ubefabrik plans.",
						[2] = "Hugo noticed that your accent is off, also he knew the person you are impersonating. Improvise.",
						[3] = "Find Hugo recipe for his favourite drink.",
						[4] = "You found Hugo's recipe. Report back to him.",
						[5] = "Find hammer in Lecima shithole and repair pipe is castle sewers.",
						[6] = "You repaired the faulty sewer pipe. Report back to hugo",
						[7] = "Hugo told you to search the basement of his castle and find and open special chest.",
						[8] = "You opened the magic chest. Report back to Hugo.",
						[9] = "Hugo told you that you can keep the experience you got from chest. Ask him for new mission.",
						[10] = "Hugo asked you to deal with something lurking in southern beach.",
					},
				},
				[6] = {
					name = "06. I Don't Brush My Teeth. How Did You Know?",
					storageId = Storage.PerIustitiaAdAstra.Mission06,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Hugo asked you to deal with something lurking in southern beach.",
						[2] = "You killed the monster menacing the beach. Report to Hugo.",
						[3] = "Hugo told you about ancient artifact buried somewhere in the northern dump.",
						[4] = "You found an ancient artifact. Report to Astral Janus.",
					},
				},
			},
		}
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Ali baba door")
		local monster = {}

		monster.description = "a fire field"
		monster.experience = 0
		monster.outfit =
			{ lookType = 305, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 500
		monster.maxHealth = 500
		monster.race = "undead"
		monster.speed = 10
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 10 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 20,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = true,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = { interval = 4999, chance = 10 }

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
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		local toInside = USHAYAAN_FORGE_ANCHOR:Moved(0, 18, -1)
		local toOutside = USHAYAAN_FORGE_ANCHOR:Moved(0, 20, -1)

		local function isPlayerOnTeleportableTile(playerPos)
			return playerPos == toInside or playerPos == toOutside
		end

		mType.onSay = function(listener, talker, type, message)
			if message:lower() == "ali baba" then
				local listenerPos = listener:getPosition()
				local talkerPos = talker:getPosition()

				if not isPlayerOnTeleportableTile(talkerPos) then
					return
				end

				if talkerPos.y < listenerPos.y then
					talker:teleportTo(toOutside)
					toOutside:sendMagicEffect(CONST_ME_TELEPORT)
				elseif talkerPos.y > listenerPos.y then
					talker:teleportTo(toInside)
					toInside:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		end

		mType.onAppear = function(monster, creature)
			monster:setOutfit({ lookTypeEx = 470 })
		end
		mType:register(monster)
	end)
	:Script(function(storageToRequiredState)
		local vortex = MoveEvent()

		function vortex.onStepIn(player, _, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.PerIustitiaAdAstra.RukcaAccess)
			if storageVal == -1 then
				return true
			end

			local toPos = toPosition:Moved(0, 0, 1)
			player:teleportTo(toPos, true)
			toPos:sendMagicEffect(CONST_ME_WATERSPLASH)
		end

		vortex:aid(Storage.PerIustitiaAdAstra.RukcaAccess)
		vortex:register()
	end)
	:Script(function(storageToRequiredState)
		local leftDoorPos = FUEL_SHOP_ANCHOR:Moved(-1, -19, 0)

		local closedDoor = { [14159] = { 0, 0, 0 }, [20435] = { 0, 0, 0 }, [1612] = { 0, 0, 0 }, [20429] = { 0, 1, 0 } }

		local noDoors = 2

		local function openCloseDoor(close, door)
			local show = close and -1 or 0
			local hide = close and 0 or -1
			for i = 0, noDoors - 1 do
				for id, offset in pairs(door) do
					local origin = leftDoorPos:Moved(offset):Moved(i, 0, show)
					local destination = leftDoorPos:Moved(offset):Moved(i, 0, hide)
					local item = Tile(origin):getItemById(id)
					if not item then
						return
					end
					item:moveTo(destination)
				end
			end
		end

		local doorCurentlyOpening = false

		local openingTime

		local function tryCloseDoor()
			if os.clock() > openingTime then
				doorCurentlyOpening = false
				openCloseDoor(true, closedDoor)
			else
				addEvent(function()
					tryCloseDoor()
				end, 1000)
			end
		end

		local beforeCpnDoor = MoveEvent()
		function beforeCpnDoor.onStepIn(player, _, _, _)
			openingTime = os.clock() + 4
			if doorCurentlyOpening then
				return
			end
			doorCurentlyOpening = true

			openCloseDoor(false, closedDoor)
			tryCloseDoor()
		end

		beforeCpnDoor:aid(Storage.PerIustitiaAdAstra.CpnDoor)
		beforeCpnDoor:register()
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.PerIustitiaAdAstra.Questline] = 21,
			[Storage.PerIustitiaAdAstra.Mission05] = 6,
		}

		local hammerId = PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.lecinaHammer.id
		local pipeId = 20787

		local item = Action()
		function item.onUse(player, hammer, fromPosition, pipe, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			if hammer:getId() ~= hammerId then
				return false
			end

			if pipe:getId() ~= pipeId then
				return false
			end

			if pipe:getActionId() ~= hammer:getActionId() then
				return false
			end

			if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) ~= 20 then
				return false
			end

			pipe:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:UpdateStorages(updateStorages)
			hammer:remove()
			return true
		end

		item:aid(Storage.PerIustitiaAdAstra.HammerUse)
		item:register()
	end)
	:Script(function(storageToRequiredState)
		local szczurKrolowConfig = { name = "Astral Janus", pos = Position(5839, 790, 0) }

		local tileIn = MoveEvent()

		function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.PerIustitiaAdAstra.Questline)

			if storageVal == -1 then
				return false
			end
			if storageVal > 3 and storageVal < 27 then
				return false
			end

			local pos = Position(szczurKrolowConfig.pos)
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local monster = tile:getTopCreature()
			if monster then
				return false
			else
				local npc = Game.createNpc(szczurKrolowConfig.name, pos, false, false)
			end
		end

		tileIn:aid(Storage.PerIustitiaAdAstra.JanuszTile)
		tileIn:register()

		local tileOut = MoveEvent()

		function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			local pos = Position(szczurKrolowConfig.pos)
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local monster = tile:getTopCreature()
			if
				monster
				and not Tile(fromPosition):getTopCreature()
				and string.lower(monster:getName()) == "astral janus"
			then
				monster:remove()
				Position(pos):sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		tileOut:aid(Storage.PerIustitiaAdAstra.JanuszTile)
		tileOut:register()
	end)
	:Script(function(storageToRequiredState)
		local starLeftStepIn = MoveEvent()

		function starLeftStepIn.onStepIn(creature, _, _, _)
			local pos = creature:getPosition()
			local toPos = pos:Moved(36, 0, 0)

			creature:teleportTo(toPos)
		end

		starLeftStepIn:aid(Storage.PerIustitiaAdAstra.MovingStarTile)
		starLeftStepIn:register()
	end)
	:Script(function(storageToRequiredState)
		local runeId = 3164
		local failDmg = 500

		local function canOpenChest(player, toPosition)
			if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) ~= 22 then
				return false
			end

			local runePos = toPosition:Moved(2, 0, 0)
			local rune = Tile(runePos):getItemById(runeId)
			if not rune then
				return false
			end

			runePos:sendMagicEffect(CONST_ME_POFF)
			rune:remove()
			return true
		end

		local updateStorages = {
			[Storage.PerIustitiaAdAstra.Questline] = 23,
			[Storage.PerIustitiaAdAstra.Mission05] = 8,
		}

		local mysteriousChest = Action()
		function mysteriousChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if not canOpenChest(player, toPosition) then
				doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -failDmg, -failDmg, CONST_ME_LOSEENERGY)
				Game.createMonster("Old Giant Spider", fromPosition)
				return false
			end

			player:UpdateStorages(updateStorages)
			player:addExperience(250 * 1000, true)
			player:getPosition():sendMagicEffect(CONST_ME_BLUE_ENERGY_SPARK)
			return true
		end

		mysteriousChest:aid(Storage.PerIustitiaAdAstra.MysteriousChest)
		mysteriousChest:register()
	end)
	:Script(function(storageToRequiredState)
		local rukcaConfig = {
			actionid = Storage.PerIustitiaAdAstra.RukcaAccess,
			bossName = "Ruk'ca Maw",
			timerStorage = Storage.PerIustitiaAdAstra.RukcaAccess,
			cooldown = "weekly",

			leverPosition = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 87, 1),
			entranceGrid = {
				topLeft = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 83, 1),
				downRight = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 86, 1),
			},

			bossPos = RUKCA_ANCHOR:Moved(44, 22, 0),
			enterPos = RUKCA_ANCHOR:Moved(46, 24, 0),
			durationMinutes = 5,
			exitTeleportDestination = RUKCA_ANCHOR:Moved(-21, -11, -1),
			corner1 = RUKCA_ANCHOR:Moved(-37, -17, 0),
			corner2 = RUKCA_ANCHOR:Moved(53, 32, 0),

			requiredStorages = {
				[Storage.PerIustitiaAdAstra.RukcaAccess] = 1,
			},
			cannotEnterDuring = true,
		}
		RegisterEncounter(rukcaConfig)

		local originalSealCage

		local sealCagePositions = {
			RUKCA_ANCHOR:Moved(3, 1, 0),
			RUKCA_ANCHOR:Moved(10, -15, 0),
			RUKCA_ANCHOR:Moved(20, -6, 0),
			RUKCA_ANCHOR:Moved(15, 9, 0),
			RUKCA_ANCHOR:Moved(36, 11, 0),
			RUKCA_ANCHOR:Moved(34, 26, 0),
			RUKCA_ANCHOR:Moved(-6, 12, 0),
			RUKCA_ANCHOR:Moved(-17, 9, 0),
			RUKCA_ANCHOR:Moved(-24, 2, 0),
		}

		local cages = ItemExList()

		local function tryRemoveBabySealCages()
			cages:Remove()
		end

		local function initializeBabySealCages()
			for _, destination in pairs(sealCagePositions) do
				cages:AddMultiple(originalSealCage:Copied(destination))
			end
		end

		local function startEncounter()
			tryRemoveBabySealCages()
			initializeBabySealCages()
		end
		local rukcaLever = Action()

		function rukcaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if UseEncounterLever(player, item, rukcaConfig) then
				startEncounter()
			end
		end

		rukcaLever:aid(rukcaConfig.actionid)
		rukcaLever:register()

		local rukcaEncounterInit = GlobalEvent("RukcaEncounterInit")
		function rukcaEncounterInit.onStartup()
			originalSealCage = ItemExList():Area(RUKCA_ANCHOR:Moved(-1, 26, 0), RUKCA_ANCHOR:Moved(0, 27, 0))
		end
		rukcaEncounterInit:register()
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.PerIustitiaAdAstra.Questline] = 26,
			[Storage.PerIustitiaAdAstra.Mission06] = 2,
		}

		local rukca = CreatureEvent("RukcaKill")

		function rukca.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.PerIustitiaAdAstra.Questline)
				if storage_val ~= 25 then
					return true
				end
				player:UpdateStorages(updateStorages)
			end)
			return true
		end

		rukca:register()
	end)
	:Script(function(storageToRequiredState)
		local dmg = 20000

		local saltyTile = MoveEvent()

		function saltyTile.onStepIn(creature, _, _, _)
			if creature:getName():lower() == "ruk'ca maw" then
				doTargetCombatHealth(0, creature, COMBAT_POISONDAMAGE, -dmg, -dmg, CONST_ME_STUN)
			end
		end

		saltyTile:aid(Storage.PerIustitiaAdAstra.SaltyTile)
		saltyTile:register()
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.PerIustitiaAdAstra.Questline] = 7,
			[Storage.PerIustitiaAdAstra.Mission03] = 2,
			[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = 1,
			[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = 1,
		}

		local deeplingTile = MoveEvent()
		function deeplingTile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) == 6 then
				player:UpdateStorages(updateStorages)
			end
		end

		deeplingTile:aid(Storage.PerIustitiaAdAstra.DeeplingTile)
		deeplingTile:register()
	end)
	:Script(function(storageToRequiredState)
		local shipPos = STARSHIP_ANCHOR:Moved(15, 6, -1)

		local blockage = {}

		local function removeBlockage(position)
			for _, item in pairs(blockage[position:ToString()]) do
				item:remove()
			end
			blockage = {}
		end

		local function spawnBlockage(centerPos)
			local posString = centerPos:ToString()
			blockage[posString] = {}
			for i = -1, 1 do
				for j = -1, 1 do
					local item = Game.createItem(2187, 1, centerPos:Moved(i, j, 0))
					table.insert(blockage[posString], item)
				end
			end
		end

		local function sendShipEnterCountdown(player)
			for i = 1, 3 do
				addEvent(function()
					if player then
						player:say(4 - i, TALKTYPE_MONSTER_SAY)
					end
				end, i * 1000)
			end
		end

		local enterShipTile = MoveEvent()
		function enterShipTile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) < 7 then
				return false
			end

			sendShipEnterCountdown(player)

			spawnBlockage(toPosition)
			addEvent(function()
				if player then
					player:teleportTo(shipPos)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					toPosition:sendMagicEffect(CONST_ME_POFF)
				end
				removeBlockage(toPosition)
			end, 4000)
		end

		enterShipTile:aid(Storage.PerIustitiaAdAstra.ShipControl.Enter)
		enterShipTile:register()
	end)
	:Script(function(storageToRequiredState)
		local function getDestination(aid)
			local toPos = SPACESHIP_AID_TO_POS[aid]
			if not toPos then
				return false
			end
			return toPos
		end

		local exitDevice = MoveEvent()

		function exitDevice.onStepIn(player, _, _, _)
			if not player:isPlayer() then
				return false
			end

			local aid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current)
			local toPos = getDestination(aid)
			if not toPos then
				return
			end

			player:teleportTo(toPos)
			toPos:sendMagicEffect(CONST_ME_TELEPORT)
		end

		exitDevice:aid(Storage.PerIustitiaAdAstra.ShipControl.Exit)
		exitDevice:register()
	end)
	:Script(function(storageToRequiredState)
		local Monitor = Action()
		function Monitor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if
				not player:TryTradeInItems(
					{ PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.fuelRod },
					{ PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.rocketFuel }
				)
			then
				player:say(
					player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You don't have any fuel rods."),
					TALKTYPE_MONSTER_SAY
				)
				return
			end

			player:say(
				player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("Rod synthesis successful."),
				TALKTYPE_MONSTER_SAY
			)

			return true
		end

		Monitor:aid(Storage.PerIustitiaAdAstra.ShipControl.RodMelter)
		Monitor:register()
	end)
	:Script(function(storageToRequiredState)
		local function refillFuel(player)
			local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
			player:IncrementStorage(fuelStorage)
		end

		local function sendFuelStatus(player)
			local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
			local fuelLevel = player:getStorageValue(fuelStorage)
			player:say(
				player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("Current fuel tank status: ") .. fuelLevel,
				TALKTYPE_MONSTER_SAY
			)
		end

		local valve = Action()
		function valve.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			if not player:TryRemoveItems({ PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.rocketFuel }) then
				player:say(
					player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You dont have any fuel."),
					TALKTYPE_MONSTER_SAY
				)
				sendFuelStatus(player)
				return
			end

			player:say(
				player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You refilled the fuel tank."),
				TALKTYPE_MONSTER_SAY
			)
			refillFuel(player)
			sendFuelStatus(player)

			local trickle = Game.createItem(5662, 1, item:getPosition():Moved(2, 2, 0))
			addEvent(function()
				trickle:remove()
			end, 1000)
			return true
		end

		valve:aid(Storage.PerIustitiaAdAstra.ShipControl.FuelRefillLever)
		valve:register()

		local fuel = Action()
		function fuel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return false
		end

		fuel:aid(Storage.PerIustitiaAdAstra.Rewards.RocketFuel)
		fuel:register()
	end)
	:Script(function(storageToRequiredState)
		local aidToDestName = {
			[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = "ShipDestCpn",
			[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = "ShipDestDeepling",
			[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = "ShipDestGanymede",
			[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = "ShipDestHugoTarPlanet",
			[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = "ShipDestHugoBeachPlanet",
		}

		SPACESHIP_AID_TO_POS = {
			[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = FUEL_SHOP_ANCHOR:Moved(2, 0, 0),
			[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = DEEPLING_TEMPLE_ANCHOR:Moved(0, 1, 0),
			[Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede] = GANYMEDE_ANCHOR:Moved(-3, 0, 0),
			[Storage.PerIustitiaAdAstra.ShipDestinations.HugoTarPlanet] = HUGO_TAR_PLANET_ANCHOR:Moved(-24, -62, -2),
			[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = HUGO_BEACH_PLANET_ANCHOR:Moved(0, -35, -5),
		}

		local function hasUnlockedDestination(player, destinationStorage)
			if player:getStorageValue(destinationStorage) ~= -1 then
				return true
			end
			return false
		end

		local manaCostPercentage = 0.4
		local maxManaCostFlat = 1000
		local function chargeForTravel(player, aid)
			if
				aid == Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop
				or aid == Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede
			then
				local manaCostFlat = manaCostPercentage * player:getMaxMana()
				if manaCostFlat > maxManaCostFlat then
					manaCostFlat = maxManaCostFlat
				end

				if player:getMana() < manaCostFlat then
					return false, player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipCantAffordMana")
				end
				player:addMana(-manaCostFlat)
				return true
			end

			local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
			if player:getStorageValue(fuelStorage) < 1 then
				return false, player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipCantAffordFuel")
			end
			player:IncrementStorage(fuelStorage, -1)
			return true
		end

		local confirmChoice = function(player, button, choice)
			if not choice then
				return true
			end
			player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next, choice.aid)
			player:say(
				player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipLocationLocked") .. choice.text,
				TALKTYPE_MONSTER_SAY
			)
		end

		local nextDestinationSetter = Action()
		function nextDestinationSetter.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local title = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipTitle")
			local message = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipMessage")

			local window = ModalWindow({ title = title, message = message })

			local nextDestAid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
			for aid in pairs(SPACESHIP_AID_TO_POS) do
				if hasUnlockedDestination(player, aid) then
					local transaltedText =
						player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get(aidToDestName[aid])
					if aid == nextDestAid then
						transaltedText = "* " .. transaltedText .. " *"
					end
					local choice = window:addChoice(transaltedText)
					choice.aid = aid
				end
			end

			window:addButton(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipOk"), confirmChoice)

			window:sendToPlayer(player)
			return true
		end

		nextDestinationSetter:aid(Storage.PerIustitiaAdAstra.ShipControl.ChangeNextDestination)
		nextDestinationSetter:register()

		local starshipXsize = 37
		local starshipYsize = 18
		local mainShipCorners = {
			topLeft = Position(STARSHIP_ANCHOR),
			downRight = Position(STARSHIP_ANCHOR:Moved(starshipXsize - 1, starshipYsize - 1, 0)),
		}

		local starshipsOffset = 26
		local baseSpeed = 100
		local baseDelay = 500 * 70 / 100
		local movingStars = {
			topLeft = mainShipCorners.topLeft:Moved(1, -starshipsOffset * 1, 0),
			downRight = mainShipCorners.downRight:Moved(0, -starshipsOffset * 1, 0),
			rate = 0.5,
			stars = {},
		}

		local randomStarsParams = { { id = 0, weight = 99 }, { id = 3249, weight = 1 } }
		local randomToStarId = {}

		local function initializeStarIdWeights()
			local sumSoFar = 1
			for _, starParams in pairs(randomStarsParams) do
				for _ = 1, starParams.weight do
					randomToStarId[sumSoFar] = starParams.id
					sumSoFar = sumSoFar + 1
				end
				sumSoFar = starParams.weight
			end
		end

		local currentMoveToLoopId = 0
		local flightTimerLoopStarted = false

		local function moveToLoop(topLeft, downRight, delay, stars, moveToLoopId)
			if currentMoveToLoopId ~= moveToLoopId then
				return
			end
			if not flightTimerLoopStarted then
				return
			end
			for _, monster in pairs(stars) do
				monster:move(DIRECTION_WEST)
			end
			addEvent(function()
				moveToLoop(topLeft, downRight, delay, stars, moveToLoopId)
			end, delay)
		end

		local function flightTimerLoop()
			if os.time() > getGlobalStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer) then
				flightTimerLoopStarted = false
				return
			end
			addEvent(function()
				flightTimerLoop()
			end, 1000)
		end

		local function tryStartFlightTimerLoop()
			if flightTimerLoopStarted then
				return
			end
			currentMoveToLoopId = currentMoveToLoopId + 1
			flightTimerLoopStarted = true
			flightTimerLoop()
			moveToLoop(
				movingStars.topleft,
				movingStars.downRight,
				movingStars.delay,
				movingStars.stars,
				currentMoveToLoopId
			)
		end

		local function getRandomStarId()
			return randomToStarId[math.random(1, #randomToStarId)]
		end

		local function clearOldStars()
			IterateBetweenPositions(movingStars.topLeft, movingStars.downRight, function(context)
				local i = 1
				local pos = context.pos
				local starMonsterOld = pos:GetTopCreature()
				while starMonsterOld and i < 5 do
					if starMonsterOld then
						starMonsterOld:remove()
					else
						return
					end
					starMonsterOld = pos:GetTopCreature()
					i = i + 1
				end
			end)
			movingStars.stars = {}
		end

		local function initializeStarMonsters()
			movingStars.delay = baseDelay / movingStars.rate
			movingStars.speed = baseSpeed * movingStars.rate
			IterateBetweenPositions(movingStars.topLeft, movingStars.downRight, function(context)
				local itemId = getRandomStarId()
				if itemId ~= 0 then
					local pos = context.pos
					local starMonster = Game.createMonster("Moving Star", pos)
					table.insert(movingStars.stars, starMonster)
					starMonster:setSpeed(movingStars.speed)
					doSetItemOutfit(starMonster, itemId, 24 * 60 * 60 * 1000)
				end
			end)
			currentMoveToLoopId = 0
		end

		local starsInitialized = false
		local function tryInitializeStars()
			if starsInitialized then
				return false
			end
			starsInitialized = true
			initializeStarIdWeights()
			clearOldStars()
			initializeStarMonsters()
		end

		local travelTime = 12 * 1000
		local function startTravel(player)
			player:teleportTo(player:getPosition():Moved(0, -starshipsOffset, 0))
			addEvent(function()
				player:teleportTo(player:getPosition():Moved(0, starshipsOffset, 0))
			end, travelTime)
		end

		local shipWheel = Action()
		function shipWheel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local shipNextStorageValue = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
			local shipCurrentStorageValue = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current)
			if shipNextStorageValue == shipCurrentStorageValue then
				player:say(
					player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipAlreadyAtDestination"),
					TALKTYPE_MONSTER_SAY
				)
				return true
			end

			local success, chargingErrorMessage = chargeForTravel(player, shipNextStorageValue)
			if not success then
				player:say(chargingErrorMessage, TALKTYPE_MONSTER_SAY)
				return false
			end

			tryInitializeStars()

			local nextDestAid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Next)
			setGlobalStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer, os.time() + travelTime / 1000)
			player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.FlightTimer, os.time() + travelTime / 1000)
			player:setStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current, nextDestAid)
			tryStartFlightTimerLoop()
			startTravel(player)

			local transaltedString = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipJustStartedTravel")
			local nextName = aidToDestName[nextDestAid]
			local translatedName = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get(nextName)
			player:say(transaltedString .. translatedName, TALKTYPE_MONSTER_SAY)
			return true
		end

		shipWheel:aid(Storage.PerIustitiaAdAstra.ShipControl.StartTravelWheel)
		shipWheel:register()
	end)

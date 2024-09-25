local quest = Quest("path_of_the_undead")
quest
	:Storage(function()
		Storage.PathOfTheUndead = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Circles = NextStorage(),
			KonmuldBush = NextStorage(),
			UpperLever = NextStorage(),
			CursedChest = NextStorage(),
			GuardianSkull = NextStorage(),
			GuardianGateTile = NextStorage(),
			RitualLocus = NextStorage(),
			BossBook = NextStorage(),
			BossRoomExit = NextStorage(),
			SkipDoor = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Path of the Undead",
			startStorageId = Storage.PathOfTheUndead.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Test of Strength",
					storageId = Storage.PathOfTheUndead.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "Gandalf told you about the history of Mirkotown. Now, ask him what conditions you need to fulfill to get his help.",
						[2] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
					},
				},
				[2] = {
					name = "Endurance Test",
					storageId = Storage.PathOfTheUndead.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
						[2] = "Gandalf has blessed you and advised you to go to Konmuld for further instructions.",
					},
				},
				[3] = {
					name = "The Final Battle",
					storageId = Storage.PathOfTheUndead.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Gather the necessary items, summon, and ultimately defeat the Undead Crypt King.",
						[2] = "You have defeated the Undead Crypt King. Return to Gandalf for your reward.",
						[3] = "Gandalf misplaced a certain item intended as a reward, but you have received his other gifts.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local book = Action()

		function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local pos = item:getPosition()
			pos:sendMagicEffect(CONST_ME_THUNDER)
			pos:sendMagicEffect(CONST_ME_TELEPORT)
			Game.createMonster("Nieumarly Krol Krypty", pos, true, true)
			item:remove()
			return true
		end

		book:aid(Storage.PathOfTheUndead.BossBook)
		book:register()
	end)
	:Script(function(storageToRequiredState)
		local conditions = {
			CONDITION_POISON, -- utori pox
			CONDITION_FIRE, -- utori flam
			CONDITION_ENERGY, -- utori vis
			CONDITION_BLEEDING, -- utori kor
			CONDITION_HASTE, -- utani hur
			CONDITION_INVISIBLE, -- utana vid/stealth ring
			CONDITION_MANASHIELD, -- utamo vita/ering
			CONDITION_INFIGHT, -- any attack spell
			CONDITION_DRUNK, -- drink beer
			CONDITION_DROWN, -- special chest
			CONDITION_MUTED, -- spam
			CONDITION_FREEZING, -- special chest
			CONDITION_DAZZLED, -- utori san
			CONDITION_CURSED, -- utori mort
		}

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			for _, identifier in pairs(conditions) do
				local condition = Condition(identifier)
				condition:setParameter(CONDITION_PARAM_DELAYED, 1)
				condition:setParameter(CONDITION_PARAM_TICKS, 200000)
				condition:addDamage(5000, 2000, -50)
				player:addCondition(condition)
			end
		end

		lever:aid(44433)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local conditions = {}

		do
			local condition = Condition(CONDITION_FREEZING)
			condition:setParameter(CONDITION_PARAM_DELAYED, 1)
			condition:addDamage(5000, 3000, -50)

			conditions[#conditions + 1] = condition
		end

		do
			local condition = Condition(CONDITION_DROWN)
			condition:setParameter(CONDITION_PARAM_DELAYED, 1)
			condition:addDamage(5000, 2000, -50)

			conditions[#conditions + 1] = condition
		end

		local chest = Action()

		function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return true
			end
			for _, condition in pairs(conditions) do
				player:addCondition(condition)
			end
			player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			return true
		end

		chest:aid(Storage.PathOfTheUndead.CursedChest)
		chest:register()
	end)
	:Script(function(storageToRequiredState)
		local conditions = {
			CONDITION_POISON, --utori pox
			CONDITION_FIRE, --utori flam
			CONDITION_ENERGY, --utori vis

			CONDITION_BLEEDING, --utori kor
			CONDITION_HASTE, --utani hur
			CONDITION_INVISIBLE, --utana vid/stealth ring

			CONDITION_MANASHIELD, --utamo vita/ering
			CONDITION_INFIGHT, -- any attack spell
			CONDITION_DRUNK, -- drink beer

			CONDITION_DROWN, -- special chest
			CONDITION_MUTED, -- spam
			CONDITION_FREEZING, -- special chest

			CONDITION_DAZZLED, --utori san
			CONDITION_CURSED, --utori mort
		}

		function Player:CountConditions()
			local counter = 0

			for _, condition in pairs(conditions) do
				if self:hasCondition(condition) then
					counter = counter + 1
				end
			end

			if not self:hasCondition(CONDITION_REGENERATION) then
				counter = counter + 1
			end
			return counter
		end

		local idToCreatureName = {
			[7575] = "Cipociamkacz",
			[7568] = "PatriotaPL",
			[7574] = "CalaNapszut",
		}

		local skull = Action()

		local spawnstates = {
			[7575] = 0,
			[7568] = 0,
			[7574] = 0,
		}

		local requiredCount = #conditions - 1

		function skull.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local id = item:getId()
			if spawnstates[id] == 1 then
				return false
			end

			local conditionsCount = player:CountConditions()
			if conditionsCount >= requiredCount then
				for _, condition in pairs(conditions) do
					player:removeCondition(condition)
				end
				spawnstates[id] = 1
				Game.createMonster(idToCreatureName[id], player:getPosition(), true, true)
			end
			return false
		end

		skull:aid(Storage.PathOfTheUndead.GuardianSkull)
		skull:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CalaNapszutKill")

		function guardian.onDeath(creature)
			local pos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["CalaNapszut"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CipociamkaczKill")

		function guardian.onDeath(creature)
			local pos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["Cipociamkacz"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local krolKrypty = CreatureEvent("NieumarlyKrolKryptyKill")

		function krolKrypty.onDeath(creature)
			local targetMonster = creature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return true
			end

			local pos = targetMonster:getPosition()
			local portal = Game.createItem(27590, 1, pos)
			portal:setActionId(Storage.PathOfTheUndead.BossRoomExit)
		end

		krolKrypty:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("PatriotaPLKill")

		function guardian.onDeath(creature)
			local pos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["PatriotaPL"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:Script(function(storageToRequiredState)
		local bushMessage =
			"enum ConditionType_t {\nCONDITION_NONE,\n    \nCONDITION_POISON = 1 << 0,\nCONDITION_FIRE = 1 << 1,\nCONDITION_ENERGY = 1 << 2,\nCONDITION_BLEEDING = 1 << 3,\nCONDITION_HASTE = 1 << 4,\nCONDITION_PARALYZE = 1 << 5,\nCONDITION_OUTFIT = 1 << 6,\nCONDITION_INVISIBLE = 1 << 7,\nCONDITION_LIGHT = 1 << 8,\nCONDITION_MANASHIELD = 1 << 9,\nCONDITION_INFIGHT = 1 << 10,\nCONDITION_DRUNK = 1 << 11,\nCONDITION_EXHAUST = 1 << 12, // unused\nCONDITION_REGENERATION = 1 << 13,\nCONDITION_SOUL = 1 << 14,\nCONDITION_DROWN = 1 << 15,\nCONDITION_MUTED = 1 << 16,\nCONDITION_CHANNELMUTEDTICKS = 1 << 17,\nCONDITION_YELLTICKS = 1 << 18,\nCONDITION_ATTRIBUTES = 1 << 19,\nCONDITION_FREEZING = 1 << 20,\nCONDITION_DAZZLED = 1 << 21,\nCONDITION_CURSED = 1 << 22,\nCONDITION_EXHAUST_COMBAT = 1 << 23, // unused\nCONDITION_EXHAUST_HEAL = 1 << 24, // unused\nCONDITION_PACIFIED = 1 << 25,\nCONDITION_SPELLCOOLDOWN = 1 << 26,\nCONDITION_SPELLGROUPCOOLDOWN = 1 << 27,\nCONDITION_ROOTED = 1 << 28,\n"

		local bush = Action()

		function bush.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return true
			end

			local storageval = player:getStorageValue(Storage.PathOfTheUndead.Questline)
			if storageval < 3 then
				return false
			end

			player:registerEvent("konmuldBushModalWindow")

			local title = "You read the following."
			local message = bushMessage

			local window = ModalWindow(item.actionid, title, message)
			window:addButton(101, "Close")
			window:setDefaultEscapeButton(101)
			window:sendToPlayer(player)
			player:unregisterEvent("konmuldBushModalWindow")
			return true
		end

		bush:aid(Storage.PathOfTheUndead.KonmuldBush)
		bush:register()
	end)
	:MonsterEvent(function()
		local smallArea = createCombatArea(AREA_PLUS3)
		local exori = Combat()
		exori:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		exori:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		exori:setArea(smallArea)
		exori:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

		local lagaDyga = CreatureEvent("LagaDygaDeath")
		function lagaDyga.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			doCombat(creature, exori, { type = 2, pos = creature:getPosition() })
			return true
		end

		lagaDyga:register()
	end)
	:Script(function(storageToRequiredState)
		local idToStorageVal = { [596] = 1, [597] = 2, [598] = 4, [599] = 8, [924] = 16 }

		local step_tile = MoveEvent()

		local function IsFactor(number, factor)
			if (number % (factor * 2)) >= factor then
				return true
			end
			return false
		end

		local questlineStorage = Storage.PathOfTheUndead.Questline
		local circleStorage = Storage.PathOfTheUndead.Circles

		local function GetUncompletedCirclesCount(player)
			local storageVal = player:getStorageValue(circleStorage)
			local length = 0

			for _, value in pairs(idToStorageVal) do
				if not IsFactor(storageVal, value) then
					length = length + 1
				end
			end
			return length
		end

		function step_tile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local questlineStorageVal = player:getStorageValue(questlineStorage)
			if questlineStorageVal ~= 2 then
				return
			end

			local storageVal = player:getStorageValue(circleStorage)
			if storageVal < 0 then
				player:setStorageValue(circleStorage, 0)
			end

			local addend = idToStorageVal[item:getId()]
			if not IsFactor(storageVal, addend) then
				player:setStorageValue(circleStorage, player:getStorageValue(circleStorage) + addend)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				local firstStepMessage =
					player:Localizer(Storage.PathOfTheUndead.Questline):Get("You step on circle number ")
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, firstStepMessage .. math.floor(math.log(addend, 2) + 1))
			end

			local circlesCount = GetUncompletedCirclesCount(player)
			if circlesCount ~= 0 then
				local standOn = player
					:Localizer(Storage.PathOfTheUndead.Questline)
					:Get("To fulfill Gandalf's task you need to stand on ")
				local remaining = player:Localizer(Storage.PathOfTheUndead.Questline):Get(" remaining circles.")

				player:sendTextMessage(MESSAGE_FAILURE, standOn .. circlesCount .. remaining)
			end
		end

		step_tile:aid(Storage.PathOfTheUndead.Circles)
		step_tile:type("stepin")
		step_tile:register()
	end)
	:Script(function(storageToRequiredState)
		local doors = {
			{ pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -8, y = 12, z = 1 })), id = 1564 },
			{ pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -9, y = 12, z = 1 })), id = 1563 },
		}

		local function eachTileHasItem(top_left, down_right, id, anchor)
			if anchor then
				top_left = anchor:Moved(top_left)
				down_right = anchor:Moved(down_right)
			end

			for i = top_left.x, down_right.x do
				for j = top_left.y, down_right.y do
					local pos = Position(i, j, top_left.z)
					if not pos:hasItem(id) then
						return false
					end
				end
			end
			return true
		end

		local beforeGate = MoveEvent()

		function beforeGate.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end
			if not eachTileHasItem(Vector(-12, 15, 1), Vector(-10, 15, 1), 12952, SCIEZKA_NIEUMARLYCH_ANCHOR) then
				return false
			end
			for _, door in pairs(doors) do
				local pos = door.pos
				local id = door.id
				local tile = Tile(pos)
				if tile:getItemById(id) then
					tile:getItemById(id):remove()
					pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
				end
			end
			player:setStorageValue(Storage.PathOfTheUndead.SkipDoor, 1)
		end

		beforeGate:aid(Storage.PathOfTheUndead.GuardianGateTile)
		beforeGate:type("stepin")
		beforeGate:register()
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.PathOfTheUndead.Questline] = 4,
			[Storage.PathOfTheUndead.Mission03] = 2,
		}

		local exitPos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = 4, y = -32, z = -2 })
		local portal = MoveEvent()

		function portal.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.PathOfTheUndead.Questline)
			if storageVal == 3 then
				player:UpdateStorages(updateStorages)
			end

			player:teleportTo(exitPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end

		portal:aid(Storage.PathOfTheUndead.BossRoomExit)
		portal:type("stepin")
		portal:register()
	end)
	:Script(function(storageToRequiredState)
		local bossRoomPos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -60, y = -14, z = 0 })

		local workingTeleportId = 23483

		local nextRequiredThrowId = { 5901, 3465, 5467, 10316, 18935, 7993 }

		local ritualStateToNextPotId = { [2] = 1997, [3] = 2002, [4] = 2003 }

		local ritualState = 1

		local ritualPot = nil

		local function openPortal(pos)
			local portal = Game.createItem(workingTeleportId, 1, pos)
			portal:setActionId(Storage.PathOfTheUndead.RitualLocus)
			ritualPot:remove()
		end

		local function tryProgressRitualPot(pos)
			local nextRitualPotId = ritualStateToNextPotId[ritualState]
			if nextRitualPotId then
				ritualPot:transform(nextRitualPotId)
			else
				pos:sendMagicEffect(CONST_ME_WATERSPLASH)
			end
		end

		local ritualLocus = MoveEvent()
		function ritualLocus.onAddItem(moveitem, tileitem, position)
			if not moveitem then
				return false
			end

			if ritualPot == nil then
				ritualPot = Tile(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(1, -35, -1)):getItemById(1996)
			end

			local nextThrowId = nextRequiredThrowId[ritualState]
			local moveitemId = moveitem:getId()

			if moveitemId ~= nextThrowId then
				return false
			end

			ritualState = ritualState + 1
			moveitem:remove()
			tryProgressRitualPot(tileitem:getPosition())
			if ritualState > #nextRequiredThrowId then
				openPortal(tileitem:getPosition())
			end
			return true
		end

		ritualLocus:type("additem")
		ritualLocus:aid(Storage.PathOfTheUndead.RitualLocus)
		ritualLocus:register()

		local step_tile = MoveEvent()

		function step_tile.onStepIn(player, stepInItem, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end
			local portal = Tile(toPosition):getItemById(workingTeleportId)
			if not portal then
				return
			end
			player:teleportTo(bossRoomPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end

		step_tile:aid(Storage.PathOfTheUndead.RitualLocus)
		step_tile:type("stepin")
		step_tile:register()
	end)
	:Script(function(storageToRequiredState)
		local gatePositions = {
			{ x = -12, y = 37, z = -2 },
			{ x = -11, y = 37, z = -2 },
		}
		local gateId = 2182

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			for _, relativePos in pairs(gatePositions) do
				local pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(relativePos))
				local tile = Tile(pos)
				local gate = tile:getItemById(gateId)
				if gate then
					gate:remove()
				else
					Game.createItem(gateId, 1, pos)
				end
				toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			return true
		end

		lever:aid(Storage.PathOfTheUndead.UpperLever)
		lever:register()
	end)

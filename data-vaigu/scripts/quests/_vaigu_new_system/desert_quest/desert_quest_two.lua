local quest = Quest("desert_quest_two")
quest
	:Storage(function()
		Storage.DesertQuestHub = Storage.DesertQuestHub or {}
		Storage.DesertQuestHub.ToDesertQuestTwo = NextStorage()
		Storage.DesertQuestTwo = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			ProgressChests = NextStorage(),
			FastMonster = NextStorage(),
			RewardRoomTp = NextStorage(),
			Rewards = {
				ExpReward = NextStorage(),
				ChestOne = NextStorage(),
				ChestTwo = NextStorage(),
			},
			Puzzles = {
				Chess = {
					Piece = NextStorage(),
					ClearLever = NextStorage(),
					PromoteLever = NextStorage(),
				},
				MazeStoneRemove = NextStorage(),
				FireBlockageTile = NextStorage(),
				WaterPipesLever = NextStorage(),
				WaterPipeStepIn = NextStorage(),
				MazeReveal = NextStorage(),
				FiftenPuzzleLever = NextStorage(),
				FiftenPuzzleMove = NextStorage(),
				FastMoaLever = NextStorage(),
				RgbColors = NextStorage(),
				IdenticalRoomsTeleport = NextStorage(),
				IdenticalRoomsGoDown = NextStorage(),
				IdenticalRoomsClassTeleport = NextStorage(),
				OrbsMove = NextStorage(),
				OrbsReset = NextStorage(),
				TrickSign = NextStorage(),
				TrickGrave = NextStorage(),
				TrickTeleport = NextStorage(),
				RubiksCube = {
					Back = NextStorage(),
					Xaxis = NextStorage(),
					Front = NextStorage(),
					Right = NextStorage(),
					Yaxis = NextStorage(),
					Left = NextStorage(),
					Bottom = NextStorage(),
					Zaxis = NextStorage(),
					Top = NextStorage(),
				},
			},
			Teleports = {
				ToIdenticalRoom = NextStorage(),
				FromIdenticalRoom = NextStorage(),
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local chests = {
			["FirstHouse"] = {
				id = 2478,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(0, 25, -2),
				bitProgress = 2 ^ 0,
				permanent = true,
			},
			["FifteenPuzzle"] = { id = 11520, pos = DESERT_QUEST_TWO_ANCHOR:Moved(6, 7, 0), bitProgress = 2 ^ 1 },
			["RubiksCube"] = { id = 2471, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-10, -38, -1), bitProgress = 2 ^ 2 },
			["FireWall"] = {
				id = 2459,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-41, 9, 2),
				bitProgress = 2 ^ 3,
				permanent = true,
			},
			["Maze"] = {
				id = 4073,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -8, 2),
				bitProgress = 2 ^ 4,
				permanent = true,
			},
			["UnderWheat"] = {
				id = 2473,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-5, -28, -1),
				bitProgress = 2 ^ 5,
				permanent = true,
			},
			["RGB"] = { id = 14243, pos = DESERT_QUEST_TWO_ANCHOR:Moved(18, -12, 1), bitProgress = 2 ^ 6 },
			["Pipes"] = { id = 14245, pos = DESERT_QUEST_TWO_ANCHOR:Moved(23, -55, 1), bitProgress = 2 ^ 7 },
			["Moa"] = {
				id = 2481,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(40, -5, 0),
				bitProgress = 2 ^ 8,
				permanent = true,
			},
			["IdenticalRooms"] = {
				id = 27896,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-93, -18, 1),
				bitProgress = 2 ^ 9,
				permanent = true,
			},
			["Orbs"] = {
				id = 2472,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-21, -57, -1),
				bitProgress = 2 ^ 10,
				permanent = true,
			},
			["BehindTree"] = {
				id = 2474,
				pos = DESERT_QUEST_TWO_ANCHOR:Moved(-13, 10, -3),
				bitProgress = 2 ^ 11,
				permanent = true,
			},
		}
		local chestIdToBitProgress = {}
		local idChestIsSpawned = {}

		function TrySpawnDQ2progressChest(name, permament)
			if idChestIsSpawned[name] then
				return
			end

			local config = chests[name]
			local chest = Game.createItem(config.id, 1, config.pos)
			chest:setActionId(Storage.DesertQuestTwo.ProgressChests)
			chest:setUniqueId(1000)
			idChestIsSpawned[name] = true

			if not permament then
				addEvent(function()
					chest:remove()
					idChestIsSpawned[name] = false
				end, 60 * 2 * 1000)
			end
		end

		function InitializeDQ2chests()
			for name, chest in pairs(chests) do
				chestIdToBitProgress[chest.id] = chest.bitProgress
				idChestIsSpawned[chest.id] = true
				if chest.permanent then
					TrySpawnDQ2progressChest(name, true)
				end
			end
		end

		function GetDQ2completedPuzzleCount(player)
			local storageVal = player:getStorageValue(Storage.DesertQuestTwo.Mission01)
			local result = 0
			while storageVal > 0 do
				result = result + (bit.band(storageVal, 1))
				storageVal = bit.rshift(storageVal, 1)
			end
			return result, TableSize(chests)
		end

		local chestItem = Action()
		function chestItem.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local oldValue = player:getStorageValue(Storage.DesertQuestTwo.Mission01)
			if oldValue == -1 then
				oldValue = 0
			end

			local newValue = bit.bor(oldValue, chestIdToBitProgress[item:getId()])
			if newValue == oldValue then
				return true
			end

			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:setStorageValue(Storage.DesertQuestTwo.Mission01, newValue)

			local puzzlesCompleted, puzzlesCount = GetDQ2completedPuzzleCount(player)
			local finalString = puzzlesCompleted .. "/" .. puzzlesCount
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, finalString)
			return true
		end

		chestItem:aid(Storage.DesertQuestTwo.ProgressChests)
		chestItem:register()
	end)
	:Script(function(storageToRequiredState)
		local stonePos = DESERT_QUEST_TWO_ANCHOR:Moved(41, -6, 0)
		local moaPos = DESERT_QUEST_TWO_ANCHOR:Moved(45, -17, 0)

		local lever = Action()
		function lever.onUse(creature, _, _, _, _, _)
			print("MOA LEVER USE")
			local player = creature:getPlayer()
			if not player then
				return false
			end
			local stone = Tile(stonePos):getItemById(1791)
			if not stone then
				return
			end
			local creature = Tile(moaPos):getTopCreature()
			if not creature then
				return
			end
			if not creature:getName():lower() == "fast moa" then
				return
			end

			stone:moveTo(stonePos:Moved(-1, 0, 0))
			addEvent(function()
				stone:moveTo(stonePos)
			end, 60 * 2 * 1000)
			return false
		end

		lever:aid(Storage.DesertQuestTwo.Puzzles.FastMoaLever)
		lever:register()

		local action = Action()
		function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			player:say("meow")
			return true
		end
		action:aid(6969)
		action:register()

		local look = Look()
		function look.onLook(player, item, fromPosition, target, toPosition)
			player:say("meow")
			return true
		end
		look:aid(6969)
		look:position({ x = 6585, y = 557, z = 9 })
		look:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Fast Moa")
		local monster = {}

		monster.description = "a fast moa"
		monster.experience = 200
		monster.outfit = {
			lookType = 1534,
			lookHead = 85,
			lookBody = 1,
			lookLegs = 85,
			lookFeet = 105,
			lookAddons = 3,
			lookMount = 0,
		}

		monster.health = 1300
		monster.maxHealth = 1300
		monster.race = "blood"
		monster.corpse = 39208
		monster.speed = 900
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 1300,
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

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "Kreeee. Kreeeee.", yell = false },
		}

		monster.loot = {}

		monster.attacks = {}

		monster.defenses = {
			defense = 110,
			armor = 30,
			mitigation = 1.04,
		}

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
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Script(function(storageToRequiredState)
		local puzzleTopLeft = DESERT_QUEST_TWO_ANCHOR:Moved(1, 0, 0)
		local puzzleDownRight = puzzleTopLeft:Moved(3, 3, 0)
		local emptySpacePos = Position(puzzleTopLeft)

		local pieceIds = {}

		local function moveFifteenPuzzleElement(direction, toPosition)
			local nextPiecePos = emptySpacePos:Moved(Vector.FromDirection(direction))
			local piece = nextPiecePos:GetTopItem()
			if not piece then
				return
			end
			if not pieceIds[piece:getId()] then
				return
			end
			piece:moveTo(emptySpacePos)
			emptySpacePos = nextPiecePos
			emptySpacePos:sendMagicEffect(CONST_ME_POFF)
			if toPosition then
				toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
		end

		local function scramblePuzzle()
			for _ = 1, 300 do
				moveFifteenPuzzleElement(math.random(0, 3))
			end
		end

		function InitializeDQ2FifteenPuzzle()
			emptySpacePos = Position(puzzleTopLeft)
			IterateBetweenPositions(puzzleTopLeft, puzzleDownRight, function(context)
				local toPos = context.pos
				local fromPos = toPos:Moved(7, -1, 0)
				local copyItem = fromPos:GetTopItem()
				if not copyItem then
					return
				end
				local copyId = copyItem:getId()
				if ItemType(copyId):isMovable() then
					return
				end
				pieceIds[copyId] = true
				Game.createItem(copyId, 1, toPos)
			end)
			scramblePuzzle()
		end

		local moveTile = MoveEvent()
		function moveTile.onStepOut(creature, _, _, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local toPosition = creature:getPosition()
			if IsMoveDiagonal(fromPosition, toPosition) then
				return true
			end
			creature:teleportTo(fromPosition)
			local reverseDirection = toPosition:DirectionTo(fromPosition)
			moveFifteenPuzzleElement(reverseDirection, toPosition)
			return true
		end

		moveTile:aid(Storage.DesertQuestTwo.Puzzles.FiftenPuzzleMove)
		moveTile:type("stepout")
		moveTile:register()

		local function puzzleIsComplete()
			local result = IterateBetweenPositions(puzzleTopLeft, puzzleDownRight, function(context)
				local toPos = context.pos
				local fromPos = toPos:Moved(7, -1, 0)
				local toItem = toPos:GetTopItem()
				local fromitem = fromPos:GetTopItem()
				if not (toItem and fromitem) then
					return
				end
				return toItem:getId() == fromitem:getId()
			end, { stopCondition = STOP_CONDITIONS.isFalse })
			return result
		end

		local resetLever = Action()
		function resetLever.onUse(creature, item, _, _, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			if chestSpawned then
				return
			end
			if puzzleIsComplete() then
				TrySpawnDQ2progressChest("FifteenPuzzle")
			end
			scramblePuzzle()
			return false
		end

		resetLever:aid(Storage.DesertQuestTwo.Puzzles.FiftenPuzzleLever)
		resetLever:register()
	end)
	:Script(function(storageToRequiredState)
		local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(-118, -54, 0)
		local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(-51, 13, 0)

		local vector = topLeft:VectorTo(downRight:Moved(1, 1, 0)):Abs()
		local sideSize = 4
		local dx = vector.x
		local dy = vector.y

		if vector.x ~= vector.y or vector.x % sideSize ~= 0 then
			print(debug.traceback("desertquest2 wrong room size"))
		end

		local function initializeRoom(center)
			for i = -1, 1, 2 do
				local pos = center:Moved(i, 0, 0)
				local floor = Game.createItem(429, 1, pos)
				floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
			end
			for i = -1, 1, 2 do
				local pos = center:Moved(0, i, 0)
				local floor = Game.createItem(429, 1, pos)
				floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
			end
			local ladder = Tile(center):getItemById(1948)
			if ladder then
				ladder:remove()
				local floor = Game.createItem(429, 1, center)
				floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsGoDown)
			end
		end

		function InitializeDQ2IndeticalRooms()
			for i = 0, dx - 1, sideSize do
				for j = 0, dy - 1, sideSize do
					local roomCenter = topLeft:Moved(i + 1, j + 1, 0)
					initializeRoom(roomCenter)
				end
			end
			local startingRoomCenter = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -21, 0)
			for i = -1, 1, 2 do
				local pos = startingRoomCenter:Moved(i, 0, 0)
				local floor = Game.createItem(409, 1, pos)
				floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
			end
			for i = -1, 1, 2 do
				local pos = startingRoomCenter:Moved(0, i, 0)
				local floor = Game.createItem(409, 1, pos)
				floor:setActionId(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
			end
		end

		local function isPosTeleportable(pos)
			local tilePos = pos:Moved(1, 1, -1)
			local tile = Tile(tilePos)
			return tile
		end

		local teleportTiles = MoveEvent()
		function teleportTiles.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local dir = fromPosition:DirectionTo(toPosition)
			local offset = Vector.FromDirection(dir):scaled(4)
			local newPos = fromPosition:Moved(offset)
			if not isPosTeleportable(newPos) then
				newPos = fromPosition
			end
			player:teleportTo(newPos)
			newPos:sendMagicEffect(CONST_ME_TELEPORT)

			return false
		end

		teleportTiles:type("stepin")
		teleportTiles:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsTeleport)
		teleportTiles:register()

		local vocIdToPos = {
			[1] = DESERT_QUEST_TWO_ANCHOR:Moved(-113, -21, 0),
			[5] = DESERT_QUEST_TWO_ANCHOR:Moved(-113, -21, 0),
			[2] = DESERT_QUEST_TWO_ANCHOR:Moved(-69, -21, 0),
			[6] = DESERT_QUEST_TWO_ANCHOR:Moved(-69, -21, 0),
			[3] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -41, 0),
			[7] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -41, 0),
			[4] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -17, 0),
			[8] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -17, 0),
		}

		local goDownTile = MoveEvent()
		function goDownTile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			creature:teleportTo(toPosition:Moved(0, 0, 1))
			return false
		end

		goDownTile:type("stepin")
		goDownTile:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsGoDown)
		goDownTile:register()

		local classTile = MoveEvent()
		function classTile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			local classId = creature:getVocation():getId()
			local classPos = vocIdToPos[classId]
			if classPos then
				player:teleportTo(classPos)
			else
				player:teleportTo(fromPosition)
			end
			return false
		end

		classTile:type("stepin")
		classTile:aid(Storage.DesertQuestTwo.Puzzles.IdenticalRoomsClassTeleport)
		classTile:register()
	end)
	:Script(function(storageToRequiredState)
		local topLeftGenerate = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -2, 2)
		local downRightGenerate = DESERT_QUEST_TWO_ANCHOR:Moved(31, 32, 2)

		local dx, dy = topLeftGenerate:Distance(downRightGenerate)
		local width = dx + 1
		local height = dy + 1

		local labyrinth = {}

		local directions = {
			{ x = 0, y = -2 },
			{ x = 2, y = 0 },
			{ x = 0, y = 2 },
			{ x = -2, y = 0 },
		}

		local function generateLabyrinthTable()
			labyrinth = {}
			for i = 1, height do
				labyrinth[i] = {}
				for j = 1, width do
					labyrinth[i][j] = 1
				end
			end
			local startX = math.random(1, width)
			local startY = math.random(1, height)
			labyrinth[startY][startX] = 0

			local frontier = {}
			table.insert(frontier, { x = startX, y = startY })

			while #frontier > 0 do
				local randomIndex = math.random(1, #frontier)
				local currentCell = frontier[randomIndex]

				local unvisitedNeighbors = {}
				for _, direction in ipairs(directions) do
					local nx = currentCell.x + direction.x
					local ny = currentCell.y + direction.y

					if nx >= 1 and nx <= width and ny >= 1 and ny <= height then
						if labyrinth[ny][nx] == 1 then
							local wx = currentCell.x + direction.x / 2
							local wy = currentCell.y + direction.y / 2
							table.insert(unvisitedNeighbors, { x = nx, y = ny, wx = wx, wy = wy })
						end
					end
				end

				if #unvisitedNeighbors > 0 then
					local randomNeighbor = unvisitedNeighbors[math.random(1, #unvisitedNeighbors)]
					local nx = randomNeighbor.x
					local ny = randomNeighbor.y
					local wx = randomNeighbor.wx
					local wy = randomNeighbor.wy

					labyrinth[ny][nx] = 0
					labyrinth[wy][wx] = 0

					table.insert(frontier, { x = nx, y = ny })
				else
					table.remove(frontier, randomIndex)
				end
			end
		end

		generateLabyrinthTable()

		local wallId = 2187
		--local wallId = 4858
		local function generateLabyrinthItems()
			for i = 1, height do
				for j = 1, width do
					if labyrinth[i][j] == 1 then
						local x = topLeftGenerate.x + i - 1
						local y = topLeftGenerate.y + j - 1
						local z = topLeftGenerate.z
						Game.createItem(wallId, 1, Position(x, y, z))
					end
				end
			end
		end

		local function clearLabyrinthItems()
			IterateBetweenPositions(topLeftGenerate, downRightGenerate, function(context)
				local pos = context.pos
				local item = Tile(pos):getItemById(wallId)
				if item then
					item:remove()
				end
			end)
		end

		local function clearEntranceItems()
			local topRightEntrance = topLeftGenerate:Moved(31, 0, 0)

			local positions = {
				topLeftGenerate:Moved(0, 0, 0),
				topLeftGenerate:Moved(0, 1, 0),
				topLeftGenerate:Moved(1, 1, 0),
				topLeftGenerate:Moved(1, 0, 0),
				downRightGenerate:Moved(0, 0, 0),
				downRightGenerate:Moved(0, -1, 0),
				downRightGenerate:Moved(-1, -1, 0),
				downRightGenerate:Moved(-1, 0, 0),
				topRightEntrance:Moved(0, 0, 0),
				topRightEntrance:Moved(0, 1, 0),
				topRightEntrance:Moved(1, 1, 0),
				topRightEntrance:Moved(1, 0, 0),
			}

			for _, position in pairs(positions) do
				local item = Tile(position):getItemById(wallId)
				if item then
					item:remove()
				end
			end
		end

		local function generateRevealTiles()
			local topLeft = topLeftGenerate:Moved(0, 0, 1)
			local downRight = downRightGenerate:Moved(0, 0, 1)
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local revealGround = Game.createItem(410, 1, pos)
				revealGround:setActionId(Storage.DesertQuestTwo.Puzzles.MazeReveal)
			end)
		end

		local revealRadius = 2

		local function revealInRadius(playerPos, radius)
			local topLeft = playerPos:Moved(-radius, -radius, -1)
			local downRight = playerPos:Moved(radius, radius, -1)
			IterateBetweenPositions(topLeft, downRight, function(context)
				local wallPos = context.pos
				local tile = Tile(wallPos)
				if not tile then
					return
				end
				local wall = tile:getItemById(wallId)
				if not wall then
					return
				end
				local revealPos = wallPos:Moved(0, 0, 2)
				revealPos:sendMagicEffect(CONST_ME_TUTORIALSQUARE)
			end)
		end

		local reveal = MoveEvent()
		function reveal.onStepIn(creature, item, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			revealInRadius(player:getPosition(), revealRadius)
			return false
		end

		reveal:type("stepin")
		reveal:aid(Storage.DesertQuestTwo.Puzzles.MazeReveal)
		reveal:register()

		local blockageId = 1791
		local stoneRemovePos1 = DESERT_QUEST_TWO_ANCHOR:Moved(-2, -3, 2)
		local stoneRemovePos2 = stoneRemovePos1:Moved(32, 0, 0)
		function InitializeDQ2Labryrinth()
			generateLabyrinthTable()
			clearLabyrinthItems()
			generateLabyrinthItems()
			clearEntranceItems()
			generateRevealTiles()
			for _, pos in pairs({ stoneRemovePos1, stoneRemovePos2 }) do
				local ground = Game.createItem(431, 1, pos)
				ground:setActionId(Storage.DesertQuestTwo.Puzzles.MazeStoneRemove)
			end
		end
		local stoneRemove = MoveEvent()
		function stoneRemove.onStepIn(creature, item, toPosition, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local player1 = GetTopCreature(stoneRemovePos1)
			local player2 = GetTopCreature(stoneRemovePos2)
			if not (player1 and player2) then
				return
			end

			local stone1 = Tile(stoneRemovePos1:Moved(0, -1, 1)):getItemById(blockageId)
			local stone2 = Tile(stoneRemovePos1:Moved(0, -1, 2)):getItemById(blockageId)
			--local stone3 = Tile(standingTilePos1:Moved(0, -1, 0)):getItemById(blockageId)
			--local stone4 = Tile(standingTilePos1:Moved(32, -1, 0)):getItemById(blockageId)
			if not (stone1 and stone2) then
				return
			end
			toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)

			local stones = { stone1, stone2, stone3, stone4 }
			for _, stone in pairs(stones) do
				stone:moveTo(stone:getPosition():Moved(-1, 0, 0))
			end

			addEvent(function()
				for _, stone in pairs(stones) do
					stone:moveTo(stone:getPosition():Moved(1, 0, 0))
				end
			end, 60 * 1000)

			return false
		end

		stoneRemove:type("stepin")
		stoneRemove:aid(Storage.DesertQuestTwo.Puzzles.MazeStoneRemove)
		stoneRemove:register()
	end)
	:Script(function(storageToRequiredState)
		local orbId = 3064

		local function canMoveOrb(pos)
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local orb = tile:getItemById(orbId)
			if orb then
				return false
			end
			if not pos:IsPathable() then
				return false
			end

			return true
		end

		local function tryMoveOrb(fromPosition, toPosition)
			if IsMoveDiagonal(fromPosition, toPosition) then
				return
			end
			local direction = fromPosition:DirectionTo(toPosition)
			local offset = Vector.FromDirection(direction):Scaled(2)
			local orbPos = toPosition
			local newOrbPos = fromPosition:Moved(offset)
			fromPosition:sendMagicEffect(CONST_ME_POFF)
			if canMoveOrb(newOrbPos) then
				local orb = Tile(orbPos):getItemById(orbId)
				orb:moveTo(newOrbPos)
			end
		end

		local initTopleft = DESERT_QUEST_TWO_ANCHOR:Moved(-23, -63, 0)
		local initDownRight = DESERT_QUEST_TWO_ANCHOR:Moved(-1, -51, 0)
		local resetPlayersTo = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -48, -2)

		function InitializeDQ2orbs()
			IterateBetweenPositions(initTopleft, initDownRight, function(context)
				local initPos = context.pos
				local visiblePos = initPos:Moved(0, 0, -1)
				local player = visiblePos:GetTopCreature()
				if player then
					player:teleportTo(resetPlayersTo, true)
				end
				local visibleTile = Tile(visiblePos)
				if not visibleTile then
					return
				end
				local ground = visibleTile:getGround()
				if ground then
					ground:setActionId(Storage.SpecialStepins.DontAllowDiagonal)
				end
				local previousStone = Tile(visiblePos):getItemById(orbId)
				if previousStone then
					previousStone:remove()
				end
				local initialStone = Tile(initPos):getItemById(orbId)
				if initialStone then
					local stone = Game.createItem(orbId, 1, initPos:Moved(0, 0, -1))
					stone:setActionId(Storage.DesertQuestTwo.Puzzles.OrbsMove)
				end
			end)
		end

		local moveOrb = MoveEvent()
		function moveOrb.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			player:teleportTo(fromPosition)
			tryMoveOrb(fromPosition, toPosition)
			return false
		end
		moveOrb:type("stepin")
		moveOrb:aid(Storage.DesertQuestTwo.Puzzles.OrbsMove)
		moveOrb:register()

		local resetOrbs = Action()
		function resetOrbs.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			InitializeDQ2orbs()
			return true
		end
		resetOrbs:aid(Storage.DesertQuestTwo.Puzzles.OrbsReset)
		resetOrbs:register()
	end)
	:Script(function(storageToRequiredState)
		local currentlyVerifying = false

		local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(17, -52, 1)
		local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(27, -46, 1)

		local winningId = 20684

		local idToDir = {
			[20670] = { NORTH, SOUTH },
			[20673] = { EAST, WEST },
			[20678] = { SOUTH, EAST },
			[20677] = { SOUTH, WEST },
			[20679] = { NORTH, WEST },
			[20676] = { NORTH, EAST },
		}

		local dirToOpposite = {
			[NORTH] = SOUTH,
			[SOUTH] = NORTH,
			[EAST] = WEST,
			[WEST] = EAST,
		}

		local function getOppositeDirection(dir)
			return dirToOpposite[dir]
		end

		local straightId = { 20673, 20670 }
		local turningId = { 20678, 20677, 20679, 20676 }

		local function tryGetPipeItem(pos)
			for key, _ in pairs(idToDir) do
				local pipeItem = Tile(pos):getItemById(key)
				if pipeItem then
					return pipeItem
				end
			end
			return nil
		end

		local function rotatePipeRandom(item)
			local pipeId = item:getId()
			if table.contains(straightId, pipeId) then
				item:transform(straightId[math.random(1, #straightId)])
			elseif table.contains(turningId, pipeId) then
				item:transform(turningId[math.random(1, #turningId)])
			end
		end

		local function copyOriginal()
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local pipeItem = tryGetPipeItem(pos:Moved(0, 0, 1))
				if not pipeItem then
					return
				end
				local item = Game.createItem(pipeItem:getId(), 1, pos)
				item:setActionId(Storage.DesertQuestTwo.Puzzles.WaterPipeStepIn)
			end)
		end

		local function clearPipes()
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				for _ = 1, 3 do
					local item = tryGetPipeItem(pos)
					if not item then
						return
					end
					if idToDir[item:getId()] then
						item:remove()
					end
				end
			end)
		end

		local function rotatePipesRandom()
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local item = tryGetPipeItem(pos)
				if item then
					rotatePipeRandom(item)
				end
			end)
		end

		function InitializeDQ2PipePuzzle()
			clearPipes()
			copyOriginal()
			rotatePipesRandom()
		end

		local function onSucceedVerify()
			rotatePipesRandom()
			currentlyVerifying = false
			return true
		end

		local function onFailVerify()
			currentlyVerifying = false
			return false
		end

		local function verifyPipesConnection(currentPos, currentDir)
			local offset = Vector.FromDirection(currentDir)
			local nextPipePos = currentPos:Moved(offset)
			local nextPipe = tryGetPipeItem(nextPipePos)
			local winningPipe = Tile(nextPipePos):getItemById(winningId)
			if winningPipe then
				nextPipePos:sendMagicEffect(CONST_ME_CAKE)
				TrySpawnDQ2progressChest("Pipes")
				return onSucceedVerify()
			end
			if not nextPipe then
				return onFailVerify()
			end
			local pipeOutlets = idToDir[nextPipe:getId()]

			local nextDir = -1
			if getOppositeDirection(pipeOutlets[1]) == currentDir then
				nextDir = pipeOutlets[2]
			elseif getOppositeDirection(pipeOutlets[2]) == currentDir then
				nextDir = pipeOutlets[1]
			else
				return onFailVerify()
			end

			nextPipePos:sendMagicEffect(CONST_ME_WATERSPLASH)
			addEvent(function()
				verifyPipesConnection(nextPipePos, nextDir)
			end, 100)
		end

		local finishLever = Action()
		function finishLever.onUse(creature, item, _, _, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			if currentlyVerifying then
				return false
			end

			local nextDir = SOUTH
			if not verifyPipesConnection(topLeft, nextDir) then
				return
			end

			return false
		end

		finishLever:aid(Storage.DesertQuestTwo.Puzzles.WaterPipesLever)
		finishLever:register()

		local function rotatePipe(item)
			local itemId = item:getId()
			if table.contains(straightId, itemId) then
				for i = 1, #straightId do
					if straightId[i] == itemId then
						local nextId = straightId[i + 1] or straightId[1]
						item:transform(nextId)
					end
				end
			elseif table.contains(turningId, itemId) then
				for i = 1, #turningId do
					if turningId[i] == itemId then
						local nextId = turningId[i + 1] or turningId[1]
						item:transform(nextId)
					end
				end
			end
		end

		local playerRotatePipe = MoveEvent()
		function playerRotatePipe.onStepIn(creature, item, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			rotatePipe(item)
			return false
		end

		playerRotatePipe:type("stepin")
		playerRotatePipe:aid(Storage.DesertQuestTwo.Puzzles.WaterPipeStepIn)
		playerRotatePipe:register()
	end)
	:Script(function(storageToRequiredState)
		local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(13, -22, 1)
		local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(21, -22, 1)
		local countdownRunning = false

		local redPos = DESERT_QUEST_TWO_ANCHOR:Moved(12, -13, 1)
		local yellowPos = DESERT_QUEST_TWO_ANCHOR:Moved(17, -8, 1)
		local bluePos = DESERT_QUEST_TWO_ANCHOR:Moved(22, -13, 1)

		local colorToId = {
			["purple"] = 28131,
			["green"] = 23717,
			["orange"] = 2653,
			["brown"] = 5590,
		}

		local function getSelectedColorId()
			local red = Tile(redPos):getTopCreature()
			local yellow = Tile(yellowPos):getTopCreature()
			local blue = Tile(bluePos):getTopCreature()
			if yellow and red and blue then
				return colorToId["brown"]
			end
			if red and blue then
				return colorToId["purple"]
			end
			if blue and yellow then
				return colorToId["green"]
			end
			if yellow and red then
				return colorToId["orange"]
			end
		end

		local function getRequiredColor()
			return IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local item = pos:GetTopItem()
				return item
			end, { stopCondition = STOP_CONDITIONS.isNotNull })
		end

		local initializeIds = {
			28131,
			23717,
			2653,
			5590,
		}
		local function initialize()
			local lastRand = #initializeIds
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local item = pos:GetTopItem()
				if item then
					item:remove()
				end
				local randTableIndex = math.random(1, #initializeIds)
				if randTableIndex == lastRand then
					randTableIndex = (randTableIndex + 1) % #initializeIds + 1
				end
				lastRand = randTableIndex
				local randomItemId = initializeIds[randTableIndex]
				Game.createItem(randomItemId, 1, pos)
			end)
		end

		local lever = Action()
		function lever.onUse(creature, _, _, _, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local _, requiredColor = getRequiredColor()
			local selectedColorId = getSelectedColorId()

			if not (requiredColor and selectedColorId) then
				initialize()
				return false
			end

			local requiredColorId = requiredColor:getId()
			if requiredColorId == selectedColorId then
				requiredColor:remove()
			else
				initialize()
				return false
			end

			local requiredColor2 = getRequiredColor()
			if not requiredColor2 then
				TrySpawnDQ2progressChest("RGB")
			end
			return false
		end

		lever:aid(Storage.DesertQuestTwo.Puzzles.RgbColors)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local cubeMapPositions = {
			top = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(0, 0, 0),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(1, 0, 0),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 0),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(0, 1, 0),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(1, 1, 0),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 0),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 0),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 0),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 0),
			},
			bottom = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(3, 3, 3),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(4, 3, 3),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(5, 3, 3),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(3, 4, 3),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(4, 4, 3),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(5, 4, 3),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(3, 5, 3),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(4, 5, 3),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(5, 5, 3),
			},
			back = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 1),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 1),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 1),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 2),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 2),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 2),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 3),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 3),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 3),
			},
			front = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 1),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 1),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 1),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 2),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 2),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 2),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 3),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 3),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 3),
			},
			left = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 1),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 1),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 1),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 2),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 2),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 2),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 3),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 3),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 3),
			},
			right = {
				[1] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 1),
				[2] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 1),
				[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 1),
				[4] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 2),
				[5] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 2),
				[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 2),
				[7] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 3),
				[8] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 3),
				[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 3),
			},
		}

		local currentCubeFaceState = {
			top = {
				[1] = 0,
				[2] = 0,
				[3] = 0,
				[4] = 0,
				[5] = 0,
				[6] = 0,
				[7] = 0,
				[8] = 0,
				[9] = 0,
			},
			bottom = {
				[1] = 1,
				[2] = 1,
				[3] = 1,
				[4] = 1,
				[5] = 1,
				[6] = 1,
				[7] = 1,
				[8] = 1,
				[9] = 1,
			},
			left = {
				[1] = 2,
				[2] = 2,
				[3] = 2,
				[4] = 2,
				[5] = 2,
				[6] = 2,
				[7] = 2,
				[8] = 2,
				[9] = 2,
			},
			right = {
				[1] = 3,
				[2] = 3,
				[3] = 3,
				[4] = 3,
				[5] = 3,
				[6] = 3,
				[7] = 3,
				[8] = 3,
				[9] = 3,
			},
			front = {
				[1] = 4,
				[2] = 4,
				[3] = 4,
				[4] = 4,
				[5] = 4,
				[6] = 4,
				[7] = 4,
				[8] = 4,
				[9] = 4,
			},
			back = {
				[1] = 5,
				[2] = 5,
				[3] = 5,
				[4] = 5,
				[5] = 5,
				[6] = 5,
				[7] = 5,
				[8] = 5,
				[9] = 5,
			},
		}

		local faceTransferArray = {
			horizontal = {
				front = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 4, 5, 6 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 4, 5, 6 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 4, 5, 6 },
					destFace = "left",
				},
				left = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 4, 5, 6 },
					destFace = "front",
				},
			},
			verticalParallel = {
				top = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 2, 5, 8 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 6, 5, 4 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 4, 5, 6 },
					destTiles = { 2, 5, 8 },
					destFace = "left",
				},
				left = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 6, 5, 4 },
					destFace = "top",
				},
			},
			verticalPerpendicular = {
				top = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 8, 5, 2 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 2, 5, 8 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 8, 5, 2 },
					destFace = "front",
				},
				front = {
					sourceTiles = { 2, 5, 8 },
					destTiles = { 2, 5, 8 },
					destFace = "top",
				},
			},
			top = {
				left = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 1, 2, 3 },
					destFace = "front",
				},
				front = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 1, 2, 3 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 1, 2, 3 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 1, 2, 3 },
					destFace = "left",
				},
			},
			bottom = {
				left = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 7, 8, 9 },
					destFace = "front",
				},
				front = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 7, 8, 9 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 7, 8, 9 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 7, 8, 9 },
					destFace = "left",
				},
			},
			left = {
				top = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 9, 6, 3 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 1, 4, 7 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 7, 4, 1 },
					destFace = "front",
				},
				front = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 1, 4, 7 },
					destFace = "top",
				},
			},
			right = {
				top = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 7, 4, 1 },
					destFace = "back",
				},
				back = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 3, 6, 9 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 9, 6, 3 },
					destFace = "front",
				},
				front = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 3, 6, 9 },
					destFace = "top",
				},
			},
			front = {
				top = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 1, 4, 7 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 9, 8, 7 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 7, 8, 9 },
					destTiles = { 3, 6, 9 },
					destFace = "left",
				},
				left = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 9, 8, 7 },
					destFace = "top",
				},
			},
			back = {
				top = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 3, 6, 9 },
					destFace = "right",
				},
				right = {
					sourceTiles = { 3, 6, 9 },
					destTiles = { 3, 2, 1 },
					destFace = "bottom",
				},
				bottom = {
					sourceTiles = { 1, 2, 3 },
					destTiles = { 1, 4, 7 },
					destFace = "left",
				},
				left = {
					sourceTiles = { 1, 4, 7 },
					destTiles = { 3, 2, 1 },
					destFace = "top",
				},
			},
		}

		local selfContaintedTransferArray = {
			top = {
				[1] = 3,
				[3] = 9,
				[7] = 1,
				[9] = 7,
				[2] = 6,
				[6] = 8,
				[8] = 4,
				[4] = 2,
			},
			front = {
				[3] = 1,
				[9] = 3,
				[1] = 7,
				[7] = 9,
				[6] = 2,
				[8] = 6,
				[4] = 8,
				[2] = 4,
			},
			right = {
				[3] = 1,
				[9] = 3,
				[1] = 7,
				[7] = 9,
				[6] = 2,
				[8] = 6,
				[4] = 8,
				[2] = 4,
			},
			left = {
				[1] = 3,
				[3] = 9,
				[7] = 1,
				[9] = 7,
				[2] = 6,
				[6] = 8,
				[8] = 4,
				[4] = 2,
			},
			back = {
				--1-7-9-3
				[1] = 3,
				[3] = 9,
				[7] = 1,
				[9] = 7,
				[2] = 6,
				[6] = 8,
				[8] = 4,
				[4] = 2,
			},
			bottom = {
				[1] = 3,
				[3] = 9,
				[7] = 1,
				[9] = 7,
				[2] = 6,
				[6] = 8,
				[8] = 4,
				[4] = 2,
			},
		}

		local function rotateSelfContained(cube, faceName)
			local rotated = Deepcopied(cube)
			for fromTile, toTile in pairs(selfContaintedTransferArray[faceName] or {}) do
				rotated[faceName][fromTile] = cube[faceName][toTile]
			end

			return rotated
		end

		local function rotateCube(faceName)
			local temp = Deepcopied(currentCubeFaceState)

			local allFacesConfig = faceTransferArray[faceName]
			for sourceFace, content in pairs(allFacesConfig) do
				local destFace = content.destFace
				local sourcePositions = content.sourceTiles
				local desitnationPositions = content.destTiles

				for i = 1, 3 do
					temp[destFace][desitnationPositions[i]] = currentCubeFaceState[sourceFace][sourcePositions[i]]
				end
			end
			currentCubeFaceState = temp
			temp = Deepcopied(currentCubeFaceState)
			temp = rotateSelfContained(temp, faceName)
			currentCubeFaceState = temp
		end

		local function removeCubeFromMap()
			for _, face in pairs(cubeMapPositions) do
				for _, pos in pairs(face) do
					local tile = Tile(pos)
					if tile then
						local items = tile:getItems()
						for _, item in pairs(items) do
							item:remove()
						end
					end
				end
			end
		end

		local tileValueAndPlaneToId = {
			horizontal = {
				[0] = 936,
				[1] = 8230,
				[2] = 13437,
				[3] = 8085,
				[4] = 25339,
				[5] = 21261,
			},
			verticalPerpendicular = {
				[0] = 33097,
				[1] = 1356,
				[2] = 6739,
				[3] = 15914,
				[4] = 10981,
				[5] = 21229,
			},
			verticalPerallel = {
				[0] = 33098,
				[1] = 1357,
				[2] = 6740,
				[3] = 15918,
				[4] = 10982,
				[5] = 21224,
			},
		}

		local faceToPlane = {
			top = "horizontal",
			bottom = "horizontal",
			front = "verticalPerallel",
			back = "verticalPerallel",
			left = "verticalPerpendicular",
			right = "verticalPerpendicular",
		}

		local function getFacePlane(faceName)
			return faceToPlane[faceName]
		end

		local function renderCubeOnMap()
			for faceName, face in pairs(currentCubeFaceState) do
				for currentTileId, value in pairs(face) do
					local pos = cubeMapPositions[faceName][currentTileId]
					local id = tileValueAndPlaneToId[getFacePlane(faceName)][value]
					Game.createItem(id, 1, pos)
				end
			end
		end

		local leverAidToFaceName = {
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Back] = "back",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Xaxis] = "verticalParallel",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Front] = "front",

			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Right] = "right",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Yaxis] = "verticalPerpendicular",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Left] = "left",

			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Bottom] = "bottom",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Zaxis] = "horizontal",
			[Storage.DesertQuestTwo.Puzzles.RubiksCube.Top] = "top",
		}

		local function scrambleCube()
			local low, high = FindMinMaxKey(leverAidToFaceName)
			for _ = 1, 30 do
				local aid = math.random(low, high)
				local faceName = leverAidToFaceName[aid]
				rotateCube(faceName)
			end
		end

		function InitializeDQ2RubiksCube()
			removeCubeFromMap()
			scrambleCube()
			renderCubeOnMap()
		end

		local function cubeIsCompleted()
			for _, face in pairs(currentCubeFaceState) do
				local firstId = face[1]
				for _, id in pairs(face) do
					if firstId ~= id then
						return false
					end
				end
			end
			return true
		end

		local lever = Action()
		function lever.onUse(creature, item, _, _, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local faceName = leverAidToFaceName[item:getActionId()]
			rotateCube(faceName)

			if cubeIsCompleted() then
				TrySpawnDQ2progressChest("RubiksCube")
			end
			removeCubeFromMap()
			renderCubeOnMap()
			return false
		end

		for _, value in pairs(Storage.DesertQuestTwo.Puzzles.RubiksCube) do
			lever:aid(value)
		end
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local aidToDestination = {
			[Storage.DesertQuestTwo.Teleports.ToIdenticalRoom] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -21, 0),
			[Storage.DesertQuestTwo.Teleports.FromIdenticalRoom] = DESERT_QUEST_TWO_ANCHOR:Moved(6, -32, -5),
		}

		local lever = Action()
		function lever.onUse(creature, item, _, _, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			player:teleportTo(aidToDestination[item:getActionId()])
		end

		for _, value in pairs(Storage.DesertQuestTwo.Teleports) do
			lever:aid(value)
		end
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local fromHubToQuestPortal = MoveEvent()
		function fromHubToQuestPortal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			local puzzlesCompleted, puzzlesCount = GetDQ2completedPuzzleCount(player)
			if puzzlesCompleted < puzzlesCount then
				player:teleportTo(fromPosition)
				local errorString = player:Localizer(Storage.DesertQuestTwo.Questline):Get(
					"You need to complete all the puzzle challenges first. Your current progress: "
				)
				local finalString = errorString .. puzzlesCompleted .. "/" .. puzzlesCount
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, finalString)
				return
			end

			local treasureRoomPos = DESERT_QUEST_TWO_ANCHOR:Moved(13, -71, 0)
			player:teleportTo(treasureRoomPos)
			treasureRoomPos:sendMagicEffect(CONST_ME_TELEPORT)

			return true
		end
		fromHubToQuestPortal:aid(Storage.DesertQuestTwo.RewardRoomTp)
		fromHubToQuestPortal:type("stepin")
		fromHubToQuestPortal:register()
	end)
	:Script(function(storageToRequiredState)
		local function killingCurse(player)
			if player:hasCondition(CONDITION_DAZZLED) then
				return
			end
			local condition = Condition(CONDITION_DAZZLED)
			local damage = 10
			condition:addDamage(1, 4000, -damage)
			for _ = 1, 40 do
				damage = damage * 1.2
				condition:addDamage(1, 4000, -damage)
			end
			player:addCondition(condition)
		end

		local trickTeleport = MoveEvent()
		function trickTeleport.onStepIn(creature, item, _, _)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			player:teleportTo(DESERT_QUEST_TWO_ANCHOR:Moved(34, -69, 0))
			return false
		end
		trickTeleport:type("stepin")
		trickTeleport:aid(Storage.DesertQuestTwo.Puzzles.TrickTeleport)
		trickTeleport:register()

		local desertQuestTwoTrickSign = function(context)
			local user = context.player
			if not user:isPlayer() then
				return false
			end
			local localizer = user:Localizer(Storage.DesertQuestTwo.Questline)
			local resultReal = localizer:Get("DO NOT ROPE HERE! THIS SIGN WILL TRY TO TRICK AND KILL YOUR TEAMMATES")
			local resultTrick = localizer:Get("the sign says that knight and druid should use rope")
			if not user:isPaladin() then
				return localizer:Get("Only paladins can read the sacred texts.")
			end
			user:say(resultTrick, TALKTYPE_SAY)

			return resultReal
		end
		RegisterOnLook(desertQuestTwoTrickSign, "TRICK_SIGN", Storage.DesertQuestTwo.Questline)

		local desertQuestTwoTrickGrave = function(context)
			local user = context.player
			if not user:isPlayer() then
				return false
			end
			local localizer = user:Localizer(Storage.DesertQuestTwo.Questline)
			local hereWillLie = localizer:Get("Here will lie ")
			local dateOfDeath = localizer:Get("Date of death")
			local name = user:getName()

			local now = os.time()
			local dateTable = os.date("*t", now)
			local year = dateTable.year
			local month = dateTable.month
			local day = dateTable.day

			local finalString = T(":hereWillLie::playerName:. \n\n:dateOfDeath:: :day:-:month:-:year:", {
				hereWillLie = hereWillLie,
				playerName = name,
				dateOfDeath = dateOfDeath,
				day = day,
				month = month,
				year = year,
			})
			killingCurse(user)
			return finalString
		end
		RegisterOnLook(desertQuestTwoTrickGrave, "TRICK_GRAVE", Storage.DesertQuestTwo.Questline)
	end)
	:Script(function(storageToRequiredState)
		local sparksNumber = 3

		local passableId = 5062
		local unpassableId = 6288

		local fadeDelay = 10
		local currentFadeTimer = 0

		local function tryCreatePassableSparksLoop(topPos)
			if os.time() > currentFadeTimer then
				for i = 0, 2 do
					local sparkPos = topPos:Moved(0, i, 0)
					local sparkItem = Tile(sparkPos):getItemById(unpassableId)
					if sparkItem then
						sparkItem:remove()
					end
					Game.createItem(passableId, 1, sparkPos)
				end
				return
			end

			addEvent(function()
				tryCreatePassableSparksLoop(topPos)
			end, 1000)
		end

		local function createUnpassableSparks(topPos)
			for i = 0, 2 do
				local sparkPos = topPos:Moved(0, i, 0)
				local passableSpark = Tile(sparkPos):getItemById(passableId)
				if not passableSpark then
					return
				end
				passableSpark:remove()
				Game.createItem(unpassableId, 1, sparkPos)
			end
			tryCreatePassableSparksLoop(topPos)
		end

		local beforeSparks = MoveEvent()
		function beforeSparks.onStepIn(creature, _, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			currentFadeTimer = os.time() + fadeDelay

			local centerPos = DESERT_QUEST_TWO_ANCHOR:Moved(-26, 1, 1)
			local unpassableSpark = Tile(centerPos):getItemById(unpassableId)
			if unpassableSpark then
				return
			end

			createUnpassableSparks(centerPos)
			return true
		end

		beforeSparks:aid(Storage.DesertQuestTwo.Puzzles.FireBlockageTile)
		beforeSparks:type("stepin")
		beforeSparks:register()
	end)

local quest = Quest(LOCALIZERS.RetroRulez)

quest
	:Storage(function()
		Storage.PitsOfInfernoRetro = {
			CoalForPrzemek = {},
			Tile1 = {},
			Tile2 = {},
			Tile3 = {},
			Tile4 = {},
			Tile6 = {},
			Tile7 = {},
			Tile8 = {},
			Tile9 = {},
			PuzzleTilesState = {},
			CenterTile = {},

			LeverTile = {},
			LeverTeleportToNext = {},

			BetweenTwoLeversToNext = {},
			GrantLavaRoomAccess = {},

			InfiniteCoalChest = {},
			InfiniteCoal = {},
		}
		QuestState.PitsOfInfernoRetro = {
			CoalForPrzemek = {
				BringCoalToPrzemek = 1,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.PitsOfInfernoRetro = {
			InfiniteCoal = { id = 11334, key = Storage.PitsOfInfernoRetro.InfiniteCoal },
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Retro Rulez",
			localizer = localizer,
			missions = {
				{
					name = "Coal for Przemek",
					storage = Storage.PitsOfInfernoRetro.CoalForPrzemek,
					states = {
						[QuestState.PitsOfInfernoRetro.CoalForPrzemek.BringCoalToPrzemek] = "Przemek asked you to find infinite coal in fabulous items room inside pits of inferno. Start by discovering dark lord's laboratory.",
						[MISSION_FINISHED] = "You finished this mission.",
					},
				},
			},
		})
	end)
	:Mission(Storage.PitsOfInfernoRetro.CoalForPrzemek)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("GOD Przemek", {
				[{ GREET }] = {
					text = "Hello. We are are not finished with rewards room yet. We are short on unpickable locks, and out sculptor is late with the order. Also we have {issues} with infinite petrol lamps.",
				},
				[{ "issues", "problemy" }] = {
					text = "I left some of the supply with other fabulous items in warehouse at start of the dungeon. The warehouse is curently locked and the only way in is using a key. If you have problem with getting into the lab, i will leave a tip for you there later.",
					nextState = {
						[Storage.PitsOfInfernoRetro.CoalForPrzemek] = QuestState.PitsOfInfernoRetro.CoalForPrzemek.BringCoalToPrzemek,
					},
				},
			})
	end)
	:State(function()
		return QuestState.PitsOfInfernoRetro.CoalForPrzemek.BringCoalToPrzemek,
			QuestFactory.Dialog("GOD Przemek", {
				[{ GREET }] = {
					text = "Did you manage to find the coal?",
				},
				[{ "yes", "tak", "mission", "misja" }] = {
					text = "Good job. Take this outfit as your reward.",
					requiredItems = {
						QuestKeyItems.PitsOfInfernoRetro.InfiniteCoal,
					},
					nextState = {
						[Storage.PitsOfInfernoRetro.CoalForPrzemek] = MISSION_FINISHED,
					},
					outfitRewards = {
						{ outfitId = 948 },
						{ outfitId = 949 },
					},
					expReward = 1000000,
				},
				[{ "no", "nie" }] = {
					text = "I left some of the supply with other fabulous items in warehouse at start of the dungeon. The warehouse is curently locked and the only way in is using a key. If you have problem with getting into the lab, i will leave a tip for you there later.",
				},
			})
	end)
	:Script(function()
		local tileOrder = {}
		local coinIds = {
			ItemId.GOLD_COIN,
			ItemId.PLATINUM_COIN,
			ItemId.CRYSTAL_COIN,
		}
		local maxCoinStack = 5
		local function loadTileOrder()
			tileOrder = {}
			local corner1 = Position(5019, 1117, 11)
			local corner2 = Position(5023, 1121, 11)

			local coinToCountToGroundkey = {}
			for _, coinId in pairs(coinIds) do
				coinToCountToGroundkey[coinId] = {}
				for i = 1, maxCoinStack do
					coinToCountToGroundkey[coinId][i] = ""
				end
			end

			local keyToItems = {}
			IterateBetweenPositions(corner1, corner2, function(context)
				local pos = context.pos
				local tile = Tile(pos)
				local items = tile:getItems()
				local key = tile:getGround():getKey()
				if key then
					keyToItems[key] = items
				end
			end)
			for key, items in pairs(keyToItems) do
				for _, item in pairs(items) do
					coinToCountToGroundkey[item:getId()][item:getCount()] = key
				end
			end

			for _, coinId in pairs(coinIds) do
				local countToGroundKey = coinToCountToGroundkey[coinId]
				for count, groundKey in pairs(countToGroundKey) do
					table.insert(tileOrder, groundKey)
				end
			end
			return tileOrder
		end

		local stepOrderPuzzle = MoveEvent()
		function stepOrderPuzzle.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local state = math.max(player:getStorageValueByKey(Storage.PitsOfInfernoRetro.PuzzleTilesState), 1)
			local requiredKey = tileOrder[state]
			local nextState = 1
			if item:getKey() == requiredKey then
				nextState = state + 1
			end
			player:setStorageValueByKey(Storage.PitsOfInfernoRetro.PuzzleTilesState, nextState)
			return true
		end
		stepOrderPuzzle:type("stepin")
		for _, key in pairs({
			Storage.PitsOfInfernoRetro.Tile1,
			Storage.PitsOfInfernoRetro.Tile2,
			Storage.PitsOfInfernoRetro.Tile3,

			Storage.PitsOfInfernoRetro.Tile4,
			--Storage.PitsOfInfernoRetro.Tile5,
			Storage.PitsOfInfernoRetro.Tile6,

			Storage.PitsOfInfernoRetro.Tile7,
			Storage.PitsOfInfernoRetro.Tile8,
			Storage.PitsOfInfernoRetro.Tile9,
		}) do
			stepOrderPuzzle:key(key)
		end
		stepOrderPuzzle:register()

		local loadOrderStartup = GlobalEvent("RetroPoi/loadTileOrder")
		function loadOrderStartup.onStartup()
			loadTileOrder()
		end
		loadOrderStartup:register()

		local stepOrderPuzzlePortalDest = Position(5025, 1118, 11)
		local stepOrderCenter = MoveEvent()
		function stepOrderCenter.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local state = player:getStorageValueByKey(Storage.PitsOfInfernoRetro.PuzzleTilesState)
			if state > #tileOrder then
				player:teleportTo(stepOrderPuzzlePortalDest)
			end
			return true
		end
		stepOrderCenter:type("stepin")
		stepOrderCenter:key(Storage.PitsOfInfernoRetro.CenterTile)
		stepOrderCenter:register()

		local leversOrder = {}
		local function loadLeverOrder()
			local corner1 = Position(5026, 1183, 11)
			local corner2 = Position(5028, 1191, 11)
			IterateBetweenPositions(corner1, corner2, function(context)
				local leverLeft = context.pos:GetItemById(ItemId.LEVER_LEFT)
				local leverRight = context.pos:GetItemById(ItemId.LEVER_RIGHT)
				local foundLever = leverLeft or leverRight
				if leverLeft or leverRight then
					table.insert(leversOrder, foundLever:getId())
				end
			end)
		end
		local loadLeverOrderStartup = GlobalEvent("RetroPoi/loadLeverOrderStartup")
		function loadLeverOrderStartup.onStartup()
			loadLeverOrder()
		end
		loadLeverOrderStartup:register()

		local corner1 = Position(5028, 1116, 11)
		local corner2 = Position(5028, 1121, 11)
		local function leversAreSetCorrectly()
			local detectedLevers = {}
			IterateBetweenPositions(corner1, corner2, function(context)
				local leverLeft = context.pos:GetItemById(ItemId.LEVER_LEFT)
				local leverRight = context.pos:GetItemById(ItemId.LEVER_RIGHT)
				local detectedLever = leverLeft or leverRight
				table.insert(detectedLevers, detectedLever:getId())
			end)
			for i, detectedId in ipairs(detectedLevers) do
				if detectedId ~= leversOrder[i] then
					return false
				end
			end
			return true
		end

		local puzzlesReturnDestination = Position(5017, 1117, 11)
		local nextPuzzleDestination = Position(5028, 1115, 11)
		local leverPuzzleTeleport = MoveEvent()
		function leverPuzzleTeleport.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if leversAreSetCorrectly() then
				player:teleportTo(nextPuzzleDestination)
			else
				player:teleportTo(puzzlesReturnDestination)
			end
			return true
		end
		leverPuzzleTeleport:type("stepin")
		leverPuzzleTeleport:key(Storage.PitsOfInfernoRetro.LeverTeleportToNext)
		leverPuzzleTeleport:register()

		local leverPuzzle = MoveEvent()
		function leverPuzzle.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local leverPos = toPosition:Moved(2, -1, 0)
			local lever = leverPos:GetTopItem()
			FlipLever(lever)
			return true
		end
		leverPuzzle:type("stepin")
		leverPuzzle:key(Storage.PitsOfInfernoRetro.LeverTile)
		leverPuzzle:register()

		local grantLavaRoomAccessLever = Action()
		function grantLavaRoomAccessLever.onUse(player, item, frompos, item2, topos)
			player:setStorageValueByKey(Storage.PitsOfInfernoRetro.GrantLavaRoomAccess, ACCESS_GRANTED)
			return true
		end
		grantLavaRoomAccessLever:key(Storage.PitsOfInfernoRetro.GrantLavaRoomAccess)
		grantLavaRoomAccessLever:register()

		local teleportPuzzleDestination = Position(5026, 1113, 11)
		local leverPuzzleFinishLever = Action()
		function leverPuzzleFinishLever.onUse(player, item, frompos, item2, topos)
			if player:getStorageValueByKey(Storage.PitsOfInfernoRetro.GrantLavaRoomAccess) == ACCESS_GRANTED then
				player:teleportTo(teleportPuzzleDestination)
			else
				player:teleportTo(puzzlesReturnDestination)
			end
			return true
		end
		leverPuzzleFinishLever:key(Storage.PitsOfInfernoRetro.BetweenTwoLeversToNext)
		leverPuzzleFinishLever:register()

		local retroOutfitChest = Action()
		function retroOutfitChest.onUse(player, item, frompos, item2, topos)
			if player:getStorageValueByKey(InfiniteCoalChest) == MISSION_FINISHED then
				return true
			end

			player:setStorageValueByKey(InfiniteCoalChest, MISSION_FINISHED)
			player:TryAddItems({ QuestKeyItems.PitsOfInfernoRetro.InfiniteCoal })
			return true
		end
		retroOutfitChest:key(Storage.PitsOfInfernoRetro.InfiniteCoalChest)
		retroOutfitChest:register()
	end)
	:Register()

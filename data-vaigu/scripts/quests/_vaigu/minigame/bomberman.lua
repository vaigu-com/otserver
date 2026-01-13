local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Storage(function()
		Storage.Bomberman = {
			PlayerPerks = {
				BombExplosionRadius = {},
				MaxActiveBombs = {},
				CurrentActiveBombs = {
					[1] = {},
					[2] = {},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {},
					[7] = {},
					[8] = {},
					[9] = {},
					[10] = {},
				},
				BonusSpeed = {},
			},
			StepIns = {
				BonusSpeed = {},
				BonusRadius = {},
				BonusMaxActive = {},
			},
		}
	end)
	:Constant(function()
		QuestConstants.Bomberman = {
			BOMB_IS_ACTIVE = 1,
			BOMB_IS_INACTIVE = -1,

			BOMB_RADIUS_DEFAULT = 1,
			BOMB_MAX_ACTIVE_DEFAULT = 1,
			BONUS_SPEED_DEFAULT = 0,

			BOMB_MAX_RADIUS = 5,
			BOMB_MAX_ACTIVE = 5,
			BONUS_SPEED_MAX = 5,

			BOMB_DURATION_MS = 2000,

			BLOCKAGE_ID = 2187,
			EXPLODABLE_WALL_ID = 8505,
			BOMB_ID = 27492,
			PERK_ID = 9586,

			PERK_APPEAR_CHANCE_PERCENT = 35,
		}
	end)
	:Script(function()
		local bomberman = MinigameData({
			minigameName = "Bomberman",
			competitionType = MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING,
			requiredPlayers = 1,
		})
		Minigames.Bomberman = bomberman

		Game.setStorageValueByKey(Storage.Bomberman.PlayerPerks.MaxActiveBombs, TableSize(Storage.Bomberman.PlayerPerks.CurrentActiveBombs))

		local clearableIds = {
			QuestConstants.Bomberman.PERK_ID,
			QuestConstants.Bomberman.EXPLODABLE_WALL_ID,
		}
		local function clearRoom()
			local gameAreaCorner1, gameAreaCorner2 = Zone(Minigames.Bomberman:GetScope():Get("GameAreaCorners")):getCorners()
			ItemExList():Area(Area(gameAreaCorner1, gameAreaCorner2)):FilterByIds(clearableIds):Remove()
		end

		local function emplaceStones()
			local gameAreaCorner1, gameAreaCorner2 = Zone(Minigames.Bomberman:GetScope():Get("GameAreaCorners")):getCorners()
			local stonePositionsCorner1, stonePositionsCorner2 = Zone(Minigames.Bomberman:GetScope():Get("StonePositionsCorners")):getCorners()
			local vectorBetween1 = stonePositionsCorner1:VectorBetween(gameAreaCorner1)
			local vectorBetween2 = stonePositionsCorner2:VectorBetween(gameAreaCorner2)
			if vectorBetween1 ~= vectorBetween2 then
				logger.warn("[bomberman.beforeStart][emplaceStones] vectors between game area and stone positions room arent identical!")
			end

			ItemExList():Area(Area(stonePositionsCorner1, stonePositionsCorner2)):FilterById(QuestConstants.Bomberman.EXPLODABLE_WALL_ID):Copied(vectorBetween1)
		end

		bomberman.beforeStart = function()
			clearRoom()
			emplaceStones()

			local participants = bomberman:GetLobbyZone():getPlayers()
			for _, participant in pairs(participants) do
				participant:setStorageValueByKey(Storage.Bomberman.PlayerPerks.BombExplosionRadius, QuestConstants.Bomberman.BOMB_RADIUS_DEFAULT)
				participant:setStorageValueByKey(Storage.Bomberman.PlayerPerks.MaxActiveBombs, QuestConstants.Bomberman.BOMB_MAX_ACTIVE_DEFAULT)
				for key, value in pairs(Storage.Bomberman.PlayerPerks.CurrentActiveBombs) do
					participant:setStorageValueByKey(value, QuestConstants.Bomberman.BOMB_IS_INACTIVE)
				end
				participant:setStorageValueByKey(Storage.Bomberman.PlayerPerks.BonusSpeed, QuestConstants.Bomberman.BONUS_SPEED_DEFAULT)
			end
		end
	end)
	:Script(function()
		local playerStorageToMaximum = {
			[Storage.Bomberman.PlayerPerks.BonusSpeed] = QuestConstants.Bomberman.BONUS_SPEED_MAX,
			[Storage.Bomberman.PlayerPerks.MaxActiveBombs] = QuestConstants.Bomberman.BOMB_MAX_ACTIVE,
			[Storage.Bomberman.PlayerPerks.BombExplosionRadius] = QuestConstants.Bomberman.BOMB_MAX_RADIUS,
		}
		local playerStorageToMessage = {
			[Storage.Bomberman.PlayerPerks.BonusSpeed] = "You now move faster!",
			[Storage.Bomberman.PlayerPerks.MaxActiveBombs] = "You can now place 1 more bomb!",
			[Storage.Bomberman.PlayerPerks.BombExplosionRadius] = "Your bomb explosions are one tile bigger!",
		}
		local playerStorageToMagicEffect = {
			[Storage.Bomberman.PlayerPerks.BonusSpeed] = CONST_ME_GREEN_ENERGY_SPARK,
			[Storage.Bomberman.PlayerPerks.MaxActiveBombs] = CONST_ME_WHITE_ENERGY_SPARK,
			[Storage.Bomberman.PlayerPerks.BombExplosionRadius] = CONST_ME_BLUE_ENERGY_SPARK,
		}
		local function tryIncrementBombermanStorage(player, storage)
			local maxValue = playerStorageToMaximum[storage]
			local incrementedValue = player:getStorageValueByKey(storage) + 1
			local nextValue = math.min(maxValue, incrementedValue)
			player:setStorageValueByKey(storage, nextValue)

			if incrementedValue > maxValue then
				player:sendTextMessage(MESSAGE_LOOK, "You already have maximum bonus for this perk.")
			elseif incrementedValue <= maxValue then
				player:sendTextMessage(MESSAGE_LOOK, playerStorageToMessage[storage])
				player:getPosition():sendMagicEffect(playerStorageToMagicEffect[storage])
			end
			return nextValue
		end

		local speedBuff = MoveEvent()
		function speedBuff.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local playerBonus = tryIncrementBombermanStorage(player, Storage.Bomberman.PlayerPerks.BonusSpeed)
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, Minigames.Bomberman:GetFixedSpeed() + playerBonus * 10)
			player:SetMinigameFixedSpeed()
			item:remove()
			return true
		end
		speedBuff:key(Storage.Bomberman.StepIns.BonusSpeed)
		speedBuff:type("stepin")
		speedBuff:register()

		local radiusBuff = MoveEvent()
		function radiusBuff.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			tryIncrementBombermanStorage(player, Storage.Bomberman.PlayerPerks.BombExplosionRadius)
			item:remove()
			return true
		end
		radiusBuff:key(Storage.Bomberman.StepIns.BonusRadius)
		radiusBuff:type("stepin")
		radiusBuff:register()

		local activeBombsCountBuff = MoveEvent()
		function activeBombsCountBuff.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			tryIncrementBombermanStorage(player, Storage.Bomberman.PlayerPerks.MaxActiveBombs)
			item:remove()
			return true
		end
		activeBombsCountBuff:key(Storage.Bomberman.StepIns.BonusMaxActive)
		activeBombsCountBuff:type("stepin")
		activeBombsCountBuff:register()
	end)
	:Script(function()
		local function tryCreatePerkStepIn(pos)
			local roll = math.random(1, 100)
			if roll < QuestConstants.Bomberman.PERK_APPEAR_CHANCE_PERCENT then
				Game.createItem(QuestConstants.Bomberman.PERK_ID, 1, pos):setKey(table.random(Storage.Bomberman.StepIns))
			end
		end

		local function tryRemoveBlockageInDirection(centerPosition, direction, radius)
			for i = 1, radius do
				local pos = centerPosition:MovedByVector(Vector.FromDirection(direction):Scaled(i))
				local wall = pos:GetItemById(QuestConstants.Bomberman.EXPLODABLE_WALL_ID)
				if wall then
					wall:remove()
					pos:sendMagicEffect(CONST_ME_POFF)
					tryCreatePerkStepIn(pos)
					return i
				elseif pos:GetItemById(QuestConstants.Bomberman.BLOCKAGE_ID) then
					return i
				else
					pos:sendMagicEffect(CONST_ME_ENERGYAREA)
				end
			end
			return radius
		end

		local function explodeBomb(position, radius)
			for key, direction in pairs({
				DIRECTION_NORTH,
				DIRECTION_EAST,
				DIRECTION_SOUTH,
				DIRECTION_WEST,
			}) do
				local bombRangeInThisDirection = tryRemoveBlockageInDirection(position, direction, radius)
				CreatureList():Area(Area(position, position:MovedInDirection(direction, bombRangeInThisDirection))):FilterByPlayer():ForEach(function(player)
					player:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end)
			end
		end

		local function placeBomb(position, radius)
			local bomb = Game.createItem(QuestConstants.Bomberman.BOMB_ID, 1, position)
			local blockage = Game.createItem(QuestConstants.Bomberman.BLOCKAGE_ID, 1, position)
			addEvent(function()
				bomb:remove()
				blockage:remove()
				explodeBomb(position, radius)
			end, QuestConstants.Bomberman.BOMB_DURATION_MS)
		end

		local function tryPlaceBomb(player, bombSlot)
			if player:getStorageValueByKey(bombSlot) == QuestConstants.Bomberman.BOMB_IS_INACTIVE then
				player:setStorageValueByKey(bombSlot, QuestConstants.Bomberman.BOMB_IS_ACTIVE)
				placeBomb(player:getPosition(), player:getStorageValueByKey(Storage.Bomberman.PlayerPerks.BombExplosionRadius))
				addEvent(function()
					player:setStorageValueByKey(bombSlot, QuestConstants.Bomberman.BOMB_IS_INACTIVE)
				end, QuestConstants.Bomberman.BOMB_DURATION_MS)
				return true
			else
				return false
			end
		end

		local function tryPlaceBombAnySlot(player)
			local maxBombs = player:getStorageValueByKey(Storage.Bomberman.PlayerPerks.MaxActiveBombs)
			for i, bombSlot in ipairs(Storage.Bomberman.PlayerPerks.CurrentActiveBombs) do
				if i > maxBombs then
					return false
				end
				if tryPlaceBomb(player, bombSlot) then
					return true
				end
			end

			return false
		end

		local placeBombSay = TalkAction("!bomb")
		function placeBombSay.onSay(player, words, param)
			if not Minigames.Bomberman:isInZone(player:getPosition()) then
				return false
			end

			local success = tryPlaceBombAnySlot(player)
			if not success then
				doCreatureSay(player, "You already placed maximum number of bombs.", TALKTYPE_ORANGE_1)
			end
			return true
		end
		placeBombSay:groupType("normal")
		placeBombSay:register()

		local startEvent = TalkAction("!bomberman")
		function startEvent.onSay(player, words, param)
			local status = Minigames.Bomberman:TryStartLobbyFast()
			return false
		end
		startEvent:separator(" ")
		startEvent:groupType("tutor")
		startEvent:register()
	end)
	:Register()

local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:Storage(function()
		--Minigame zones are configured at startup (after map is loaded; before players can log in)
		Storage.Minigames = {
			FixedSpeed = {},
			SpecificMinigameStatistics = {},
			AllMinigamesStatistics = {
				Wins = {},
				Matches = {},
				Points = {},
			},
			CurrentMinigame = {},
			ExitToSharedLobby = {},
			SharedLobbyExitTeleport = {},
			SharedLobbyEnterTeleport = {},
			SharedLobbyPlayerSpawn = {},
			SharedLobbyArea = {},
			LastSharedLobbyEnterFromPostion = {},

			AllowPlayersWalkthrough = {},
		}
	end)
	:Constant(function()
		GRAND_PLACE_NOT_ASSIGNED = -1

		---@class PlayerMinigameFinishContext
		---@field player Player
		---@field minigameData MinigameData
		---@field grandPlace number
		---generated
		---@field timeTakenSeconds number
		---@field competitionType MINIGAME_COMPETITION_TYPE
		PlayerMinigameFinishContext = {}
		PlayerMinigameFinishContext.__index = PlayerMinigameFinishContext
		function PlayerMinigameFinishContext.New(context)
			local newObj = {
				player = context.player,
				grandPlace = context.grandPlace,
				startTimestamp = context.startTimestamp,
				timeTakenSeconds = os.time() - context.startTimestamp,
				minigameData = context.minigameData,
			}
			setmetatable(newObj, PlayerMinigameFinishContext)
			return newObj
		end
		setmetatable(PlayerMinigameFinishContext, {
			__call = function(_, ...)
				return PlayerMinigameFinishContext.New(...)
			end,
		})

		--[[
		---@class MinigameDataContext
		---@field private disabled boolean?
		---@field public disableLockout boolean does not apply cooldown on kill/entry
		---@field private requiredState table?
		---@field private lockoutExpiryTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
		---@field private lockoutTriggerCriterion LOCKOUT_TRIGGER_TYPE?
		---@field private timeToDefeat number?
		---@field private ejectAfterCompletionSeconds number?
		---@field private requiredLevel number?
		---@field private requiredPlayers integer? -- size of entrance grid if nil
		---@field private onUseExtra function
		---@field private monsters {name: string, pos: Position}[]
		---@field private timeoutEvent Event
		---@field private stages EncounterStage[]
		---@field private currentStage number
		---@field private events table
		---@field private global boolean
		---@field private timeToSpawnMonsters number|nil
		---@field private onReset function?
		---@field private beforeStart function?
		---@field private active boolean
		---@field private isMinigame boolean?
		---@field public bossName string?
		MinigameDataContext = MinigameDataContext

		---@class MinigameOrchestratorContext
		---@field competitionType MINIGAME_COMPETITION_TYPE
		---@field finishPosition Position
		---@field startParticipantsCount integer
		---@field startPosition Position
		---@field startTimestamp number
		MinigameOrchestratorContext = {}
		MinigameOrchestratorContext.__index = MinigameOrchestratorContext
		function MinigameOrchestratorContext.New(competitionType, finishPosition, startParticipantsCount, startPosition, minigameName, startTimestamp)
			local newObj = {}
			newObj.competitionType = competitionType
			newObj.finishPosition = finishPosition
			newObj.startParticipantsCount = startParticipantsCount
			newObj.startPosition = startPosition
			newObj.minigameName = minigameName
			newObj.startTimestamp = startTimestamp
			setmetatable(newObj, MinigameOrchestratorContext)
			return newObj
		end
		setmetatable(MinigameOrchestratorContext, {
			__call = function(_, ...)
				return MinigameOrchestratorContext.New(...)
			end,
		})

		---@param minigameData MinigameData
		---@return MinigameOrchestratorContext
		function MinigameOrchestratorContext.FromMinigameData(minigameData)
			local context = MinigameOrchestratorContext(
			minigameData:GetCompetitionType(), 
			minigameData:GetFinishPosition(), 
			minigameData:GetStartParticipantsCount(), 
			minigameData:GetStartPosition(), 
			minigameData:GetDisplayName(), 
			minigameData:GetStartTimestamp()
		)
			return context
		end
		]]

		---@class MinigameOrchestrator
		---@field private competitionType MINIGAME_COMPETITION_TYPE
		---@field private finishPosition Position
		---@field private startParticipantsCount number
		---@field private startPosition Position
		---@field private minigameName string
		---@field private startTimestamp number
		---generated
		---@field private finishContexts PlayerMinigameFinishContext[]
		MinigameOrchestrator = {}
		MinigameOrchestrator.__index = MinigameOrchestrator
		----@param context MinigameOrchestratorContext
		---@param minigameData MinigameData
		---@return MinigameOrchestrator
		function MinigameOrchestrator.FromMinigameData(minigameData)
			local newObj = {
				competitionType = minigameData:GetCompetitionType(),
				finishPosition = minigameData:GetFinishPosition(),
				startParticipantsCount = minigameData:GetStartParticipantsCount(),
				startPosition = minigameData:GetStartPosition(),
				minigameName = minigameData:GetDisplayName(),
				startTimestamp = minigameData:GetStartTimestamp(),
				minigameData = minigameData,
				finishContexts = {},
			}

			if newObj.competitionType == MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING then
				newObj.nextGrandPlace = newObj.startParticipantsCount
			elseif newObj.competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
				newObj.nextGrandPlace = 1
			end
			setmetatable(newObj, MinigameOrchestrator)
			return newObj
		end
		setmetatable(MinigameOrchestrator, {
			__call = function(_, ...)
				return MinigameOrchestrator.New(...)
			end,
		})

		function MinigameOrchestrator:GetMinigameData()
			return self.minigameData
		end

		function MinigameOrchestrator:GetNextGrandPlaceSpeedrun()
			local nextGrandPlace = self.nextGrandPlace
			self.nextGrandPlace = self.nextGrandPlace + 1
			return nextGrandPlace
		end
		function MinigameOrchestrator:GetNextGrandPlaceLMS()
			local nextGrandPlace = self.nextGrandPlace
			self.nextGrandPlace = self.nextGrandPlace - 1
			return nextGrandPlace
		end

		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdateWins(playerContext)
			playerContext.player:incrementStorageByKeyClampZero(playerContext.minigameData.winsStorage)
			playerContext.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Wins)
		end
		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdateMatches(playerContext)
			playerContext.player:incrementStorageByKeyClampZero(playerContext.minigameData.matchesStorage)
			playerContext.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Matches)
		end
		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdatePoints(playerContext)
			local grandPlacePoints = math.max((4 - playerContext.grandPlace), 0)
			playerContext.player:incrementStorageByKeyClampZero(playerContext.minigameData.pointsStorage, grandPlacePoints)
			playerContext.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Points, grandPlacePoints)
		end
		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdateTimesSpeedrun(playerContext)
			local timeTakenSeconds = playerContext.timeTakenSeconds
			local shortestTime = playerContext.player:getStorageValueByKey(playerContext.minigameData.shortestTime)
			if shortestTime == MISSION_NOT_STARTED then
				shortestTime = 9000000
			end

			if timeTakenSeconds < shortestTime and playerContext.grandPlace == 1 then
				playerContext.player:setStorageValueByKey(playerContext.minigameData.shortestTime, timeTakenSeconds)
			end
		end
		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdateTimesLMS(playerContext)
			local timeTakenSeconds = playerContext.timeTakenSeconds
			local longestTime = playerContext.player:getStorageValueByKey(playerContext.minigameData.longestTime)

			if timeTakenSeconds > longestTime then
				playerContext.player:setStorageValueByKey(playerContext.minigameData.longestTime, timeTakenSeconds)
			end
		end

		---@param playerContext PlayerMinigameFinishContext
		function MinigameOrchestrator:UpdateRecords(playerContext)
			if playerContext.grandPlace == 1 then
				self:UpdateWins(playerContext)
			end

			self:UpdateMatches(playerContext)
			self:UpdatePoints(playerContext)
		end
		local consolationMultiplier = 1
		---@param finishContext PlayerMinigameFinishContext
		function MinigameOrchestrator:GrantRewards(finishContext)
			local highPlaceMultiplier = math.max((4 - finishContext.grandPlace), 0)
			finishContext.player:addXpBoostTime((highPlaceMultiplier + consolationMultiplier) * 5 * 60)
			finishContext.player:AddAllCoins((consolationMultiplier + highPlaceMultiplier) * 1)
		end
		function MinigameOrchestrator:AnnounceGrandPlace(finishContext)
			if finishContext.grandPlace > 3 then
				return
			end
			Game.broadcastMessage(MINIGAMES_BROADCAST_TOP_PARTICIPANTS, nil, true, {
				playerName = finishContext.player:getName(),
				timeTakenSeconds = finishContext.timeTakenSeconds,
				grandPlace = finishContext.grandPlace,
				competitionType = self.competitionType,
				minigameName = self.minigameName,
			})
		end
		function MinigameOrchestrator:AfterSuccesfulEveryoneFinishSpeedrun()
			local finishContexts = self:GetFinishContexts()
			table.sort(finishContexts, function(a, b)
				if a.distance ~= b.distance then
					return a.distance > b.distance
				else
					return a.timeTakenSeconds < b.timeTakenSeconds
				end
			end)

			for _, finishContext in pairs(finishContexts) do
				finishContext.grandPlace = self:GetNextGrandPlaceSpeedrun()
				self:OnNextPlaceWinnerFinish(finishContext)
			end
		end
		--[[
		function MinigameOrchestrator:AfterSuccesfulEveryoneFinishLMS()
			local finishContexts = self:GetFinishContexts()
			table.sort(finishContexts, function(a, b)
				return a.timeTakenSeconds > b.timeTakenSeconds
			end)

			for _, playerContext in pairs(finishContexts) do
				playerContext.grandPlace = self:GetNextGrandPlaceSpeedrun()
				self:UpdateTimesSpeedrun(playerContext)
				self:UpdateRecords(playerContext)
				self:GrantRewards(playerContext)
				self:AnnounceGrandPlace(playerContext)
			end
		end
		]]
		---@return PlayerMinigameFinishContext[]
		function MinigameOrchestrator:GetFinishContexts()
			return self.finishContexts
		end
		---@param finishContext PlayerMinigameFinishContext
		function MinigameOrchestrator:AppendFinishContext(finishContext)
			table.insert(self.finishContexts, finishContext)
		end
		function MinigameOrchestrator:GetFinishPosition()
			return self.finishPosition
		end
		---@param finishContext PlayerMinigameFinishContext
		function MinigameOrchestrator:OnNextPlaceWinnerFinish(finishContext)
			self:UpdateTimesSpeedrun(finishContext)
			self:UpdateRecords(finishContext)
			self:GrantRewards(finishContext)
			self:AnnounceGrandPlace(finishContext)
		end
		function MinigameOrchestrator:AfterSuccesfulPlayerFinishSpeedrun(player)
			local playerFinishPosition = player:getPosition()
			local x, y, z = playerFinishPosition:DistanceVector(self.startPosition)
			local maxDist = math.max(x, y, z)
			local playerContext = PlayerMinigameFinishContext({
				player = player,
				grandPlace = GRAND_PLACE_NOT_ASSIGNED,
				distance = maxDist,
				minigameData = self:GetMinigameData(),
			})
			if playerFinishPosition == self.finishPosition then
				playerContext.grandPlace = self:GetNextGrandPlaceSpeedrun()
				self:OnNextPlaceWinnerFinish(playerContext)
			else
				self:AppendFinishContext(playerContext)
			end
		end
		function MinigameOrchestrator:GetStartTimestamp()
			return self.startTimestamp
		end
		function MinigameOrchestrator:AfterSuccesfulPlayerFinishLMS(player)
			local playerContext = PlayerMinigameFinishContext({
				player = player,
				grandPlace = self:GetNextGrandPlaceLMS(),
				startTimestamp = self:GetStartTimestamp(),
				minigameData = self:GetMinigameData(),
			})
			self:OnNextPlaceWinnerFinish(playerContext)
		end
		function MinigameOrchestrator:AfterSuccesfulPlayerFinish(player)
			local competitionType = self.competitionType
			if competitionType == MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING then
				self:AfterSuccesfulPlayerFinishLMS(player)
			elseif competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
				self:AfterSuccesfulPlayerFinishSpeedrun(player)
			end
		end

		local specificMinigameStatisticsScope = Scope(Storage.Minigames.SpecificMinigameStatistics)

		---@class MinigameData
		---@field private disabled boolean?
		---@field public disableLockout boolean does not apply cooldown on kill/entry
		---@field private requiredState table?
		---@field private lockoutExpiryTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
		---@field private lockoutTriggerCriterion LOCKOUT_TRIGGER_CRITERION?
		---@field private timeToDefeatSeconds number?
		---@field private ejectAfterCompletionSeconds number?
		---@field private requiredLevel number?
		---@field private requiredPlayers integer?
		---@field private timeoutEvent Event
		---@field private stages EncounterStage[]
		---@field private currentStage number
		---@field private events table
		---@field private global boolean
		---@field private onReset function?
		---@field private beforeStart function?
		---@field private active boolean
		---@field private isMinigame boolean?
		---@field private minigameName string
		---@field private enableDebug boolean?
		---generated:
		---@field private registered boolean
		---@field private bossSpawnPosition Position
		---@field private entranceLeverZone Zone
		---@field private bossRoomEntranceZone Zone
		---@field private encounterAreaPositionsZone Zone
		---@field private monsterSpawnZone Zone
		---@field shortestTime string
		---@field longestTime string
		MinigameData = {}
		MinigameData.__index = MinigameData
		---@param context MinigameDataContext
		function MinigameData.New(context)
			local newObj = {
				shortestTime = specificMinigameStatisticsScope:Get("ShortestTime"),
				longestTime = specificMinigameStatisticsScope:Get("LongestTime"),
			}
			setmetatable(newObj, MinigameData)
			newObj:GenerateOnStartup(context)
			newObj:SetupScopes()
			return newObj
		end
		setmetatable(MinigameData, {
			__call = function(_, displayName)
				return MinigameData.New(displayName)
			end,
		})

		function MinigameData:GetDisplayName()
			return self.minigameName
		end

		function MinigameData.ConfigureSharedLobby()
			local sharedLobbyZone = Zone(Storage.Minigames.SharedLobbyArea)
			local zoneEvents = ZoneEvent(sharedLobbyZone)

			function zoneEvents.beforeEnter(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				player:sendTextMessage(MESSAGE_FAILURE, "During minigames, you cannot use potions, runes or spells and your movement speed will be fixed to a certain value.")
				player:setStorageValueByKey(Storage.Minigames.AllowPlayersWalkthrough, ACCESS_GRANTED)
				player:isOnMinigame(true)
				player:setStorageValueByKey(Storage.Minigames.FixedSpeed, 100)
				player:changeSpeed()
				return true
			end

			function zoneEvents.afterLeave(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return
				end
				player:isOnMinigame(false)
				player:changeSpeed()
			end

			zoneEvents:register()
		end
		SHARED_LOBBY_SPAWN_POSITION = nil
		local sharedLobbySpawnPositionScope = Storage.Minigames.SharedLobbyPlayerSpawn

		local sharedLobbySpawnPositionStartup = GlobalEvent(sharedLobbySpawnPositionScope)
		function sharedLobbySpawnPositionStartup.onStartup()
			SHARED_LOBBY_SPAWN_POSITION = Zone(sharedLobbySpawnPositionScope):getSinglePosition()
			MinigameData.ConfigureSharedLobby()
		end
		sharedLobbySpawnPositionStartup:register()

		local requiredGeneratedFields = {
			"minigameScope",
			"lobbyPlayerSpawnZone",
			"lobbyPlayerSpawnKey",
			"lobbyAreaZone",
			"gamePlayerSpawnZone",
			"gameAreaZone",
			"winsStorage",
			"matchesStorage",
			"pointsStorage",
			"shortestTimeStorage",
			"longestTimeStorage",
		}
		local requiredZones = {
			"lobbyPlayerSpawnZone",
			"lobbyAreaZone",
			"gamePlayerSpawnZone",
			"gameAreaZone",
		}
		local requiredZonesSpeedrun = {
			"finishTeleportZone",
		}
		function MinigameData:Validate()
			if not self.minigameName then
				logger.error(debug.traceback("[MinigameData:Validate] no minigameName provided."))
				return false
			end

			local missingFields = {}
			for _, value in pairs(requiredGeneratedFields) do
				if self[value] == nil then
					table.insert(missingFields, value)
				end
			end
			if #missingFields > 0 then
				logger.warn("[MinigameData:Validate] - minigame with name {} missing generated fields (zones might be missing in otbm): {}", (self.minigameName or "Unknown"), table.concat(missingFields, ", "))
				return false
			end

			local emptyZones = {}
			for _, value in pairs(requiredZones) do
				if self[value] == nil then
					table.insert(emptyZones, value)
				elseif #self[value]:getPositions() == 0 then
					table.insert(emptyZones, value)
				end
			end
			if #emptyZones > 0 then
				logger.warn("[MinigameData:Validate] - minigame with name {} zones have no positions assigned (zones might be missing in otbm): {}", (self.minigameName or "Unknown"), table.concat(emptyZones, ", "))
				return false
			end

			if self:GetCompetitionType() == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
				local emptyZonesSpeedrun = {}
				for _, value in pairs(requiredZonesSpeedrun) do
					if self[value] == nil then
						table.insert(emptyZonesSpeedrun, value)
					elseif #self[value]:getPositions() == 0 then
						table.insert(emptyZonesSpeedrun, value)
					end
				end
				if #emptyZonesSpeedrun > 0 then
					logger.warn("[MinigameData:Validate] - minigame with name {} zones have no positions assigned (zones might be missing in otbm): {}", (self.minigameName or "Unknown"), table.concat(emptyZonesSpeedrun, ", "))
					return false
				end
			end

			return true
		end

		local minigameDeath = CreatureEvent("MinigamePlayerDeath")
		function minigameDeath.onPrepareDeath(creature, killer)
			local player = Player(creature)
			if not player then
				return true
			end

			player:addHealth(player:getMaxHealth())
			player:addMana(player:getMaxMana())
			player:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return false
		end

		minigameDeath:register()
		function MinigameData.SetupExitToSharedLobby()
			local teleport = MoveEvent()
			function teleport.onStepIn(creature, item, position, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return false
				end

				player:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end
			teleport:key(Storage.Minigames.ExitToSharedLobby)
			teleport:register()
		end
		MinigameData.SetupExitToSharedLobby()
		function MinigameData:SetupEnterTeleport()
			local teleport = MoveEvent()
			function teleport.onStepIn(creature, item, position, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return false
				end

				player:teleportTo(self.lobbyPlayerSpawnZone:randomPosition())
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end
			teleport:key(self.lobbyPlayerSpawnKey)
			teleport:register()
		end

		function MinigameData.SetupSharedLobbyEnterTeleport()
			local teleport = MoveEvent()
			function teleport.onStepIn(creature, item, position, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return false
				end

				player:setStorageValueByKey(Storage.Minigames.LastSharedLobbyEnterFromPostion, fromPosition)

				player:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end
			teleport:key(Storage.Minigames.SharedLobbyEnterTeleport)
			teleport:register()
		end
		MinigameData.SetupSharedLobbyEnterTeleport()
		function MinigameData.SetupSharedLobbyExitTeleport()
			local teleport = MoveEvent()
			function teleport.onStepIn(creature, item, position, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return false
				end

				player:teleportToStoredOrTemple(Storage.Minigames.LastSharedLobbyEnterFromPostion)
				return true
			end
			teleport:key(Storage.Minigames.SharedLobbyExitTeleport)
			teleport:register()
		end
		MinigameData.SetupSharedLobbyExitTeleport()

		--[[
function MinigameData:SetupEntranceLeverUse()
	local leverUse = Action()
	function leverUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if not player:isPlayer() then
			return false
		end

		self:tryEnter(player)
		return true
	end
	leverUse:key(self.entranceLeverKey)
	leverUse:register()

	local leverLook = Look()
	function leverLook.onLook(player, item, fromPosition, target, toPosition, isHotkey)
		if not player:isPlayer() then
			return false
		end

		return true
	end
	leverLook:key(self.entranceLeverKey)
	leverLook:register()
end
]]

		function MinigameData:GetScope()
			return self.minigameScope
		end

		function MinigameData:GetEventScope()
			return self.eventScope
		end

		local minigameScopes = {
			-- Zones
			LobbyArea = "LobbyArea",
			LobbyPlayerSpawn = "LobbyPlayerSpawn",
			GameArea = "GameArea",
			GamePlayerSpawn = "GamePlayerSpawn",
			FinishTeleport = "FinishTeleport",
			LobbyEntrancePosition = "LobbyEntrancePosition",

			Wins = "Wins",
			Matches = "Matches",
			Points = "Points",
			ShortestTime = "ShortestTime",
			LongestTime = "LongestTime",
		}
		function MinigameData:SetupScopes()
			local selfScope = Scope("Minigames", self.minigameName)
			self.minigameScope = selfScope
			self.scope = selfScope
			self.eventScope = Scope("Minigames", self.minigameName, "GlobalEvent")

			--Position (or random positions) at which player will appear in lobby
			--Usually one position
			local lobbyPlayerSpawnScore = selfScope:Get(minigameScopes.LobbyPlayerSpawn)
			self.lobbyPlayerSpawnZone = Zone(lobbyPlayerSpawnScore)
			self.lobbyPlayerSpawnKey = lobbyPlayerSpawnScore

			--Area of positions from which players will be teleported to when entering minigame lobby
			local lobbyAreaScope = selfScope:Get(minigameScopes.LobbyArea)
			self.lobbyAreaZone = Zone(lobbyAreaScope)

			--Position (or random positions) where players will apear in playing field.
			--Usually one position for speedruns - for even playing field.
			--Usually same as "gameAreaZone" for last man standing.
			--Can be empty if minigame uses custom teleport method (eg. in self.beforeStart).
			local gamePlayerSpawnScope = selfScope:Get(minigameScopes.GamePlayerSpawn)
			self.gamePlayerSpawnZone = Zone(gamePlayerSpawnScope)

			local finishTeleportsZoneScope = selfScope:Get(minigameScopes.FinishTeleport)
			self.finishTeleportZone = Zone(finishTeleportsZoneScope)

			--Minigame whole playing field
			local gameAreaScope = selfScope:Get(minigameScopes.GameArea)
			self.gameAreaZone = Zone(gameAreaScope)

			local winsScope = selfScope:Get(minigameScopes.Wins)
			self.winsStorage = winsScope

			local matchesScope = selfScope:Get(minigameScopes.Matches)
			self.matchesStorage = matchesScope

			local pointsScope = selfScope:Get(minigameScopes.Points)
			self.pointsStorage = pointsScope

			local shortestTimeScope = selfScope:Get(minigameScopes.ShortestTime)
			self.shortestTimeStorage = shortestTimeScope

			local longestTimeScope = selfScope:Get(minigameScopes.LongestTime)
			self.longestTimeStorage = longestTimeScope

			--[[
			local exitTeleportDestinationScope = Storage.Minigames.ExitToSharedLobby
			self.exitTeleportDestinationKey = exitTeleportDestinationScope
			]]
		end

		function MinigameData:TryStartLobby()
			if self:IsActive() then
				logger.error("[ MinigameData:TryStartLobby] minigame is already active.")
				return
			end

			self:enterStage(MINIGAME_STAGE.LOBBY_10MIN_BEFORE)
		end

		MINIGAME_STARTING_STATUS = {
			MINIGAME_WAS_STARTED = "MINIGAME_WAS_STARTED",
			CANNOT_CREATE_LOBBY_ENTRANCE_TELEPORT = "CANNOT_CREATE_LOBBY_ENTRANCE_TELEPORT",
			MINIGAME_IS_ALREADY_ACTIVE = "MINIGAME_IS_ALREADY_ACTIVE",
		}
		function MinigameData:TryStartLobbyFast()
			if self:IsActive() then
				logger.error("[ MinigameData:TryStartLobbyFast] minigame is already active.")
				return MINIGAME_STARTING_STATUS.MINIGAME_IS_ALREADY_ACTIVE
			end
			self.entranceTeleport = self.entranceTeleport or Game.createItem(self.lobbyTeleportId, 1, self.lobbyEntrancePosition)
			if not self.entranceTeleport then
				return MINIGAME_STARTING_STATUS.CANNOT_CREATE_LOBBY_ENTRANCE_TELEPORT
			end
			self.entranceTeleport:setKey(self.lobbyPlayerSpawnKey)

			self:enterStage(MINIGAME_STAGE.LOBBY_10SECONDS_BEFORE)

			return MINIGAME_STARTING_STATUS.MINIGAME_WAS_STARTED
		end

		local nameToMinigameData = {}
		function MinigameData.GetByName(name)
			return nameToMinigameData[name]
		end

		local defaultFixedSpeed = 100
		local defaultMaxParticipants = 30
		local defaultTeleportId = 0
		local minigameScope = Scope("Minigame")
		function MinigameData:GenerateOnStartup(context)
			self.validationStatus = MINIGAME_VALIDATION_STATUS.UNVALIDATED
			self.minigameName = context.minigameName or context.encounterName

			local serverstartup = GlobalEvent(minigameScope:Get(self:GetDisplayName(), "GenerateOnStartup"))
			function serverstartup.onStartup()
				--Position where teleport to this minigame lobby will appear
				local lobbyEntrancePositionScope = self:GetScope():Get(minigameScopes.LobbyEntrancePosition)
				self.lobbyEntrancePosition = Zone(lobbyEntrancePositionScope):randomPosition()
				
				self.competitionType = context.competitionType
				if not self.competitionType then
					logger.error(T("[MinigameData:Data] Minigame :name: no competitionType declared. Not registering.", { name = self.minigameName }))
					return
				end
				if self.competitionType == MINIGAME_COMPETITION_TYPE.OTHER then
					self.GetGrandPlace = context.GetGrandPlace
					self.IsSuccesfulFinish = context.IsSuccesfulFinish
					if not self.GetGrandPlace then
						logger.error(T("[MinigameData:Data] Minigame :name: has competitionType of 'OTHER' but no GetGrandPlace function defined. Not registering.", { name = self.minigameName }))
						return
					end
					if not self.IsSuccesfulFinish then
						logger.error(T("[MinigameData:Data] Minigame :name: has competitionType of 'OTHER' but no IsSuccesfulFinish function defined. Not registering.", { name = self.minigameName }))
						return
					end
				end
				--self:SetupEntranceLeverUse()

				self.requiredPlayers = context.requiredPlayers or 3

				self.allowPlayersWalkthrough = false
				if context.allowPlayersWalkthrough ~= nil then
					self.allowPlayersWalkthrough = context.allowPlayersWalkthrough
				end

				--Fight
				self.stages = {}
				self.currentStage = MINIGAME_STAGE.UNSTARTED

				self.global = context.global or false
				self.timeToSpawnMonsters = ParseDuration(context.timeToSpawnMonsters or "3s")
				self.events = context.events or Set()

				self.timeToDefeatSeconds = context.timeToDefeat or context.timeToDefeatSeconds or (10 * 60)

				self.fixedSpeed = context.fixedSpeed or defaultFixedSpeed
				self.maxPartitipantsCount = context.maxPartitipantsCount or defaultMaxParticipants

				self.lobbyTeleportId = context.lobbyTeleportId or 22761

				self.beforeStart = self.beforeStart or context.beforeStart

				self.enableDebug = context.enableDebug

				self:AppendCustomFields(context)
				self:ConfigureOnEnterLeave()
				self:SetupEnterTeleport()

				self:addStage({
					start = function()
						self:teleportParticipantsToSharedLobby()
					end,
					stageNumber = MINIGAME_STAGE.UNSTARTED,
				})
				self:addStage({
					start = function()
						self.entranceTeleport = self.entranceTeleport or Game.createItem(self.lobbyTeleportId, 1, self.lobbyEntrancePosition)
						self.entranceTeleport:setKey(self.lobbyPlayerSpawnKey)

						Game.broadcastMessage(T("Minigame :name: starts in 10 minutes!", { name = self.minigameName }))
						addEvent(function()
							self:enterStage(MINIGAME_STAGE.LOBBY_5MIN_BEFORE)
						end, 5 * 60 * 1000)
					end,
					stageNumber = MINIGAME_STAGE.LOBBY_10MIN_BEFORE,
				})
				self:addStage({
					start = function()
						Game.broadcastMessage(T("Minigame :name: starts in 5 minutes!", { name = self.minigameName }))
						addEvent(function()
							self:enterStage(MINIGAME_STAGE.LOBBY_1MIN_BEFORE)
						end, 4 * 60 * 1000)
					end,
					stageNumber = MINIGAME_STAGE.LOBBY_5MIN_BEFORE,
				})
				self:addStage({
					start = function()
						Game.broadcastMessage(T("Minigame :name: starts in 1 minute!", { name = self.minigameName }))
						addEvent(function()
							self:enterStage(MINIGAME_STAGE.LOBBY_10SECONDS_BEFORE)
						end, 50 * 1000)
					end,
					stageNumber = MINIGAME_STAGE.LOBBY_1MIN_BEFORE,
				})
				self:addStage({
					start = function()
						Game.broadcastMessage(T("Minigame :name: starts in 10 seconds!", { name = self.minigameName }))
						addEvent(function()
							self:enterStage(MINIGAME_STAGE.RUNNING)
						end, 10 * 1000)
					end,
					stageNumber = MINIGAME_STAGE.LOBBY_10SECONDS_BEFORE,
				})
				self:addStage({
					start = function()
						if self.entranceTeleport then
							self.entranceTeleport:remove()
							self.entranceTeleport = nil
						end

						local participantCount = self:countPlayersLobby()
						if participantCount < self.requiredPlayers then
							Game.broadcastMessage(T("Minigame :name: was not started - not enough players (:requiredPlayers:).", { name = self.minigameName, requiredPlayers = self.requiredPlayers }))
							self:reset()
							return
						else
							self.active = true
							Game.broadcastMessage(T("Minigame :name: has started with :participantCount: players. Good luck!", { name = self.minigameName, participantCount = participantCount }))
						end
						self:TryStartMinigame()
					end,
					stageNumber = MINIGAME_STAGE.RUNNING,
				})

				if self:Validate() then
					nameToMinigameData[self:GetDisplayName()] = self
				end
			end
			serverstartup:register()
		end

		function MinigameData:AppendCustomFields(context)
			for key, value in pairs(context) do
				self[key] = self[key] or value
			end
		end

		--[[
function MinigameData:checkZoneOccupied(players, leverUser)
	local zone = self:GetGameAreaZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end
function MinigameData:checkEncounterActive(players, leverUser)
	if not self:IsActive() then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end
	return ENCOUNTER_ERROR_CODES.ENCOUNTER_ACTIVE
end
]]

		function MinigameData:handleTimeEvent(zone)
			if self.timeoutEvent then
				stopEvent(self.timeoutEvent)
				self.timeoutEvent = nil
			end
			self.timeoutEvent = addEvent(function(zn)
				zn:refresh()
				for _, player in pairs(zone:getPlayers()) do
					player:teleportTo(self.exitTeleportDestination)
				end
				ActiveEncounterRegistry:Unregister(self)
			end, self.timeToDefeatSeconds * 1000, zone)
		end

		local function formatMinigameName(name)
			local cleaned = name:gsub("[^%w]", " ")

			local formatted = cleaned:gsub("(%S+)", function(word)
				if word:match("^%a") then
					return word:sub(1, 1):upper() .. word:sub(2):lower()
				else
					return word
				end
			end)

			return formatted
		end

		function MinigameData:OnSuccessfulCompletion(participants)
			local zone = self:GetGameAreaZone()
			if not zone then
				return true
			end

			if self.timeoutEvent then
				stopEvent(self.timeoutEvent)
				self.timeoutEvent = nil
			end

			for _, player in pairs(participants) do
				ResolutionContext.FromActiveEncounter(self, player):Resolve()
				player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)
			end

			if self.lockoutTriggerCriterion == LOCKOUT_TRIGGER_CRITERION.ON_KILL then
				self:SetLockouts(participants)
			end

			if self.ejectAfterCompletionSeconds > 0 then
				zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":formattedName: is finished. You have :time: seconds to leave the room.", { formattedName = formatMinigameName(self.minigameName), time = self.ejectAfterCompletionSeconds }))

				self.timeoutEvent = addEvent(function(zn)
					zn:refresh()
					for _, player in pairs(zone:getPlayers()) do
						player:teleportTo(self.exitTeleportDestination)
					end
					ActiveEncounterRegistry:Unregister(self)
				end, self.ejectAfterCompletionSeconds * 1000, zone)
			end
		end

		function MinigameData:teleportParticipantsToSharedLobby()
			for key, value in pairs(self.gameAreaZone:getPlayers()) do
				value:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
			end
			for key, value in pairs(self.lobbyAreaZone:getPlayers()) do
				value:teleportTo(SHARED_LOBBY_SPAWN_POSITION)
			end
		end

		--TODO teleport to not-so-random positions, eg.: always teleport fixed amount of tiles north
		function MinigameData:teleportParticipantToSpawnPosition(players)
			for _, player in ipairs(players) do
				local destination = self.gamePlayerSpawnZone:randomPosition()
				player:teleportTo(destination)
			end
		end

		function MinigameData:GetStartParticipantsCount()
			return self.startParticipantsCount
		end
		---@return boolean
		function MinigameData:TryStartMinigame()
			if self.beforeStart then
				self:beforeStart()
			end

			self:SetStartTimestamp(os.time())
			local zone = self:GetGameAreaZone()
			zone:removeMonsters()
			zone:removePlayers()

			local participants = self:GetLobbyZone():getPlayers()
			self.startParticipantsCount = #participants
			self.startPosition = self.gamePlayerSpawnZone:randomPosition()
			self:teleportParticipantToSpawnPosition(participants)

			self:ResetOrchestrator()
			self:ResetFinishPosition()
			self:debug("MinigameData[{}]:start", self:GetDisplayName())
			self:handleTimeEvent(zone)
			return true
		end

		---@param callable function The callable function for the event
		---@param delay number The delay time for the event
		function MinigameData:addEvent(callable, delay, ...)
			local event = addEvent(function(callable, ...)
				pcall(callable, ...)
				self.events:remove(event)
			end, ParseDuration(delay), callable, ...)
			self.events:insert(event)
		end

		function MinigameData:IsActive()
			return self.active
		end

		---Cancels all the events associated with the encounter
		function MinigameData:cancelEvents()
			for event in self.events:iter() do
				stopEvent(event)
			end
			self.events = Set()
		end

		---Returns the stage of the encounter by the given stage number
		---@param stageNumber number? The number of the stage. Optional.
		---@return EncounterStage The stage of the encounter
		function MinigameData:getStage(stageNumber)
			return self.stages[stageNumber or self.currentStage]
		end

		---Enters a new stage in the encounter
		---@param stageNumber number The number of the stage to enter
		---@param abort boolean? A flag to determine whether to abort the current stage without calling the finish function. Optional.
		---@return boolean True if the stage is entered successfully, false otherwise
		function MinigameData:enterStage(stageNumber, abort)
			self:debug("MinigameData[{}]:enterStage | stageNumber: {} | abort: {}", self.minigameName, stageNumber, abort)
			if not abort then
				local currentStage = self:getStage(self.currentStage)
				if currentStage and currentStage.finish then
					currentStage:finish()
				end
			end

			self:cancelEvents()

			if stageNumber == MINIGAME_STAGE.UNSTARTED then
				self.currentStage = MINIGAME_STAGE.UNSTARTED
			end

			local stage = self:getStage(stageNumber)
			if not stage then
				logger.error("MinigameData:enterStage - stage {} not found", stageNumber)
				return false
			end

			self.currentStage = stageNumber
			if stage.start then
				stage:start()
			end

			return true
		end

		---@alias SpawnMonsterConfig { name: string|string[], amount: number, event: string?, timeLimit: number?, position: Position|table?, positions: Position|table[]?, spawn: function? }

		---Spawns monsters based on the given configuration
		---@param config SpawnMonsterConfig The configuration for spawning monsters
		function MinigameData:spawnMonsters(config)
			local positions = config.positions
			local amount = config.amount
			if positions and config.position then
				error("You can't use both 'position' and 'positions' in the same config.")
			end
			if positions and amount then
				error("You can't use both 'amount' and 'positions' in the same config.")
			end
			if amount and amount > 0 then
				positions = {}
				for _ = 1, amount do
					if config.position then
						table.insert(positions, config.position)
					else
						table.insert(positions, self:GetMonsterSpawnZone():randomPosition())
					end
				end
			end
			for _, position in ipairs(positions) do
				if self.timeToSpawnMonsters >= 1000 then
					for i = 1, self.timeToSpawnMonsters / 1000 do
						self:addEvent(function(position)
							position:sendMagicEffect(CONST_ME_TELEPORT)
						end, i * 1000, position)
					end
				end
				local name = config.name
				if type(name) == "table" then
					name = name[math.random(#name)]
				end
				self:addEvent(function(name, position, event, spawn, timeLimit)
					local monster = Game.createMonster(name, position)
					if not monster then
						return false
					end
					if spawn then
						spawn(monster)
					end
					if event then
						if type(event) == "string" then
							event = { event }
						end
						for _, event in ipairs(event) do
							monster:registerEvent(event)
						end
					end
					if timeLimit then
						self:addEvent(function(monsterId)
							local monster = Monster(monsterId)
							if not monster then
								return
							end
							monster:remove()
						end, config.timeLimit, monster:getID())
					end
				end, self.timeToSpawnMonsters, name, position, config.event, config.spawn, config.timeLimit)
			end
		end

		function MinigameData:GetLobbyZone()
			return self.lobbyAreaZone
		end

		function MinigameData:GetGameAreaZone()
			return self.gameAreaZone
		end

		function MinigameData:GetMonsterSpawnZone()
			return self.monsterSpawnZone
		end

		function MinigameData:GetFixedSpeed()
			return self.fixedSpeed
		end

		---Broadcasts a message to all players
		function MinigameData:broadcast(...)
			if self.global then
				for _, player in ipairs(Game.getPlayers()) do
					player:sendTextMessage(...)
				end
				return
			else
				self:GetGameAreaZone():sendTextMessage(...)
			end
		end

		---Counts the number of monsters with the given name in the encounter zone
		---@param name string? The name of the monster to count
		---@return number The number of monsters with the given name
		function MinigameData:countMonsters(name)
			return self:GetGameAreaZone():countMonsters(name)
		end

		---@return number --The number of players in the encounter zone
		function MinigameData:countPlayersGameArea()
			return self:GetGameAreaZone():countPlayers(IgnoredByMonsters)
		end

		---@return number --The number of players in the encounter zone
		function MinigameData:countPlayersLobby()
			return self:GetLobbyZone():countPlayers(IgnoredByMonsters)
		end

		---Removes all monsters from the encounter zone
		function MinigameData:removeMonsters()
			self:GetGameAreaZone():removeMonsters()
		end

		---Removes all players from the encounter zone
		function MinigameData:removePlayers()
			self:GetGameAreaZone():removePlayers()
		end

		---Resets the encounter to its initial state
		---@return boolean True if the encounter is reset successfully, false otherwise
		function MinigameData:reset()
			self:debug("MinigameData[{}]:reset", self.minigameName)
			if self.onReset then
				self:onReset()
			end

			-- Event has to be scheduled to avoid nesting
			-- return addEvent(function()
			self.active = false
			self:enterStage(MINIGAME_STAGE.UNSTARTED)
			-- end, 100)
		end

		---Checks if a position is inside the encounter zone
		---@param position Position The position to check
		---@return boolean True if the position is inside the encounter zone, false otherwise
		function MinigameData:isInZone(position)
			return self:GetGameAreaZone():isInZone(position)
		end

		---Enters the previous stage in the encounter
		---@return boolean True if the previous stage is entered successfully, false otherwise
		function MinigameData:previousStage()
			return self:enterStage(self.currentStage - 1, true)
		end

		---Enters the next stage in the encounter
		---@return boolean True if the next stage is entered successfully, false otherwise
		function MinigameData:nextStage()
			if self.currentStage == #self.stages then
				return self:reset()
			end
			return self:enterStage(self.currentStage + 1)
		end

		---@return boolean
		function MinigameData:canStart()
			return self.currentStage == MINIGAME_STAGE.UNSTARTED
		end

		function MinigameData:GetFinishPosition()
			return self.finishTeleportPosition
		end
		function MinigameData:GetStartPosition()
			return self.startPosition
		end

		function MinigameData:ResetOrchestrator()
			self.orchestrator = MinigameOrchestrator.FromMinigameData(self)
			return self
		end
		function MinigameData:ResetFinishPosition()
			if self.competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
				self.finishTeleportPosition = self.finishTeleportZone:randomPosition()
			end
			return self
		end

		---Adds a new stage to the encounter
		---@param context table The stage to add
		---@return boolean True if the stage is added successfully, false otherwise
		function MinigameData:addStage(context)
			local stage = EncounterStage(context)
			stage.encounter = self
			if context.stageNumber then
				self.stages[context.stageNumber] = stage
			else
				table.insert(self.stages, stage)
			end
			return stage
		end

		---Adds an intermission stage to the encounter
		---@param interval number|string The duration of the intermission
		---@return boolean True if the intermission stage is added successfully, false otherwise
		function MinigameData:addIntermission(interval)
			return self:addStage({
				start = function()
					self:addEvent(function()
						self:nextStage()
					end, interval)
				end,
			})
		end

		---Adds a stage that just sends a message to all players
		---@param message string The message to send
		---@return boolean True if the message stage is added successfully, false otherwise
		function MinigameData:addBroadcast(message, type)
			type = type or MESSAGE_EVENT_ADVANCE
			return self:addStage({
				start = function()
					self:broadcast(type, message)
				end,
			})
		end

		---Adds a stage that spawns monsters
		---@param configs SpawnMonsterConfig[] The configurations for spawning monsters
		---@return boolean True if the spawn monsters stage is added successfully, false otherwise
		function MinigameData:addSpawnMonsters(configs)
			if not configs then
				return false
			end
			if not configs[1] then
				configs = { configs }
			end -- convert single config to array
			return self:addStage({
				start = function()
					for _, config in ipairs(configs) do
						self:spawnMonsters(config)
					end
				end,
			})
		end

		---Adds a stage that removes all monsters from the encounter zone
		---@return boolean True if the remove monsters stage is added successfully, false otherwise
		function MinigameData:addRemoveMonsters()
			return self:addStage({
				start = function()
					self:removeMonsters()
				end,
			})
		end

		---Adds a stage that removes all players from the encounter zone
		---@return boolean True if the remove monsters stage is added successfully, false otherwise
		function MinigameData:addRemovePlayers()
			return self:addStage({
				start = function()
					self:removePlayers()
				end,
			})
		end

		function MinigameData:IsAllowingPlayersWalkthrough()
			return self.allowPlayersWalkthrough
		end

		function MinigameData:SetMinigameLock(player)
			player:isOnMinigame(true)
			if self:IsAllowingPlayersWalkthrough() then
				player:setStorageValueByKey(Storage.Minigames.AllowPlayersWalkthrough, ACCESS_GRANTED)
			else
				player:setStorageValueByKey(Storage.Minigames.AllowPlayersWalkthrough, ACCESS_NOT_GRANTED)
			end
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, self.fixedSpeed)
			player:setStorageValueByKey(Storage.Minigames.CurrentMinigame, self.minigameName)
			player:changeSpeed()
		end
		function ResetMinigameLock(player)
			player:isOnMinigame(false)
			SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, 0)
			player:unregisterEvent("MinigamePlayerDeath")
			player:changeSpeed()
		end
		function MinigameData:AfterEnterAnyMinigameState(player)
			player:registerEvent("MinigamePlayerDeath")

			SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })

			self:SetMinigameLock(player)
			player:changeSpeed()
		end

		function MinigameData:GetCurrentPlayersCount()
			return #self.gameAreaZone:getPlayers()
		end

		function MinigameData:GetCompetitionType()
			return self.competitionType
		end
		function MinigameData:SetStartTimestamp(startTimestamp)
			self.startTimestamp = startTimestamp
		end
		function MinigameData:GetStartTimestamp()
			return self.startTimestamp
		end
		function MinigameData:GetLifetime()
			return os.time() - self:GetStartTimestamp()
		end

		--TODO implementation
		function MinigameData:AfterSuccesfulMinigameFinishOther(player)
			logger.warn("[MinigameData::AfterSuccesfulMinigameFinishLastManOther] Not implemented.")
		end

		--TODO Localization
		function MinigameData:BroadCastPlayerJoinedLobby(player)
			local participantsCount = #self.lobbyAreaZone:getPlayers()
			Game.broadcastMessage(T("Player :playerName: joined :name:. :participantsCount:/:maxPartitipantsCount:", { playerName = player:getName(), name = self:GetDisplayName(), participantsCount = participantsCount, maxPartitipantsCount = self.maxPartitipantsCount }))
		end
		--TODO Localization
		function MinigameData:BroadcastPlayerLeftLobby(player)
			local participantsCount = #self.lobbyAreaZone:getPlayers()
			Game.broadcastMessage(T("Player :playerName: left :name:. :participantsCount:/:maxPartitipantsCount:", { playerName = player:getName(), name = self:GetDisplayName(), participantsCount = participantsCount, maxPartitipantsCount = self.maxPartitipantsCount }))
		end

		---@return MinigameOrchestrator
		function MinigameData:GetOrchestrator()
			return self.orchestrator
		end

		function MinigameData:ConfigureOnEnterLeave()
			local zoneEventsGameArea = ZoneEvent(self:GetGameAreaZone())
			function zoneEventsGameArea.afterEnter(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:hasGroupFlag(IgnoredByMonsters) then
					return true
				end

				self:AfterEnterAnyMinigameState(player)
				player:addHealth(player:getMaxHealth())
				player:addMana(-player:getMaxMana())
				return true
			end
			function zoneEventsGameArea.beforeLeave(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end
				if player:hasGroupFlag(IgnoredByMonsters) then
					return true
				end

				if self:IsActive() then
					self:GetOrchestrator():AfterSuccesfulPlayerFinish(player)
				end
				ResetMinigameLock(player)

				return true
			end
			function zoneEventsGameArea.afterLeave(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end
				if player:hasGroupFlag(IgnoredByMonsters) then
					return true
				end

				if self:countPlayersGameArea() == 0 then
					self:reset()
				end
				return true
			end
			zoneEventsGameArea:register()

			local zoneEventsLobby = ZoneEvent(self:GetLobbyZone())
			function zoneEventsLobby.afterEnter(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:hasGroupFlag(IgnoredByMonsters) then
					return true
				end

				self:BroadCastPlayerJoinedLobby(player)
				self:AfterEnterAnyMinigameState(player)
				return true
			end
			function zoneEventsLobby.afterLeave(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:hasGroupFlag(IgnoredByMonsters) then
					return true
				end

				if not self:IsActive() then
					self:BroadcastPlayerLeftLobby(player)
				end

				ResetMinigameLock(player)
				return true
			end
			zoneEventsLobby:register()
		end

		function MinigameData:debug(...)
			if not self.enableDebug then
				return
			end
			logger.debug(...)
		end

		--[[
		local encounterTick = GlobalEvent("Minigame/UpdateSpeed")
		function encounterTick.onThink(interval)
			for _, minigame in pairs(Minigames) do
				local players = minigame:GetGameAreaZone():getPlayers() or  {}
				for _, player in pairs(players) do 
					player:updateSpeed()
				end
			end
			return true
		end
		encounterTick:interval(1000)
		encounterTick:register()
		]]
	end)
	:NoQuestlog()

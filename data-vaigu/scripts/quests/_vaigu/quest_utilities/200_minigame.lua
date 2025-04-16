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
			LastLobbyEnterFromPostion = {},
		}
	end)
	:Constant(function()
		---@class MinigameDataContext:DataClass
		---@field private disabled boolean?
		---@field public disableLockout boolean does not apply cooldown on kill/entry
		---@field private requiredState table?
		---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
		---@field private lockoutType LOCKOUT_TYPE?
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

		---@class MinigameData
		---@field private disabled boolean?
		---@field public disableLockout boolean does not apply cooldown on kill/entry
		---@field private requiredState table?
		---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
		---@field private lockoutType LOCKOUT_TYPE?
		---@field private timeToComplete number?
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
		---generated:
		---@field private registered boolean
		---@field private bossSpawnPosition Position
		---@field private entranceLeverZone Zone
		---@field private bossRoomEntranceZone Zone
		---@field private encounterAreaPositionsZone Zone
		---@field private monsterSpawnZone Zone
		MinigameData = {}
		MinigameData.__index = MinigameData
		---@param context MinigameDataContext
		function MinigameData.New(context)
			local newObj = {}
			setmetatable(newObj, MinigameData)
			newObj:GenerateOnStartup(context)
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

			function zoneEvents.afterEnter(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				player:sendTextMessage(MESSAGE_FAILURE, "During minigames, you cannot use potions, runes or spells and your movement speed will be fixed to a certain value.")
				player:isOnMinigame(true)
				player:setStorageValueByKey(Storage.Minigames.FixedSpeed, 100)
				player:changeSpeed()
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
		local sharedLobbySpawnPosition = nil
		local sharedLobbySpawnPositionScope = Storage.Minigames.SharedLobbyPlayerSpawn

		local sharedLobbySpawnPositionStartup = GlobalEvent(sharedLobbySpawnPositionScope)
		function sharedLobbySpawnPositionStartup.onStartup()
			sharedLobbySpawnPosition = Zone(sharedLobbySpawnPositionScope):randomPosition()
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
				logger.warn("[MinigameData:Validate] - minigame with name {} missing generated fields (zones might be missing in otbm): {}", (self.encounterName or "Unknown"), table.concat(missingFields, ", "))
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
				logger.warn("[MinigameData:Validate] - minigame with name {} zones have no positions assigned (zones might be missing in otbm): {}", (self.encounterName or "Unknown"), table.concat(emptyZones, ", "))
				return false
			end
			return true
		end

		function MinigameData.SetupExitToSharedLobby()
			local teleport = MoveEvent()
			function teleport.onStepIn(creature, item, position, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return false
				end

				player:teleportTo(sharedLobbySpawnPosition)
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

				player:setStorageValueByKey(Storage.Minigames.LastLobbyEnterFromPostion, fromPosition)

				player:teleportTo(sharedLobbySpawnPosition)
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

				local lastEnterPos = player:getStorageValueByKey(Storage.Minigames.LastLobbyEnterFromPostion)

				player:teleportTo(lastEnterPos)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
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
			LobbyArea = "LobbyArea",
			LobbyPlayerSpawn = "LobbyPlayerSpawn",
			GameArea = "GameArea",
			GamePlayerSpawn = "GamePlayerSpawn",
			LobbyEntrancePosition = "LobbyEntrancePosition",

			Wins = "Wins",
			Matches = "Matches",
			Points = "Points",
			ShortestTime = "ShortestTime",
			LongestTime = "LongestTime",
		}
		function MinigameData:SetupScopes()
			local minigameScope = Scope("Minigames", self.minigameName)
			self.minigameScope = minigameScope

			--Position (or random positions) at which player will appear in lobby
			--Usually one position
			local lobbyPlayerSpawnScore = minigameScope:Get(minigameScopes.LobbyPlayerSpawn)
			self.lobbyPlayerSpawnZone = Zone(lobbyPlayerSpawnScore)
			self.lobbyPlayerSpawnKey = lobbyPlayerSpawnScore

			--Area of positions from which players will be teleported to "gameAreaPlayerSpawnZone"
			local lobbyAreaScope = minigameScope:Get(minigameScopes.LobbyArea)
			self.lobbyAreaZone = Zone(lobbyAreaScope)

			--Position (or random positions) where players will apear in playing field.
			--Usually one position for speedruns - for even playing field.
			--Usually same as "gameAreaZone" for last man standing.
			--Can be empty if minigame uses custom teleport method (custom self.beforeStart).
			local gamePlayerSpawnScope = minigameScope:Get(minigameScopes.GamePlayerSpawn)
			self.gamePlayerSpawnZone = Zone(gamePlayerSpawnScope)

			--Minigame whole playing field
			local gameAreaScope = minigameScope:Get(minigameScopes.GameArea)
			self.gameAreaZone = Zone(gameAreaScope)

			--Position where teleport to this minigame lobby will appear
			local lobbyEntrancePositionScope = minigameScope:Get(minigameScopes.LobbyEntrancePosition)
			self.lobbyEntrancePosition = Zone(lobbyEntrancePositionScope):randomPosition()

			local winsScope = minigameScope:Get(minigameScopes.Wins)
			self.winsStorage = winsScope

			local matchesScope = minigameScope:Get(minigameScopes.Matches)
			self.matchesStorage = matchesScope

			local pointsScope = minigameScope:Get(minigameScopes.Points)
			self.pointsStorage = pointsScope

			local shortestTimeScope = minigameScope:Get(minigameScopes.ShortestTime)
			self.shortestTimeStorage = shortestTimeScope

			local longestTimeScope = minigameScope:Get(minigameScopes.LongestTime)
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
		function MinigameData:TryStartLobbyFast()
			if self:IsActive() then
				logger.error("[ MinigameData:TryStartLobbyFast] minigame is already active.")
				return
			end
			self.entranceTeleport = self.entranceTeleport or Game.createItem(1949, 1, self.lobbyPlayerSpawnZone:randomPosition())
			self.entranceTeleport:setKey(self.lobbyPlayerSpawnKey)

			self:enterStage(MINIGAME_STAGE.LOBBY_10SECONDS_BEFORE)
		end

		local nameToMinigameData = {}
		function MinigameData.GetByName(name)
			return nameToMinigameData[name]
		end

		local minigameScope = Scope("Minigame")
		function MinigameData:GenerateOnStartup(context)
			self.validationStatus = MINIGAME_VALIDATION_STATUS.UNVALIDATED
			self.encounterName = context.encounterName or context.minigameName
			self.minigameName = context.encounterName or context.minigameName

			local serverstartup = GlobalEvent(minigameScope:Get(self:GetDisplayName(), "GenerateOnStartup"))
			function serverstartup.onStartup()
				self:SetupScopes()
				self.competitionType = context.competitionType
				if not self.competitionType then
					logger.error(T("[MinigameData:Data] Minigame :name: no competitionType declared. Not registering.", { name = self.minigameName }))
					return
				end
				--self:SetupEntranceLeverUse()

				self.requiredPlayers = context.requiredPlayers or 3
				--Fight
				self.stages = {}
				self.currentStage = MINIGAME_STAGE.UNSTARTED

				self.global = context.global or false
				self.timeToSpawnMonsters = ParseDuration(context.timeToSpawnMonsters or "3s")
				self.events = context.events or Set()

				self.timeToComplete = context.timeToDefeat or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_DEFEAT)

				self.fixedSpeed = context.fixedSpeed or 200
				self.maxPartitipantsCount = context.maxPartitipantsCount or 30

				self.lobbyTeleportId = context.lobbyTeleportId or 22761

				self.beforeStart = self.beforeStart or context.beforeStart

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
						self.entranceTeleport:remove()
						self.entranceTeleport = nil
						local participants = self.lobbyAreaZone:getPlayers()
						if #participants < self.requiredPlayers then
							Game.broadcastMessage(T("Minigame :name: was not started - not enough players.", { name = self.minigameName }))
							self:reset()
							return
						else
							Game.broadcastMessage(T("Minigame :name: has started. Good luck!", { name = self.minigameName }))
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
	local zone = self:GetMinigameZone()
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
			end, self.timeToComplete * 1000, zone)
		end

		local function formatEncounterName(name)
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
			local zone = self:GetMinigameZone()
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

			if self.lockoutType == LOCKOUT_TYPE.ON_KILL then
				self:SetLockouts(participants)
			end

			if self.ejectAfterCompletionSeconds > 0 then
				zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":formattedName: is finished. You have :time: seconds to leave the room.", { formattedName = formatEncounterName(self.encounterName), time = self.ejectAfterCompletionSeconds }))

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
				value:teleportTo(sharedLobbySpawnPosition)
			end
			for key, value in pairs(self.lobbyAreaZone:getPlayers()) do
				value:teleportTo(sharedLobbySpawnPosition)
			end
		end

		function MinigameData:teleportPlayersToMinigameSpawnPositions(players)
			for _, player in ipairs(players) do
				local destination = self.gamePlayerSpawnZone:randomPosition()
				player:teleportTo(destination)
			end
		end

		---@param leverUser Player
		---@return boolean
		function MinigameData:TryStartMinigame()
			local zone = self:GetMinigameZone()
			zone:removeMonsters()

			local participants = self.lobbyAreaZone:getPlayers()
			self.participantsStartingCount = #participants
			self:teleportPlayersToMinigameSpawnPositions(participants)

			self:start()
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
			self:debug("MinigameData[{}]:enterStage | stageNumber: {} | abort: {}", self.encounterName, stageNumber, abort)
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

		function MinigameData:GetMinigameZone()
			return self.encounterAreaPositionsZone
		end

		function MinigameData:GetMonsterSpawnZone()
			return self.monsterSpawnZone
		end

		---Broadcasts a message to all players
		function MinigameData:broadcast(...)
			if self.global then
				for _, player in ipairs(Game.getPlayers()) do
					player:sendTextMessage(...)
				end
				return
			else
				self:GetMinigameZone():sendTextMessage(...)
			end
		end

		---Counts the number of monsters with the given name in the encounter zone
		---@param name string? The name of the monster to count
		---@return number The number of monsters with the given name
		function MinigameData:countMonsters(name)
			return self:GetMinigameZone():countMonsters(name)
		end

		---Counts the number of players in the encounter zone
		---@return number The number of players in the encounter zone
		function MinigameData:countPlayers()
			return self:GetMinigameZone():countPlayers(IgnoredByMonsters)
		end

		---Removes all monsters from the encounter zone
		function MinigameData:removeMonsters()
			self:GetMinigameZone():removeMonsters()
		end

		---Removes all players from the encounter zone
		function MinigameData:removePlayers()
			self:GetMinigameZone():removePlayers()
		end

		---Resets the encounter to its initial state
		---@return boolean True if the encounter is reset successfully, false otherwise
		function MinigameData:reset()
			self:debug("MinigameData[{}]:reset", self.encounterName)
			if self.onReset then
				self:onReset()
			end
			self.active = false
			return self:enterStage(MINIGAME_STAGE.UNSTARTED)
		end

		---Checks if a position is inside the encounter zone
		---@param position Position The position to check
		---@return boolean True if the position is inside the encounter zone, false otherwise
		function MinigameData:isInZone(position)
			return self:GetMinigameZone():isInZone(position)
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

		---Check if can start encounter
		---@return boolean True if encounter can be started, fale otherwise
		function MinigameData:canStart()
			return self.currentStage == MINIGAME_STAGE.UNSTARTED
		end

		---Starts the encounter
		---@return boolean True if the encounter is started successfully, false otherwise
		function MinigameData:start()
			if self.beforeStart then
				self:beforeStart()
			end
			self.active = true
			self:debug("MinigameData[{}]:start", self:GetDisplayName())
			return self:enterStage(MINIGAME_STAGE.FIRST_STAGE)
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

		function MinigameData:SetMinigameLock(player)
			player:isOnMinigame(true)
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, self.fixedSpeed)
			player:setStorageValueByKey(Storage.Minigames.CurrentMinigame, self.encounterName)
			player:changeSpeed()
		end
		function ResetMinigameLock(player)
			player:isOnMinigame(false)
			SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
			player:setStorageValueByKey(Storage.Minigames.FixedSpeed, 0	)
			player:unregisterEvent("MinigameDeath")
			player:changeSpeed()
		end
		function MinigameData:AfterEnterAnyMinigameState(player)
			player:registerEvent("MinigamePlayerDeath")

			SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
			--[[
	player:addHealth(player:getMaxHealth())
	player:addHealth(-(player:getMaxHealth() - player:getMaxBaseHealth()), COMBAT_UNDEFINEDDAMAGE)
	local maxMana = player:getMaxMana()
	player:addMana(-maxMana)
	]]

			SetMinigameLock(player)
			player:changeSpeed()
		end

		function MinigameData:AfterLeaveAnyStateMinigame(player)
			ResetMinigameLock(player)
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

		MinigameCompletionContext = {}
		MinigameCompletionContext.__index = MinigameCompletionContext
		function MinigameCompletionContext.New(context)
			local newObj = {}
			newObj.player = context.player
			newObj.minigame = context.minigame

			newObj.grandPlace = context.grandPlace
			newObj.timeTakenSeconds = os.time() - newObj.minigame:GetStartTimestamp()
			newObj.competitionType = newObj.minigame:GetCompetitionType()

			setmetatable(newObj, MinigameCompletionContext)
			return newObj
		end
		setmetatable(MinigameCompletionContext, {
			__call = function(_, ...)
				return MinigameCompletionContext.New(...)
			end,
		})

		function MinigameCompletionContext:UpdateWins()
			self.player:incrementStorageByKeyClampZero(self.minigame.winsStorage)
			self.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Wins)
		end

		function MinigameCompletionContext:UpdateRecords()
			if self.grandPlace == 1 then
				MinigameCompletionContext:UpdateWins()
			end

			local grandPlacePoints = math.max((4 - self.grandPlace), 0)
			self.player:incrementStorageByKeyClampZero(self.minigame.pointsStorage, grandPlacePoints)
			self.player:incrementStorageByKeyClampZero(self.matchesStorage)
			self.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Points, grandPlacePoints)
			self.player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Matches)

			local timeTakenSeconds = self.timeTakenSeconds
			local shortestTime = self.player:getStorageValueByKey(self.minigame.shortestTime)
			if shortestTime == MISSION_NOT_STARTED then
				shortestTime = 90000
			end
			local longestTime = self.player:getStorageValueByKey(self.minigame.longestTime)

			if timeTakenSeconds < shortestTime then
				self.player:setStorageValueByKey(self.minigame.shortestTime, timeTakenSeconds)
			end
			if timeTakenSeconds > longestTime then
				self.player:setStorageValueByKey(self.minigame.longestTime, timeTakenSeconds)
			end
		end

		local consolationMultiplier = 1
		function MinigameCompletionContext:GrantRewards()
			local highPlaceMultiplier = math.max((4 - self.grandPlace), 0)
			self.player:addXpBoostTime((highPlaceMultiplier + consolationMultiplier) * 5)
			self.player:AddAllCoins((consolationMultiplier + highPlaceMultiplier) * 1)
		end
		function MinigameCompletionContext:AnnounceGrandPlace()
			if self.grandPlace < 3 then
				return
			end
			Game.broadcastMessage(MINIGAMES_BROADCAST_TOP_PARTICIPANTS, nil, true, {
				playerName = self.player:getName(),
				timeTakenSeconds = self.timeTakenSeconds,
				grandPlace = self.grandPlace,
				competitionType = self.competitionType,
				minigameName = self:GetDisplayName(),
			})
		end

		function MinigameData:AfterLeaveActiveMinigame(player)
			local grandPlace = 0
			local currentPlayers = self:GetCurrentPlayersCount()
			if self.competitionType == MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING then
				grandPlace = currentPlayers
			elseif self.competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
				grandPlace = self.participantsStartingCount - currentPlayers + 1
			end

			local completionContext = MinigameCompletionContext({
				player = player,
				minigame = self,
				grandPlace = grandPlace,
			})
			completionContext:UpdateRecords()
			completionContext:GrantRewards()
			completionContext:AnnounceGrandPlace()
		end

		--Localization
		function MinigameData:BroadCastPlayerJoinedLobby(player)
			local participantsCount = #self.lobbyAreaZone:getPlayers()
			Game.broadcastMessage(T("Player :playerName: joined :minigameName:. :participantsCount:/:maxPartitipantsCount:", { playerName = player:getName(), name = self:GetDisplayName(), participantsCount = participantsCount, maxPartitipantsCount = self.maxPartitipantsCount }))
		end
		--Localization
		function MinigameData:BroadCastPlayerLeftLobby(player)
			local participantsCount = #self.lobbyAreaZone:getPlayers()
			Game.broadcastMessage(T("Player :playerName: left :minigameName:. :participantsCount:/:maxPartitipantsCount:", { playerName = player:getName(), name = self:GetDisplayName(), participantsCount = participantsCount, maxPartitipantsCount = self.maxPartitipantsCount }))
		end

		function MinigameData:ConfigureOnEnterLeave()
			local zoneEvents = ZoneEvent(self:GetMinigameZone())

			function zoneEvents.afterEnter(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:hasGroupFlag(IgnoredByMonsters) then
					return
				end

				self:BroadCastPlayerJoinedLobby(creature)
				self:AfterEnterAnyMinigameState()
			end

			function zoneEvents.afterLeave(zone, creature)
				local player = creature:getPlayer()
				if not player then
					return
				end
				if player:hasGroupFlag(IgnoredByMonsters) then
					return
				end

				if not self:IsActive() then
					self:BroadCastPlayerLeftLobby(player)
				else
					self:AfterLeaveActiveMinigame(player)
				end
				self:AfterLeaveAnyStateMinigame(player)

				if self:countPlayers() == 0 then
					self:reset()
				end
			end

			zoneEvents:register()
		end

		function MinigameData:debug(...)
			if not self.enableDebug then
				return
			end
			logger.debug(...)
		end
	end)
	:NoQuestlog()

--[[
:Script(function(storageToRequiredState)
local aidConfig = {
	missingEnergy = 13526,
	leftLight = 13527,
	rightLight = 13528,
	leftDoor = 13529,
	rightDoor = 13530,
	monitor = 13531,
}

local lightCorridorConfig = {
	left = {
		topLeft = FNAF_ANCHOR:Moved({ x = -7, y = -5, z = 0 }),
		downRight = FNAF_ANCHOR:Moved({ x = -2, y = 5, z = 0 }),
	},
	right = {
		topLeft = FNAF_ANCHOR:Moved({ x = 1, y = -5, z = 0 }),
		downRight = FNAF_ANCHOR:Moved({ x = 5, y = 5, z = 0 }),
	},
}
local sharedConfig = {
	pitchBlack = 10802,
	nothingSpecial = 470,
	aidToItemName = {
		[aidConfig.leftLight] = "leftLight",
		[aidConfig.rightLight] = "rightLight",
		[aidConfig.leftDoor] = "leftDoor",
		[aidConfig.rightDoor] = "rightDoor",
	},
	camIds = {
		[1] = "CAM_1A",
		[2] = "CAM_1B",
		[3] = "CAM_1C",
		[4] = "CAM_2A",
		[5] = "CAM_2B",
		[6] = "CAM_3",
		[7] = "CAM_4A",
		[8] = "CAM_4B",
		[9] = "CAM_5",
		[10] = "CAM_6",
		[11] = "CAM_7",
	},
	monitorConfig = {
		["CAM_1A"] = { toPos = { x = 826, y = 1239, z = 12 } },
		["CAM_2A"] = { toPos = FNAF_ANCHOR:Moved({ x = -4, y = -9, z = 1 }) },
	},
	MonitorPeekTimer = 3717,
	MaxPlayingTimer = 1245 * 5,
	ExitLocation = { 1, 1, 1 },
}

local monsterConfig = {
	foxy = {
		verticalId = 29307,
		horizontalId = 29308,
		spawnPos = FNAF_ANCHOR:Moved({ x = -4, y = -12, z = 1 }),
	},
}

local usingLeftDoor = false
local usingRightDoor = false
local lightState = {}

local stringConfig = nil
local langToStringConfig = {
	["EN"] = {
		["youHave"] = "You have ",
		["energyLeft"] = " % energy remaining.",
	},
	["PL"] = { ["youHave"] = "Pozostalo Ci ", ["energyLeft"] = " % energii." },
}

local function runInDirection(item, speed, dir, iterations, acceleration, currentTimer)
	iterations = iterations or 1
	acceleration = acceleration or 0
	local offset = Vector.FromDirection(dir)
	currentTimer = currentTimer or 0
	for _ = 1, iterations do
		addEvent(function()
			item:moveTo(item:getPosition():Moved(offset))
		end, currentTimer)
		currentTimer = currentTimer + speed
		speed = speed - acceleration
	end
	return currentTimer
end

local function isGameOccupied()
	return Game.getStorageValue(aidConfig.GameOccupied) == 1
end

local function occupyGame(player)
	Game.setStorageValue(aidConfig.GameOccupied, 1)
	sharedConfig.player = player
	addEvent(function()
		Game.setStorageValue(aidConfig.GameOccupied, 0)
		if player and player:isPlayer() then
			player:teleportTo(sharedConfig.ExitLocation)
		end
	end, sharedConfig.MaxPlayingTimer)
end

local function rechargeBattery(player)
	player:setStorageValue(aidConfig.missingEnergy, 0)
end

local function enterGame(player)
	rechargeBattery(player)
	occupyGame(player)
end

local TryEnter = MoveEvent()
function TryEnter.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if isGameOccupied() then
		return false
	end
	enterGame(player)
end

local function announceEnergyLevel(player)
	stringConfig = GetConfigByPlayer(langToStringConfig, player)
	local energy = 100 - player:getStorageValue(aidConfig.missingEnergy)
	player:say(stringConfig["youHave"] .. energy .. stringConfig["energyLeft"], TALKTYPE_MONSTER_SAY)
end

local function tryDischargeBattery(player, kwh)
	local result = player:IncrementStorage(aidConfig.missingEnergy, kwh)
	return result < 100
end

local function SwapItemsArea(top_left, down_right, fromId, toId, anchor)
	if anchor then
		top_left = anchor:Moved(top_left)
		down_right = anchor:Moved(down_right)
	end
	IterateBetweenPositions(top_left, down_right, function(context)
		local pos = context.pos
		if not pos then
			return
		end
		local tile = Tile(pos)
		if not tile then
			return
		end
		local item = tile:getItemById(fromId)
		if not item then
			return
		end
		item:transform(toId)
	end)
	return true
end

local function useLight(player, dir)
	if lightState[dir] == true then
		return
	end

	if not tryDischargeBattery(player, 1) then
		return false
	end

	lightState[dir] = true

	local topLeft = lightCorridorConfig[dir].topLeft
	local downRight = lightCorridorConfig[dir].downRight

	local fromId = sharedConfig.pitchBlack
	local toId = sharedConfig.nothingSpecial

	addEvent(function()
		SwapItemsArea(topLeft, downRight, fromId, toId)
	end, 100)
	addEvent(function()
		SwapItemsArea(topLeft, downRight, toId, fromId)
	end, 200)
	addEvent(function()
		SwapItemsArea(topLeft, downRight, fromId, toId)
	end, 400)
	addEvent(function()
		SwapItemsArea(topLeft, downRight, toId, fromId)
	end, 3700)
	addEvent(function()
		SwapItemsArea(topLeft, downRight, fromId, toId)
	end, 3800)
	addEvent(function()
		SwapItemsArea(topLeft, downRight, toId, fromId)
		lightState[dir] = false
	end, 4000)
end

local function spawnFoxy(player)
	if Game.getStorageValue(sharedConfig.IsFoxySpawned) == 1 then
		return true
	end
	if math.random(1, 10) < 0 then
		return true
	end

	local verticalId = monsterConfig.foxy.verticalId
	local horizontalId = monsterConfig.foxy.horizontalId
	local spawnPos = monsterConfig.foxy.spawnPos
	local foxy = Game.createItem(verticalId, 1, spawnPos)

	local timer = 0
	addEvent(function()
		timer = 0
		timer = runInDirection(foxy, 300, SOUTH, 11, 10, timer)
		useLight(player, "leftLight")
		addEvent(function()
			timer = 0
			if not Tile(Position(sharedConfig.leftDoor.pos)):getItemById(sharedConfig.leftDoor.id) then
				foxy:transform(horizontalId)
				foxy:moveTo(foxy:getPosition():Moved(2, 1, -1))
				timer = runInDirection(foxy, 190, EAST, 3, 0, timer)
				addEvent(function()
					if player then
						-- kill player
					end
					foxy:remove()
				end, timer)
			else
				timer = runInDirection(foxy, 190, SOUTH, 10, 0, timer)
				addEvent(function()
					foxy:remove()
				end, timer)
			end
		end, timer)
	end, sharedConfig.MonitorPeekTimer)
end

local monitorSpecialActions = { ["CAM_2A"] = spawnFoxy }

local function fnafPeekMonitor(player, timer, fromPos, choice)
	local toPos = sharedConfig.monitorConfig[choice.text].toPos
	local specialAction = monitorSpecialActions[choice.text]
	doSetItemOutfit(player, 10559, timer)
	player:teleportTo(toPos)
	specialAction(player)
	addEvent(function()
		if player then
			player:teleportTo(fromPos)
		else
			-- player: set position in database to temple?
		end
	end, timer)
end

local function fnafMonitorUse(player, choice)
	if not tryDischargeBattery(player, 1) then
		return false
	end
	local fromPosition = player:getPosition()
	local timer = sharedConfig.MonitorPeekTimer
	fnafPeekMonitor(player, timer, fromPosition, choice)
end

local EnergyBar = Action()
function EnergyBar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	announceEnergyLevel(player)
	return true
end

EnergyBar:aid(aidConfig.missingEnergy)
EnergyBar:register()

local lamp = Action()
function lamp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local side = "left"
	if item:getActionId() == Storage.Fnaf.RightLight then
		side = "right"
	end
	useLight(player, side)

	return true
end

lamp:aid(Storage.Fnaf.LeftLight)
lamp:aid(Storage.Fnaf.RightLight)
lamp:register()

local doorId = 21232
local leftDoorPos = FNAF_ANCHOR:Moved(-2, 0, 0)
local leftDoorTile = {}
local rightDoorPos = FNAF_ANCHOR:Moved(2, 0, 0)
local rightDoorTile = {}

local leftDoorFlip = MoveEvent()
function leftDoorFlip.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local door = leftDoorTile:getItemById(doorId)
	if door then
		usingLeftDoor = false
		return door:remove()
	end
	usingLeftDoor = true
	Game.createItem(doorId, 1, leftDoorPos)
	return true
end
leftDoorFlip:aid(Storage.Fnaf.LeftDoor)
leftDoorFlip:register()
local rightDoorFlip = MoveEvent()
function rightDoorFlip.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local door = rightDoorTile:getItemById(doorId)
	if door then
		usingRightDoor = false
		return door:remove()
	end
	usingRightDoor = true
	Game.createItem(doorId, 1, rightDoorPos)
	return true
end
rightDoorFlip:aid(Storage.Fnaf.RightDoor)
rightDoorFlip:register()

local Monitor = Action()
function Monitor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	-- nie dokonczone
	do
		return
	end

	local title = "Monitoring control panel"
	local message = "Choose the monitor to be displayed:"

	local window = ModalWindow({ title = title, message = message })

	for i = 1, #sharedConfig.camIds do
		local choice = window:addChoice(1, sharedConfig.camIds[i])
		choice.text = sharedConfig.camIds[i]
	end

	local internalConfirm = function(button, choice)
		fnafMonitorUse(player, choice)
	end
	window:addButton("Choose", internalConfirm)

	window:sendToPlayer(player)
	return true
end

Monitor:aid(Storage.Fnaf.ControlPanel)
Monitor:register()

local desertQuestInit = GlobalEvent("fnafDoorInit")
function desertQuestInit.onStartup()
	-- leftDoorTile = Tile(leftDoorPos)
	-- rightDoorTile = Tile(rightDoorPos)
end
desertQuestInit:register()
end)
]]

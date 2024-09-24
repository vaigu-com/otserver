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
	if aid == Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop or aid == Storage.PerIustitiaAdAstra.ShipDestinations.Ganymede then
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
	player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipLocationLocked") .. choice.text, TALKTYPE_MONSTER_SAY)
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
			local transaltedText = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get(aidToDestName[aid])
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
	moveToLoop(movingStars.topleft, movingStars.downRight, movingStars.delay, movingStars.stars, currentMoveToLoopId)
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
		player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ShipAlreadyAtDestination"), TALKTYPE_MONSTER_SAY)
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

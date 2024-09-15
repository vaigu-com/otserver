FREE_TRANSPORTS = 10

TRANSPORT_TYPE = {
	SHIP = "TRANSPORT_TYPE.SHIP",
	CARPET = "TRANSPORT_TYPE.CARPET",
}
DEFAULT_TRANSPORT_COST = 200

local function createHelpDialog(player, _, _)
	player:showTextDialog(2994, player:Localizer(LOCALIZER_UNIVERSAL):Get("TravelHelpDialog"))
end

local function chargeForTravel(player, price)
	local freeSailsLeft = player:getStorageValue(Storage.FreeTravels)
	if freeSailsLeft > 0 then
		player:setStorageValue(Storage.FreeTravels, freeSailsLeft - 1)
		return true
	end

	return player:removeMoney(price)
end

local function teleportToDestination(player, choice)
	local toPos = choice.toPos
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(toPos)
	toPos:sendMagicEffect(CONST_ME_TELEPORT)
end

local function confirmDestination(player, _, choice)
	if not choice then
		return true
	end

	if player:isPzLocked() then
		createHelpDialog(player, "ship")
		return
	end

	local minLevel = choice.minLevel or 0
	if player:getLevel() < minLevel then
		player:sendCancelMessage(player:Localizer(LOCALIZER_UNIVERSAL):Context({ minLevel = minLevel }):Get("MINIMUM_LEVEL_TO_TRAVEL"))
		return
	end

	if not chargeForTravel(player, choice.price or DEFAULT_TRANSPORT_COST) then
		player:sendCancelMessage(player:Localizer(LOCALIZER_UNIVERSAL):Get("You dont have enough money."))
		return
	end

	teleportToDestination(player, choice)
end

local transportNameToWindowTitle = {
	[TRANSPORT_TYPE.SHIP] = "ShipWindowTitle",
	[TRANSPORT_TYPE.CARPET] = "CarpetWindowTitle",
}

local transportnameToWindowMessage = {
	[TRANSPORT_TYPE.SHIP] = "ShipWindowMessage",
	[TRANSPORT_TYPE.CARPET] = "CarpetWindowMessage",
}

--ToDoL use context
function CreateTransportWindow(context)
	local player = context.player
	local transports = context.transports
	local transportName = context.transportName

	local title = player:Localizer(LOCALIZER_UNIVERSAL):Get(transportNameToWindowTitle[transportName])
	local message = player:Localizer("UNIVRESAL"):Get(transportnameToWindowMessage[transportName])
	local window = ModalWindow({ title = title, message = message })

	for _, transportConfig in pairs(transports) do
		local choice = window:addChoice(transportConfig.name)
		choice.minLevel = transportConfig.minLevel
		choice.toPos = transportConfig.toPos
		choice.price = transportConfig.price
		choice.transportName = transportName
	end

	window:addButton(player:Localizer(LOCALIZER_UNIVERSAL):Get("Select"), confirmDestination)
	window:addButton(player:Localizer(LOCALIZER_UNIVERSAL):Get("Cancel"))
	window:addButton(player:Localizer(LOCALIZER_UNIVERSAL):Get("Help"), createHelpDialog)
	window:sendToPlayer(player)
end

SHIP_ROUTES_JACEK_WROBEL = {
	{ toPos = Position(5980, 1502, 6), name = "Mirko Town" },
	{ toPos = Position(6740, 1357, 6), name = "Hurgada" },
	{ toPos = Position(7074, 801, 6), name = "Kongo" },
	{ toPos = Position(5539, 1509, 6), name = "Knurowo" },
	{ toPos = Position(6602, 1877, 7), name = "Sybir" },
	{ toPos = Position(6791, 1082, 6), name = "Wyspa Piratow" },
	{ toPos = Position(5990, 766, 6), name = "Karaiby", minLevel = 60 },
	{ toPos = Position(6421, 727, 7), name = "Praga Polnoc", minLevel = 60 },
	--	{ toPos = Position(7318, 1090, 6), name = "Maioor'ka" },
	--	{ toPos = Position(7929, 1533, 6), name = "Bydgoshch" },
}

SHIP_ROUTES_KRZYSZTOF_KOLUMB = {
	{ toPos = Position(5909, 1233, 6), name = "North Mirko" },
	{ toPos = Position(6247, 1023, 6), name = "Stepy" },
	{ toPos = Position(5747, 1217, 6), name = "Bornholm", minLevel = 50 },
	{ toPos = Position(6223, 1392, 7), name = "Wyspa Quar" },
	{ toPos = KRAKEN_ANCHOR, name = "Leviathan", minLevel = 50 },
}

SHIP_ROUTES_RUDOBRODY = {
	--	{ toPos = Position(7318, 1090, 6), name = "Maioor'ka" },
	--	{ toPos = Position(7929, 1533, 6), name = "Bydgoshch" },
}
TRANSPORT_ROUTES = {
	ALI_BABA_CARPET = {
		{ toPos = Position(7273, 1104, 3), name = "Maioor'ka" },
		{ toPos = Position(7027, 1201, 2), name = "Zoltystok" },
		{ toPos = Position(7477, 1775, 6), name = "Orshaawa" },
		{ toPos = Position(6322, 1929, 4), name = "A'laska" },
	},
	RUDOBRODY_SHIP = {
		--	{ toPos = Position(7318, 1090, 6), name = "Maioor'ka" },
		--	{ toPos = Position(7929, 1533, 6), name = "Bydgoshch" },
	},
	KRZYSZTOF_KOLUMB_SHIP = {
		{ toPos = Position(5909, 1233, 6), name = "North Mirko" },
		{ toPos = Position(6247, 1023, 6), name = "Stepy" },
		{ toPos = Position(5747, 1217, 6), name = "Bornholm", minLevel = 50 },
		{ toPos = Position(6223, 1392, 7), name = "Wyspa Quar" },
		{ toPos = KRAKEN_ANCHOR, name = "Leviathan", minLevel = 50 },
	},
	JACEK_WROBEL_SHIP = {
		{ toPos = Position(5980, 1502, 6), name = "Mirko Town" },
		{ toPos = Position(6740, 1357, 6), name = "Hurgada" },
		{ toPos = Position(7074, 801, 6), name = "Kongo" },
		{ toPos = Position(5539, 1509, 6), name = "Knurowo" },
		{ toPos = Position(6602, 1877, 7), name = "Sybir" },
		{ toPos = Position(6791, 1082, 6), name = "Wyspa Piratow" },
		{ toPos = Position(5990, 766, 6), name = "Karaiby", minLevel = 60 },
		{ toPos = Position(6421, 727, 7), name = "Praga Polnoc", minLevel = 60 },
		--	{ toPos = Position(7318, 1090, 6), name = "Maioor'ka" },
		--	{ toPos = Position(7929, 1533, 6), name = "Bydgoshch" },
	},
}

TRANSPORT_ROUTES_ALI_BABA = {}

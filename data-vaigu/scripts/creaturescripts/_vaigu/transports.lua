FREE_TRANSPORTS = 10

TRANSPORT_TYPE = {
	SHIP = "TRANSPORT_TYPE.SHIP",
	CARPET = "TRANSPORT_TYPE.CARPET",
}
DEFAULT_TRANSPORT_COST = 200

local function createHelpDialog(player, _, _)
	player:showTextDialog(2994, player:Localizer(LOCALIZERS.Universal):Get("TravelHelpDialog"))
end

local function chargeForTravel(player, price)
	local freeSailsLeft = player:getStorageValueByKey(Storage.FreeTravels)
	if freeSailsLeft > 0 then
		player:setStorageValueByKey(Storage.FreeTravels, freeSailsLeft - 1)
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
		player:sendCancelMessage(player:Localizer(LOCALIZERS.Universal):Context({ minLevel = minLevel }):Get("MINIMUM_LEVEL_TO_TRAVEL"))
		return
	end

	if not chargeForTravel(player, choice.price or DEFAULT_TRANSPORT_COST) then
		player:sendCancelMessage(player:Localizer(LOCALIZERS.Universal):Get("You dont have enough money."))
		return
	end

	teleportToDestination(player, choice)
end

local transportTypeToWindowTitle = {
	[TRANSPORT_TYPE.SHIP] = "ShipWindowTitle",
	[TRANSPORT_TYPE.CARPET] = "CarpetWindowTitle",
}

local transportTypeToWindowMessage = {
	[TRANSPORT_TYPE.SHIP] = "ShipWindowMessage",
	[TRANSPORT_TYPE.CARPET] = "CarpetWindowMessage",
}

local function hasAccess(player, transport)
	if transport.storage and player:getStorageValueByKey(transport.storage) ~= ACCESS_GRANTED then
		return false
	end

	return true
end

function CreateTransportWindow(context)
	local player = context.player
	local transports = context.transports
	local transportType = context.transportType

	local title = player:Localizer(LOCALIZERS.Universal):Get(transportTypeToWindowTitle[transportType])
	local message = player:Localizer(LOCALIZERS.Universal):Get(transportTypeToWindowMessage[transportType])
	local window = ModalWindow({ title = title, message = message })

	for _, transportConfig in pairs(transports) do
		if hasAccess(player, transportConfig) then
			local translatedName = player:Localier(LOCALIZERS.Universal):Get(transportConfig.name)
			local choice = window:addChoice(translatedName)
			choice.minLevel = transportConfig.minLevel
			choice.toPos = transportConfig.toPos
			choice.price = transportConfig.price
			choice.transportType = transportType
		end
	end

	window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Select"), confirmDestination)
	window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Cancel"))
	window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Help"), createHelpDialog)
	window:sendToPlayer(player)
end

SHIP_ROUTES_RUDOBRODY = {
	--	{ toPos = Position(7318, 1090, 6), name = "Maioor'ka" },
	--	{ toPos = Position(7929, 1533, 6), name = "Bydgoshch" },
}
TRANSPORT_ROUTES = {
	ALI_BABA_CARPET = {
		{ toPos = Position(7273, 1104, 3), name = "Maioor'ka" },
		{ toPos = Position(7027, 1201, 2), name = "Cairo Fornia" },
		{ toPos = Position(7477, 1775, 6), name = "Orshaawa" },
		{ toPos = Position(6739, 1280, 4), name = "Hurghada" },
		{ toPos = Position(6972, 784, 4), name = "Kongo" },
		{ toPos = Position(6044, 1282, 3), name = "Zasrane" },
	},
	REDBEARD_SHIP = {
		{ toPos = Position(6335, 1357, 6), name = "Wyrm Cliffs" },
		{ toPos = Position(), name = "Pirate Island" },
		{ toPos = Position(5689, 1465, 6), name = "Phantom Port" },
		{ toPos = Position(5701, 1832, 7), name = "South knurow PLACEHOLDER_VAIGU"},
		{ toPos = Position(6846, 1425, 6), name = "Hurghada PLACEHOLDER_VAIGU"}
	},
	CRISTOPHER_COLUMBUS_SHIP = {
		{ toPos = Position(5909, 1233, 6), name = "North Mirko" },
		{ toPos = Position(6247, 1023, 6), name = "Steppes" },
		{ toPos = Position(5747, 1217, 6), name = "Bornholm", minLevel = 50 },
		{ toPos = Position(6223, 1392, 7), name = "Quara Island" },
		{ toPos = KRAKEN_ANCHOR, name = "Leviathan", minLevel = 50 },
	},
	JACK_SPARROW_SHIP = {
		{ toPos = Position(5980, 1502, 6), name = "Mirko Town" },
		{ toPos = Position(6740, 1357, 6), name = "Hurgada" },
		{ toPos = Position(7074, 801, 6), name = "Kongo" },
		{ toPos = Position(5539, 1509, 6), name = "Knurowo" },
		{ toPos = Position(6602, 1877, 7), name = "Syberia" },
		{ toPos = Position(6791, 1082, 6), name = "Pirate Island" },
		{ toPos = Position(5990, 766, 6), name = "Caribbean", minLevel = 60 },
		-- { toPos = Position(6421, 727, 7), name = "Praga Polnoc", minLevel = 60 }, --removed from game (currently)
		{ toPos = Position(7311, 1082, 6), name = "Maioor'ka" },
		{ toPos = Position(7933, 1546, 6), name = "Bydgoshch" },
	},
	TARZAN_SHIP = {
		"PLACEHOLDER_VAIGU"
	}
}

TRANSPORT_ROUTES_ALI_BABA = {}

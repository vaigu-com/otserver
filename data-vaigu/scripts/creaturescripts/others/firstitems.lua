local starterItems = {
	[VOCATION.ID.SORCERER] = {
		toBody = {
			{ id = 3059, count = 1, dontAnnounce = true },
			{ id = 3074, count = 1, dontAnnounce = true },
			{ id = 7991, count = 1, dontAnnounce = true },
			{ id = 7992, count = 1, dontAnnounce = true },
			{ id = 3362, count = 1, dontAnnounce = true },
			{ id = 3552, count = 1, dontAnnounce = true },
			{ id = 3572, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 3003, count = 1, dontAnnounce = true },
			{ id = 266, count = 2, addToStore = true, dontAnnounce = true },
			{ id = 268, count = 10, addToStore = true, dontAnnounce = true },
			{ id = 8015, count = 20, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
	[VOCATION.ID.DRUID] = {
		toBody = {
			{ id = 3059, count = 1, dontAnnounce = true },
			{ id = 3066, count = 1, dontAnnounce = true },
			{ id = 7991, count = 1, dontAnnounce = true },
			{ id = 7992, count = 1, dontAnnounce = true },
			{ id = 3362, count = 1, dontAnnounce = true },
			{ id = 3552, count = 1, dontAnnounce = true },
			{ id = 3572, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 3003, count = 1, dontAnnounce = true },
			{ id = 266, count = 2, addToStore = true, dontAnnounce = true },
			{ id = 268, count = 10, addToStore = true, dontAnnounce = true },
			{ id = 8015, count = 20, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
	[VOCATION.ID.PALADIN] = {
		toBody = {

			{ id = 3430, count = 1, dontAnnounce = true },
			{ id = 3277, count = 5, dontAnnounce = true },
			{ id = 3571, count = 1, dontAnnounce = true },
			{ id = 8095, count = 1, dontAnnounce = true },
			{ id = 3552, count = 1, dontAnnounce = true },
			{ id = 3572, count = 1, dontAnnounce = true },
			{ id = 3354, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 3003, count = 1, dontAnnounce = true },
			{ id = 266, count = 3, addToStore = true, dontAnnounce = true },
			{ id = 268, count = 6, addToStore = true, dontAnnounce = true },
			{ id = 8015, count = 20, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},

	[VOCATION.ID.KNIGHT] = {
		toBody = {
			{ id = 3430, count = 1, dontAnnounce = true },
			{ id = 3359, count = 1, dontAnnounce = true },
			{ id = 3354, count = 1, dontAnnounce = true },
			{ id = 3372, count = 1, dontAnnounce = true },
			{ id = 3552, count = 1, dontAnnounce = true },
			{ id = 3572, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 3003, count = 1, dontAnnounce = true },
			{ id = 266, count = 10, addToStore = true, dontAnnounce = true },
			{ id = 268, count = 4, addToStore = true, dontAnnounce = true },
			{ id = 8015, count = 20, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
}

local function setFreeTravels(player)
	player:setStorageValue(Storage.FreeTravels, FREE_TRANSPORTS)
end

local knightWeaponChoices = {
	Club = 3327,
	Sword = 7774,
	Axe = 7773,
}
local defaultWeapon = 7774

local confirmStarterWeaponChoice = function(player, button, choice)
	if not choice then
		choice = { weaponType = defaultWeapon }
		player:sendTextMessage(32, player:Localizer(LOCALIZER_UNIVERSAL):Get("Fine, i will choose your starter weapon then..."))
	end

	player:AddCustomItem({ id = choice.id })

	CreateChooseLanguageWindow(player)
end

local function sendKnightStarterWeaponChoice(player)
	local title = player:Localizer(LOCALIZER_UNIVERSAL):Get("Starter weapons")
	local message = player:Localizer(LOCALIZER_UNIVERSAL):Get("Choose your starter weapon:")
	local window = ModalWindow({ title = title, message = message })

	for weaponType, id in pairs(knightWeaponChoices) do
		local choice = window:addChoice(weaponType)
		choice.weaponType = weaponType
		choice.id = id
	end

	window:addButton(player:Localizer(LOCALIZER_UNIVERSAL):Get("ModalWindowOk"), confirmStarterWeaponChoice)
	window:sendToPlayer(player)
end

local firstLogin = CreatureEvent("FirstLogin")
function firstLogin.onLogin(player)
	if player:getLastLoginSaved() ~= 0 then
		return true
	end

	setFreeTravels(player)

	local playerVocation = player:getVocation():getId()
	local items = starterItems[playerVocation]
	if not items then
		return true
	end

	for _, item in pairs(items.toBody) do
		player:AddCustomItem(item, nil)
	end

	local backpack = player:addItem(2854)
	for _, item in pairs(items.toBackpack) do
		player:AddCustomItem(item, backpack)
	end

	if player:getVocation():getId() ~= VOCATION.ID.KNIGHT then
		CreateChooseLanguageWindow(player)
		return true
	end

	sendKnightStarterWeaponChoice(player)

	return true
end

firstLogin:register()

local starterItems = {
	[VOCATION.ID.SORCERER] = {
		toBody = {
			{ id = 21348, count = 1, dontAnnounce = true },
			{ id = 3561, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 8015, count = 5, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
	[VOCATION.ID.DRUID] = {
		toBody = {
			{ id = 21350, count = 1, dontAnnounce = true },
			{ id = 3561, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 8015, count = 5, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
	[VOCATION.ID.PALADIN] = {
		toBody = {
			{ id = 3277, count = 8, dontAnnounce = true },
			{ id = 3561, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 8015, count = 5, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },
		},
	},
	[VOCATION.ID.KNIGHT] = {
		toBody = {
			{ id = 3561, count = 1, dontAnnounce = true },
		},
		toBackpack = {
			{ id = 8015, count = 5, dontAnnounce = true },
			{ id = 7879, count = 1, dontAnnounce = true },

			{ id = 3267, count = 1 },
			{ id = 3268, count = 1 },
			{ id = 3336, count = 1 },
		},
	},
}

local function setFreeTravels(player)
	player:setStorageValueByKey(Storage.FreeTravels, FREE_TRAVELS_COUNT)
end

local function addKeyRing(player)
	local keyRing = Game.createItem(KEY_RING_ID)
	keyRing:setKey(Storage.DoorKeys.KeyRing)
	for doorKeyIdStr, collectionStorage in pairs(Storage.DoorKeys.KeyCollections) do
		local doorKey = keyRing:addItem(tonumber(doorKeyIdStr))
		doorKey:setKey(collectionStorage)
		player:setStorageValueByKey(collectionStorage, {})
	end
	local inbox = player:getStoreInbox()
	inbox:addItemEx(keyRing)
end

local initialStorages = {
	[Storage.Tasks.TaskInfo] = 1,
	[Storage.Tasks.TaskPoints] = 0,
}

Storage.FirstLogin = {}

local firstLogin = CreatureEvent("FirstLogin")
function firstLogin.onLogin(player)
	if player:getStorageValueByKey(Storage.FirstLogin) == ACCESS_GRANTED then
		return true
	end

	setFreeTravels(player)

	player:NextState(initialStorages)

	local playerVocation = player:getVocation():getId()
	local items = starterItems[playerVocation]

	if items then
		for _, item in pairs(items.toBody) do
			player:AddCustomItem({ id = item.id, count = item.count or 1 })
		end

		player:AddCustomItem({ id = 2854 })
		for _, item in pairs(items.toBackpack) do
			player:AddCustomItem(item)
		end
	end

	player:addForgeDustLevel(1000 - player:getForgeDustLevel())
	addKeyRing(player)

	-- CreateChooseLanguageWindow(player)

	player:setStorageValueByKey(Storage.FirstLogin, ACCESS_GRANTED)
	return true
end

firstLogin:register()

local closedToOpen = {}
local openToClosed = {}
local unlockedToLocked = {}
local lockedToUnlocked = {}
for _, value in pairs(KeyDoorTable) do
	closedToOpen[value.closedDoor] = value.openDoor
	openToClosed[value.openDoor] = value.closedDoor
	unlockedToLocked[value.closedDoor] = value.lockedDoor
	unlockedToLocked[value.openDoor] = value.lockedDoor
	lockedToUnlocked[value.lockedDoor] = value.closedDoor
end

local lockedDoor = Action()
function lockedDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:sendTextMessage(MESSAGE_LOOK, "It is locked.")
	return true
end

for key, value in pairs(KeyDoorTable) do
	lockedDoor:id(value.lockedDoor)
end
lockedDoor:register()

local closedDoor = Action()
function closedDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(closedToOpen[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	return true
end
for key, value in pairs(KeyDoorTable) do
	closedDoor:id(value.closedDoor)
end
closedDoor:register()

local openDoor = Action()
function openDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(openToClosed[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	Creature.checkCreatureInsideDoor(player, toPosition)
	return true
end
for key, value in pairs(KeyDoorTable) do
	openDoor:id(value.openDoor)
end
openDoor:register()

local doorKeyIdToUnlockedKeys = (function()
	local keyStorages = {}
	for _, doorKeyId in pairs(keysID) do
		keyStorages[tostring(doorKeyId)] = {}
	end
	return keyStorages
end)()
Storage.DoorKeys = {
	KeyRing = {},
	KeyCollections = doorKeyIdToUnlockedKeys,
	BaseUnlockerKey = {},
}

local function isDoor(door)
	local id = door:getId()
	return openToClosed[id] or closedToOpen[id] or lockedToUnlocked[id]
end

local function keyMatches(item, door)
	return item:getKey() == door:getKey()
end

local function tryToggleLockUnlockDoor(door)
	if not isDoor(door) then
		return
	end
	local key = door:getKey()
	if not key then
		return
	end

	local locked = lockedToUnlocked[door:getId()]
	local unlocked = unlockedToLocked[door:getId()]
	if locked then
		door:transform(locked)
		door:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_CLOSE_DOOR)
	elseif unlocked then
		door:transform(unlocked)
		door:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	end
end

local function tryToggleCollectionKey(player, door, doorKey)
	local unlockedKeys = player:getStorageValueByKey(doorKey:getKey())
	if not unlockedKeys[door:getKey()] then
		return "This key collection cannot open this door yet."
	end

	tryToggleLockUnlockDoor(door)
end

local function tryToggleDoorKey(doorKey, door)
	if not keyMatches(doorKey, door) then
		return "The key does not match."
	end
	tryToggleLockUnlockDoor(door)
end

---#region permanent key unlock
local function isCollectionKey(doorKey)
	return table.contains(Storage.DoorKeys.KeyCollections, doorKey:getKey())
end
local function isAddingToCollection(doorKey, target)
	if doorKey:getId() ~= target:getId() then
		return false
	end
	if not table.contains(Storage.DoorKeys.KeyCollections, target:getKey()) then
		return false
	end
	if table.contains(Storage.DoorKeys.KeyCollections, doorKey:getKey()) then
		return false
	end

	return true
end
local function hasInCollection(player, doorKey)
	for doorKeyId, collectionStorage in pairs(Storage.DoorKeys.KeyCollections) do
		local unlockedKeys = player:getStorageValueByKey(collectionStorage)
		if unlockedKeys[doorKey:getKey()] then
			return true
		end
	end

	return false
end
local function withoutStoragePrefix(str)
	return str:gsub("^Storage%-", "")
end

local function withoutStandardPrefixes(str)
	return str:gsub("^Storage%-", ""):gsub("^DoorKeys%-", "")
end

local function addToCollection(player, doorKeyStorage, collectionStorage)
	local unlockedKeys = player:getStorageValueByKey(collectionStorage)
	local desc = withoutStoragePrefix(doorKeyStorage)
	unlockedKeys[doorKeyStorage] = desc
	player:setStorageValueByKey(collectionStorage, unlockedKeys)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
end
local doorKeyUse = Action()
function doorKeyUse.onUse(player, doorKey, fromPosition, doorOrCollection, toPosition, isHotkey)
	--Permanent add to collection
	local _isAddingToCollection = isAddingToCollection(doorKey, doorOrCollection)
	local _hasInCollection = hasInCollection(player, doorKey)

	if _isAddingToCollection and not _hasInCollection then
		addToCollection(player, doorKey:getKey(), doorOrCollection:getKey())
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked this key.")
		doorKey:remove()
		return
	end

	if _isAddingToCollection and _hasInCollection then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already unlocked this key.")
		return
	end

	--Toggle door locked/unlocked
	local errorMessage = ""
	if isCollectionKey(doorKey) then
		errorMessage = tryToggleCollectionKey(player, doorOrCollection, doorKey)
	else
		errorMessage = tryToggleDoorKey(doorKey, doorOrCollection)
	end

	if errorMessage then
		player:sendCancelMessage(errorMessage)
		return
	end

	return true
end
for _, doorKeyId in pairs(keysID) do
	doorKeyUse:id(doorKeyId)
end
doorKeyUse:register()

local function generateCollectionMessage(player, keyId, collectionStorage)
	local message = T("You have unlocked the following :name:s:", { name = ItemType(keyId):getName() })
	local unlockedKeys = player:getStorageValueByKey(collectionStorage)
	if TableSize(unlockedKeys or {}) == 0 then
		unlockedKeys = { "---None---" }
	end
	for storage, desc in pairs(unlockedKeys) do
		message = message .. "\n" .. withoutStandardPrefixes(desc)
	end
	return message
end
local collectionLook = Look()
function collectionLook.onLook(player, doorKey)
	local message = generateCollectionMessage(player, doorKey:getId(), doorKey:getKey())
	player:sendTextMessage(MESSAGE_LOGIN, message)
	return DONT_SHOW_ONLOOK
end
for doorKeyId, collectionStorage in pairs(Storage.DoorKeys.KeyCollections) do
	collectionLook:key(collectionStorage)
end
collectionLook:register()

local keyRingLook = Look()
function keyRingLook.onLook(player, doorKey)
	local message = ""
	for keyId, storage in pairs(Storage.DoorKeys.KeyCollections) do
		message = message .. generateCollectionMessage(player, tonumber(keyId), storage) .. "\n"
	end
	player:sendTextMessage(MESSAGE_LOGIN, message)
	return DONT_SHOW_ONLOOK
end
keyRingLook:id(KEY_RING_ID)
keyRingLook:register()

local function keyNameIfInCollection(player, door)
	for doorKeyId, storage in pairs(Storage.DoorKeys.KeyCollections) do
		local collectionState = player:getStorageValueByKey(storage)
		local unlocked = collectionState[door:getKey()] ~= nil
		if unlocked then
			return ItemType(tonumber(doorKeyId)):getName()
		end
	end
end
local doorLook = Look()
function doorLook.onLook(player, door)
	if (door:getAttribute(ITEM_ATTRIBUTE_DOORID) or 0) > 0 then
		return DO_SHOW_ONLOOK
	end
	local youSee = T("You see a :doorName:.", { doorName = door:getName() })

	local lockedStatus = ""
	local id = door:getId()
	if lockedToUnlocked[id] and door:getPosition():ChebyshevDistance(player:getPosition()) <= 1 then
		lockedStatus = " It is locked."
	else
		lockedStatus = " It is unlocked."
	end

	local itRequires = ""
	local key = door:getKey()
	if key and key ~= PERMANENTLY_CLOSED then
		itRequires = T(" It requires key :keyDesc:.", { keyDesc = withoutStandardPrefixes(door:getKey()) })
	end

	local name = keyNameIfInCollection(player, door)
	local youCanUnlock = ""
	if name then
		youCanUnlock = T(" You can unlock this door with your :name:.", { name = name })
	end

	player:sendTextMessage(MESSAGE_LOOK, T(":youSee::status::itRequires::youCanUnlock:", { youSee = youSee, status = lockedStatus, itRequires = itRequires, youCanUnlock = youCanUnlock }))
	return DONT_SHOW_ONLOOK
end
for key, value in pairs(KeyDoorTable) do
	doorLook:id(value.closedDoor)
	doorLook:id(value.openDoor)
	doorLook:id(value.lockedDoor)
end
doorLook:register()
---#endregion permanent key unlock

local doorKeyLook = Look()
function doorKeyLook.onLook(player, doorKey)
	local youSee = T("You see a :keyName:.", { keyName = doorKey:getName() })

	local itUnlocks = ""
	local key = doorKey:getKey()
	if key and key ~= PERMANENTLY_CLOSED then
		itUnlocks = T("It unlocks :keyDesc:.", { keyDesc = withoutStandardPrefixes(key) })
	end

	local itWeights = "It weight 1.00 oz."

	player:sendTextMessage(MESSAGE_LOOK, T(":youSee: :itUnlocks: :itWeights:", { youSee = youSee, itUnlocks = itUnlocks, itWeights = itWeights }))
	return DONT_SHOW_ONLOOK
end
for _, id in pairs(keysID) do
	doorKeyLook:id(id)
end
doorKeyLook:register()

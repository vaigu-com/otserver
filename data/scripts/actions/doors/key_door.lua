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

local keyScope = Scope("Storage", "DoorKeys", "UnlockedKeys")
function GetDoorKeyStorage(doorKey)
	return keyScope:Get(doorKey:getId())
end

local doorKeyIdToUnlockedKeys = (function()
	local keyStorages = {}
	for _, doorKeyId in pairs(keysID) do
		keyStorages[keyScope:Get(doorKeyId)] = {}
	end
	return keyStorages
end)()

Storage.DoorKeys = {
	KeyRing = {},
	DoorKeyIdToUnlockedKeys = doorKeyIdToUnlockedKeys,
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
	local unlockedKeys = player:getStorageValueByKey(GetDoorKeyStorage(doorKey))
	if not unlockedKeys[door:getKey()] then
		return "You have not unlocked this door key yet."
	end

	tryToggleLockUnlockDoor(door)
end

local function tryToogleDoorKey(doorKey, door)
	if not keyMatches(doorKey, door) then
		return "The key does not match."
	end
	tryToggleLockUnlockDoor(door)
end

---#region permanent key unlock
local function isUniversalKey(doorKey)
	return doorKey:getKey() == Storage.DoorKeys.BaseUnlockerKey
end
local function isAddingToCollection(doorKey, target)
	if doorKey:getId() ~= target:getId() then
		return false
	end
	if target:getKey() ~= Storage.DoorKeys.BaseUnlockerKey then
		return false
	end
	if doorKey:getKey() == Storage.DoorKeys.BaseUnlockerKey then
		return false
	end

	return true
end
local function hasInCollection(player, doorKey)
	local unlockedKeys = player:getStorageValueByKey(GetDoorKeyStorage(doorKey))
	return unlockedKeys[doorKey:getKey()]
end
local function withoutStoragePrefix(str)
	return str:gsub("^Storage%-", "")
end
local function addToCollection(player, doorKey)
	local unlockedKeys = player:getStorageValueByKey(GetDoorKeyStorage(doorKey))
	local desc = withoutStoragePrefix(doorKey:getKey())
	unlockedKeys[doorKey:getKey()] = desc
	player:setStorageValueByKey(GetDoorKeyStorage(doorKey), unlockedKeys)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
	doorKey:remove()
end
local doorKeyUse = Action()
function doorKeyUse.onUse(player, doorKey, fromPosition, door, toPosition, isHotkey)
	--Permanent add to collection
	local _isAddingToCollection = isAddingToCollection(doorKey, door)
	local _hasInCollection = hasInCollection(player, doorKey)

	if _isAddingToCollection and not _hasInCollection then
		addToCollection(player, doorKey)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked this key.")
		return
	end

	if _isAddingToCollection and _hasInCollection then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already unlocked this key.")
		return
	end

	--Toggle door locked/unlocked
	local errorMessage = ""
	if isUniversalKey(doorKey) then
		errorMessage = tryToggleCollectionKey(player, door, doorKey)
	else
		errorMessage = tryToogleDoorKey(doorKey, door)
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
local unlockerKeyLook = Look()
function unlockerKeyLook.onLook(player, doorKey)
	local message = T("You have unlocked the following :name:s:", { name = doorKey:getName() })
	local unlockedKeys = player:getStorageValueByKey(GetDoorKeyStorage(doorKey))
	if TableSize(unlockedKeys) == 0 then
		unlockedKeys = { "---None---" }
	end
	for storage, desc in pairs(unlockedKeys) do
		message = message .. "\n" .. desc
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	return DONT_SHOW_playerOnLook
end
unlockerKeyLook:key(Storage.DoorKeys.BaseUnlockerKey)
unlockerKeyLook:register()
---#endregion permanent key unlock

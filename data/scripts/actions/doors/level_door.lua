--Lookup tables
local closedToOpen = {}
local openToClosed = {}
for index, value in ipairs(LevelDoorTable) do
	closedToOpen[value.closedDoor] = value.openDoor
	openToClosed[value.openDoor] = value.closedDoor
end

local function doorHasValidLevel(door)
	local key = door:getKey()
	if not key then
		return false
	end

	local requiredLevel = tonumber(key)
	if not requiredLevel then
		return false
	end

	if requiredLevel <= 0 then
		return false
	end

	return true
end

local function canPassDoor(player, door)
	local playerLevel = player:getLevel()

	if not doorHasValidLevel(door) then
		return true
	end

	local requiredLevel = tonumber()
	if playerLevel >= requiredLevel then
		return true
	end
	return false
end

local lookAtDoor = Look()
function lookAtDoor.onLook(player, door)
	local forLevel = ""
	if doorHasValidLevel(door) then
		forLevel = " for level " .. door:getKey()
	end

	player:sendTextMessage(MESSAGE_LOOK, T("You see :doorDesc::forLevel:.", {doorDesc = door:getNameDescription(), forLevel = forLevel}))
end

local openLevelDoor = Action()
function openLevelDoor.onUse(player, door, fromPosition, target, toPosition, isHotkey)
	if not canPassDoor(player, door) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
		return false
	end

	local doorId = door:getId()
	local openDoorId = closedToOpen[doorId]
	if openDoorId then
		door:transform(openDoorId)
		door:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
		player:teleportTo(toPosition, true)
	else
		Creature.checkCreatureInsideDoor(player, toPosition)
	end

	return true
end
for closedId, openId in pairs(closedToOpen) do
	openLevelDoor:id(closedId)
end
openLevelDoor:register()

local closingLevelDoor = MoveEvent()
function closingLevelDoor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local requiredLevel = tonumber(item:getKey())
	local playerLevel = creature:getLevel()
	if playerLevel >= requiredLevel then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
	player:teleportTo(fromPosition, true)
	return false
end
for openId, closedId in pairs(openToClosed) do
	closingLevelDoor:id(openId)
end
closingLevelDoor:type("stepin")
closingLevelDoor:register()

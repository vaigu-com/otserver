local closedToOpen = {}
local openToClosed = {}
for _, value in pairs(LevelDoorTable) do
	closedToOpen[value.closedDoor] = value.openDoor
	openToClosed[value.openDoor] = value.closedDoor
end

local function extractRequiredLevel(door)
	local key = door:getKey()
	if not key then
		return
	end

	local requiredLevel = tonumber(key)
	if not requiredLevel then
		return
	end

	if requiredLevel <= 0 then
		return
	end

	return requiredLevel
end

local function canPassDoor(player, door)
	local playerLevel = player:getLevel()

	local requiredLevel = extractRequiredLevel(door)
	if not requiredLevel then
		return true
	end

	if playerLevel >= requiredLevel then
		return true
	end
	return false
end

local lookAtDoor = Look()
function lookAtDoor.onLook(player, door)
	local forLevel = ""
	local requiredLevel = extractRequiredLevel(door)
	if requiredLevel then
		forLevel = T(" for level :level:", { level = requiredLevel })
	end

	player:sendTextMessage(MESSAGE_LOOK, T("You see :doorDesc::forLevel:.", { doorDesc = door:getNameDescription(), forLevel = forLevel }))
	return DONT_SHOW_ONLOOK
end
for closedId, openId in pairs(closedToOpen) do
	lookAtDoor:id(closedId)
	lookAtDoor:id(openId)
end
lookAtDoor:register()

local closedDoor = Action()
function closedDoor.onUse(player, door, fromPosition, target, toPosition, isHotkey)
	if not canPassDoor(player, door) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
		return false
	end

	door:transform(closedToOpen[door:getId()])
	door:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	player:teleportTo(toPosition, true)

	return true
end
for closedId, openId in pairs(closedToOpen) do
	closedDoor:id(closedId)
end
closedDoor:register()

local stepInOpenDoor = MoveEvent()
function stepInOpenDoor.onStepIn(creature, door, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local requiredLevel = tonumber(door:getKey())
	local playerLevel = creature:getLevel()
	if playerLevel >= requiredLevel then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
	player:teleportTo(fromPosition, true)
	return false
end
for openId, closedId in pairs(openToClosed) do
	stepInOpenDoor:id(openId)
end
stepInOpenDoor:type("stepin")
stepInOpenDoor:register()

local closedToOpen = {}
local openToClosed = {}
for _, value in pairs(QuestDoorTable) do
	closedToOpen[value.closedDoor] = value.openDoor
	closedToOpen[value.openDoor] = value.closedDoor
end

local closedDoor = Action()
function closedDoor.onUse(player, door, fromPosition, target, toPosition, isHotkey)
	local key = door:getKey()
	if player:getStorageValueByKey(key) == ACCESS_NOT_GRANTED then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		return true
	end
	door:transform(closedToOpen[door:getId()])
	door:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	player:teleportTo(toPosition, true)

	return true
end
for _, value in pairs(QuestDoorTable) do
	closedDoor:id(value.closedDoor)
end
closedDoor:register()

local openDoor = Action()
function openDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local key = item:getKey()
	if player:getStorageValueByKey(key) == ACCESS_NOT_GRANTED then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		return true
	end
	item:transform(openToClosed[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)

	if Creature.checkCreatureInsideDoor(player, toPosition) then
		return true
	end
	return true
end
for _, value in pairs(QuestDoorTable) do
	openDoor:id(value.openDoor)
end
openDoor:register()

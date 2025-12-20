local keyClosedToOpen = {}
local keyOpenToClosed = {}
for _, value in pairs(CustomDoorTable) do
	keyClosedToOpen[value.closedDoor] = value.openDoor
	keyOpenToClosed[value.openDoor] = value.closedDoor
end

local closedDoor = Action()
function closedDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(keyClosedToOpen[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	return true
end
for key, value in pairs(CustomDoorTable) do
	closedDoor:id(value.closedDoor)
end
closedDoor:register()

local openDoor = Action()
function openDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(keyOpenToClosed[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_OPEN_DOOR)
	Creature.checkCreatureInsideDoor(player, toPosition)
	return true
end
for _, value in pairs(CustomDoorTable) do
	openDoor:id(value.openDoor)
end
openDoor:register()

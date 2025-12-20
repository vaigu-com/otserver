local openToClosed = {}
local closedToOpen = {}
for _, doorData in pairs(LevelDoorTable) do
	closedToOpen[doorData.closedDoor] = doorData.openDoor
	openToClosed[doorData.openDoor] = doorData.closedDoor
end
for _, doorData in pairs(QuestDoorTable) do
	closedToOpen[doorData.closedDoor] = doorData.openDoor
	openToClosed[doorData.openDoor] = doorData.closedDoor
end
--[[
local closingDoor = MoveEvent()
for index, value in pairs(QuestDoorTable) do
	if not table.contains(doorIds, value.openDoor) then
		table.insert(doorIds, value.openDoor)
	end
end

function closingDoor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	for index, value in pairs(QuestDoorTable) do
		if value.openDoor == item.itemid then
			if player:getStorageValueByKey(item.actionid) ~= -1 then
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
				player:teleportTo(fromPosition, true)
				return false
			end
		end
	end
	return true
end
closingDoor:type("stepin")
for index, value in pairs(doorIds) do
	closingDoor:id(value)
end
closingDoor:register()
]]

local stepOutOpenDoor = MoveEvent()
function stepOutOpenDoor.onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local tile = Tile(position)

	if tile:getCreatureCount() > 0 then
		return true
	end

	local newPosition = { x = position.x + 1, y = position.y, z = position.z }
	local query = Tile(newPosition):queryAdd(creature)

	if query ~= RETURNVALUE_NOERROR or query == RETURNVALUE_NOTENOUGHROOM then
		newPosition.x = newPosition.x - 1
		newPosition.y = newPosition.y + 1
		query = Tile(newPosition):queryAdd(creature)
	end

	if query == RETURNVALUE_NOERROR or query ~= RETURNVALUE_NOTENOUGHROOM then
		position:relocateTo(newPosition)
	end

	local i, tileItem, tileCount = 1, true, tile:getThingCount()

	while tileItem and i < tileCount do
		tileItem = tile:getThing(i)
		if tileItem and tileItem:getUniqueId() ~= item.uid and tileItem:getType():isMovable() and not isCorpse(tileItem:getUniqueId()) then
			tileItem:remove()
		else
			i = i + 1
		end
	end

	item:transform(openToClosed[item:getId()])
	item:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_CLOSE_DOOR)
	return true
end
stepOutOpenDoor:type("stepout")
for openId in pairs(openToClosed) do
	stepOutOpenDoor:id(openId)
end
stepOutOpenDoor:register()

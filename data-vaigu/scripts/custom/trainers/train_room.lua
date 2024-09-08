local range = 15
local trainRoomPositions = {
	[1] = Position(5901, 1564, 10), -- mirko dp
	[2] = Position(5825, 1515, 8), -- mirko temple
	[3] = Position(6717, 1323, 8), -- hurghada
	[4] = Position(7049, 759, 7), -- kongo
	[5] = Position(5757, 1176, 5), -- bornholm
	--[6] = ,
}

-- Spawn Training Dummies
local setupTrainDummies = GlobalEvent("SetupTrainDummies")
function setupTrainDummies.onStartup()
	trainDummiesPositions = {}

	for _, roomPos in pairs(trainRoomPositions) do
		for i = roomPos.x - range, roomPos.x + range do
			for j = roomPos.y - range, roomPos.y + range do
				local pos = Position(i, j, roomPos.z)
				local tile = Tile(pos)
				if tile then
					local tileDummyId = tile:getItemById(5787)
					if tileDummyId then
						table.insert(trainDummiesPositions, pos)
					end
					-- Remove dummies (item)
					pos:removeItem(5787)
				end
			end
		end
	end

	-- Spawn training dummies (monster)
	for _, dummyPos in ipairs(trainDummiesPositions) do
		Game.createMonster("Training Dummy", dummyPos, true, true)
	end
end
setupTrainDummies:register()

-- Step on Training Room tiles
local trainEntrance = MoveEvent()
function trainEntrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	player:setStorageValue(Storage.TrainRoom, 1)
	player:setAttackSpeed(2500)
	return true
end
trainEntrance:type("stepin")
trainEntrance:aid(2400)
trainEntrance:register()

-- Step out of Training Room
local trainOut = MoveEvent()
function trainOut.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	player:setStorageValue(Storage.TrainRoom, 0)
	player:setAttackSpeed(2000)
	return true
end
trainOut:type("stepin")
trainOut:aid(2401)
trainOut:register()

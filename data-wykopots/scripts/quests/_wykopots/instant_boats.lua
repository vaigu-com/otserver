--[[
ToDo: create fields:
	positions,
	requiredState,
]] 

local boatsInit = {
	["Boat behind house, Island trolls archipelago"] = { Position(7143, 944, 7), Position(7014, 906, 7) },
	["Hellfire spawn cave entrance, Mercuru blob rocks"] = { Position(7468, 1014, 7), Position(7645, 974, 7) },
	["Nomad city, Amazon camp, Swamp trolls shore"] = { Position(7122, 1323, 7), Position(7181, 1272, 7), Position(7256, 1146, 8) },
	["Elf docks, Haunted treeling forest"] = { Position(7619, 1569, 7), Position(7606, 1654, 7) },
	["Orc port, Orc fortress"] = { Position(7804, 1381, 7), Position(7775, 1299, 7) },
	["Warlocks, Dark Magician ruins"] = { Position(7633, 1613, 8), Position(7724, 1629, 8) },
	["Tarnished spirit rocks, Feverish citizen peninsula, Stone Golem mountain"] = { Position(7578, 1268, 7), Position(7701, 1206, 7), Position(7682, 1178, 7) },
	["Orshaawa deep underground, "] = { Position(7644, 1837, 12), Position(7659, 1635, 14) },
	["Ruined ship, hermit cave"] = { Position(7375, 1441, 6), Position(7429, 1427, 7) },
	["Banshee caves, Grim reaper caves"] = { Position(7440, 1362, 10), Position(7451, 1376, 11) },
}

local boatsConfig = {}

local function loadBoats(boatConfigs)
	for _, config in pairs(boatConfigs) do
		for i = 1, #config do
			local fromPos = config[i]
			local toPos = config[i + 1] or config[1]

			local boatItem = fromPos:GetTopItem()
			boatItem:setActionId(Storage.InstantBoat)
			boatItem:setUniqueId(1000)

			boatsConfig[fromPos:ToString()] = { toPos = toPos, requiredState = config.requiredState }
		end
	end
end

local desertQuestInit = GlobalEvent("instantBoatsInit")
function desertQuestInit.onStartup()
	loadBoats(boatsInit)
end
desertQuestInit:register()

local boat = Action()
function boat.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if isPlayerPzLocked(player) then
		player:sendTextMessage(MESSAGE_FAILURE, "You can not use this after attacking another player.")
		return false
	end

	local boatIdentifier = fromPosition:ToString()
	local boatConfig = boatsConfig[boatIdentifier]
	local requiredStorages = boatConfig.requiredState
	if requiredStorages and not player:HasCorrectStorageValues(requiredStorages) then
		player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this yet.")
		return false
	end

	local toPos = boatConfig.toPos:FindAnyUnoccupiedSpot()
	player:teleportTo(toPos)
	toPos:sendMagicEffect(CONST_ME_TELEPORT)
end
boat:aid(Storage.InstantBoat)
boat:blockWalls()
boat:register()

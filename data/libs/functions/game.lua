function getGlobalStorage(key)
	local keyNumber = tonumber(key)
	if not keyNumber then
		key = "'" .. key .. "'"
	end
	local resultId = db.storeQuery("SELECT `value` FROM `global_storage` WHERE `key` = " .. key)
	if resultId ~= false then
		local isNumber = tonumber(Result.getString(resultId, "value"))
		if isNumber then
			local val = Result.getNumber(resultId, "value")
			Result.free(resultId)
			return val
		else
			local val = Result.getString(resultId, "value")
			Result.free(resultId)
			return val
		end
	end
	return -1
end

function setGlobalStorage(key, value)
	local keyNumber = tonumber(key)
	if not keyNumber then
		key = "'" .. key .. "'"
	end
	local valueNumber = tonumber(value)
	if not valueNumber then
		value = "'" .. value .. "'"
	end
	db.query("INSERT INTO `global_storage` (`key`, `value`) VALUES (" .. key .. ", " .. value .. ") ON DUPLICATE KEY UPDATE `value` = " .. value)
end

-- Vaigu custom
function Game.broadcastMessage(message, messageType, translate, context)
	if not messageType then
		messageType = MESSAGE_GAME_HIGHLIGHT
	end

	for _, player in ipairs(Game.getPlayers()) do
		local translatedMessage = message
		if translate then
			translatedMessage = player:Localizer(nil):Context(context):Get(message)
		end
		player:sendTextMessage(messageType, translatedMessage)
	end
end

function Game.convertIpToString(ip)
	local band = bit.band
	local rshift = bit.rshift
	return string.format("%d.%d.%d.%d", band(ip, 0xFF), band(rshift(ip, 8), 0xFF), band(rshift(ip, 16), 0xFF), rshift(ip, 24))
end

function Game.getHouseByPlayerGUID(playerGUID)
	local houses, house = Game.getHouses()
	for i = 1, #houses do
		house = houses[i]
		if house:getOwnerGuid() == playerGUID then
			return house
		end
	end
	return nil
end

function Game.getPlayersByIPAddress(ip, mask)
	if not mask then
		mask = 0xFFFFFFFF
	end
	local masked = bit.band(ip, mask)
	local result = {}
	local players, player = Game.getPlayers()
	for i = 1, #players do
		player = players[i]
		if bit.band(player:getIp(), mask) == masked then
			result[#result + 1] = player
		end
	end
	return result
end

function Game.getReverseDirection(direction)
	if direction == WEST then
		return EAST
	elseif direction == EAST then
		return WEST
	elseif direction == NORTH then
		return SOUTH
	elseif direction == SOUTH then
		return NORTH
	elseif direction == NORTHWEST then
		return SOUTHEAST
	elseif direction == NORTHEAST then
		return SOUTHWEST
	elseif direction == SOUTHWEST then
		return NORTHEAST
	elseif direction == SOUTHEAST then
		return NORTHWEST
	end
	return NORTH
end

function Game.getSkillType(weaponType)
	if weaponType == WEAPON_CLUB then
		return SKILL_CLUB
	elseif weaponType == WEAPON_SWORD then
		return SKILL_SWORD
	elseif weaponType == WEAPON_AXE then
		return SKILL_AXE
	elseif weaponType == WEAPON_DISTANCE or weaponType == WEAPON_MISSILE then
		return SKILL_DISTANCE
	elseif weaponType == WEAPON_SHIELD then
		return SKILL_SHIELD
	end
	return SKILL_FIST
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	return globalStorageTable[key] or -1
end

function Game.setStorageValue(key, value)
	if key == nil then
		logger.error("[Game.setStorageValue] Key is nil")
		return
	end

	if value == -1 then
		if globalStorageTable[key] then
			globalStorageTable[key] = nil
		end
		return
	end

	globalStorageTable[key] = value
end

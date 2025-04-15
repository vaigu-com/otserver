local keyToBossRoomData = {
	[28574] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, playerSpawnPosition = Position(6905, 2472, 11), centerPosition = Position(6998, 969, 11) },
	[28575] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, playerSpawnPosition = Position(6811, 2502, 11), centerPosition = Position(6893, 995, 11) },
	[28576] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, playerSpawnPosition = Position(6685, 2494, 11), centerPosition = Position(6784, 991, 9) },
}

local function roomIsFull(setting)
	local spectators = Game.getSpectators(setting.centerPosition, false, true, 15, 15)
	if #spectators >= 5 then
		return false
	end
	return true
end

local deeplingBossesEntranceTeleport = MoveEvent()
function deeplingBossesEntranceTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if os.time() < player:getStorageValueByKey(Storage.DeeplingBosses.DailyDeeplingKill) then
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
		player:sendCancelMessage("Try another day.")
		return true
	end

	local bossRoomData = keyToBossRoomData[item:getKey()]
	if roomIsFull(bossRoomData) then
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
		player:sendCancelMessage("Room is occupied.")
		return true
	end

	player:teleportTo(bossRoomData.playerSpawnPosition)
	player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
	return true
end

for key in pairs(keyToBossRoomData) do
	deeplingBossesEntranceTeleport:key(key)
end
deeplingBossesEntranceTeleport:register()

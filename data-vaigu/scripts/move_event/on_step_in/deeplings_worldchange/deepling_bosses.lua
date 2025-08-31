local uidToBossRoomData = {
	[28574] = { playerSpawnPosition = Position(33641, 31236, 11) },
	[28575] = { playerSpawnPosition = Position(33421, 31255, 11) },
	[28576] = { playerSpawnPosition = Position(33543, 31263, 11)},
}

local deeplingBosses = MoveEvent()

function deeplingBosses.onStepIn(creature, item, position, fromPosition)
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

	local bossRoomData = uidToBossRoomData[item:getKey()]
	player:teleportTo(bossRoomData.playerSpawnPosition, true)
	player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
	return true
end

for key in pairs(uidToBossRoomData) do
	deeplingBosses:uid(key)
end
deeplingBosses:register()

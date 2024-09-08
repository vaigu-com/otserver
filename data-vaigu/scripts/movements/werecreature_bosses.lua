local config = {
	[28580] = { value = 13, bossName = "Black Vixen" }, -- {x = 6210, y = 1085, z = 7}
	[28581] = { value = 13, bossName = "Sharpclaw" }, --
	[28582] = { value = 13, bossName = "Darkfang" }, --
	[28583] = { value = 13, bossName = "Bloodback" }, --
	[28584] = { value = 13, bossName = "Shadowpelt" }, --
}

local wereBosses = MoveEvent()

function wereBosses.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local function roomIsOccupied()
		local setting = config[item.actionid]
		local spectators = Game.getSpectators(Position(6210, 1085, 7), false, true, 9, 9)
		if #spectators ~= 0 then
			return true
		end
		return false
	end

	if player:isPzLocked() then
		player:sendTextMessage(MESSAGE_FAILURE, "You can not enter here after attacking another player.")
		player:teleportTo(fromPosition, true)
		return true
	end

	if player:getStorageValue(Storage.WereBossKill) == 1 then
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Try another day.")
		return true
	end

	if roomIsOccupied() then
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendCancelMessage("Room is occupied.")
		return true
	end

	local spectators, spectator = Game.getSpectators(Position(6210, 1085, 7), false, false, 9, 9, 9, 9)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end

	local setting = config[item.actionid]
	player:teleportTo(Position(6212, 1088, 7))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	Game.createMonster(setting.bossName, Position(6208, 1084, 7), true, true)
	return true
end

for index, value in pairs(config) do
	wereBosses:aid(index)
end

wereBosses:register()

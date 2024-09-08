local config = {
	[28574] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, position = Position(6993, 962, 11), centerPosition = Position(6998, 969, 11) }, --{x = 6993, y = 962, z = 11}{x = 6998, y = 969, z = 11}
	[28575] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, position = Position(6897, 989, 11), centerPosition = Position(6893, 995, 11) }, --{x = 6897, y = 989, z = 11} jaul{x = 6893, y = 995, z = 11} 2
	[28576] = { storage = Storage.DeeplingsWorldChange.Crystal, value = 13, position = Position(6772, 981, 9), centerPosition = Position(6784, 991, 9) }, --{x = 6772, y = 981, z = 9}{x = 6784, y = 991, z = 9}
}

local deeplingBosses = MoveEvent()

function deeplingBosses.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local function roomIsOccupied()
		local setting = config[item.actionid]
		local spectators = Game.getSpectators(setting.centerPosition, false, true, 15, 15)
		if #spectators >= 5 then
			return false
		end
		return true
	end

	local setting = config[item.actionid]
	if player:getStorageValue(Storage.DeeplingBosses.DailyDeeplingKill) ~= 1 then
		if roomIsOccupied() then
			player:teleportTo(setting.position)
			player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
			return true
		else
			player:teleportTo(fromPosition, true)
			player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
			player:sendCancelMessage("Room is occupied.")
			return true
		end
	else
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
		player:sendCancelMessage("Try another day.")
		return true
	end
end

for index, value in pairs(config) do
	deeplingBosses:aid(index)
end

deeplingBosses:register()

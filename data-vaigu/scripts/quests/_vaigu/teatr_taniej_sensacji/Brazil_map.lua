local updateStorages = {
	[Storage.TeatrTaniejSensacji.Questline] = 30,
	[Storage.TeatrTaniejSensacji.Mission10] = 3,
}

local map = Action()

function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TeatrTaniejSensacji.Mission10) ~= 2 then
		return
	end

	player:UpdateStorages(updateStorages)
	return true
end

map:aid(Storage.TeatrTaniejSensacji.BrazilMap)
map:register()

local updateStorages = {
	[Storage.TheaterOfCheapThrills.Questline] = 30,
	[Storage.TheaterOfCheapThrills.Mission10] = 3,
}

local map = Action()

function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheaterOfCheapThrills.Mission10) ~= 2 then
		return
	end

	player:UpdateStorages(updateStorages)
	return true
end

map:aid(Storage.TheaterOfCheapThrills.BrazilMap)
map:register()

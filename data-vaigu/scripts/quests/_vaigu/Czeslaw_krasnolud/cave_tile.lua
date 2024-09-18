local updateStorages = {
	[Storage.ChesterTheDwarf.Questline] = 7,
	[Storage.ChesterTheDwarf.Mission03] = 3,
}

local tile = MoveEvent()

function tile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local storageVal = player:getStorageValue(Storage.ChesterTheDwarf.Questline)
	if storageVal == 6 then
		player:UpdateStorages(updateStorages)
		player:say(player:Localizer(Storage.ChesterTheDwarf.Questline):Get("This just might be the place Chester was talking about"), TALKTYPE_MONSTER_SAY)
	end
	return true
end

tile:aid(Storage.ChesterTheDwarf.CaveTile)
tile:type("stepin")
tile:register()

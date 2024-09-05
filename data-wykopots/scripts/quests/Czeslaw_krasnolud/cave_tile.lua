local updateStorages = {
	[Storage.CzeslawKrasnolud.Questline] = 7,
	[Storage.CzeslawKrasnolud.Mission03] = 3,
}

local tile = MoveEvent()

function tile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local storageVal = player:getStorageValue(Storage.CzeslawKrasnolud.Questline)
	if storageVal == 6 then
		player:UpdateStorages(updateStorages)
		player:say(player:Localizer(Storage.CzeslawKrasnolud.Questline):Get("This just might be the place Chester was talking about"), TALKTYPE_MONSTER_SAY)
	end
	return true
end

tile:aid(Storage.CzeslawKrasnolud.CaveTile)
tile:type("stepin")
tile:register()

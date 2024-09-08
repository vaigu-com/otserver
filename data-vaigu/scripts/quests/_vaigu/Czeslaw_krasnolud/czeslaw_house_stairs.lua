local tile = MoveEvent()

function tile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.CzeslawKrasnolud.Questline) >= 8 then
		player:teleportTo(fromPosition, true)
		player:say(player:Localizer(Storage.CzeslawKrasnolud.Questline):Get("Chester's house is vacant right now. Therefore it would be impolite to tresspass."), TALKTYPE_MONSTER_SAY)
	end
	return true
end

tile:aid(Storage.CzeslawKrasnolud.CzeslawHouseStairs)
tile:type("stepin")
tile:register()

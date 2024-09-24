local tile = MoveEvent()

function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline) ~= 13 then
		return
	end

	local aid = item:getActionId()
	if Game.getStorageValue(aid) == 1 then
		return
	end
	if Game.createMonster("petrus ciemiezca", player:getPosition()) then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		Game.setStorageValue(aid, 1)
	end
end

tile:aid(Storage.SafetyAndOccupationalHygiene.Spawns.Petrus)
tile:register()

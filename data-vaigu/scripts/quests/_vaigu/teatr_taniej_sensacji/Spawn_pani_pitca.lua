local tile = MoveEvent()

function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.TeatrTaniejSensacji.Mission03) ~= 2 then
		return
	end

	local aid = item:getActionId()
	if Game.getStorageValue(aid) == 1 then
		return
	end
	if Game.createMonster("pani pitca", player:getPosition()) then
		Game.setStorageValue(aid, 1)
	end
end

tile:aid(Storage.TeatrTaniejSensacji.Spawns.PaniPitca)
tile:register()

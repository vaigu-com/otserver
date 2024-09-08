local tile = MoveEvent()

function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	local aid = item:getActionId()
	if not player:isPlayer() then
		return false
	end

	if not (player:getStorageValue(Storage.TeatrTaniejSensacji.Mission07) == 2) then
		return
	end

	if Game.getStorageValue(aid) == 1 then
		return
	end

	if Game.createMonster("Robercik", player:getPosition()) then
		Game.setStorageValue(aid, 1)
	end
end

tile:aid(Storage.TeatrTaniejSensacji.Spawns.Robercik)
tile:register()

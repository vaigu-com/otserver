	:Script(function(storageToRequiredState)
local tile = MoveEvent()

function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.TheaterOfCheapThrills.Mission03) ~= 2 then
		return
	end

	local aid = item:getActionId()
	if Game.getStorageValue(aid) == 1 then
		return
	end
	if Game.createMonster("Miss Pitca", player:getPosition()) then
		Game.setStorageValue(aid, 1)
	end
end

tile:aid(Storage.TheaterOfCheapThrills.Spawns.MissPizza)
tile:register()
end)

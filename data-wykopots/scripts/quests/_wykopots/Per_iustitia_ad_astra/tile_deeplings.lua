local updateStorages = {
	[Storage.PerIustitiaAdAstra.Questline] = 7,
	[Storage.PerIustitiaAdAstra.Mission03] = 2,
	[Storage.PerIustitiaAdAstra.ShipDestinations.Deeplings] = 1,
	[Storage.PerIustitiaAdAstra.ShipDestinations.FuelShop] = 1,
}

local deeplingTile = MoveEvent()
function deeplingTile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) == 6 then
		player:UpdateStorages(updateStorages)
	end
end

deeplingTile:aid(Storage.PerIustitiaAdAstra.DeeplingTile)
deeplingTile:register()

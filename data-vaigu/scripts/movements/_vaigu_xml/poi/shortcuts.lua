local storages = {
	[2064] = Storage.PitsOfInferno.ShortcutHub,
	[2065] = Storage.PitsOfInferno.ShortcutLevers,
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local cutoffStorage = storages[item.actionid]
	if player:getStorageValue(cutoffStorage) ~= 1 then
		player:setStorageValue(cutoffStorage, 1)
	end
	return true
end

movement:type("stepin")
movement:aid(2064, 2065)
movement:register()

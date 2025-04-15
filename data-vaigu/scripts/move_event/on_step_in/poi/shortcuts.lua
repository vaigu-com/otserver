local storages = {
	[8816] = Storage.PitsOfInferno.ShortcutHub,
	[8817] = Storage.PitsOfInferno.ShortcutLevers,
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local cutoffStorage = storages[item.actionid]
	if player:getStorageValueByKey(cutoffStorage) ~= 1 then
		player:setStorageValueByKey(cutoffStorage, 1)
	end
	return true
end

movement:type("stepin")
movement:aid(8816, 8817)
movement:register()

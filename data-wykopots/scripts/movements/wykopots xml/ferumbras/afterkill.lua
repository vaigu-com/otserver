local config = {
	[60000] = { pos = Position(7500, 1739, 12), storage = Storage.Ferumbras.PlagirathTp, globalStorage = GlobalStorage.Ferumbras.PlagirathTp }, --{x = 7500, y = 1739, z = 12}
	[60001] = { pos = Position(7361, 1831, 11), storage = Storage.Ferumbras.ZamuloshTp, globalStorage = GlobalStorage.Ferumbras.ZamuloshTp }, --{x = 7361, y = 1831, z = 11}
	[60002] = { pos = Position(7332, 1715, 14), storage = Storage.Ferumbras.MazoranTp, globalStorage = GlobalStorage.Ferumbras.MazoranTp }, --{x = 7332, y = 1715, z = 14}
	[60003] = { pos = Position(7145, 1779, 12), storage = Storage.Ferumbras.RazzagornTp, globalStorage = GlobalStorage.Ferumbras.RazzagornTp }, --{x = 7145, y = 1779, z = 12}
	[60004] = { pos = Position(7251, 1730, 12), storage = Storage.Ferumbras.RagiazTp, globalStorage = GlobalStorage.Ferumbras.RagiazTp }, --{x = 7251, y = 1730, z = 12}
	[60005] = { pos = Position(7248, 1943, 12), storage = Storage.Ferumbras.BossCountTarbaz, globalStorage = GlobalStorage.Ferumbras.TarbazTp }, --{x = 7248, y = 1943, z = 12}
	[60006] = { pos = Position(7281, 1912, 13), storage = Storage.Ferumbras.ShulgraxTp, globalStorage = GlobalStorage.Ferumbras.ShulgraxTp }, --{x = 7281, y = 1912, z = 13}
	[60007] = { pos = Position(7555, 1837, 14), storage = Storage.Ferumbras.FerumbrasMortalTp, globalStorage = GlobalStorage.Ferumbras.FerumbrasMortalTp }, --{x = 7555, y = 1837, z = 14}
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	if targetPosition then
		if Game.getStorageValue(targetPosition.globalStorage) >= os.time() then
			player:teleportTo(targetPosition.pos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(Position(7097, 1713, 12)) -- po 3min nie tpuje dalej
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	return true
end

movement:type("stepin")

for index, value in pairs(config) do
	movement:aid(index)
end

movement:register()

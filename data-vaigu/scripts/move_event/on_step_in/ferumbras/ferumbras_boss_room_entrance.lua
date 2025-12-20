local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if
		player:getStorageValueByKey(Storage.Ferumbras.BossCountPlagirath) == 1 --BossCountPlagirath
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountZamulosh) == 1 --BossCountZamulosh
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountMazoran) == 1 --BossCountMazoran
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountRazzagorn) == 1 --BossCountRazzagorn
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountRagiaz) == 1 --BossCountRagiaz
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountTarbaz) == 1 --BossCountTarbaz
		and player:getStorageValueByKey(Storage.Ferumbras.BossCountShulgrax) == 1
	then --BossCountShulgrax
		player:teleportTo(Position(7460, 1879, 12)) --{x = 7460, y = 1879, z = 12}
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition) --{x = 6730, y = 1281, z = 8}
		player:sendCancelMessage("Musisz przeteleportowac wszystkie 7 artefaktow, aby przejsc dalej.") -- po uzyciu kazdego artefaktu
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
movement:type("stepin")
movement:aid(45791)
movement:register()

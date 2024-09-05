local retroMirkoPos = RETRO_MIRKO_ANCHOR:Moved({ x = -46, y = -68, z = -2 })

local lever = Action()

function lever.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end
	if player:getStorageValue(Storage.SultanPrime.Mission03) < 1 then
		return true
	end

	player:teleportTo(retroMirkoPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

lever:aid(Storage.SultanPrime.RetroLever)
lever:register()

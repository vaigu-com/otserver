local surfaceZ = JANUSZEX_ANCHOR:Moved(0, 0, 2).z
local function isOnSurface(pos)
	return pos.z == surfaceZ
end

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local playerPos = player:getPosition()

	local offsetZ = -3
	if isOnSurface(playerPos) then
		offsetZ = 3
	end

	local newPos = playerPos:Moved(0, 0, offsetZ)
	player:teleportTo(newPos, true)
	newPos:sendMagicEffect(CONST_ME_WATERSPLASH)
	return true
end
lever:aid(Storage.ProdigalSon.SewersLever)
lever:register()

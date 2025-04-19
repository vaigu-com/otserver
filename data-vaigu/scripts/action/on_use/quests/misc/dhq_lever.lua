Storage.DhqLever = {}

local stoneId =1842
local stonePos = Position(5670, 1379, 15)

local teleportId= 1949
local teleportPos = Position(5671, 1377, 15)
local teleportDest = Position(5684, 1396, 14)

local action = Action()

function action.onUse(player, lever, fromPosition, target, toPosition, isHotkey)
	local stone = stonePos:GetItemById(stoneId)
	if stone then
		stone:remove()
	else
		Game.createItem(stoneId, 1, stonePos)
		stonePos:sendMagicEffect(CONST_ME_POFF)
	end

	local teleport = teleportPos:GetItemById(teleportId)
	if teleport then
		teleportPos:sendMagicEffect(CONST_ME_TELEPORT)
		teleport:remove()
	else
		teleportPos:sendMagicEffect(CONST_ME_TELEPORT)
		Game.createItem(teleportId, 1, teleportPos):setDestination(teleportDest)
	end
	FlipLever(lever)

	return true
end

action:key(Storage.DhqLever)
action:register()

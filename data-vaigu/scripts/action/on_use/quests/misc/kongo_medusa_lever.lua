Storage.KongoMedusaLever = {}

local stonePos = Position(6733, 803, 10)
local stoneId = 1791

local action = Action()
function action.onUse(player, lever, fromPosition, target, toPosition, isHotkey)
	local stone = stonePos:GetItemById(stoneId)
	if stone then
		stone:remove()
	else
		Game.createItem(stoneId, 1, stonePos)
	end
	stonePos:sendMagicEffect(CONST_ME_PLANTATTACK)
	FlipLever(lever)
	return true
end
action:key(Storage.KongoMedusaLever)
action:register()

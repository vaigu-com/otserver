Storage.OrcCrusaderHelmetLever = {}

local wallId = 6283
local wallPos = Position(5773, 1321, 10)

local action = Action()
function action.onUse(player, lever, fromPosition, target, toPosition, isHotkey)
	local wall = wallPos:GetItemById(wallId)
	if wall then
		wall:remove()
	else
		Game.createItem(wallId, 1, wallPos)
	end
	wallPos:sendMagicEffect(CONST_ME_BLOCKHIT)
	FlipLever(lever)
	return true
end

action:key(Storage.OrcCrusaderHelmetLever)
action:register()

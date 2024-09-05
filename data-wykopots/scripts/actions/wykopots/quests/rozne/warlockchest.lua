local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(player)
	local destination = Position(6163, 1319, 14)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_PURPLEENERGY)
	return true
end

action:uid(2210)
action:register()

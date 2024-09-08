local drawWellDown = Action()

function drawWellDown.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getActionId() ~= 1111 then
		return false
	end

	fromPosition.z = fromPosition.z + 1
	player:teleportTo(fromPosition)
	return true
end

drawWellDown:id(1931)
drawWellDown:register()
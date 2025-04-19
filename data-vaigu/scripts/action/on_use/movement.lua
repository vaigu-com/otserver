local useUp = Action()
function useUp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    fromPosition:moveUpstairs()

	if player:isPzLocked() and Tile(fromPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
		return true
	end

	player:teleportTo(fromPosition, true)
	return true
end
useUp:key(USE_UP)
useUp:register()

local useDown = Action()
function useDown.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	fromPosition.z = fromPosition.z + 1

	if player:isPzLocked() and Tile(fromPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
		return true
	end

	player:teleportTo(fromPosition, true)
	return true
end
useDown:key(USE_DOWN)
useDown:register()

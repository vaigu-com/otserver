local templeScroll = Action()

function templeScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isPlayerPzLocked(player) then
		player:sendCancelMessage("You cant use temple scroll while in fight.")
		return true
	end

	if player:getStorageValue(Storage.templeScroll) >= os.time() then
		player:sendCancelMessage("You already used temple scroll in last 5 minutes.")
		return true
	end

	local playerPos = player:getPosition()
	local tile = Tile(playerPos)
	if not tile or tile:hasFlag(TILESTATE_NOLOGOUT) then
		player:sendCancelMessage("You cant use temple scroll in no logout zone.")
		return true
	end

	local town = player:getTown()
	local templePos = town:getTemplePosition()
	player:teleportTo(templePos)
	templePos:sendMagicEffect(CONST_ME_TELEPORT)
	player:setStorageValue(Storage.templeScroll, os.time() + 5 * 60)
end

templeScroll:id(25718)
templeScroll:register()

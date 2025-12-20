Storage.BootsOfHomecoming = {}

local ferumbrasAscendantHomeComing = Action()
function ferumbrasAscendantHomeComing.onUse(player, usedItem, fromPosition, target, toPosition, isHotkey)
	local equippedBoots = player:getSlotItem(CONST_SLOT_FEET)
	if equippedBoots ~= usedItem then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to equip the boot to try use it.")
		return false
	end
	if not player:isLockoutExpired(Storage.BootsOfHomecoming) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are tired of the last use of the boots. Try again tomorrow.")
		return false
	end
	if isPlayerPzLocked(player) then
		SendPlayerIsPzLocked(player)
		return false
	end
	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are tired of the last use of the boots. Try again tomorrow.")
		player:sendCancelMessage("You cant use temple scroll while in fight.")
		return false
	end

	player:setLockoutExpiry(Storage.BootsOfHomecoming, LOCKOUT_EXPIRY_TIME.DAILY)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	local templePos = player:getTown():getTemplePosition()
	player:teleportTo(templePos)
	templePos:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Magical sparks whirl around the boots and suddenly you are somewhere else.")
	return true
end

ferumbrasAscendantHomeComing:id(22773, 22774)
ferumbrasAscendantHomeComing:register()

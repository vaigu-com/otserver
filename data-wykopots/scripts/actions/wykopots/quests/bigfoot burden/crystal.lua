local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local repairedCount = player:getStorageValue(Storage.BigfootBurden.RepairedCrystalCount)
	if repairedCount == 5 or player:getStorageValue(Storage.BigfootBurden.MissionCrystalKeeper) ~= 1 then
		return false
	end

	if target.itemid == 15796 or target.itemid == 15712 then
		player:setStorageValue(Storage.BigfootBurden.RepairedCrystalCount, repairedCount + 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Naprawiles zniszczony krysztal.")
		target:transform(15800)
		target:decay()
		toPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	elseif isInArray({ 15797, 15798, 15799, 15800 }, target.itemid) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "To nie ten!")
	end
	return true
end

action:id(15703)
action:register()

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target:isCreature() or not target:isMonster() then
		return true
	end

	if player:getStorageValueByKey(Storage.BigfootsBurden.GolemCount) < 4 and player:getStorageValueByKey(Storage.BigfootsBurden.MissionTinkersBell) == 1 and target:getName():lower() == "damaged crystal golem" then
		player:setStorageValueByKey(Storage.BigfootsBurden.GolemCount, player:getStorageValueByKey(Storage.BigfootsBurden.GolemCount) + 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Golem powraca do warsztatu.")
		target:remove()
		toPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

action:id(15832)
action:register()

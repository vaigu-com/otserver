local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target:isCreature() or not target:isMonster() then
		return true
	end

	if player:getStorageValue(Storage.BigfootBurden.GolemCount) < 4 and player:getStorageValue(Storage.BigfootBurden.MissionTinkersBell) == 1 and target:getName():lower() == "damaged crystal golem" then
		player:setStorageValue(Storage.BigfootBurden.GolemCount, player:getStorageValue(Storage.BigfootBurden.GolemCount) + 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Golem powraca do warsztatu.")
		target:remove()
		toPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

action:id(15832)
action:register()

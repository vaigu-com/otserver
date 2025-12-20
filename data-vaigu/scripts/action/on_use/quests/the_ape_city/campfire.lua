local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheApeCity.QuestProgress) <= 13 then
		player:setStorageValueByKey(Storage.TheApeCity.CampfireMission, 2)
		item:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
	end
	return true
end
action:aid(2152)
action:register()

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.BigfootsBurden.GrindstoneStatus) == 1 or player:getStorageValueByKey(Storage.BigfootsBurden.MissionGrindstoneHunt) ~= 1 then
		return false
	end

	toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
	item:transform(15824)

	if math.random(2) ~= 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tym razem ci sie nie poszczescilo.")
		return true
	end

	player:setStorageValueByKey(Storage.BigfootsBurden.GrindstoneStatus, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Twoja zwinnosc pozwolila zlapac kamien nim wpadl do lawy.")
	player:AddCustomItem({id = 15826, count = 1})
	return true
end

action:id(15825)
action:register()

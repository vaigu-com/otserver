local crystaldeepling = Action()
function crystaldeepling.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local posMonster = player:getPosition()
	if player:getStorageValueByKey(Storage.DeeplingsWorldChange.Crystal) == 9 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Suddenly a guard jumps at you from behind!")
		Game.createMonster("Deepling Worker", posMonster)
		player:setStorageValueByKey(Storage.DeeplingsWorldChange.Crystal, 10)
	elseif player:getStorageValueByKey(Storage.DeeplingsWorldChange.Crystal) == 10 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fail.")
		player:setStorageValueByKey(Storage.DeeplingsWorldChange.Crystal, 11)
	elseif player:getStorageValueByKey(Storage.DeeplingsWorldChange.Crystal) == 11 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Yeah.")
		player:AddCustomItem({id = 14165, count = 1})
		player:setStorageValueByKey(Storage.DeeplingsWorldChange.Crystal, 12)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sorry.")
	end
	return true
end
crystaldeepling:aid(28572)
crystaldeepling:register()

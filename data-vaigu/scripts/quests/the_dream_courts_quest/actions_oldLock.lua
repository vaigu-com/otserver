local doorPosition = Position(32091, 31970, 14)
local keysCount = Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Count

local actions_oldLock = Action()

function actions_oldLock.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

	if target:getPosition() == doorPosition then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You insert the old lock into the door. It fits perfectly.")
		player:addAchievement("Keeper of the 7 Keys")
		player:setStorageValueByKey(keysCount, 7)
		player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Questline, 2)
		player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.OldLockRoom, ACCESS_GRANTED)
	end

	return true
end

actions_oldLock:id(29992)
actions_oldLock:register()

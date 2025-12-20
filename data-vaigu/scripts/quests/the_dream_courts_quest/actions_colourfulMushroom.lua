local actions_colourfulMushroom = Action()

function actions_colourfulMushroom.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.MushRoom) ~= ACCESS_GRANTED then
		player:removeItem(30009, 1)
		player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.MushRoom, ACCESS_GRANTED)
		return true
	end
end

actions_colourfulMushroom:id(30009)
actions_colourfulMushroom:register()

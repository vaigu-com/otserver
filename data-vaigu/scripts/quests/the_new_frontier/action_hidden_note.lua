local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier

local hiddenNote = Action()

function hiddenNote.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(TheNewFrontier.Mission07.HiddenNote) < 1 then
		player:AddCustomItem({id = 8747, count = 1, text = "Go to the secret door to the north"})
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a piece of paper.")
		player:setStorageValueByKey(TheNewFrontier.Mission07.HiddenNote, 1)
		return true
	end
end

hiddenNote:position(Position(33165, 31249, 11))
hiddenNote:register()

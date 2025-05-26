local cToneStorages = {
	Storage.BigfootsBurden.MelodyTone1,
	Storage.BigfootsBurden.MelodyTone2,
	Storage.BigfootsBurden.MelodyTone3,
	Storage.BigfootsBurden.MelodyTone4,
	Storage.BigfootsBurden.MelodyTone5,
	Storage.BigfootsBurden.MelodyTone6,
	Storage.BigfootsBurden.MelodyTone7,
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.BigfootsBurden.QuestLine) == 12 then
		local value = player:getStorageValueByKey(Storage.BigfootsBurden.MelodyStatus)
		if player:getStorageValueByKey(cToneStorages[value]) == item.uid then
			player:setStorageValueByKey(Storage.BigfootsBurden.MelodyStatus, value + 1)
			toPosition:sendMagicEffect(CONST_ME_FIREWORK_BLUE)
			if value + 1 == 8 then
				player:setStorageValueByKey(Storage.BigfootsBurden.QuestLine, 13)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Co za melodia!")
			end
		else
			player:setStorageValueByKey(Storage.BigfootsBurden.MelodyStatus, 1)
			toPosition:sendMagicEffect(CONST_ME_SOUND_RED)
		end
	end
	return true
end

action:uid(3124, 3125, 3126, 3127)
action:register()

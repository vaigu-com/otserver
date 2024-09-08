local cToneStorages = {
	Storage.BigfootBurden.MelodyTone1,
	Storage.BigfootBurden.MelodyTone2,
	Storage.BigfootBurden.MelodyTone3,
	Storage.BigfootBurden.MelodyTone4,
	Storage.BigfootBurden.MelodyTone5,
	Storage.BigfootBurden.MelodyTone6,
	Storage.BigfootBurden.MelodyTone7,
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 12 then
		local value = player:getStorageValue(Storage.BigfootBurden.MelodyStatus)
		if player:getStorageValue(cToneStorages[value]) == item.uid then
			player:setStorageValue(Storage.BigfootBurden.MelodyStatus, value + 1)
			toPosition:sendMagicEffect(CONST_ME_FIREWORK_BLUE)
			if value + 1 == 8 then
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 13)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Co za melodia!")
			end
		else
			player:setStorageValue(Storage.BigfootBurden.MelodyStatus, 1)
			toPosition:sendMagicEffect(CONST_ME_SOUND_RED)
		end
	end
	return true
end

action:uid(3124, 3125, 3126, 3127)
action:register()

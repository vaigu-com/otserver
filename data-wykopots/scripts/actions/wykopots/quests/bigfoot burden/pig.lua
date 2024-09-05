local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 15830 then
		return false
	end

	local mushroomCount = player:getStorageValue(Storage.BigfootBurden.MushroomCount)
	if mushroomCount == 3 or player:getStorageValue(Storage.BigfootBurden.MissionMushroomDigger) ~= 1 then
		return false
	end

	player:setStorageValue(Storage.BigfootBurden.MushroomCount, mushroomCount + 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Swinka zjadla trufle.")
	target:transform(15829)
	toPosition:sendMagicEffect(CONST_ME_GROUNDSHAKER)
	return true
end

action:id(15828)
action:register()

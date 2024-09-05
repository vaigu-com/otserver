local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 16197 then
		return false
	end

	local extractedCount = player:getStorageValue(Storage.BigfootBurden.ExtractedCount)
	if extractedCount == 7 or player:getStorageValue(Storage.BigfootBurden.MissionRaidersOfTheLostSpark) ~= 1 then
		return false
	end

	player:setStorageValue(Storage.BigfootBurden.ExtractedCount, math.max(0, extractedCount) + 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Znalazles iskre.")
	target:transform(16195)
	toPosition:sendMagicEffect(CONST_ME_ENERGYHIT)
	return true
end

action:id(15696)
action:register()

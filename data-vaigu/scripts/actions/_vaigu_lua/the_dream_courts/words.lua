local config = {
	[7913] = { storage = Storage.TheDreamCourts.CathedralWords.Word1 },
	[7914] = { storage = Storage.TheDreamCourts.CathedralWords.Word2 },
	[7915] = { storage = Storage.TheDreamCourts.CathedralWords.Word3 },
	[7916] = { storage = Storage.TheDreamCourts.CathedralWords.Word4 },
}

local facelesswords = Action()
function facelesswords.onUse(player, item, fromPosition, itemEx, toPosition)
	local targetItem = config[item.uid]
	if not targetItem then
		return true
	end

	if player:getStorageValue(targetItem.storage) <= 0 then
		if player:getStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords) <= 0 then
			player:setStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords, 1)
		else
			player:setStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords, (player:getStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords) + 1))
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Odnalazles slowo.")
		player:setStorageValue(targetItem.storage, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "To juz wiem..")
	end
	return true
end
facelesswords:uid(7913, 7914, 7915, 7916)
facelesswords:register()

local facelessbook = Action()
function facelessbook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords) <= 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nic tu po mnie..")
	elseif player:getStorageValue(Storage.TheDreamCourts.CathedralWords.CathedralWords) >= 4 then
		player:teleportTo(Position(5894, 778, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
facelessbook:uid(7917)
facelessbook:register()

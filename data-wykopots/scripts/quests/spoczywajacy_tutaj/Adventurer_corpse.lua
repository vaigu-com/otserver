local updateStorages = {
	[Storage.SpoczywajacyTutaj.Questline] = 6,
	[Storage.SpoczywajacyTutaj.Mission01] = 3,
	[Storage.Finished.SpoczywajacyTutaj] = 1,
}

local coffin = Action()

function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storageVal = player:getStorageValue(Storage.SpoczywajacyTutaj.Questline)
	if storageVal == 5 then
		if player:TryAddItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS["torch"], SPOCZYWAJACY_TUTAJ_KEY_ITEMS["contract"] }) then
			player:UpdateStorages(updateStorages)
			player:addOutfit(574)
			player:addOutfit(575)
			player:addExperience(30000)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have gained " .. 30000 .. " experience")
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
		end
	end
	return false
end

coffin:aid(Storage.SpoczywajacyTutaj.Corpse)
coffin:register()

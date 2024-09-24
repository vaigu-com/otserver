	:Script(function(storageToRequiredState)
local updateStorages = {
	[Storage.ImRestingHere.Mission01] = 3,
}

local coffin = Action()

function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storageVal = player:getStorageValue(Storage.ImRestingHere.Mission01)
	if storageVal ~= 2 then
		return false
	end
	if player:TryAddItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.torch, SPOCZYWAJACY_TUTAJ_KEY_ITEMS.contract }) then
		player:UpdateStorages(updateStorages)
		player:addOutfit(574)
		player:addOutfit(575)
		player:AddExperienceWithAnnouncement(30000)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return false
end

coffin:aid(Storage.ImRestingHere.Corpse)
coffin:register()
end)

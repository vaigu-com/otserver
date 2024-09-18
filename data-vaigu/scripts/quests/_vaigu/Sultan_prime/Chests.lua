local corpse = Action()

local neckUpdateStorages = {
	[Storage.SultanPrime.Questline] = 1,
	[Storage.SultanPrime.Mission01] = 1,
	[Storage.SultanPrime.RewardsScripted.Necklace] = 2,
}

local necklaceStorage = Storage.SultanPrime.RewardsScripted.Necklace

function corpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(necklaceStorage) < 1 then
		player:AddItems({ SULTAN_PRIME_KEY_ITEMS.amulet })
		player:UpdateStorages(neckUpdateStorages)
		return true
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
	return true
end

corpse:aid(Storage.SultanPrime.RewardsScripted.Necklace)
corpse:register()

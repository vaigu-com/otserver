local moonlightCrystals = Action()

function moonlightCrystals.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 22060 then -- werewolf amulet
		target:remove()
		player:AddCustomItem({ id = 22061, count = 1 })
		item:remove(1)
		player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
		return true
	elseif target.itemid == 22062 then -- werewolf helmet
		if player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) < 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Visit Madame Malkin to select enchant first.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) == 1 then
			target:remove() -- Magic level helmet
			player:AddCustomItem({ id = 24783, count = 1 })
			item:remove(1)
		elseif player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) == 2 then
			target:remove() -- Paladin helmet
			player:AddCustomItem({ id = 22132, count = 1 })
			item:remove(1)
		elseif player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) == 3 then
			target:remove() -- Knight club
			player:AddCustomItem({ id = 22128, count = 1 })
			item:remove(1)
		elseif player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) == 4 then
			target:remove() -- Knight axe
			player:AddCustomItem({ id = 22130, count = 1 })
			item:remove(1)
		elseif player:getStorageValueByKey(Storage.Grimvale.WereHelmetEnchant) == 5 then
			target:remove() -- Knight sword
			player:AddCustomItem({ id = 22129, count = 1 })
			item:remove(1)
		else
			return false
		end
		player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
		return true
	end
	return false
end

moonlightCrystals:id(22083)
moonlightCrystals:register()

local moonlightCrystals = Action()

function moonlightCrystals.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 22060 then
		target:remove()
		player:AddCustomItem({id = 22061, count = 1})
		item:remove(1)
		return true
	elseif target.itemid == 22062 then
		if (player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 0) or (player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 1) then
			target:remove() -- Magic level helmet
			player:AddCustomItem({id = 24783, count = 1})
			item:remove(1)
		elseif player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 2 then
			target:remove() -- Paladin helmet
			player:AddCustomItem({id = 22132, count = 1})
			item:remove(1)
		elseif player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 3 then
			target:remove() -- Knight club
			player:AddCustomItem({id = 22128, count = 1})
			item:remove(1)
		elseif player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 4 then
			target:remove() -- Knight axe
			player:AddCustomItem({id = 22130, count = 1})
			item:remove(1)
		elseif player:getStorageValue(Storage.Quest.U10_80.GrimvaleQuest.WereHelmetEnchant) == 5 then
			target:remove() -- Knight sword
			player:AddCustomItem({id = 22129, count = 1})
			item:remove(1)
		else
			return false
		end
		return true
	end
	return false
end

moonlightCrystals:id(22083)
moonlightCrystals:register()

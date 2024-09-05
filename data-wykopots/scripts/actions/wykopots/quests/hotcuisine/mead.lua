local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.uid == 8000 and item.itemid == 7140 then
		if player:getStorageValue(Storage.MeadVial) >= os.time() then
			player:say("Ehh, juz jest pusta.", TALKTYPE_MONSTER_SAY)
			return false
		end
	end
	if target.uid == 8000 and item.itemid == 7140 then
		item:remove()
		player:addItem(7141)
		player:setStorageValue(Storage.MeadVial, os.time() + 22 * 3600)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
	end
	return true
end

action:id(7140)
action:register()

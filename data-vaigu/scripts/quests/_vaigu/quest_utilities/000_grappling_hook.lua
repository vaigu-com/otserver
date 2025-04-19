Storage.GrapplingHook = {}
Storage.GrapplingBook = {}

local exerciseWeaponBox = Action()
function exerciseWeaponBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	player:setStorageValueByKey(Storage.GrapplingHook, ACCESS_GRANTED)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You learned how to use the grappling hooks.")
    fromPosition:sendMagicEffect(CONST_ME_STUN)
    item:remove()
end

exerciseWeaponBox:key(Storage.GrapplingBook)
exerciseWeaponBox:register()

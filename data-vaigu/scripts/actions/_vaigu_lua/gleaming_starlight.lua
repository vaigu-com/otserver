local gleamingStarlight = Action()

function gleamingStarlight.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 3613 then
		--target:remove(1)
		item:remove(1)
		player:addItem(25976)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		return true
	end
end

gleamingStarlight:id(25732)
gleamingStarlight:register()

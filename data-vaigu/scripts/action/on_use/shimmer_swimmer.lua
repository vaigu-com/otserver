local shimmerItems = { 12737, 12730, 12805, 12806, 12742 }
local shimmerSwimmer = Action()

function shimmerSwimmer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArray(shimmerItems, target.itemid) then
		target:remove(1)
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		if target.itemid == 12737 then
			player:AddCustomItem({id = 12741})
		elseif target.itemid == 12730 then
			player:AddCustomItem({id = 12735})
		elseif target.itemid == 12805 then
			player:AddCustomItem({id = 12733})
		elseif target.itemid == 12806 then
			player:AddCustomItem({id = 12731})
		elseif target.itemid == 12742 then
			player:AddCustomItem({id = 12732})
		end
	elseif target.itemid == 7841 or target.itemid == 7842 then
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		player:AddCustomItem({id = 12807})
		return true
	end
end

shimmerSwimmer:id(12557)
shimmerSwimmer:register()

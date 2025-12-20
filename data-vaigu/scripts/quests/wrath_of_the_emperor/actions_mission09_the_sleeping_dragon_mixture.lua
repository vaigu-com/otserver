local wrathEmperorMiss9Sleeping = Action()
function wrathEmperorMiss9Sleeping.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.Quest.U8_6.WrathOfTheEmperor.InterdimensionalPotion) == 1 then
		return true
	end

	player:setStorageValueByKey(Storage.Quest.U8_6.WrathOfTheEmperor.InterdimensionalPotion, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

	item:remove()
	return true
end

wrathEmperorMiss9Sleeping:id(11372)
wrathEmperorMiss9Sleeping:register()

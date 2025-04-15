local piggyBank = Action()

function piggyBank.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if math.random(6) == 1 then
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		item:transform(2996)

		player:AddCustomItem({id = ITEM_GOLD_COIN, count = 1})
		player:addAchievementProgress("Allowance Collector", 50)
	else
		fromPosition:sendMagicEffect(CONST_ME_SOUND_YELLOW)
		player:AddCustomItem({id = ITEM_PLATINUM_COIN, count = 1})
	end
	return true
end

piggyBank:id(2995)
piggyBank:register()

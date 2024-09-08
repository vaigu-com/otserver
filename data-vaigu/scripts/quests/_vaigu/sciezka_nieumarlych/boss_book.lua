local book = Action()

function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local pos = item:getPosition()
	pos:sendMagicEffect(CONST_ME_THUNDER)
	pos:sendMagicEffect(CONST_ME_TELEPORT)
	Game.createMonster("Nieumarly Krol Krypty", pos, true, true)
	item:remove()
	return true
end

book:aid(Storage.SciezkaNieumarlych.BossBook)
book:register()

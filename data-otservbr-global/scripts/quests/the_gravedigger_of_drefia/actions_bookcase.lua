local gravediggerBook = Action()
function gravediggerBook.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Bookcase) < 1 then
		player:setStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Bookcase, 1)
<<<<<<< HEAD
<<<<<<< HEAD
		player:AddCustomItem({id = 19158, count = 1})
=======
=======
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		player:addItem(19158, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:say("You have found a crumpled paper.", TALKTYPE_MONSTER_SAY)
	else
		player:say("You've picked up here.", TALKTYPE_MONSTER_SAY)
		return true
	end
	return true
end

gravediggerBook:aid(4669)
gravediggerBook:register()

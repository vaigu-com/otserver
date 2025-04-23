local gravediggerBones = Action()
function gravediggerBones.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid ~= 4633 then
		return false
	end

	if player:getStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission17) == 1 and player:getStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission19) < 1 then
		player:setStorageValue(Storage.Quest.U10_10.TheGravediggerOfDrefia.Mission19, 1)
<<<<<<< HEAD
<<<<<<< HEAD
		player:AddCustomItem({id = 19089, count = 1})
=======
		player:addItem(19089, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
=======
		player:addItem(19089, 1)
>>>>>>> 2c5bf72d39e17e74a5e9f70901c0ed9d0e5d2d32
		item:remove()
	end
	return true
end

gravediggerBones:id(19090)
gravediggerBones:register()

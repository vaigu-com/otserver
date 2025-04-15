local bigfootPiece = Action()
function bigfootPiece.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.Mouthpiece) ~= os.time() then
		player:AddCustomItem({id = 20057, count = 1})
		player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Mouthpiece, os.time() + configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN))
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
	end
	return true
end

bigfootPiece:uid(9307)
bigfootPiece:register()

local config = {
	idcoin = 22118,
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local item = Item(item.uid)
	if player:getItemCount(config.idcoin) > 0 then
		player:getPosition():sendMagicEffect(15)
		item:remove()
		--player:addTibiaCoins(item:getCount())
		player:addTransferableCoins(item:getCount())
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to carry coins in your backpack.")
	end
	return true
end

action:id(22118)
action:register()

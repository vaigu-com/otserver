local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid == 2253 then
		if player:getItemCount(28721) > 0 and player:getItemCount(28824) > 0 and player:getItemCount(28821) > 0 then --jak mamy shielda, patch of fine i grant of arms
			--if player:removeItem(28821, 1) then --patch of fine
			player:removeItem(28721, 1) --shield
			player:removeItem(28821, 1) --patch of fine
			player:addItem(28722, 1) --falcon escu
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Udalo ci sie stworzyc Falcon Escutcheon.")
			--else
			--	player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Nie posiadasz patch of fine cloth.")
			--end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie posiadasz wymaganych przedmiotow.")
		end
		return true
	end
end

action:id(28721)
action:register()

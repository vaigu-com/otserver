local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid == 9021 then
		if player:isPzLocked() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie wejdziesz tu podczas walki.")
			return false
		end
		if player:getStorageValue(Storage.TheInquisition.Questline) == 23 then
			return (player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zapomniales poprosic Henryka o outfit."))
		end
		if player:getStorageValue(Storage.TheInquisition.Questline) >= 24 then
			if item.itemid == 5103 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Potrzebujesz specjalnych uprawnien aby przejsc dalej.")
		end
	end
	return true
end

action:uid(9021)
action:register()

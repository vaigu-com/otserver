local hay_bed_id = 2515
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(player)
	if player:getStorageValue(Storage.Yalahar.MiloscAriela) ~= 6 then -- czy ktos juz bral to i czy ma aktywny od postmana
		return false
	end

	if hay_bed_id == item.itemid then
		if player:getStorageValue(Storage.Yalahar.Haybed) ~= 1 then
			if player:getItemCount(19133) > 0 then -- czy ma eliksir przy sobie
				doCreatureSay(player, "Znalazles wlosa", TALKTYPE_ORANGE_1)
				doSendMagicEffect(fromPosition, 49)
				doCreatureSay(player, "Mikstura zabulgotala", TALKTYPE_ORANGE_1)
				player:setStorageValue(item.uid, 1) -- uaktualnienie uid lozka na 1
			end
		end
	end
	return true
end

action:aid(11004)
action:register()

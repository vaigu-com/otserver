local crate_id = 405 -- id skrzynki
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if crate_id == item.itemid and player:getStorageValue(Storage.NaPomocBagietom.ListTaken) < 1 and item.uid == 11035 then -- Nie trzeba aktywnego questa, ale tlyko raz mozna wziac
		player:setStorageValue(Storage.NaPomocBagietom.ListTaken, 1)
		player:AddCustomItem({ id = 22160,addToStore = true }) 
	else
		doCreatureSay(player, "Skrzynia jest pusta!", TALKTYPE_ORANGE_1)
	end
	return true
end

action:aid(11036)
action:register()

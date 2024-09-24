local item_id = 15639 -- id marchwi
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item_id == item.itemid and player:getStorageValue(Storage.NaPomocBagietom.Carrot) < 1 and item.uid == 11038 then -- Nie trzeba aktywnego questa, ale tlyko raz mozna wziac
		player:setStorageValue(Storage.NaPomocBagietom.Carrot, 1)
		player:say("You have found Vege Carrot.", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_HITBYPOISON)
		player:AddCustomItem({ id = 3250, addToStore = true }) 
	end
	return true
end

action:aid(11038)
action:register()

local wyrm_egg = 14098

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(player)
	if player:getStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda) < 1 then -- Jak ktos nie ma questa
		return false
	end
	if wyrm_egg == item.itemid then
		if player:getStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda) < 2 then
			player:AddCustomItem({ id = 18996,addToStore = true }) 
			player:setStorageValue(Storage.SciezkaDruida.LekarstwoOdOrnulda, 2)
			doCreatureSay(player, "*Crack* na jajku powstalo pekniecie przy wyciaganiu", TALKTYPE_ORANGE_1)
			toPosition:sendMagicEffect(10)
			Game.createMonster("Elder Wyrm", player:getPosition())
			Game.createMonster("Elder Wyrm", player:getPosition())
			Game.createMonster("Elder Wyrm", player:getPosition())
		else
			doCreatureSay(player, "Nie ma tam juz wiecej jajek", TALKTYPE_ORANGE_1)
		end
	end
	return true
end

action:aid(11068)
action:register()

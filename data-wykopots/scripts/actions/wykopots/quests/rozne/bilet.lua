-- === REV: 01        DATE: 26 Jan 2017     By: W     Tag: Q1*
local item_id = 256 -- id namiotu
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item_id == item.itemid and player:getStorageValue(Storage.OskareKXddd.Bilety) == 1 and item.uid == 11041 then
		player:setStorageValue(Storage.OskareKXddd.Bilety, 2)
		player:say("Znalazles bilet na mecz.", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		Game.createMonster("Wild Warrior", fromPosition)
		player:AddCustomItem({ id = 28818, addToStore = true }) 
	else
		doCreatureSay(player, "Nic tam nie ma!", TALKTYPE_ORANGE_1)
	end
	return true
end

action:aid(11041)
action:register()

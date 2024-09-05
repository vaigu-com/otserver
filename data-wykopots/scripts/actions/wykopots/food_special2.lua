local config = {
	storage = 19030, --use empty storage
	exhaust = 60, --Exhaust is in seconds 600 equals 10min
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.GrimEvent.Joined) >= 1 or player:getStorageValue(Storage.hasteLock) == 1 or player:getStorageValue(Storage.healLock) == 1 then
		player:sendCancelMessage("You cannot eat dishes on this event.")
		return true
	end
	if getPlayerStorageValue(player, config.storage) <= os.time() then
		if item.itemid == 9079 then
			doCreatureAddHealth(player, getCreatureMaxHealth(player))
			doCreatureSay(player, "Gulp.", TALKTYPE_ORANGE_1)
			doRemoveItem(item.uid, 1)
			setPlayerStorageValue(player, config.storage, os.time() + config.exhaust)
		elseif item.itemid == 9086 then
			doPlayerAddMana(player, getPlayerMaxMana(player))
			doCreatureSay(player, "Chomp.", TALKTYPE_ORANGE_1)
			doSendMagicEffect(getPlayerPosition(player), 14)
			doRemoveItem(item.uid, 1)
			setPlayerStorageValue(player, config.storage, os.time() + config.exhaust)
		elseif item.itemid == 11586 then -- Pot of Blackjack
			player:addHealth(math.max(1, player:getMaxHealth() - player:getHealth()))
			doCreatureSay(player, "You take the last gulp from the large bowl. No leftovers!", TALKTYPE_ORANGE_1)
			setPlayerStorageValue(player, config.storage, os.time() + config.exhaust)
			item:remove(1)
		end
	else
		doPlayerSendCancel(player, "You are full or need 1 min to use again.")
	end
	return true
end

action:id(9079, 9086, 11586)
action:register()

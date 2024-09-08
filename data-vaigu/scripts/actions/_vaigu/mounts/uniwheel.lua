local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(cid)
	n = math.random(100)
	broken = 30
	if item.itemid == 13938 and itemEx.itemid == 13937 then
		if player:getStorageValue(Storage.Uniwheel) < 1 then
			if n < broken then
				doPlayerAddMount(cid, 15)
				doRemoveItem(item.uid, 1)
				player:say("Vroooomratatatatatatat", TALKTYPE_MONSTER_SAY)
				player:say("The strange wheel seems to vibrate and slowly starts turning continuously", TALKTYPE_MONSTER_SAY)
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.Uniwheel, 1)
				if player:getStorageValue(Storage.Uniwheel) == 1 then
					--player:addAchievement(332, showMsg)
				end
			else
				doRemoveItem(item.uid)
				player:say("Splosh!", TALKTYPE_MONSTER_SAY)
				player:say("It looks like most of the special oil this can was holding was spilt without any effect", TALKTYPE_MONSTER_SAY)
				doSendMagicEffect(toPosition, CONST_ME_POFF)
			end
		elseif player:getStorageValue(Storage.Uniwheel) == 1 then
			player:say("You already tamed a uniwheel.", TALKTYPE_MONSTER_SAY)
		end
	else
		return false
	end
end

action:id(12801)
action:register()

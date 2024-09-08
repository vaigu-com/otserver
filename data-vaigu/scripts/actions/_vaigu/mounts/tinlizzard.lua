local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(cid)
	n = math.random(100)
	broken = 80
	if item.itemid == 13292 and itemEx.itemid == 13306 then
		if player:getStorageValue(Storage.Tinlizzard) < 1 then
			if n < broken then
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
				doPlayerAddMount(cid, 8)
				doRemoveItem(item.uid, 1)
				player:say("Krkrkrkrk", TALKTYPE_MONSTER_SAY)
				player:say("You wind up the tin lizzard.", TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Tinlizzard, 1)
				if player:getStorageValue(Storage.Tinlizzard) == 1 then
					--player:addAchievement(331, showMsg)
				end
			else
				doRemoveItem(item.uid)
				player:say("Krr... kch.", TALKTYPE_MONSTER_SAY)
				player:say("The tin lizzard broke apart.", TALKTYPE_MONSTER_SAY)
				doSendMagicEffect(toPosition, CONST_ME_POFF)
			end
		elseif player:getStorageValue(Storage.Tinlizzard) == 1 then
			player:say("You already tamed a  tin lizzard.", TALKTYPE_MONSTER_SAY)
		end
	end
end

action:id(12305)
action:register()

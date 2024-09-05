local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 6966 then
		if player:getStorageValue(Storage.IcePickIcicle) >= os.time() then
			return player:say("Na dzis juz wystarczy..", TALKTYPE_MONSTER_SAY)
		end
		if player:getStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy) == 2 then
			local szansa = math.random(100)
			if szansa <= 60 then
				toPosition:sendMagicEffect(38)
				player:say("Ehh..", TALKTYPE_MONSTER_SAY)
			elseif szansa >= 61 and szansa <= 85 then
				player:addItem(4837, 1)
				toPosition:sendMagicEffect(38)
				player:setStorageValue(Storage.IcePickIcicle, os.time() + 20 * 3600) --20h
				player:say("O prosze!", TALKTYPE_MONSTER_SAY)
			elseif szansa >= 86 then
				player:addItem(7290, 1)
				toPosition:sendMagicEffect(38)
				player:setStorageValue(Storage.IcePickIcicle, os.time() + 20 * 3600) --20h
				player:say("O prosze!", TALKTYPE_MONSTER_SAY)
			end
		else
			player:say("Nie wiesz jak tego uzyc..", TALKTYPE_MONSTER_SAY)
		end
	end
end
action:id(4872)
action:register()

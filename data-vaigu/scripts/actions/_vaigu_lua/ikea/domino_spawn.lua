local dominoSpawn = Action()

function dominoSpawn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--if target.actionid == 11077 then
	if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 3 then
		if Game.getStorageValue(GlobalStorage.DominoAlive) <= 0 then
			local pos = Position(5833, 1595, 11)
			Game.createMonster("drwal domino", pos)
			player:say("Ja pierdole! Nie dadza czlowiekowi uczciwie zarobic?!", TALKTYPE_MONSTER_YELL, false, nil, pos)
			pos:sendMagicEffect(CONST_ME_BLOCKHIT)
			Game.setStorageValue(GlobalStorage.DominoAlive, 1)
		end
	elseif player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 4 then
		player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 5)
		local book = doPlayerAddItem(player, 2816, 1)
		if item then
			doSetItemText(book, "Strona 7\n\nUtarg: Sprochniala sztuczna bukowa noga, Krysztalowa kula z mahoniowa podstawka, Debowy stolek.")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nic tu dla ciebie nie ma.")
		return true
	end
	--end
end

dominoSpawn:aid(11077)
dominoSpawn:register()

local dominoSpawn2 = Action()

function dominoSpawn2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	print("1")
	--if target.actionid == 11078 then
	if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 11 then
		print("2")
		if Game.getStorageValue(GlobalStorage.Domino2Alive) <= 0 then
			print("3")
			local pos = Position(6201, 1205, 7)
			Game.createMonster("drwal domino2", pos)
			player:say("Czego ty znowu chcesz?!", TALKTYPE_MONSTER_YELL, false, nil, pos)
			pos:sendMagicEffect(CONST_ME_BLOCKHIT)
			Game.setStorageValue(GlobalStorage.Domino2Alive, 1)
		end
	elseif player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) >= 13 then
		if isPlayerPzLocked(player) then
			doCreatureSay(player, "Nie mozesz tedy uciec!", TALKTYPE_ORANGE_1)
			return false
		else
			fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
			local destination = Position(6049, 1648, 7)
			player:teleportTo(destination)
			destination:sendMagicEffect(CONST_ME_TELEPORT)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie wiesz jak tego uzyc.")
	end
	--end
end

dominoSpawn2:aid(11078)
dominoSpawn2:register()

local dominoMirkoBoat = Action()

function dominoMirkoBoat.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) >= 13 then
		if isPlayerPzLocked(player) then
			doCreatureSay(player, "Nie mozesz tedy uciec!", TALKTYPE_ORANGE_1)
			return false
		else
			fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
			local destination = Position(6198, 1206, 7)
			player:teleportTo(destination)
			destination:sendMagicEffect(CONST_ME_TELEPORT)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie wiesz jak tego uzyc.")
	end
end

dominoMirkoBoat:aid(11079)
dominoMirkoBoat:register()

local dominoBoatUnlock = Action()

function dominoBoatUnlock.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid == 11078 then
		if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 12 then
			player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 13)
			toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
			item:remove(1)
		end
	end
end

dominoBoatUnlock:id(7934)
dominoBoatUnlock:register()

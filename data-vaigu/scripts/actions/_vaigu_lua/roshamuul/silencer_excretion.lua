local guzzleShrines = { 11200, 11201, 11203, 11204, 11205, 11206, 11207, 11208, 11209, 11210, 11211, 11212, 11213 }
local silencerExcretion = Action()

function silencerExcretion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArray(guzzleShrines, target.uid) then
		if getGlobalStorageValue(GlobalStorage.MawhawkState) >= 20 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Mawhawk got spawned already.")
			return false
		end

		if getGlobalStorageValue(target.uid) >= os.time() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This one still smells really bad..")
			return false
		end

		if getGlobalStorageValue(GlobalStorage.MawhawkState) < 0 then
			setGlobalStorageValue(GlobalStorage.MawhawkState, 0)
		end

		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_SMALLCLOUDS)
		setGlobalStorageValue(GlobalStorage.MawhawkState, getGlobalStorageValue(GlobalStorage.MawhawkState) + 1)
		setGlobalStorageValue(target.uid, os.time() + 1 * 60)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You desecrated " .. getGlobalStorageValue(GlobalStorage.MawhawkState) .. " out of 20 shrines to spawn a Mawhawk.")
		Game.createMonster("Guzzlemaw", player:getPosition(), true, false)

		if getGlobalStorageValue(GlobalStorage.MawhawkState) == 20 then
			Game.createMonster("Mawhawk", Position(6282, 571, 7))
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Mawhawk appeared in his lair!")
		end
	end
end

silencerExcretion:id(20165)
silencerExcretion:register()

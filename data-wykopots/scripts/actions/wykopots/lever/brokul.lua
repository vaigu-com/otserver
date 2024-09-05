local config = {
	[57609] = {
		actionid = 57609, -- lever aid & lock global storage
		usePosition = Position(6874, 1191, 15), -- lever pos {x = 6874, y = 1191, z = 15}
		bossName = "Brokul",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.BrokulTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6872, 1191, 15), to = Position(6876, 1191, 15) }, -- from to {x = 6876, y = 1191, z = 15}
		bossPos = Position(6833, 1163, 15), -- Boss Position {x = 6833, y = 1163, z = 15}
		centerRoom = Position(6835, 1165, 15), -- Center Room{x = 6835, y = 1165, z = 15}
		enterPos = Position(6843, 1166, 15), -- Enter Position{x = 6843, y = 1166, z = 15}
		exitPosition = Position(6874, 1193, 15), -- Exit Position{x = 6874, y = 1193, z = 15}
		range = 13,
		time = 20, -- time in minutes to remove the player
	},
}

local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition, storageId)
	if Game.getStorageValue(storageId) == 1 then
		local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:isPlayer() then
				spectator:teleportTo(exitPosition)
				spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				spectator:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
			elseif spectator:isMonster() then
				spectator:remove()
			end
		end
		Game.setStorageValue(storageId, 0)
	end
end

-- Start Script
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local uid_act = config[item.actionid]
	if not uid_act then
		return true
	end

	if (item.itemid == 1945 or item.itemid == 9825 or item.itemid == 10029) and item.actionid == uid_act.actionid then
		if player:getPosition() ~= uid_act.usePosition then
			return true
		end
		for x = uid_act.positions.from.x, uid_act.positions.to.x do
			for y = uid_act.positions.from.y, uid_act.positions.to.y do
				local playerTile = Tile(Position(x, y, uid_act.positions.from.z)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					if uid_act.timerStorage then
						if playerTile:getStorageValue(uid_act.timerStorage) > os.time() then
							player:sendTextMessage(MESSAGE_STATUS_SMALL, "You or a member in your team have to wait " .. uid_act.timerHours .. " hours to challange " .. uid_act.bossName .. " again!")
							--item:transform(1946)
							return true
						end
					end
				end
			end
		end

		if Game.getStorageValue(GlobalStorage.RestoredIdols) < 9 then -- global storage posagi
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need to restore broken idols before fighting Brokul!")
			return true
		end

		local specs, spec = Game.getSpectators(uid_act.centerRoom, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "There's someone fighting with " .. uid_act.bossName .. " already.")
				--item:transform(1946)
				return true
			end
		end

		if Game.getStorageValue(uid_act.actionid) == 1 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Someone already used this lever in last " .. uid_act.time .. " minutes!")
			return true
		end

		local spectators = Game.getSpectators(uid_act.bossPos, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:isMonster() then
				spectator:remove()
			end
		end
		--[[for n = 1, #monsters do
			Game.createMonster(monsters[n].pillar, monsters[n].pos, true, true)
		end]]
		Game.createMonster(uid_act.bossName, uid_act.bossPos, true, true)
		Game.setStorageValue(uid_act.actionid, 1)
		for x = uid_act.positions.from.x, uid_act.positions.to.x do
			for y = uid_act.positions.from.y, uid_act.positions.to.y do
				local playerTile = Tile(Position(x, y, uid_act.positions.from.z)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(uid_act.enterPos)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					if uid_act.timerStorage then
						playerTile:setStorageValue(uid_act.timerStorage, os.time() + uid_act.timerHours * 60 * 60) -- + 20 * 60 * 3600
					end
					addEvent(clearBossRoom, 60 * uid_act.time * 1000, playerTile:getId(), uid_act.centerRoom, uid_act.range, uid_act.range, uid_act.exitPosition, uid_act.actionid)
					playerTile:sendTextMessage(MESSAGE_STATUS_SMALL, "You have " .. uid_act.time .. " minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
					if item.itemid == 1945 then
						item:transform(1946)
					elseif item.itemid == 9825 then
						item:transform(9826)
					elseif item.itemid == 10029 then
						item:transform(10030)
					end
				end
			end
		end
	elseif item.itemid == 1946 then
		item:transform(1945)
	elseif item.itemid == 9826 then
		item:transform(9825)
	elseif item.itemid == 10030 then
		item:transform(10029)
	end
	return true
end

action:aid(57609)
action:register()

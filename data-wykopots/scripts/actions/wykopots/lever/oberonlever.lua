local config = {
	[57605] = {
		actionid = 57605, -- lever aid & lock global storage
		usePosition = Position(6370, 1897, 9), -- lever pos
		bossName = "Grand Master Oberon",
		timerStorage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6370, 1897, 9), to = Position(6370, 1901, 9) }, -- player positions from to
		bossPos = Position(6386, 1895, 9), -- Boss Position
		centerRoom = Position(6389, 1898, 9), -- Center Room
		enterPos = Position(6395, 1898, 9), -- Enter Position
		exitPosition = Position(6368, 1899, 9), -- Exit Position
		range = 9,
		time = 15, -- time in minutes to remove the player
	},
	[9520] = {
		actionid = 9520, -- lever aid & lock global storage
		usePosition = Position(7312, 1682, 14), -- lever pos
		bossName = "Mazoran",
		timerStorage = Storage.Ferumbras.Mazoran48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7312, 1682, 14), to = Position(7312, 1686, 14) }, -- from to
		bossPos = Position(7303, 1727, 14), -- Boss Position
		centerRoom = Position(7303, 1727, 14), -- Center Room
		enterPos = Position(7303, 1731, 14), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9521] = {
		actionid = 9521, -- lever aid & lock global storage
		usePosition = Position(7174, 1795, 14), -- lever pos
		bossName = "Razzagorn",
		timerStorage = Storage.Ferumbras.Razzagorn48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7174, 1795, 14), to = Position(7178, 1795, 14) }, -- from to
		bossPos = Position(7212, 1806, 14), -- Boss Position
		centerRoom = Position(7212, 1806, 14), -- Center Room
		enterPos = Position(7206, 1807, 14), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9522] = {
		actionid = 9522, -- lever aid & lock global storage
		usePosition = Position(7525, 1730, 13), -- lever pos
		bossName = "Plagirath",
		timerStorage = Storage.Ferumbras.Plagirath48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7525, 1730, 13), to = Position(7525, 1734, 13) }, -- from to
		bossPos = Position(7468, 1731, 13), -- Boss Position
		centerRoom = Position(7468, 1731, 13), -- Center Room
		enterPos = Position(7470, 1734, 13), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9523] = {
		actionid = 9523, -- lever aid & lock global storage
		usePosition = Position(7545, 1803, 14), -- lever pos
		bossName = "Ferumbras Mortal Shell",
		timerStorage = Storage.Ferumbras.FerumbrasMortal48, -- player timer 20h
		timerHours = 44,
		positions = { from = Position(7544, 1803, 14), to = Position(7546, 1807, 14) }, -- from to
		bossPos = Position(7559, 1898, 14), -- Boss Position
		centerRoom = Position(7559, 1898, 14), -- Center Room
		enterPos = Position(7559, 1908, 14), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 30, -- time in minutes to remove the player
	},
	[9524] = {
		actionid = 9524, -- lever aid & lock global storage
		usePosition = Position(7242, 1694, 13), -- lever pos
		bossName = "Ragiaz",
		timerStorage = Storage.Ferumbras.Ragiaz48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7242, 1694, 13), to = Position(7246, 1694, 13) }, -- from to
		bossPos = Position(7268, 1672, 13), -- Boss Position
		centerRoom = Position(7268, 1672, 13), -- Center Room
		enterPos = Position(7268, 1676, 13), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9525] = {
		actionid = 9525, -- lever aid & lock global storage
		usePosition = Position(7399, 1779, 11), -- lever pos
		bossName = "Zamulosh",
		timerStorage = Storage.Ferumbras.Zamulosh48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7399, 1779, 11), to = Position(7399, 1783, 11) }, -- from to
		bossPos = Position(7362, 1794, 11), -- Boss Position
		centerRoom = Position(7362, 1794, 11), -- Center Room
		enterPos = Position(7363, 1797, 11), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9526] = {
		actionid = 9526, -- lever aid & lock global storage
		usePosition = Position(7240, 1943, 11), -- lever pos
		bossName = "Tarbaz",
		timerStorage = Storage.Ferumbras.Tarbaz48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7240, 1943, 11), to = Position(7240, 1947, 11) }, -- from to
		bossPos = Position(7281, 1936, 11), -- Boss Position
		centerRoom = Position(7281, 1936, 11), -- Center Room
		enterPos = Position(7281, 1930, 11), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9527] = {
		actionid = 9527, -- lever aid & lock global storage
		usePosition = Position(7256, 1878, 13), -- lever pos
		bossName = "Shulgrax",
		timerStorage = Storage.Ferumbras.Shulgrax48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7256, 1878, 13), to = Position(7256, 1882, 13) }, -- from to
		bossPos = Position(7307, 1879, 13), -- Boss Position
		centerRoom = Position(7307, 1879, 13), -- Center Room
		enterPos = Position(7308, 1882, 13), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 15,
		time = 20, -- time in minutes to remove the player
	},
	[9528] = {
		actionid = 9528, -- lever aid & lock global storage
		usePosition = Position(7191, 1805, 13), -- lever pos
		bossName = "The Shatterer",
		--timerStorage = Storage.Ferumbras.Shulgrax48, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(7191, 1805, 13), to = Position(7195, 1805, 13) }, -- from to
		bossPos = Position(7202, 1758, 14), -- Boss Position
		centerRoom = Position(7202, 1758, 14), -- Center Room
		enterPos = Position(7187, 1773, 14), -- Enter Position
		exitPosition = Position(7099, 1714, 12), -- Exit Position
		range = 20,
		time = 20, -- time in minutes to remove the player
	},
	[57606] = {
		actionid = 57606, -- lever aid & lock global storage
		usePosition = Position(6346, 1953, 13), -- lever pos
		bossName = "The Nightmare Beast",
		timerStorage = Storage.TheDreamCourts.NightmareBeastTimer, -- player timer 20h
		timerHours = 44,
		positions = { from = Position(6344, 1953, 13), to = Position(6348, 1954, 13) }, -- from to
		bossPos = Position(6318, 1979, 14), -- Boss Position
		centerRoom = Position(6322, 1979, 14), -- Center Room
		enterPos = Position(6327, 1979, 14), -- Enter Position
		exitPosition = Position(6328, 1973, 13), -- Exit Position
		range = 10,
		time = 30, -- time in minutes to remove the player
	},
	[57608] = {
		actionid = 57608, -- lever aid & lock global storage
		usePosition = Position(5892, 780, 13), -- lever pos
		bossName = "Faceless Bane",
		timerStorage = Storage.TheDreamCourts.FacelessTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(5892, 780, 13), to = Position(5896, 780, 13) }, -- from to
		bossPos = Position(5871, 777, 13), -- Boss Position
		centerRoom = Position(5871, 780, 13), -- Center Room
		enterPos = Position(5871, 785, 13), -- Enter Position
		exitPosition = Position(5894, 779, 13), -- Exit Position
		range = 11,
		time = 10, -- time in minutes to remove the player
	},
}

local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition, storageId)
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			if spectator:getId() == playerId then
				spectator:teleportTo(exitPosition)
				spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				spectator:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
			end
		end
	end
end
-- Start Script
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local uid_act = config[item.actionid]
	if not uid_act then
		return true
	end

	if (item.itemid == 2772 or item.itemid == 8911 or item.itemid == 9110) and item.actionid == uid_act.actionid then
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
							return true
						end
					end
				end
			end
		end

		local specs, spec = Game.getSpectators(uid_act.centerRoom, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "There's someone fighting with " .. uid_act.bossName .. " already.")
				return true
			end
		end

		local spectators = Game.getSpectators(uid_act.centerRoom, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:isMonster() then
				spectator:remove()
			end
		end

		Game.createMonster(uid_act.bossName, uid_act.bossPos, true, true)

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
					if item.itemid == 2772 then
						item:transform(2773)
					elseif item.itemid == 8911 then
						item:transform(8912)
					elseif item.itemid == 9110 then
						item:transform(9111)
					end
				end
			end
		end
	elseif item.itemid == 2773 then
		item:transform(2772)
	elseif item.itemid == 8912 then
		item:transform(8911)
	elseif item.itemid == 9111 then
		item:transform(9110)
	end
	return true
end

action:aid(57605, 57606, 57608, 9520, 9521, 9522, 9523, 9524, 9525, 9526, 9527, 9528)
action:register()

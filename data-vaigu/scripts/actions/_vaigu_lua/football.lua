local footballLever = Action()

local function timeReminder30big(cid)
	local middle = Position(6286, 1507, 7)
	local player = Player(cid)
	if player then
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, middle)
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6270, 1499, 7))
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6302, 1499, 7))
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6270, 1515, 7))
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6302, 1515, 7))
	end
end

local function timeReminder10big(cid)
	local middle = Position(6286, 1507, 7)
	local player = Player(cid)
	if player then
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, middle)
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6270, 1499, 7))
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6302, 1499, 7))
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6270, 1515, 7))
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, Position(6302, 1515, 7))
	end
end

local function timeReminder30small(cid)
	local middle = Position(6286, 1507, 8)
	local player = Player(cid)
	if player then
		player:say("30 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, middle)
	end
end

local function timeReminder10small(cid)
	local middle = Position(6286, 1507, 8)
	local player = Player(cid)
	if player then
		player:say("10 seconds left!", TALKTYPE_MONSTER_YELL, false, nil, middle)
	end
end

local function clearAreaBig()
	if Game.getStorageValue(GlobalStorage.Football.MatchGoing) == 1 then
		local resultLeft = string.format(Game.getStorageValue(GlobalStorage.Football.LeftScore))
		local resultRight = string.format(Game.getStorageValue(GlobalStorage.Football.RightScore))
		local upConer = { x = 6269, y = 1498, z = 7 } -- upLeftCorner {x = 5491, y = 1432, z = 14}
		local downConer = { x = 6303, y = 1516, z = 7 } -- downRightCorner {x = 5517, y = 1457, z = 14}
		local centerPos = Position(6286, 1507, 7)
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						local getItem = tile:getItemById(9104)
						if creatures and #creatures > 0 then
							for _, c in pairs(creatures) do
								if isPlayer(c) then
									c:teleportTo({ x = 5905, y = 1557, z = 9 }) --{5905, 1557, 9
									c:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
									c:sendTextMessage(MESSAGE_STATUS_SMALL, "Time out! Final result: " .. resultLeft .. ":" .. resultRight)
								elseif isMonster(c) then
									c:remove()
								end
							end
						end
						if getItem then
							getItem:remove()
							Game.createItem(9104, 1, centerPos)
						end
					end
				end
			end
		end
		Game.setStorageValue(GlobalStorage.Football.MatchGoing, 0)
	end
end

local function clearAreaSmall()
	if Game.getStorageValue(GlobalStorage.Football.MatchGoing) == 1 then
		local resultLeft = string.format(Game.getStorageValue(GlobalStorage.Football.LeftScore))
		local resultRight = string.format(Game.getStorageValue(GlobalStorage.Football.RightScore))
		local upConer = { x = 6279, y = 1502, z = 8 } -- upLeftCorner {x = 5491, y = 1432, z = 14}
		local downConer = { x = 6293, y = 1512, z = 8 } -- downRightCorner {x = 5517, y = 1457, z = 14}
		local centerPos = Position(6286, 1507, 8)
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						local getItem = tile:getItemById(9104)
						if creatures and #creatures > 0 then
							for _, c in pairs(creatures) do
								if isPlayer(c) then
									c:teleportTo({ x = 5905, y = 1557, z = 9 }) --{5905, 1557, 9
									c:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
									c:sendTextMessage(MESSAGE_STATUS_SMALL, "Time out! Final result: " .. resultLeft .. ":" .. resultRight)
								elseif isMonster(c) then
									c:remove()
								end
							end
						end
						if getItem then
							getItem:remove()
							Game.createItem(9104, 1, centerPos)
						end
					end
				end
			end
		end
		Game.setStorageValue(GlobalStorage.Football.MatchGoing, 0)
	end
end

function footballLever.onUse(player, item, fromPosition, itemEx, toPosition)
	local configBig = {
		leftPositions = {
			Position(5906, 1555, 9), --{x = 5906, y = 1555, z = 9}
			Position(5907, 1555, 9),
			Position(5908, 1555, 9),
			Position(5909, 1555, 9),
			Position(5910, 1555, 9), --{x = 5910, y = 1555, z = 9}
			Position(5906, 1556, 9), --{x = 5906, y = 1555, z = 9}
			Position(5907, 1556, 9),
			Position(5908, 1556, 9),
			Position(5909, 1556, 9),
			Position(5910, 1556, 9), --{x = 5910, y = 1555, z = 9}
		},
		rightPositions = {
			Position(5906, 1558, 9), --{x = 5906, y = 1558, z = 9}
			Position(5907, 1558, 9),
			Position(5908, 1558, 9),
			Position(5909, 1558, 9),
			Position(5910, 1558, 9), --{x = 5910, y = 1558, z = 9}
			Position(5906, 1559, 9), --{x = 5906, y = 1558, z = 9}
			Position(5907, 1559, 9),
			Position(5908, 1559, 9),
			Position(5909, 1559, 9),
			Position(5910, 1559, 9), --{x = 5910, y = 1558, z = 9}
		},

		leftNewPos = { x = 6281, y = 1507, z = 7 }, --{x = 5477, y = 1509, z = 14}
		rightNewPos = { x = 6291, y = 1507, z = 7 }, --{x = 5504, y = 1453, z = 14}
	}
	local configSmall = {
		leftPositions = {
			Position(5906, 1555, 9), --{x = 5906, y = 1555, z = 9}
			Position(5907, 1555, 9),
			Position(5908, 1555, 9),
			Position(5909, 1555, 9),
			Position(5910, 1555, 9), --{x = 5910, y = 1555, z = 9}
			Position(5906, 1556, 9), --{x = 5906, y = 1555, z = 9}
			Position(5907, 1556, 9),
			Position(5908, 1556, 9),
			Position(5909, 1556, 9),
			Position(5910, 1556, 9), --{x = 5910, y = 1555, z = 9}
		},
		rightPositions = {
			Position(5906, 1558, 9), --{x = 5906, y = 1558, z = 9}
			Position(5907, 1558, 9),
			Position(5908, 1558, 9),
			Position(5909, 1558, 9),
			Position(5910, 1558, 9), --{x = 5910, y = 1558, z = 9}
			Position(5906, 1559, 9), --{x = 5906, y = 1558, z = 9}
			Position(5907, 1559, 9),
			Position(5908, 1559, 9),
			Position(5909, 1559, 9),
			Position(5910, 1559, 9), --{x = 5910, y = 1558, z = 9}
		},

		leftNewPos = { x = 6283, y = 1507, z = 8 }, --Position(6283, 1507, 8)
		rightNewPos = { x = 6289, y = 1507, z = 8 }, --Position(6289, 1507, 8)
	}
	local pushPos1 = Position(5908, 1556, 9) --{x = 5908, y = 1556, z = 9}
	local pushPos2 = Position(5908, 1558, 9) --{x = 5908, y = 1556, z = 9}

	if item.actionid == 2113 then
		if item.itemid == 2772 then
			if (player:getPosition() == pushPos1) or (player:getPosition() == pushPos2) then
				local storeLeft, leftTile = {}
				local storeRight, rightTile = {}
				if Game.getStorageValue(GlobalStorage.Football.Field) == 1 then -- big field
					print("big start")
					for i = 1, #configBig.leftPositions do
						leftTile = Tile(configBig.leftPositions[i]):getTopCreature()
						if isPlayer(leftTile) then
							storeLeft[#storeLeft + 1] = leftTile
						end
					end

					for i = 1, #configBig.rightPositions do
						rightTile = Tile(configBig.rightPositions[i]):getTopCreature()
						if isPlayer(rightTile) then
							storeRight[#storeRight + 1] = rightTile
						end
					end

					if #storeLeft < 1 or #storeRight < 1 then
						player:sendTextMessage(19, "You need at least 2 players, each in a team.")
						return true
					end

					if Game.getStorageValue(GlobalStorage.Football.MatchGoing) < 1 then
						local teamLeft
						local teamRight

						for i = 1, #storeLeft do
							teamLeft = storeLeft[i]
							configBig.leftPositions[i]:sendMagicEffect(CONST_ME_POFF)
							teamLeft:teleportTo(configBig.leftNewPos)
						end

						for i = 1, #storeRight do
							teamRight = storeRight[i]
							configBig.rightPositions[i]:sendMagicEffect(CONST_ME_POFF)
							teamRight:teleportTo(configBig.rightNewPos)
						end

						Position(configBig.leftNewPos):sendMagicEffect(11)
						Position(configBig.rightNewPos):sendMagicEffect(11)
						Game.setStorageValue(GlobalStorage.Football.MatchGoing, 1)
						Game.setStorageValue(GlobalStorage.Football.LeftScore, 0)
						Game.setStorageValue(GlobalStorage.Football.RightScore, 0)
						Game.setStorageValue(GlobalStorage.Football.GoalTimeout, 0)
						addEvent(clearAreaBig, Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000)
						addEvent(timeReminder30big, (Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000) - (30 * 1000), player:getId())
						addEvent(timeReminder10big, (Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000) - (10 * 1000), player:getId())
					else
						player:sendTextMessage(19, "Match is already going.")
					end
				else --small field
					print("small start")
					for i = 1, #configSmall.leftPositions do
						leftTile = Tile(configSmall.leftPositions[i]):getTopCreature()
						if isPlayer(leftTile) then
							storeLeft[#storeLeft + 1] = leftTile
						end
					end

					for i = 1, #configSmall.rightPositions do
						rightTile = Tile(configSmall.rightPositions[i]):getTopCreature()
						if isPlayer(rightTile) then
							storeRight[#storeRight + 1] = rightTile
						end
					end

					if #storeLeft < 1 or #storeRight < 1 then
						player:sendTextMessage(19, "You need at least 2 players, each in a team.")
						return true
					end

					if Game.getStorageValue(GlobalStorage.Football.MatchGoing) < 1 then
						local teamLeft
						local teamRight

						for i = 1, #storeLeft do
							teamLeft = storeLeft[i]
							configSmall.leftPositions[i]:sendMagicEffect(CONST_ME_POFF)
							teamLeft:teleportTo(configSmall.leftNewPos)
						end

						for i = 1, #storeRight do
							teamRight = storeRight[i]
							configSmall.rightPositions[i]:sendMagicEffect(CONST_ME_POFF)
							teamRight:teleportTo(configSmall.rightNewPos)
						end

						Position(configSmall.leftNewPos):sendMagicEffect(11)
						Position(configSmall.rightNewPos):sendMagicEffect(11)
						Game.setStorageValue(GlobalStorage.Football.MatchGoing, 1)
						Game.setStorageValue(GlobalStorage.Football.LeftScore, 0)
						Game.setStorageValue(GlobalStorage.Football.RightScore, 0)
						Game.setStorageValue(GlobalStorage.Football.GoalTimeout, 0)
						addEvent(clearAreaSmall, Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000)
						addEvent(timeReminder30small, (Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000) - (30 * 1000), player:getId())
						addEvent(timeReminder10small, (Game.getStorageValue(GlobalStorage.Football.Timer) * 60 * 1000) - (10 * 1000), player:getId())
					else
						player:sendTextMessage(19, "Match is already going.")
					end
				end
			else
				return true
			end
		end
		item:transform(item.itemid == 2772 and 2773 or 2772)
	end
	return true
end
footballLever:aid(2113)
footballLever:register()

local footballTime = Action()

function footballTime.onUse(player, item, frompos, item2, topos)
	if item.itemid == 2772 then
		doTransformItem(item.uid, item.itemid + 1)
	elseif item.itemid == 2773 then
		doTransformItem(item.uid, item.itemid - 1)
	end

	if Game.getStorageValue(GlobalStorage.Football.Timer) < 10 then
		Game.setStorageValue(GlobalStorage.Football.Timer, Game.getStorageValue(GlobalStorage.Football.Timer) + 1)
		local resultTime = string.format(Game.getStorageValue(GlobalStorage.Football.Timer))
		player:say("Czas meczu zmieniony na " .. resultTime .. " min.", TALKTYPE_MONSTER_SAY, false, nil, topos)
	else
		Game.setStorageValue(GlobalStorage.Football.Timer, 1)
		player:say("Czas meczu zmieniony na 1 min.", TALKTYPE_MONSTER_SAY, false, nil, topos)
	end
	return true
end

footballTime:aid(2112)
footballTime:register()

local footballTime = Action()

function footballTime.onUse(player, item, frompos, item2, topos)
	if item.itemid == 2772 then
		doTransformItem(item.uid, item.itemid + 1)
	elseif item.itemid == 2773 then
		doTransformItem(item.uid, item.itemid - 1)
	end

	if Game.getStorageValue(GlobalStorage.Football.Field) == 0 then
		Game.setStorageValue(GlobalStorage.Football.Field, 1)
		player:say("Ustawiono duze boisko.", TALKTYPE_MONSTER_SAY, false, nil, topos)
	else
		Game.setStorageValue(GlobalStorage.Football.Field, 0)
		player:say("Ustawiono male boisko.", TALKTYPE_MONSTER_SAY, false, nil, topos)
	end
	return true
end

footballTime:aid(2114)
footballTime:register()

local function jumpFunc(playerId, position)
	local player = Player(playerId)
	player:teleportTo(position, true)
end

local jump = TalkAction("!jump")
function jump.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	--[[if player:getStorageValue(Storage.JumpExhaust) >= os.time() then
		player:sendCancelMessage("You are exhausted.")
		return false
	end]]
	local direction = player:getDirection()
	local jumpOverPos = player:getPosition()
	local destPos = player:getPosition()
	jumpOverPos:sendMagicEffect(CONST_ME_POFF)

	jumpOverPos:getNextPosition(direction, 1)
	destPos:getNextPosition(direction, 2)

	local overTile = Tile(jumpOverPos)
	if overTile then
		if overTile:isJumpable(false, false, true, false, false) then -- possible to jump through non blockprojectile tiles
			local destTile = Tile(destPos)
			if destTile then
				if destTile:isWalkable(false, true, true, true, true) then -- walkable destination
					jumpFunc(player:getId(), jumpOverPos)
					addEvent(jumpFunc, 100, player:getId(), destPos)
					--player:setStorageValue(Storage.JumpExhaust, os.time() + 1)
				else
					player:sendCancelMessage("You cannot jump there.")
				end
			end
		else
			player:sendCancelMessage("You cannot jump there.")
		end
	end
end
jump:separator(" ")
jump:groupType("normal")
jump:register()

local function changeSpeeds(cid, var)
	local creature = Creature(cid)
	if not creature then
		return
	end
	creature:changeSpeed(creature:getBaseSpeed())
end

local speed = TalkAction("/base")

function speed.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	local usage = "/condition PLAYER NAME"
	if param == "" then
		player:sendCancelMessage("Command param required. Usage: " .. usage)
		return false
	end

	local target = Player(param)
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	target:setStorageValue(Storage.hasteLock, -1)
	target:changeSpeed()
end
speed:separator(" ")
speed:groupType("gamemaster")
speed:register()

local basespeed = TalkAction("/speed")

function basespeed.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	local usage = "/condition PLAYER NAME"
	if param == "" then
		player:sendCancelMessage("Command param required. Usage: " .. usage)
		return false
	end

	local target = Player(param)
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	target:setStorageValue(Storage.hasteLock, 230)
	target:changeSpeed()
end
basespeed:separator(" ")
basespeed:groupType("gamemaster")
basespeed:register()

local playersOnline = TalkAction("!online")

local VOC_NAMES = { "S", "D", "P", "K", "MS", "ED", "RP", "EK" }

local function getVisiblePlayers(player)
	local result = {}
	for _, target in ipairs(Game.getPlayers()) do
		if player:canSeeCreature(target) then
			result[#result + 1] = target
		end
	end
	return result
end

local function formatPlayerEntry(target)
	local vocId = target:getVocation():getId()
	if vocId > 0 and vocId < 9 then
		return string.format("%s (%d%s)", target:getName(), target:getLevel(), VOC_NAMES[vocId])
	end
	return string.format("%s [%d]", target:getName(), target:getLevel())
end

local function sendChunk(player, msg, isLast)
	player:sendTextMessage(30, msg .. (isLast and "." or ","))
end

function playersOnline.onSay(player, words, param)
	local visiblePlayers = getVisiblePlayers(player)
	player:sendTextMessage(32, #visiblePlayers .. " players online.")

	local msg, count = "", 0
	for i, target in ipairs(visiblePlayers) do
		msg = msg .. (count > 0 and ", " or "") .. formatPlayerEntry(target)
		count = count + 1

		if count == 10 then
			sendChunk(player, msg, i == #visiblePlayers)
			msg, count = "", 0
		end
	end

	if count > 0 then
		sendChunk(player, msg, true)
	end
	return true
end

playersOnline:groupType("normal")
playersOnline:register()

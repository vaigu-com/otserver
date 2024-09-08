local startHours = {
	"17:00:00",
	"20:00:00",
	"23:00:00",
}

local function runLottery()
	local players = Game.getPlayers()
	local onlineList = {
		Active = {},
	}

	for _, targetPlayer in ipairs(players) do
		local hasAccess = targetPlayer:getGroup():getAccess()
		if hasAccess == false then
			table.insert(onlineList.Active, targetPlayer)
		end
	end

	if #onlineList.Active > 0 then
		local uid = math.random(1, #onlineList.Active)
		local lucky = onlineList.Active[uid]

		if lucky then
			lucky:addTibiaCoins(5)
			lucky:addTransferableCoins(15)
			Game.broadcastMessage("Coin Lottery! " .. lucky:getName() .. " wygrywa 15 coinow. Gratulacje!", MESSAGE_STATUS_WARNING)
		end
	end
end

-- Register event and start hours
local function createAndRegisterEvent(eventId, startHour)
	local lotteryEvent = GlobalEvent(eventId)

	function lotteryEvent.onTime(interval)
		runLottery()
		return true
	end

	if startHour then
		lotteryEvent:time(startHour)
		lotteryEvent:register()
	end
end

for i, startHour in ipairs(startHours) do
	createAndRegisterEvent("lotteryEvent" .. i, startHour)
end

-- Lottery talkaction
local lotteryTA = TalkAction("!lottery")
function lotteryTA.onSay(player, words, param)
	runLottery()
end
lotteryTA:groupType("god")
lotteryTA:register()

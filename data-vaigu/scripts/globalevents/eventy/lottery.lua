local startHours = {
	"17:00:00",
	"20:00:00",
	"23:00:00",
}

local function runLottery()
	local players = Game.getPlayers()
	local onlineList = {}

	for _, targetPlayer in ipairs(players) do
		local hasAccess = targetPlayer:getGroup():getAccess()
		if hasAccess == false then
			table.insert(onlineList, targetPlayer)
		end
	end

	if #onlineList <= 0 then
		return
	end

	local uid = math.random(1, #onlineList)
	local luckyPlayer = onlineList[uid]

	if luckyPlayer then
		luckyPlayer:AddAllCoins(5)
		Game.broadcastMessage("COIN_LOTTERY_WINNER", MESSAGE_STATUS_WARNING, true, { playerName = luckyPlayer:getName(), 5})
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

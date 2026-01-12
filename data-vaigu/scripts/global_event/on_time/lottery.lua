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
		luckyPlayer:AddAllCoins(3)
		Game.broadcastMessage("COIN_LOTTERY_WINNER_BROADCAST_MESSAGE", MESSAGE_STATUS_WARNING, true, { playerName = luckyPlayer:getName(), coins = 3 })
	end
end

local _nextEventId = 0
local function nextLotteryId()
	local result = _nextEventId
	_nextEventId = _nextEventId + 1
	return result
end

local function createAndRegisterEvent(startHour)
	local lotteryEvent = GlobalEvent("CoinLottery" .. nextLotteryId())
	function lotteryEvent.onTime(interval)
		runLottery()
		return true
	end
	lotteryEvent:time(startHour)
	lotteryEvent:register()
end

for hour = 0, 23, 3 do
	createAndRegisterEvent(hour)
end

local lotteryManualRun = TalkAction("!lottery")
function lotteryManualRun.onSay(player, words, param)
	runLottery()
end
lotteryManualRun:groupType("god")
lotteryManualRun:register()

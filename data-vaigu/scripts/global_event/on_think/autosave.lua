--[[
local cleanMapAtSave = false

local function serverSave(interval)
	if cleanMapAtSave then
		cleanMap()
	end

	saveServer()
	--Game.broadcastMessage('Zapis serwera zakonczony. Nastepny za ' .. math.floor(interval / 60000) .. ' minut!', MESSAGE_STATUS_WARNING)
end

local globalevent = GlobalEvent("AutoSave")

function globalevent.onThink(...)
	Game.broadcastMessage("Server save in 10 seconds. It may lag or freeze.", MESSAGE_STATUS_WARNING)
	addEvent(serverSave, 1, interval)
	return true
end

globalevent:interval(30 * 60 * 1) --30min
--globalevent:register()
---]]

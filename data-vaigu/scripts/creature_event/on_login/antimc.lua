local maxClientsPerIp = 6

local playerLogin = CreatureEvent("AntiMc")

function playerLogin.onLogin(player)
	if maxClientsPerIp <= 0 then
		return true
	end

	local loggingInClientIp = player:getIp()
	local sameIpClients = {}

	for _, otherClient in ipairs(Game.getPlayers()) do
		if loggingInClientIp == otherClient:getIp() then
			table.insert(sameIpClients, otherClient)
		end
	end

	if #sameIpClients > maxClientsPerIp then
		for _, client in ipairs(sameIpClients) do
			client:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You can be logged in to up to :maxClientsPerIp: characters at the time!", { maxClientsPerIp = maxClientsPerIp }))
		end
		return false
	end

	return true
end

playerLogin:register()

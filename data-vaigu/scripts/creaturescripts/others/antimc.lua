local maxClientsPerIp = 6

local playerLogin = CreatureEvent("AntiMc")

function playerLogin.onLogin(player)
	if maxClientsPerIp <= 0 then
		return true
	end
	local ipClients = 0
	for _, client in ipairs(Game.getPlayers()) do
		if player:getIp() == client:getIp() then
			ipClients = ipClients + 1
		end
	end
	if ipClients > maxClientsPerIp then
		return false
	end

	return true
end

playerLogin:register()

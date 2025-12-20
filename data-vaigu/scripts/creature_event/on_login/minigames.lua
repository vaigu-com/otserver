local playerLogin = CreatureEvent("MinigamesResetStatus")
function playerLogin.onLogin(player)
	local zones = player:getZones()
	for _, zone in pairs(zones) do
		if zone:isMinigameZone() then
			player:isOnMinigame(true)
			return LOGIN_OK
		end
	end

	player:isOnMinigame(false)
	return LOGIN_OK
end
playerLogin:register()

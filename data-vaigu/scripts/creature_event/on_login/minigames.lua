local playerLogin = CreatureEvent("MinigamesResetFlag")

function playerLogin.onLogin(player)
    player:isOnMinigame(false)
	return true
end

playerLogin:register()

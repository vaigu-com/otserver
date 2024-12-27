local playerLogin = CreatureEvent("MinigamesLeave")

function playerLogin.onLogin(player)
    player:setStorageValue(Storage.Minigames.IsOnMinigame, -1)
	return true
end

playerLogin:register()

local playerLogin = CreatureEvent("MinigamesResetFlag")

function playerLogin.onLogin(player)
    player:setStorageValueByKey(Storage.Minigames.IsOnMinigame, -1)
	return true
end

playerLogin:register()

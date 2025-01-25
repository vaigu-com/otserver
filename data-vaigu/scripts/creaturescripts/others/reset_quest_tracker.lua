local playerLogin = CreatureEvent("ResetQuestTracker")

function playerLogin.onLogin(player)
    player:setStorageValueByKey(Storage.FirstTrackerRequest, FIRST_REQUEST)
	return true
end

playerLogin:register()

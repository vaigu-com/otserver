local closeStartup = GlobalEvent("CloseStartup")
function closeStartup.onStartup()
	print("close")
	Game.setGameState(GAME_STATE_CLOSED)
	return true
end
--closeStartup:register()

local openServer = GlobalEvent("OpenServer")
function openServer.onTime(interval)
	print("open")
	Game.setGameState(GAME_STATE_NORMAL)
	return true
end

openServer:time("19:00:00")
--openServer:register()

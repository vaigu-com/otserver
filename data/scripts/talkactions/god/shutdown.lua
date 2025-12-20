local pcallLuaIngame = TalkAction("/shutdown")
function pcallLuaIngame.onSay(cid, words, param)
	Game.setGameState(GAME_STATE_SHUTDOWN)
end
pcallLuaIngame:separator(" ")
pcallLuaIngame:groupType("god")
pcallLuaIngame:register()

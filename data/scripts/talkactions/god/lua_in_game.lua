local function ingameCall(playerCid, scriptString, mode)
	local script, scriptSyntaxErr = load(scriptString)
	if scriptSyntaxErr or script == nil then
		doPlayerSendTextMessage(playerCid, 25, "Lua syntax error:\n" .. scriptSyntaxErr)
		return
	end
	local returnValue, runtimeError
	if mode == "pcall" then
		returnValue, runtimeError = pcall(script)
	end
	if mode == "call" then
		returnValue, runtimeError = script()
	end

	if runtimeError then
		doPlayerSendTextMessage(playerCid, 25, "Lua runtime error:\n" .. tostring(runtimeError))
		return
	end
	if returnValue then
		doPlayerSendTextMessage(playerCid, 25, "Lua script returned:\n" .. tostring(returnValue))
		return
	end
end

local callLuaIngame = TalkAction("/pcall")
function callLuaIngame.onSay(cid, words, scriptString)
	ingameCall(cid, scriptString, "pcall")
end
callLuaIngame:separator(" ")
callLuaIngame:groupType("god")
callLuaIngame:register()

local pcallLuaIngame = TalkAction("/lua", "/script")
function pcallLuaIngame.onSay(cid, words, param)
	ingameCall(cid, param, "call")
end
pcallLuaIngame:separator(" ")
pcallLuaIngame:groupType("god")
pcallLuaIngame:register()

local startRaid = TalkAction("/raid")

function startRaid.onSay(player, words, raidName)
	-- create log
	logCommand(player, words, raidName)

	if raidName == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end

	local returnValue = LuaRaidRegistry:StartByName(raidName, true)
	if returnValue then
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Raid started.")
	else
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, RETURNVALUE_NOSUCHRAIDEXISTS)
	end
	return true
end

startRaid:separator(" ")
startRaid:groupType("god")
startRaid:register()

local listRaids = TalkAction("/raids")

function listRaids.onSay(player, words, raidName)
	-- create log
	logCommand(player, words, raidName)

	local raids = LuaRaidRegistry:Get()
	local rowSize = math.floor(math.sqrt(TableSize(raids)))
	local namesString = "Available raids: "
	local i = 1
	for _, raid in pairs(raids) do
		if i % rowSize == 0 then
			namesString = namesString .. "\n"
		end
		namesString = namesString .. raid.name .. ", "
		i = i + 1
	end

	player:sendTextMessage(MESSAGE_ADMINISTRATOR, namesString)
	return true
end

listRaids:separator(" ")
listRaids:groupType("god")
listRaids:register()

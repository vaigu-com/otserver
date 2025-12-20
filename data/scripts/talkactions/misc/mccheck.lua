local talkaction = TalkAction("/mccheck")

function talkaction.onSay(admin, words, param)
	admin:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Multiclient Check List:")

	local ipPlayers = {}
	local players = Game.getPlayers()
	for _, player in pairs(players) do
		local ip = player:getIp() or ""
		ipPlayers[ip] = ipPlayers[ip] or {}
		table.insert(ipPlayers[ip], player)
	end

	for ip, players in pairs(ipPlayers) do
		if TableSize(players) > 1 then
			local message = "Ip: " .. Game.convertIpToString(ip)
			for _, player in pairs(players) do
				message = message .. T(":name:, :level:", { name = player:getName(), level = player:getLevel() })
			end
			admin:sendTextMessage(MESSAGE_EVENT_ADVANCE, message .. ".")
		end
	end

	return false
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()

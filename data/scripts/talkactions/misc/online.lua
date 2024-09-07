local playersOnline = TalkAction("!online")

function playersOnline.onSay(player, words, param)
	local players = Game.getPlayers()
	local playerCount = Game.getPlayerCount()
	local vocNames = { "S", "D", "P", "K", "MS", "ED", "RP", "EK" }

	player:sendTextMessage(32, playerCount .. " graczy zalogowanych.")

	local i = 0
	local msg = ""
	for k, targetPlayer in ipairs(players) do
		if player:canSeeCreature(targetPlayer) then
			if i > 0 then
				msg = msg .. ", "
			end

			if targetPlayer:getVocation():getId() > 0 and targetPlayer:getVocation():getId() < 9 then
				msg = msg .. targetPlayer:getName() .. " (" .. targetPlayer:getLevel() .. vocNames[targetPlayer:getVocation():getId()] .. ")"
			else
				msg = msg .. targetPlayer:getName() .. " [" .. targetPlayer:getLevel() .. "]"
			end
			i = i + 1
		end

		if i == 10 then
			if k == playerCount then
				msg = msg .. "."
			else
				msg = msg .. ","
			end
			player:sendTextMessage(30, msg)
			msg = ""
			i = 0
		end
	end

	if i > 0 then
		msg = msg .. "."
		player:sendTextMessage(30, msg)
	end
	return true
end

playersOnline:groupType("normal")
playersOnline:register()

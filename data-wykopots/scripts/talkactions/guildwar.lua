GUILDLEVEL_LEADER = 3
CHANNEL_GUILD = 0x00

function getGuildId(name)
	local result_ptr = db.storeQuery("SELECT `id` FROM `guilds` WHERE `name` = " .. db.escapeString(name) .. ";")
	if not result_ptr then
		return nil
	end
	return result.getDataInt(result_ptr, "id")
end

function getGuildNameById(id)
	local result_ptr = db.storeQuery("SELECT `name` FROM `guilds` WHERE `id` = " .. id .. ";")
	if not result_ptr then
		return nil
	end
	return result.getDataString(result_ptr, "name")
end

local talkaction = TalkAction("!war")

function talkaction.onSay(player, words, param)
	local cooldown = 1 -- seconds, prevent db overload

	if player:getStorageValue(Storage.WarCooldown) <= os.time() then
		player:setStorageValue(Storage.WarCooldown, os.time() + cooldown)

		player:sendCancelMessage("Remember to open your guild chat.")

		local guild = player:getGuild()
		if guild == nil then
			player:sendCancelMessage("You need to be in a guild in order to execute this talkaction.")
			return false
		end

		local guild = getPlayerGuildId(player)
		if not guild or (player:getGuildLevel() < GUILDLEVEL_LEADER) then
			player:sendCancelMessage("You cannot execute this talkaction.")
			return false
		end

		local t = string.split(param, ", ")
		if not t[2] then
			player:sendChannelMessage("", "Warmode commands:", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			player:sendChannelMessage("", "!war invite, guildname, duration(hours): Invite guild to start a war. Duration is optional, default value = 24 hours.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			player:sendChannelMessage("", "!war accept, guildname: Accept the invitation to start a war.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			player:sendChannelMessage("", "!war reject, guildname: Reject the invitation to start a war.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			player:sendChannelMessage("", "!war end, guildname: Ends the war if time is over. Aggressor can end the war before this time.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			return false
		end

		local enemy = getGuildId(t[2])
		if not enemy then
			player:sendChannelMessage("", 'Guild "' .. t[2] .. '" does not exists.', TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			return false
		end

		if enemy == guild then
			player:sendChannelMessage("", "You cannot perform war action on your own guild.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			return false
		end

		local enemyName, tmp = "", db.storeQuery("SELECT `name` FROM `guilds` WHERE `id` = " .. enemy)
		if tmp ~= false then
			enemyName = result.getDataString(tmp, "name")
			result.free(tmp)
		end

		if isInArray({ "accept", "reject", "cancel" }, t[1]) then
			local query = "`guild1` = " .. enemy .. " AND `guild2` = " .. guild
			if t[1] == "cancel" then
				query = "`guild1` = " .. guild .. " AND `guild2` = " .. enemy
			end

			tmp = db.storeQuery("SELECT `id`, `started`, `ended` FROM `guild_wars` WHERE " .. query .. " AND `status` = 0")
			if tmp == false then
				player:sendChannelMessage("", "Currently there's no pending invitation for a war with " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
				return false
			end

			query = "UPDATE `guild_wars` SET "
			local msg = "accepted " .. enemyName .. " invitation to war."
			if t[1] == "reject" then
				query = query .. "`ended` = " .. os.time() .. ", `status` = 2"
				msg = "rejected " .. enemyName .. " invitation to war."
			elseif t[1] == "cancel" then
				query = query .. "`ended` = " .. os.time() .. ", `status` = 3"
				msg = "canceled invitation to a war with " .. enemyName .. "."
			else --accept
				query = query .. "`started` = " .. os.time() .. ", `ended` = " .. ((result.getDataInt(tmp, "ended")) + (os.time() - (result.getDataInt(tmp, "started")))) .. ", `status` = 1"
			end

			query = query .. " WHERE `id` = " .. result.getDataInt(tmp, "id")
			result.free(tmp)
			db.query(query)
			broadcastMessage(getPlayerGuildName(player) .. " has " .. msg, MESSAGE_LOGIN)
			return false
		end

		if t[1] == "invite" then
			local str = ""
			tmp = db.storeQuery("SELECT `guild1`, `status` FROM `guild_wars` WHERE `guild1` IN (" .. guild .. "," .. enemy .. ") AND `guild2` IN (" .. enemy .. "," .. guild .. ") AND `status` IN (0, 1)")
			if tmp ~= false then
				if result.getDataInt(tmp, "status") == 0 then
					if result.getDataInt(tmp, "guild1") == guild then
						str = "You have already invited " .. enemyName .. " to war."
					else
						str = enemyName .. " have already invited you to war."
					end
				else
					str = "You are already on a war with " .. enemyName .. "."
				end

				result.free(tmp)
			end

			if str ~= "" then
				player:sendChannelMessage("", str, TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
				return false
			end

			local warHours = tonumber(t[3])
			if warHours == nil then
				warHours = 24
			end

			local begining, ending = os.time(), warHours
			if ending ~= nil and ending ~= 0 then
				ending = begining + (ending * 3600) --24h
			else
				ending = 0
			end

			db.query("INSERT INTO `guild_wars` (`guild1`, `guild2`, `name1`, `name2`, `started`, `ended`) VALUES (" .. guild .. ", " .. enemy .. ", " .. db.escapeString(getPlayerGuildName(player)) .. ", " .. db.escapeString(enemyName) .. ", " .. begining .. ", " .. ending .. ");")
			broadcastMessage(getPlayerGuildName(player) .. " has invited " .. enemyName .. " for war that will last " .. warHours .. " hours.", MESSAGE_LOGIN)
			return false
		end

		if not isInArray({ "end", "finish" }, t[1]) then
			return false
		end

		local status = (t[1] == "end" and 1 or 4)
		tmp = db.storeQuery("SELECT `id` FROM `guild_wars` WHERE `guild1` = " .. guild .. " AND `guild2` = " .. enemy .. " AND `status` = " .. status) -- jestes agresorem
		if tmp ~= false then
			local query = "UPDATE `guild_wars` SET `ended` = " .. os.time() .. ", `status` = 4 WHERE `id` = " .. result.getDataInt(tmp, "id")
			result.free(tmp)

			db.query(query)
			broadcastMessage(getPlayerGuildName(player) .. " has " .. (status == 4 and "mend fences" or "ended up a war") .. " with " .. enemyName .. ".", MESSAGE_LOGIN)
			return false
		end

		if status == 4 then --ended already
			player:sendChannelMessage("", "Currently there's no pending war truce from " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			return false
		end

		tmp = db.storeQuery("SELECT `id`, `ended` FROM `guild_wars` WHERE `guild1` = " .. enemy .. " AND `guild2` = " .. guild .. " AND `status` = 1") -- jestes broniacym
		if tmp ~= false then
			if result.getDataInt(tmp, "ended") > os.time() then
				result.free(tmp)
				player:sendChannelMessage("", "You cannot request ending for war with " .. enemyName .. " yet.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
				return false
			end

			local query = "UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.time() .. " WHERE `id` = " .. result.getDataInt(tmp, "id")
			result.free(tmp)

			db.query(query)
			broadcastMessage(getPlayerGuildName(player) .. " has signed an armstice declaration on a war with " .. enemyName .. ".", MESSAGE_LOGIN)
			return false
		end

		player:sendChannelMessage("", "Currently there's no active war with " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Can only be executed once every " .. cooldown .. " seconds. Remaining cooldown: " .. player:getStorageValue(storage) - os.time())
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()

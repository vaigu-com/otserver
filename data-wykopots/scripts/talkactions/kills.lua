local talkaction = TalkAction("!kills", "!frags")

function talkaction.onSay(player, words, param)
	local fragTime = configManager.getNumber(configKeys.FRAG_TIME)
	local skullTime = player:getSkullTime()
	if skullTime <= 0 then
		player:sendTextMessage(22, "You do not have any kills.")
		return false
	end

	local kills = math.ceil(skullTime / fragTime)
	local remainingSeconds = math.floor(skullTime % fragTime)

	local hours = math.floor(remainingSeconds / 3600)
	local minutes = math.floor((remainingSeconds % 3600) / 60)
	local seconds = remainingSeconds % 60

	local message = "You have " .. kills .. " unjustified kill" .. (kills > 1 and "s" or "") .. ". It will decrease after: "
	if hours ~= 0 then
		if hours == 1 then
			message = message .. hours .. " hour, "
		else
			message = message .. hours .. " hours, "
		end
	end

	if hours ~= 0 or minutes ~= 0 then
		if minutes == 1 then
			message = message .. minutes .. " minute and "
		else
			message = message .. minutes .. " minutes and "
		end
	end

	if seconds == 1 then
		message = message .. seconds .. " second."
	else
		message = message .. seconds .. " seconds."
	end

	player:sendTextMessage(22, message)

	-- RED SKULL START
	local rsskullTime = player:getRSSkullTime()
	if player:getSkull() == SKULL_RED then
		local rsskullTime = player:getRSSkullTime()
		if rsskullTime <= 0 then
			return false
		end
		local rsremainingSeconds = math.floor(rsskullTime)
		local rsdays = math.floor(rsremainingSeconds / (24 * 3600))
		local rshours = math.floor((rsremainingSeconds % (24 * 3600)) / 3600)
		local rsminutes = math.floor((rsremainingSeconds % 3600) / 60)
		local rsseconds = rsremainingSeconds % 60

		local rsmessage = "Your red skull will last for: "

		local function appendTimeUnit(value, unit)
			if value ~= 0 then
				rsmessage = rsmessage .. value .. " " .. unit
				if value > 1 then
					rsmessage = rsmessage .. "s"
				end
				rsmessage = rsmessage .. ", "
			end
		end

		appendTimeUnit(rsdays, "day")
		appendTimeUnit(rshours, "hour")
		appendTimeUnit(rsminutes, "minute")
		appendTimeUnit(rsseconds, "second")

		rsmessage = rsmessage:sub(1, -3) .. "."
		player:sendTextMessage(22, rsmessage)
	end

	-- BLACK SKULL START
	local bsskullTime = player:getBSSkullTime()
	if player:getSkull() == SKULL_BLACK then
		local bsskullTime = player:getBSSkullTime()
		if bsskullTime <= 0 then
			return false
		end
		local bsremainingSeconds = math.floor(bsskullTime)
		local bsdays = math.floor(bsremainingSeconds / (24 * 3600))
		local bshours = math.floor((bsremainingSeconds % (24 * 3600)) / 3600)
		local bsminutes = math.floor((bsremainingSeconds % 3600) / 60)
		local bsseconds = bsremainingSeconds % 60

		local bsmessage = "Your black skull will last for: "

		local function appendTimeUnit(value, unit)
			if value ~= 0 then
				bsmessage = bsmessage .. value .. " " .. unit
				if value > 1 then
					bsmessage = bsmessage .. "s"
				end
				bsmessage = bsmessage .. ", "
			end
		end

		appendTimeUnit(bsdays, "day")
		appendTimeUnit(bshours, "hour")
		appendTimeUnit(bsminutes, "minute")
		appendTimeUnit(bsseconds, "second")

		bsmessage = bsmessage:sub(1, -3) .. "."
		player:sendTextMessage(22, bsmessage)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()

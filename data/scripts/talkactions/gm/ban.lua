local banDays = 7

local ban = TalkAction("/ban")

function ban.onSay(executioner, _, offenderName)
	-- create log
	logCommand(executioner, _, offenderName)

	if offenderName == "" then
		executioner:sendCancelMessage("Command param required. Usage: /ban nick, reason, days")
		return true
	end

	local name = offenderName
	local reason = ""

	local separatorPos = offenderName:find(",")
	if separatorPos then
		name = offenderName:sub(0, separatorPos - 1)
		reason = string.trim(offenderName:sub(separatorPos + 1))
	end

	local accountId = getAccountNumberByPlayerName(name)
	if accountId == 0 then
		return true
	end

	local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
	if resultId ~= false then
		Result.free(resultId)
		return true
	end

	local timeNow = os.time()
	db.query("INSERT INTO `account_bans` (`account_id`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(reason) .. ", " .. timeNow .. ", " .. timeNow + (banDays * 86400) .. ", " .. executioner:getGuid() .. ")")
	local message = T(":offender: has been banned for :banDays: days", { offender = offenderName, banDays = banDays })
	executioner:sendTextMessage(MESSAGE_ADMINISTRATOR, message)
	local offender = Player(name)

	local announcement = T(":offender: has been banned; reason: :reason:. (by: :executioner:)", { offender = offenderName, reason = reason, executioner = executioner:getName() })
	Webhook.sendMessage("Player Banned", announcement, WEBHOOK_COLOR_YELLOW, announcementChannels["serverAnnouncements"])

	if offender then
		offender:remove()
	end
end

ban:separator(" ")
ban:groupType("gamemaster")
ban:register()

local talkaction = TalkAction("!fraginfo", "!skullinfo", "!killinfo")

function talkaction.onSay(player, words, param)
	if getPlayerLanguage(player) == "PL" then
		player:popupFYI(
			"Pvp system info:"
				.. "\n"
				.. "\nPvp system: "
				.. "\nRetro pvp with orange skull. "
				.. "\n"
				.. "\nKills to red skull: "
				.. "\nDaily: "
				.. configManager.getNumber(configKeys.DAY_KILLS_TO_RED)
				.. "\nWeekly: "
				.. configManager.getNumber(configKeys.WEEK_KILLS_TO_RED)
				.. "\nMonthly: "
				.. configManager.getNumber(configKeys.MONTH_KILLS_TO_RED)
				.. "\n"
				.. "\nKills to black skull: "
				.. "\nDaily: "
				.. configManager.getNumber(configKeys.DAY_KILLS_TO_BLACK)
				.. "\nWeekly: "
				.. configManager.getNumber(configKeys.WEEK_KILLS_TO_BLACK)
				.. "\nMonthly: "
				.. configManager.getNumber(configKeys.MONTH_KILLS_TO_BLACK)
				.. "\n"
				.. "\nSkull durations: "
				.. "\nRed skull: "
				.. configManager.getNumber(configKeys.RED_SKULL_DURATION)
				.. " days"
				.. "\nBlack skull: "
				.. configManager.getNumber(configKeys.BLACK_SKULL_DURATION)
				.. " days"
				.. "\nOrange skull: "
				.. configManager.getNumber(configKeys.ORANGE_SKULL_DURATION)
				.. " days"
				.. "\nWhite skull: 15min"
				.. "\n"
				.. "\nWraz z kazdym fragiem wbitym podczas\nposiadania red/black skulla czas jego\ntrwania zostaje przedluzony o 1 dzien."
		)
	else
		player:popupFYI(
			"Pvp system info:"
				.. "\n"
				.. "\nPvp system: "
				.. "\nRetro pvp with orange skull. "
				.. "\n"
				.. "\nKills to red skull: "
				.. "\nDaily: "
				.. configManager.getNumber(configKeys.DAY_KILLS_TO_RED)
				.. "\nWeekly: "
				.. configManager.getNumber(configKeys.WEEK_KILLS_TO_RED)
				.. "\nMonthly: "
				.. configManager.getNumber(configKeys.MONTH_KILLS_TO_RED)
				.. "\n"
				.. "\nKills to black skull: "
				.. "\nDaily: "
				.. configManager.getNumber(configKeys.DAY_KILLS_TO_BLACK)
				.. "\nWeekly: "
				.. configManager.getNumber(configKeys.WEEK_KILLS_TO_BLACK)
				.. "\nMonthly: "
				.. configManager.getNumber(configKeys.MONTH_KILLS_TO_BLACK)
				.. "\n"
				.. "\nSkull durations: "
				.. "\nRed skull: "
				.. configManager.getNumber(configKeys.RED_SKULL_DURATION)
				.. " days"
				.. "\nBlack skull: "
				.. configManager.getNumber(configKeys.BLACK_SKULL_DURATION)
				.. " days"
				.. "\nOrange skull: "
				.. configManager.getNumber(configKeys.ORANGE_SKULL_DURATION)
				.. " days"
				.. "\nWhite skull: 15min"
				.. "\n"
				.. "\nWith each frag gained while having\nred/black skull its duration is being\nextended for addidtional 24 hours."
		)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()

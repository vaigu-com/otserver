local globalevent = GlobalEvent("autoBroadcast")

function globalevent.onThink(...)
	local MESSAGE = {
		"[KOMENDY] !serverinfo - !pvpinfo - !online - !uptime - !outfit - !spells - !kills - !bless - !buyhouse - !sellhouse",
		"[BETA TEST] Znalazles jakis blad? Zglos to przez klienta lub napisz na forum!",
		"[UWAGA] Nikt z administracji NIGDY nie spyta Cie o haslo. Nie daj sie okrasc!",
	}
	Game.broadcastMessage(MESSAGE[math.random(1, #MESSAGE)], MESSAGE_EVENT_ADVANCE)
	return true
end

globalevent:interval(15 * 60 * 1000) --15min
--globalevent:register()

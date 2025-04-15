local loginEvents = CreatureEvent("LoginEvents")
function loginEvents.onLogin(player)
	local events = {
		--Events
		"ZombieLifeSteal",
		"MinigamesLeave",
		--Modal
		"language",
		"addon",
		"ships",
		"tasks",
		"daily",
		--Others
		"MagicConverter",
		"AntiMc",
		"FirstLogin",
		"tp_save",
		"sharedLife",
		"PlayerDeathByCow",
		"AdvanceSave",
		"BossParticipation",
		"DropLoot",
		"PlayerDeath",
		"FamiliarLogin",
		"FamiliarAdvance",
		--"Recompense",
		-- Concoctions
		"ConcoctionsOnLogin",
	}

	for i = 1, #events do
		player:registerEvent(events[i])
	end
	return true
end
loginEvents:register()

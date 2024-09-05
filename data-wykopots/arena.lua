rooms = {
	[1] = {
		teleportPosition = Position(6910, 657, 7),
		centerPosition = Position(6905, 654, 7),
	},
	[2] = {
		teleportPosition = Position(6895, 657, 7),
		centerPosition = Position(6890, 654, 7),
	},
	[3] = {
		teleportPosition = Position(6880, 657, 7),
		centerPosition = Position(6875, 654, 7),
	},
	[4] = {
		teleportPosition = Position(6865, 657, 7),
		centerPosition = Position(6860, 654, 7),
	},
	[5] = {
		teleportPosition = Position(6873, 641, 7),
		centerPosition = Position(6868, 638, 7),
	},
	[6] = {
		teleportPosition = Position(6888, 641, 7),
		centerPosition = Position(6883, 638, 7),
	},
	[7] = {
		teleportPosition = Position(4203, 641, 7),
		centerPosition = Position(6898, 638, 7),
	},
	[8] = {
		teleportPosition = Position(6896, 625, 7),
		centerPosition = Position(6891, 622, 7),
	},
	[9] = {
		teleportPosition = Position(6881, 625, 7),
		centerPosition = Position(6876, 622, 7),
	},
	[10] = {
		teleportPosition = Position(6889, 609, 7),
		centerPosition = Position(6884, 606, 7),
	},
}

arena_bosses = {
	"frostfur",
	"bloodpaw",
	"bovinus",
	"achad",
	"colerian the barbarian",
	"the hairy one",
	"axeitus headbanger",
	"rocky",
	"cursed gladiator",
	"orcus the cruel",
	"avalanche",
	"kreebosh the exile",
	"the dark dancer",
	"the hag",
	"slim",
	"grimgor guteater",
	"drasilla",
	"spirit of earth",
	"spirit of water",
	"spirit of fire",
	"webster",
	"darakan the executioner",
	"norgle glacierbeard",
	"the pit lord",
	"svoren the mad",
	"the masked marauder",
	"gnorre chyllson",
	"fallen mooh'tah master ghar",
	"deathbringer",
	"the obliverator",
}

function roomsIsOccupied()
	for i = 1, #rooms do
		local spectators = Game.getSpectators(rooms[i].centerPosition, false, false, 7, 7, 7, 7)
		if #spectators == 0 then
			return false
		end
	end
	return true
end

function clearArena(playerId, bossId, room)
	local spectators, spectator = Game.getSpectators(rooms[room].centerPosition, false, false, 7, 7, 7, 7)
	local exitPosition = Position(6933, 651, 7)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
			spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Czas na pokonanie przeciwnika sie skonczyl.")
		end

		if spectator:isMonster() and spectator.uid == bossId then
			spectator:remove()
		end
	end
end

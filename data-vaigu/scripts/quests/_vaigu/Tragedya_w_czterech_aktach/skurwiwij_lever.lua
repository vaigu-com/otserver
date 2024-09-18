local skurwiwijLever = {
	encounterName = "skurwiwij-lair",

	lockoutTime = LOCKOUT_TIME.WEEKLY,
	lockoutType = LOCKOUT_TYPE.ON_KILL,

	entranceTiles = {
		{ pos = Position(6577, 557, 9), destination = Position(6546, 543, 9) },
		{ pos = Position(6578, 557, 9), destination = Position(6547, 543, 9) },
		{ pos = Position(6579, 557, 9), destination = Position(6548, 543, 9) },
		{ pos = Position(6580, 557, 9), destination = Position(6549, 543, 9) },
	},

	exitTpDestination = Position(6582, 557, 9),
	exitTpPosition = SKURWIWIJ_ANCHOR:Moved(19, 9, 0),

	-- ToDo: hp and (slight) damage scaling
	-- scalingConfig = { hpPerPlayer = 1 },

	requiredState = { [Storage.FourActTragedy.SkurwiwijAccess] = 1 },
}

EncounterLever(skurwiwijLever):position(Position(6576, 557, 9)):register()

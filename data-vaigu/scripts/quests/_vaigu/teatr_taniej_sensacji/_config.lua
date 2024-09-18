TEATR_TANIEJ_SENSACJI_KEY_ITEMS = {
	cheese = { aid = Storage.TheaterOfCheapThrills.Rewards.Cheese, id = 3607, desc = "100 Year Old Aged Cheese" },
}

TEATR_TANIEJ_SENSACJI_PLUS_SHAPE = {
	unlitToLit = { [28458] = 28459, [28452] = 28453, [28454] = 28455, [28456] = 28457 },
	litToUnlit = { [28459] = 28458, [28453] = 28452, [28455] = 28454, [28457] = 28456 },
	aidToMachineConfig = {
		[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineNorth] = {
			topLeft = LIBRUM_VORTEX_ANCHOR:Moved(5, -1, 0),
			downRight = LIBRUM_VORTEX_ANCHOR:Moved(9, 3, 0),
			pillar = { pos = Vector(-4, -12, 0), litId = 28138, unlitId = 28890 },
		},
		[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineCenter] = {
			topLeft = LIBRUM_VORTEX_ANCHOR:Moved(3, 9, 0),
			downRight = LIBRUM_VORTEX_ANCHOR:Moved(5, 11, 0),
			pillar = { pos = Vector(-2, -12, 0), litId = 28140, unlitId = 28891 },
		},
		[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineWest] = {
			topLeft = LIBRUM_VORTEX_ANCHOR:Moved(-9, 11, 0),
			downRight = LIBRUM_VORTEX_ANCHOR:Moved(-6, 15, 0),
			pillar = { pos = Vector(-4, -13, 1), litId = 28137, unlitId = 28889 },
		},
	},
	book = { lit = 28139, unlit = 28888, pos = { x = -3, y = -12, z = 0 } },
}

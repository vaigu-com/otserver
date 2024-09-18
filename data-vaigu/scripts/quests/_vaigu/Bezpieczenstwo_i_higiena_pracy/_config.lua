BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_CONDITIONS = {
	timeIsNight = function(context)
		local timeOfDay = getTibiaTimerDayOrNight()
		if timeOfDay == "night" then
			return true
		end
		return false
	end,
}

BEZPIECZENSTWO_I_HIEGIENA_PRACY_KEY_ITEMS = {
	grazynaDocument = {
		id = 2815,
		text = "scp420text",
		addToStore = false,
		aid = Storage.SafetyAndOccupationalHygiene.Scp420Document,
	},
}

BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS = {
	turdstinAttack = function(context)
		local pos = context.player:getPosition()
		local playerId = context.player:getId()
		SpawnMonstersAtPos("Gang Member", pos, 5)
		addEvent(function()
			SpawnMonstersAtPos("Gang Member", pos, 5)
		end, 5 * 1000)
		addEvent(function()
			SpawnMonstersAtPos("Crazed Beggar", pos, 5)
			if BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_CONDITIONS.timeIsNight() == false then
				SpawnMonstersAtPos("Vile Grandmaster", pos, 1)
			end
		end, 1000 * 15)
		addEvent(function()
			local player = Player(playerId)
			if player then
				UpdateStorages(player, {
					[Storage.SafetyAndOccupationalHygiene.Questline] = 8,
					[Storage.SafetyAndOccupationalHygiene.Mission03] = 2,
				})
			end
		end, 1000 * 15)
	end,
	feministCake = function(context)
		local player = context.player
		if not player then
			return
		end
		if player:HasItems({ { id = 6277 } }) then
			player:RemoveItems({ { id = 6277 } })
			return
		end

		local pos = player:getPosition()
		local feminists = {}
		for _ = 1, 3 do
			local monster = Game.createMonster("Shaper Matriarch", pos)
			monster:setOutfit({
				lookType = 932,
				lookHead = 91,
				lookBody = 1,
				lookLegs = 94,
				lookFeet = 122,
				lookAddons = 0,
				lookMount = 0,
			})
			feminists[#feminists + 1] = monster
		end
		addEvent(function()
			for _, feminist in pairs(feminists) do
				if Creature(feminist) then
					feminist:remove()
				end
			end
		end, 1000 * 40)
		local wallPositions = { Position(5744, 1499, 5), Position(5744, 1500, 5) }

		for _, wallPosition in pairs(wallPositions) do
			local wall = Game.createItem(2128, 1, wallPosition)
			wall:decay()
		end
	end,
}

BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS = {
	[Storage.SafetyAndOccupationalHygiene.Portals.ToMagicianTown] = MIRKO_MAGICIANS_ANCHOR:Moved(17, 12, -5),
	[Storage.SafetyAndOccupationalHygiene.Portals.ToPetrus] = PETRUS_CIEMIEZCA_ANCHOR:Moved(0, 0, 0),
}

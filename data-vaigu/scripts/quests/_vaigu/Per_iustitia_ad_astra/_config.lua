local penatlyRoomPos = HUGO_TAR_PLANET_ANCHOR:Moved(-12, 5, 1)

PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS = {
	officerCaughtYou = function(context)
		local player = context.player
		if player then
			player:teleportTo(penatlyRoomPos)
			penatlyRoomPos:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		end
	end,
}

PER_IUSTITIA_AD_ASTRA_SPECIAL_CONDITIONS = {
	saidRubelsteinsChecksum = function(context)
		local player = context.player
		local number = context.msg
		local requiredNumber = player:getStorageValue(Storage.PerIustitiaAdAstra.RubelsteinChecksum)
		return tostring(number) == tostring(requiredNumber)
	end,
}

PER_IUSTITIA_AD_ASTRA_KEY_ITEMS = {
	converter = {
		id = 21761,
		aid = Storage.PerIustitiaAdAstra.Rewards.Converter,
	},
	engineBlueprint = {
		id = 2822,
		aid = Storage.PerIustitiaAdAstra.Rewards.EngineBlueprint,
		desc = "Rocket engine blueprint. Qasim might have a use for it",
	},
	map1 = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map1,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	map2 = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map2,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	map3 = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map3,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	fuelRod = { id = 7752, desc = "Fissile fuel rod" },
	rocketFuel = { id = 24948, aid = Storage.PerIustitiaAdAstra.Rewards.RocketFuel, desc = "Rocket fuel" },
	swagierCrate = {
		id = 2471,
		aid = Storage.PerIustitiaAdAstra.Rewards.SwagierCrate,
		desc = "Crate of rods. Recipient: Swagger",
	},
	rubelsteinScroll = {
		id = 2815,
		aid = Storage.PerIustitiaAdAstra.Rewards.RubelsteinScroll,
		desc = "RubelsteinScrollDesc",
		addToStore = false,
	},
	officerId = {
		id = 3507,
		text = "Name: Friedrich Knopf \nNationality: Kuuyvdoobie",
	},
	hugoRecipe = {
		id = 2815,
		aid = Storage.PerIustitiaAdAstra.Rewards.HugoRecipe,
		desc = "Booty Sweat Lean recipe",
	},
	lecinaHammer = {
		id = 3460,
		aid = Storage.PerIustitiaAdAstra.HammerUse,
		desc = "Power Hammer MK3. Collectible - not for professional use",
	},
}

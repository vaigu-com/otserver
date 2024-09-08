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
	["CONVERTER"] = {
		id = 21761,
		aid = Storage.PerIustitiaAdAstra.Rewards.Converter,
	},
	["ENGINE_BLUEPRINT"] = {
		id = 2822,
		aid = Storage.PerIustitiaAdAstra.Rewards.EngineBlueprint,
		desc = "Rocket engine blueprint. Qasim might have a use for it",
	},
	["MAP1"] = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map1,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	["MAP2"] = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map2,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	["MAP3"] = {
		id = 2823,
		aid = Storage.PerIustitiaAdAstra.Rewards.Map3,
		desc = "Galactic map fragment. Qasim requested three of those",
	},
	["FUEL_ROD"] = { id = 7752, desc = "Fissile fuel rod" },
	["ROCKET_FUEL"] = { id = 24948, aid = Storage.PerIustitiaAdAstra.Rewards.RocketFuel, desc = "Rocket fuel" },
	["SWAGIER_CRATE"] = {
		id = 2471,
		aid = Storage.PerIustitiaAdAstra.Rewards.SwagierCrate,
		desc = "Crate of rods. Recipient: Swagger",
	},
	["RUBELSTEIN_SCROLL"] = {
		id = 2815,
		aid = Storage.PerIustitiaAdAstra.Rewards.RubelsteinScroll,
		desc = "RubelsteinScrollDesc",
		addToStore = false,
	},
	["OFFICER_ID"] = {
		id = 3507,
		text = "Name: Friedrich Knopf \nNationality: Kuuyvdoobie",
	},
	["HUGO_RECIPE"] = {
		id = 2815,
		aid = Storage.PerIustitiaAdAstra.Rewards.HugoRecipe,
		desc = "Booty Sweat Lean recipe",
	},
	["LECINA_HAMMER"] = {
		id = 3460,
		aid = Storage.PerIustitiaAdAstra.HammerUse,
		desc = "Power Hammer MK3. Collectible - not for professional use",
	},
}

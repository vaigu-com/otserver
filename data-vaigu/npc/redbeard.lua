local name = "Redbeard"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local dialogs = {
	[LOCALIZERS.Universal] = {
		[{ "sail", "playnac" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = CreateTransportWindow,
					transports = TRANSPORT_ROUTES.REDBEARD_SHIP,
					transportType = TRANSPORT_TYPE.SHIP,
				},
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.playerIsPzLocked,
					requiredOutcome = false,
					textNoRequiredCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
				},
			},
		},
		[GREET] = { text = "Welcome to my ship. Where would you like to {sail}?" },
	},
	--3af
	[{ "mission", "misja" }] = {
		text = "",
		requiredItems = {
			{ id = 11457 },
			{ id = 10282 },
			{ id = 10449 },
		},
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)

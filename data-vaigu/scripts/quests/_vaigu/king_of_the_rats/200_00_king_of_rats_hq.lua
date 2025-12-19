local quest = Quest(LOCALIZERS.KingOfRatsHQ)

quest
	:Storage(function()
		Storage.KingOfRatsHQ = {
			Mission01 = {},
			Portals = {
				Ryan = {},
				SweatyCyclops = {},
				Djinns = {},
				HurghadaEast = {},
				Asuras = {},
				NorthKongo = {},
				VampireCity = {},
				Werebadgers = {},
			},
			CollectibleArtifacts = {
				LibrumVortex = {},
				Wifebeater = {},
				Ytong = {},
				Bottomless = {},
				Bribeslippers = {},
				Antigone = {},
				Sylykonrydel = {},
				Hammer = {},
				Cultivator = {},
			},
			ArtifactContainer = {
				Ytong = {},
				Cultivator = {},
				Bottomless = {},
				Antigone = {},
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.KingOfRatsHQ = {
			LibrumVortex = { -- TheaterOfCheapThrills
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.LibrumVortex,
				id = 27931,
				desc = "Librum Vortex. Romek, the King of Rats might be interested in it.",
			},
			Wifebeater = { -- TheaterOfCheapThrills
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Wifebeater,
				id = 11546,
				desc = "Vestments of Wifebeaterous Regent. Romek, the King of Rats might be interested in it.",
			},
			Ytong = { -- SafetyAndOccupationalHygiene
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Ytong,
				id = 3461,
				desc = "The Ytong of The Fittest. Romek, the King of Rats might be interested in it.",
			},
			Bottomless = { -- ThreeSramatiansAndTheDragon
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Bottomless,
				id = 650,
				desc = "The Bottomless Bud Light. Romek, the King of Rats might be interested in it.",
			},
			Bribeslippers = { -- FourActTragedy
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Bribeslippers,
				id = 24409,
				desc = "The Slippers of Bribery. Romek, the King of Rats might be interested in it.",
			},
			Antigone = { -- PerIustitiaAdAstra
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Antigone,
				id = 4844,
				desc = "Sophocles' Antigone. Better than just Antigone. The King of Rats might be intersted in it.",
			},
			Cultivator = { -- ProdigalSon
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Cultivator,
				id = 3452,
				desc = "Cultivator of ULTIMATENESS. The King of Rats might be intersted in it.",
			},
			--tbd
			Sylykonrydel = {
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Sylykonrydel,
				id = 31334,
				desc = "The Silcon Riddle. Romek, the King of Rats might be interested in it.",
			},
			Hammer = {
				key = Storage.KingOfRatsHQ.CollectibleArtifacts.Hammer,
				id = 3459,
				desc = "The Hammer of Epiphany. Romek, the King of Rats might be interested in it.",
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "King of Rats Headquarters",
			localizer = localizer,
			missions = {
				{
					name = "Current HeadQuarters status",
					storage = Storage.KingOfRatsHQ.Mission01,
					description = "",
					autoTrack = DONT_AUTOTRACK,
					states = {
						[MISSION_STARTED] = "King of Rats Headquarters Status",
						[MISSION_FINISHED] = "King of Rats Headquarters Status",
					},
				},
				{
					name = "01. to Ryan",
					storage = Storage.KingOfRatsHQ.Portals.Ryan,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "02. to Sweaty Cyclops",
					storage = Storage.KingOfRatsHQ.Portals.SweatyCyclops,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "03. to Djinns",
					storage = Storage.KingOfRatsHQ.Portals.Djinns,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "04. to North Kongo",
					storage = Storage.KingOfRatsHQ.Portals.NorthKongo,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "05. to Werebadgers",
					storage = Storage.KingOfRatsHQ.Portals.Werebadgers,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "06. to Vampire city",
					storage = Storage.KingOfRatsHQ.Portals.VampireCity,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "07. to East Hurgahada",
					storage = Storage.KingOfRatsHQ.Portals.HurghadaEast,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
				{
					name = "08. to Asuras",
					storage = Storage.KingOfRatsHQ.Portals.Asuras,
					description = "You unlocked this teleport",
					autoTrack = DONT_AUTOTRACK,
				},
			},
		})
	end)
	:Mission(Storage.KingOfRatsHQ.Mission01)
	:State(function()
		return ANY_STATE,
			QuestFactory.Dialog("GM Romek", {
				[{ "artifact", "artifacts", "artefakt", "artefakty" }] = {
					text = "Ancient artifacts of the first King of Rats. I'll keep them for the darkest hour. If you've found any artifact, just tell me which one. If it's legit, I'll unlock one of the pipes for you.",
				},
				[{ "librum vortex" }] = {
					text = "Book of rat spells. It will surely come in handy.",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.LibrumVortex },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.LibrumVortex] = MISSION_FINISHED,
					},
				},
				[{ "zonobijka", "wifebeater", "vestments", "zonobijka wladzy", "vestments of wifebeaterous regent" }] = {
					text = "It looks like an ordinary shirt, but it provides the bearer with immunity to mail from the Domestic Violence Monitoring Center.",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Wifebeater },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.Djinns] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Wifebeater] = MISSION_FINISHED,
					},
				},
				[{ "ytong" }] = {
					text = "It is said that this item can bend time itself. Metal part can bend itself, so there is only time missing.",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Ytong },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.NorthKongo] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Ytong] = MISSION_FINISHED,
					},
				},
				[{ "bottomless", "bud light", "bezdenny", "harnas" }] = {
					text = "Do you think your Wu-Dka sword can defeat me?",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Bottomless },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.Werebadgers] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Bottomless] = MISSION_FINISHED,
					},
				},
				[{ "bribeslippers","slippers of bribery", "kapcie", "kapcie przekupstwa" }] = {
					text = "Now that i see them myself, they remind me of some other slippers... can't really put my finger on it though.",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Bribeslippers },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.VampireCity] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Bribeslippers] = MISSION_FINISHED,
					},
				},
				[{ "antigone", "antygona" }] = {
					text = "A reliable source of good ol' knowledge on justice.",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Antigone },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.Asuras] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Antigone] = MISSION_FINISHED,
					},
				},
				[{ "cultivator", "kultywator" }] = {
					text = "Strapping this to your belt will allow you to farm up to 1000 thousands of gold per hour, but only in dead MMORPGs. It isn't very useful, is it?",
					requiredItems = { QuestKeyItems.KingOfRatsHQ.Cultivator },
					nextState = {
						[Storage.KingOfRatsHQ.Portals.HurghadaEast] = ACCESS_GRANTED,
						[Storage.KingOfRatsHQ.CollectibleArtifacts.Cultivator] = MISSION_FINISHED,
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				KROL_SZCZUROW_TELEPORT_HUB_DESINATIONS_IN = {
					[Storage.KingOfRatsHQ.Portals.Ryan] = { -1, 3, 0 },
					[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = { -2, -2, 0 },
					[Storage.KingOfRatsHQ.Portals.Djinns] = { 0, -3, 0 },
					[Storage.KingOfRatsHQ.Portals.NorthKongo] = { 3, -1, 0 },
					[Storage.KingOfRatsHQ.Portals.Werebadgers] = { 3, 2, 0 },
					[Storage.KingOfRatsHQ.Portals.VampireCity] = { -5, 9, -1 },
					[Storage.KingOfRatsHQ.Portals.Asuras] = { 2, 12, -1 },
					[Storage.KingOfRatsHQ.Portals.HurghadaEast] = { -3, -6, -2 },
				}

				KROL_SZCZUROW_TELEPORT_HUB_DESTINATIONS_OUT = {
					[Storage.KingOfRatsHQ.Portals.Ryan] = Position(5564, 1577, 8), --baseline
					[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = Position(5971, 1480, 7), --theater
					[Storage.KingOfRatsHQ.Portals.Djinns] = Position(6658, 1242, 6), --theater
					[Storage.KingOfRatsHQ.Portals.NorthKongo] = Position(6692, 487, 7), --osha
					[Storage.KingOfRatsHQ.Portals.Werebadgers] = Position(6279, 989, 7), --sramatians
					[Storage.KingOfRatsHQ.Portals.VampireCity] = Position(6138, 846, 7), --tregedy
					[Storage.KingOfRatsHQ.Portals.Asuras] = Position(6677, 994, 7), --per iustitia
					[Storage.KingOfRatsHQ.Portals.HurghadaEast] = Position(6917, 1320, 5), --prodigal son
				}

				local leverIds = {
					[2773] = true,
					[1931] = true,
				}

				local function onFailedUse(player, fromPosition)
					if fromPosition then
						player:teleportTo(fromPosition)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					end
					player:say(player:Localizer(LOCALIZERS.KingOfRatsHQ):Get("You cannot use this pipe yet."), TALKTYPE_MONSTER_SAY)
				end

				local function canUsePipe(player, key)
					return player:getStorageValueByKey(key) == ACCESS_GRANTED
				end

				local lever = Action()
				function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if isPlayerPzLocked(player) then
						SendPlayerIsPzLocked(player)
						return false
					end

					if not player:isPlayer() then
						return false
					end

					if leverIds[item:getId()] == nil then
						return
					end

					local key = item:getKey()
					if not canUsePipe(player, key) then
						onFailedUse(player)
						return false
					end

					local toPos = KING_OF_RATS_HQ_ANCHOR:Moved(KROL_SZCZUROW_TELEPORT_HUB_DESINATIONS_IN[key])
					player:teleportTo(toPos)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return false
				end
				for _, portalStorage in pairs(Storage.KingOfRatsHQ.Portals) do
					lever:key(portalStorage)
				end
				lever:register()

				local portal = MoveEvent()

				function portal.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return false
					end

					if isPlayerPzLocked(player) then
						player:sendTextMessage(MESSAGE_FAILURE, "You cannot enter a protection zone after attacking another player.")
						return false
					end

					local key = item:getKey()
					if not canUsePipe(player, key) then
						onFailedUse(player, fromPosition)
						return
					end

					player:teleportTo(KROL_SZCZUROW_TELEPORT_HUB_DESTINATIONS_OUT[key]) -- static pos
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				for _, portalStorage in pairs(Storage.KingOfRatsHQ.Portals) do
					portal:key(portalStorage)
				end
				portal:type("stepin")
				portal:register()
			end)
	end)
	:Register()

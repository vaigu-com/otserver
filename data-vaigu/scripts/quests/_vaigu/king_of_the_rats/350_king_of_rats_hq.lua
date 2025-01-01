local quest = Quest(LOCALIZERS.KingOfRatsHQ)

quest
	:Storage(function()
		Storage.KingOfRatsHQ = {
			Mission01 = NextStorage(),
			Portals = {
				Ryan = NextStorage(),
				SweatyCyclops = NextStorage(),
				Djinns = NextStorage(),
				HurghadaEast = NextStorage(),
				Asuras = NextStorage(),
				NorthKongo = NextStorage(),
				VampireCity = NextStorage(),
				Werebadgers = NextStorage(),
			},
			Items = {
				LibrumVortex = NextStorage(),
				Wifebeater = NextStorage(),
				Ytong = NextStorage(),
				Bottomless = NextStorage(),
				Bribeslippers = NextStorage(),
				Antigone = NextStorage(),
				Sylykonrydel = NextStorage(),
				Hammer = NextStorage(),
				Cultivator = NextStorage(),
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.KingOfRatsHQ = {
			LibrumVortex = { -- TheaterOfCheapThrills
				aid = Storage.KingOfRatsHQ.Items.LibrumVortex,
				id = 27931,
				desc = "Librum Vortex. Romek, the King of Rats might be interested in it.",
			},
			Wifebeater = { -- TheaterOfCheapThrills
				aid = Storage.KingOfRatsHQ.Items.Wifebeater,
				id = 11546,
				desc = "Vestments of Wifebeaterous Regent. Romek, the King of Rats might be interested in it.",
			},
			Ytong = { -- SafetyAndOccupationalHygiene
				aid = Storage.KingOfRatsHQ.Items.Ytong,
				id = 3461,
				desc = "The Ytong of The Fittest. Romek, the King of Rats might be interested in it.",
			},
			Bottomless = { -- ThreeSramatiansAndTheDragon
				aid = Storage.KingOfRatsHQ.Items.Bottomless,
				id = 650,
				desc = "The Bottomless Bud Light. Romek, the King of Rats might be interested in it.",
			},
			Bribeslippers = { -- FourActTragedy
				aid = Storage.KingOfRatsHQ.Items.Bribeslippers,
				id = 24409,
				desc = "The Slippers of Bribery. Romek, the King of Rats might be interested in it.",
			},
			Antigone = { -- PerIustitiaAdAstra
				aid = Storage.KingOfRatsHQ.Items.Antigone,
				id = 4844,
				desc = "Sophocles' Antigone. Better than just Antigone. The King of Rats might be intersted in it.",
			},
			Cultivator = { -- ProdigalSon
				aid = Storage.KingOfRatsHQ.Items.Cultivator,
				id = 3452,
				desc = "Cultivator of ULTIMATENESS. The King of Rats might be intersted in it.",
			},
			Sylykonrydel = { -- tbd
				aid = Storage.KingOfRatsHQ.Items.Sylykonrydel,
				id = 31334,
				desc = "The Silcon Riddle. Romek, the King of Rats might be interested in it.",
			},
			Hammer = { -- tbd
				aid = Storage.KingOfRatsHQ.Items.Hammer,
				id = 3459,
				desc = "The Hammer of Epiphany. Romek, the King of Rats might be interested in it.",
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "King of Rats Headquarters",
			missions = {
				[Storage.KingOfRatsHQ.Mission01] = {
					name = "Current HeadQuarters status",
					description = "King of Rats Headquarters Status",
				},
				[Storage.KingOfRatsHQ.Portals.Ryan] = {
					name = "01. to Ryan",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = {
					name = "02. to Sweaty Cyclops",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.Djinns] = {
					name = "03. to Djinns",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.NorthKongo] = {
					name = "04. to North Kongo",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.Werebadgers] = {
					name = "05. to Werebadgers",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.VampireCity] = {
					name = "06. to Vampire city",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.Asuras] = {
					name = "07. to Asuras",
					description = "You unlocked this teleport",
				},
				[Storage.KingOfRatsHQ.Portals.HurghadaEast] = {
					name = "08. to East Hurgahada",
					description = "You unlocked this teleport",
				},
			},
		}
	end)
	:Mission(Storage.KingOfRatsHQ.Mission01)
:State(
function()
return 
		ANY_STATE,
		QuestFactory.Dialog("GM Romek", {
			[{ "artifact", "artifacts", "artefakt", "artefakty" }] = {
				text = "Ancient artifacts of the first King of Rats. I'll keep them for the darkest hour. If you've found any artifact, just tell me which one. If it's legit, I'll unlock one of the pipes for you.",
			},
			[{ "librum vortex" }] = {
				text = "Book of rat spells. It will surely come in handy.",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.librumvortex },
				nextState = { [Storage.KingOfRatsHQ.Portals.SweatyCyclops] = MISSION_FINISHED },
			},
			[{ "zonobijka", "wifebeater", "vestments", "zonobijka wladzy", "vestments of wifebeaterous regent" }] = {
				text = "It looks like an ordinary shirt, but it provides the bearer with immunity to mail from the Domestic Violence Monitoring Center.",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Wifebeater },
				nextState = { [Storage.KingOfRatsHQ.Portals.Djinns] = MISSION_FINISHED },
			},
			[{ "ytong" }] = {
				text = "It is said that this item can bend time itself. Metal part can bend itself, so there is only time missing.",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Ytong },
				nextState = { [Storage.KingOfRatsHQ.Portals.NorthKongo] = MISSION_FINISHED },
			},
			[{ "bottomless", "bud light", "bezdenny", "harnas" }] = {
				text = "Do you think your Wu-Dka sword can defeat me?",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Bottomless },
				nextState = { [Storage.KingOfRatsHQ.Portals.Werebadgers] = MISSION_FINISHED },
			},
			[{ "bribeslippers", "kapcie", "kapcie przekupstwa" }] = {
				text = "Now that i see them myself, they remind me of some other slippers... can't really put my finger on it though.",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Bribeslippers },
				nextState = { [Storage.KingOfRatsHQ.Portals.VampireCity] = MISSION_FINISHED },
			},
			[{ "antigone", "antygona" }] = {
				text = "A reliable source of good ol' knowledge on justice.",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Antigone },
				nextState = { [Storage.KingOfRatsHQ.Portals.Asuras] = MISSION_FINISHED },
			},
			[{ "cultivator", "kultywator" }] = {
				text = "Strapping this to your belt will allow you to farm up to 1000 thousands of gold per hour, but only in dead MMORPGs. It isn't very useful, is it?",
				requiredItems = { QuestKeyItems.KingOfRatsHQ.Cultivator },
				nextState = { [Storage.KingOfRatsHQ.Portals.HurghadaEast] = MISSION_FINISHED },
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
				player:say(player:Localizer(Storage.KingOfRatsHQ.Questline):Get("You cannot use this pipe yet."), TALKTYPE_MONSTER_SAY)
			end

			local function canUsePipe(player, aid)
				return player:getStorageValue(aid) >= ACCESS_GRANTED
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

				local aid = item:getActionId()
				if not canUsePipe(player, aid) then
					onFailedUse(player)
					return false
				end

				local toPos = KING_OF_RATS_HQ_ANCHOR:Moved(KROL_SZCZUROW_TELEPORT_HUB_DESINATIONS_IN[aid])
				player:teleportTo(toPos)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return false
			end
			for _, portalStorage in pairs(Storage.KingOfRatsHQ.Portals) do
				lever:aid(portalStorage)
			end
			lever:register()

			local portal = MoveEvent()

			function portal.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				if isPlayerPzLocked(player) then
					player:sendTextMessage(MESSAGE_FAILURE, "You can not enter a protection zone after attacking another player.")
					return false
				end

				local aid = item:getActionId()
				if not canUsePipe(player, aid) then
					onFailedUse(player, fromPosition)
					return
				end

				player:teleportTo(KROL_SZCZUROW_TELEPORT_HUB_DESTINATIONS_OUT[aid]) -- static pos
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end

			for _, portalStorage in pairs(Storage.KingOfRatsHQ.Portals) do
				portal:aid(portalStorage)
			end
			portal:type("stepin")
			portal:register()
		end),
		QuestFactory.StartupItems({
			{ pos = { 5563, 1577, 8 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Ryan },
			{ pos = { 5971, 1482, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.SweatyCyclops },
			{ pos = { 6657, 1242, 6 }, id = 1931, aid = Storage.KingOfRatsHQ.Portals.Djinns },
			{ pos = { 6692, 485, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.NorthKongo },
			{ pos = { 6279, 988, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Werebadgers },
			{ pos = { 6138, 845, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.VampireCity },
			{ pos = { 6678, 993, 7 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.Asuras },
			{ pos = { 6917, 1319, 5 }, id = 2773, aid = Storage.KingOfRatsHQ.Portals.HurghadaEast },
		}),
		QuestFactory.StartupItems({
			{ pos = { -3, 3, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Ryan },
			{ pos = { -4, -2, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.SweatyCyclops },
			{ pos = { 0, -4, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Djinns },
			{ pos = { 4, -1, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.NorthKongo },
			{ pos = { 4, 2, 0 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Werebadgers },
			{ pos = { -5, 8, -1 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.VampireCity },
			{ pos = { 2, 11, -1 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.Asuras },
			{ position = { -3, -7, -2 }, id = 7804, aid = Storage.KingOfRatsHQ.Portals.HurghadaEast },
		}, KING_OF_RATS_HQ_ANCHOR)

end
)	:Register()

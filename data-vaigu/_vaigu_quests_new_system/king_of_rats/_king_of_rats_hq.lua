local quest = Quest("kings_of_rats_hq")
quest
	:Storage(function()
		Storage.KingOfRatsHQ = {
			State = NextStorage(),
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
				WifeBeater = NextStorage(),
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
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "King of Rats Headquarters",
			startStorageId = Storage.KingOfRatsHQ.Questline,
			startStorageValue = 0,
			missions = {
				[1] = {
					name = "CurentStatus",
					storageId = Storage.KingOfRatsHQ.Questline,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = TableSize(Storage.KingOfRatsHQ.Items),
					description = "King of Rats Headquarters Status",
				},
				[2] = {
					name = "01. to Ryan",
					storageId = Storage.KingOfRatsHQ.Portals.Ryan,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[3] = {
					name = "02. to Sweaty Cyclops",
					storageId = Storage.KingOfRatsHQ.Portals.SweatyCyclops,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[4] = {
					name = "03. to Djinns",
					storageId = Storage.KingOfRatsHQ.Portals.Djinns,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[5] = {
					name = "04. to North Kongo",
					storageId = Storage.KingOfRatsHQ.Portals.NorthKongo,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[6] = {
					name = "05. to Werebadgers",
					storageId = Storage.KingOfRatsHQ.Portals.Werebadgers,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[7] = {
					name = "06. to Vampire city",
					storageId = Storage.KingOfRatsHQ.Portals.VampireCity,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[8] = {
					name = "07. to Asuras",
					storageId = Storage.KingOfRatsHQ.Portals.Asuras,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
				[9] = {
					name = "08. to East Hurgahada",
					storageId = Storage.KingOfRatsHQ.Portals.HurghadaEast,
					missionId = NextMissionId(),
					startValue = -1,
					endValue = 1,
					description = "You unlocked this teleport",
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
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
			[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = Position(5971, 1480, 7), --teatr
			[Storage.KingOfRatsHQ.Portals.Djinns] = Position(6658, 1242, 6), --teatr
			[Storage.KingOfRatsHQ.Portals.NorthKongo] = Position(6692, 487, 7), --bezpieczenstwo
			[Storage.KingOfRatsHQ.Portals.Werebadgers] = Position(6279, 989, 7), --trzej sramaci
			[Storage.KingOfRatsHQ.Portals.VampireCity] = Position(6138, 846, 7), --tragedya
			[Storage.KingOfRatsHQ.Portals.Asuras] = Position(6677, 994, 7), --per iustitia
			[Storage.KingOfRatsHQ.Portals.HurghadaEast] = Position(6917, 1320, 5), --syn marnotrawny
		}

		local leverIds = {
			[2773] = true,
			[1931] = true,
		}

		local function cannotUsePipe(player, fromPosition)
			if fromPosition then
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
			player:say(
				player:Localizer(Storage.KingOfRatsHQ.Questline):Get("You cannot use this pipe yet."),
				TALKTYPE_MONSTER_SAY
			)
		end

		local function canUsePipe(player, aid)
			return player:getStorageValue(aid) >= 1
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
				cannotUsePipe(player)
				return
			end

			local toPos = KROL_SZCZUROW_HUB_ANCHOR:Moved(KROL_SZCZUROW_TELEPORT_HUB_DESINATIONS_IN[aid])
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
				player:sendTextMessage(
					MESSAGE_FAILURE,
					"You can not enter a protection zone after attacking another player."
				)
				return false
			end

			local aid = item:getActionId()
			if not canUsePipe(player, aid) then
				cannotUsePipe(player, fromPosition)
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
	end)

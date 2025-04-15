--TODO
local quest = Quest(LOCALIZERS.OneTimeEscorts)

quest
	:Storage(function()
		Storage.OneTimeEscorts.MegadragonCliffs = {
			Mission01 = {},
			YellTiles = {},
			RopeThrowFromTiles = {},
			RopeThrowToTiles = {},
		}
	end)
	:Constant(function()
		QuestState.OneTimeEscorts.MegadragonCliffs = {
			ThrowRopeAndEscort = {},
		}
		local maryEscort = EscortData({
			key = Storage.OneTimeEscorts.MegadragonCliffs.Mission01,
			timeLimitSeconds = 1200,
			startAfterSeconds = 2,
			destinationPos = Position(7203, 1291, 7),
			proximityToSucceed = 35,
			requiredState = {
				[Storage.OneTimeEscorts.MegadragonCliffs] = QuestState.OneTimeEscorts.MegadragonCliffs.ThrowRopeAndEscort,
			},
			nextState = {
				[Storage.OneTimeEscorts.MegadragonCliffs] = MISSION_FINISHED,
			},
			rewards = {
				{ id = 48424 },
			},
			expReward = 200000,
		})
		EscortRegistry:Register(maryEscort)
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "One Time Escorts",
			localizer = localizer,
			missions = {
				{
					name = "Megadragon Cliffs",
					storage = Storage.OneTimeEscorts.MegadragonCliffs.Mission01,
					states = {
						[MISSION_FINISHED] = "You helped TODO",
					},
				},
			},
		})
	end)
	:Mission(Storage.OneTimeEscorts.MegadragonCliffs.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Script(function(missionState)
				local yellingTile = MoveEvent()
				function yellingTile.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return
					end

					local npc = Npc("Mary")
					npc:say("HEELP", TALKTYPE_MONSTER_YELL, true, player)
				end
				yellingTile:key(Storage.OneTimeEscorts.MegadragonCliffs.YellTiles)
				yellingTile:type("stepin")
				yellingTile:register()
			end),
			QuestFactory.Dialog("Mary", {
				[{ "mission", "misja", GREET }] = {
					text = "Im have been trapped here for days.. Im too fat to safely ride the boat. Can you help me by throwing a rope from above? Surely, someone with your expertise can manage that. After you haul me, please escort me to my home, the amazon camp.",
				},
				[{ "yes", "tak" }] = {
					text = "Thanks.",
					nextState = {
						[Storage.OneTimeEscorts.MegadragonCliffs.Mission01] = QuestState.OneTimeEscorts.MegadragonCliffs.ThrowRopeAndEscort,
					},
				},
			})
	end)
	:State(function()
		return QuestState.OneTimeEscorts.MegadragonCliffs.ThrowRopeAndEscort,
			QuestFactory.Script(function(missionState)
				local playerThrowFromZone = Zone(Storage.OneTimeEscorts.MegadragonCliffs.RopeThrowFromTiles)
				local ropeId = 3003

				local ropeThrowToSpot = MoveEvent()
				function ropeThrowToSpot.onAddItem(moveitem, tileitem, position)
					local player = playerThrowFromZone:getRandomPlayer()
					if not player then
						return false
					end

					if not player:HasExactMissionState(missionState) then
						return false
					end

					if moveitem:getId() ~= ropeId then
						return false
					end

					local npc = Npc("Mary")
					if not npc then
						return false
					end

					moveitem:remove()
					SPECIAL_ACTIONS_UNIVERSAL.startEscort({
						escortData = EscortRegistry:Get(Storage.OneTimeEscorts.MegadragonCliffs.Mission01),
						player = player,
						npc = npc,
					})
					return true
				end
				ropeThrowToSpot:type("additem")
				ropeThrowToSpot:key(Storage.OneTimeEscorts.MegadragonCliffs.RopeThrowToTiles)
				ropeThrowToSpot:register()
			end),
			QuestFactory.Dialog("Mary", {
				[{ "mission", "misja" }] = {
					text = "I will be waiting here i guess. After you haul me, please escort me to my home, the amazon camp.",
				},
			})
	end)

local quest = Quest(LOCALIZERS.BahledaPharellTroubles)

quest
	:Storage(function()
		Storage.BahledaPharellTroubles = {
			Mission01 = {},
			VisitedPositions = {},
			Snowman = {},
			LostCarrot = {},

			Mission02 = {},
			BahledaEscort = {},
		}
		QuestState.BahledaPharellTroubles = {
			Mission01 = {
				SearchSnowmenForCarrot = 1,
				BringCarrotToBahleda = 2,
			},
			Mission02 = {
				EscortBahledaToYeti = 1,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.BahledaPharellTroubles = {
			LostCarrot = {
				id = 3595,
				key = Storage.BahledaPharellTroubles.LostCarrot,
			},
		}
		local bahledaEscort = EscortData({
			key = Storage.BahledaPharellTroubles.BahledaEscort,
			timeLimitSeconds = 600,
			startAfterSeconds = 2,
			destinationPos = Position(6548, 1723, 8),
			proximityToSucceed = 3,
			requiredState = {
				[Storage.BahledaPharellTroubles.Mission02] = QuestState.BahledaPharellTroubles.Mission02.EscortBahledaToYeti,
			},
			nextState = {
				[Storage.BahledaPharellTroubles.Mission02] = MISSION_FINISHED,
			},
			rewards = {
				{ id = 30196 },
			},
			expReward = 370000,
		})
		EscortRegistry:Register(bahledaEscort)
	end)
	:NoQuestlog()
	:Mission(Storage.BahledaPharellTroubles.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Bahleda Pharell", {
				[{ "mission", "misja" }] = {
					text = "Some trickster stole my favourite carrot when i was fast asleep. I suspect they planted it on one of the snowmen scattered around this island. Please help me find my carrot.",
					nextState = {
						[Storage.BahledaPharellTroubles.Mission01] = QuestState.BahledaPharellTroubles.Mission01.SearchSnowmenForCarrot,
						[Storage.BahledaPharellTroubles.VisitedPositions] = {},
					},
				},
			})
	end)
	:State(function()
		return QuestState.BahledaPharellTroubles.Mission01.SearchSnowmenForCarrot,
			QuestFactory.Dialog("Bahleda Pharell", {
				[{ "mission", "misja" }] = {
					text = "Some trickster stole my favourite carrot when i was fast asleep. I suspect they planted it on one of the snowmen scattered around this island. Please help me find my carrot.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.BahledaPharellTroubles.Mission01] = QuestState.BahledaPharellTroubles.Mission01.BringCarrotToBahleda,
				}

				local snowman = Action()
				function snowman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return true
					end

					local visitedPositions = player:getStorageValueByKey(Storage.BahledaPharellTroubles.VisitedPositions)
					local posId = item:getPosition():ToString()

					local playerLocalizer = player:Localizer(LOCALIZERS.BahledaPharellTroubles)
					if visitedPositions[posId] then
						player:sendTextMessage(MESSAGE_FAILURE, playerLocalizer:Get("You already searched this snowman."))
						return true
					end

					visitedPositions[posId] = true
					if TableSize(visitedPositions) >= 11 then
						if player:TryAddItems({ QuestKeyItems.BahledaPharellTroubles.LostCarrot }) then
							player:NextState(nextState)
						end
					else
						player:sendTextMessage(MESSAGE_FAILURE, playerLocalizer:Get("Nothing there."))
					end

					player:setStorageValueByKey(Storage.BahledaPharellTroubles.VisitedPositions, visitedPositions)
					return true
				end
				snowman:key(Storage.BahledaPharellTroubles.Snowman)
				snowman:register()
			end)
	end)
	:State(function()
		return QuestState.BahledaPharellTroubles.Mission01.BringCarrotToBahleda,
			QuestFactory.Dialog("Bahleda Pharell", {
				[{ "mission", "misja" }] = {
					text = "Thank you for help. Would you mind escorting me to my lovers' abode? If so, tell me you are {ready}.",
					nextState = {
						[Storage.BahledaPharellTroubles.Mission01] = MISSION_FINISHED,
						[Storage.BahledaPharellTroubles.Mission02] = QuestState.BahledaPharellTroubles.Mission02.EscortBahledaToYeti,
						[Storage.BahledaPharellTroubles.VisitedPositions] = {},
					},
				},
			})
	end)
	:Mission(Storage.BahledaPharellTroubles.Mission02)
	:State(function()
		return QuestState.BahledaPharellTroubles.Mission02.EscortBahledaToYeti,
			QuestFactory.Dialog("Bahleda Pharell", {
				[{ "mission", "misja" }] = {
					text = "Would you mind escorting me to my lovers' abode? If so, tell me you are {ready}.",
				},
				[{ "ready", "gotowy" }] = {
					text = "Lets go.",
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.startEscort,
							escortData = EscortRegistry:Get(Storage.BahledaPharellTroubles.BahledaEscort),
						},
					},
				},
			})
	end)
	:Register()

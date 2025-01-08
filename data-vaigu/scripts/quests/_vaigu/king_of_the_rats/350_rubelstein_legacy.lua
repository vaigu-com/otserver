local quest = Quest(LOCALIZERS.RubelsteinLegacy)

quest
	:Storage(function()
		Storage.RubelsteinLegacy = {
			Mission01 = {},
			RubelsteinScroll = {},
			RubelsteinChecksum = {},
		}
		QuestState.RubelsteinLegacy = {
			Mission01 = {
				TalkToRubelstein = 1,
				TalkToMareesha = 2,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.RubelsteinLegacy = {
			RubelsteinScroll = {
				id = 2815,
				aid = Storage.RubelsteinLegacy.RubelsteinScroll,
				desc = "RubelsteinScrollDesc",
				addToStore = false,
			},
		}
		QuestRequirements.RubelsteinLegacy = {
			SaidRubelsteinsChecksum = function(context)
				local player = context.player
				local saidNumber = context.msg
				local requiredNumber = player:getStorageValueByKey(Storage.PerIustitiaAdAstra.RubelsteinChecksum)
				return tostring(saidNumber) == tostring(requiredNumber)
			end,
		}
	end)
	--39f add questlog
	:Mission(Storage.RubelsteinLegacy.Mission01)
	:State(function()
		return QuestState.RubelsteinLegacy.Mission01.TalkToRubelstein,
			QuestFactory.Dialog("Rubelstein", {
				[{ "mission" }] = {
					text = "Thanks for helping me",
					rewards = {
						[6104] = {
							QuestKeyItems.RubelsteinLegacy.RubelsteinScroll,
						},
					},
					nextState = { [Storage.RubelsteinLegacy.Mission01] = QuestState.RubelsteinLegacy.Mission01.TalkToMareesha },
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.setStorageRandomNumber,
							storage = Storage.RubelsteinLegacy.RubelsteinChecksum,
							min = 10 ^ 8,
							max = 10 ^ 9,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.RubelsteinLegacy.Mission01.TalkToMareesha,
			QuestFactory.Dialog("Mareesha", {
				[{ "czek", "token", "bon", "nagroda", "reward" }] = {
					text = "I can pay you any amount admitted in a token, effectively charging the party that signed it.",
				},
				[{ ANY_MESSAGE }] = {
					text = "Here, take your money.",
					nextState = { [Storage.RubelsteinLegacy.Mission01] = MISSION_FINISHED },
					rewards = { { id = 3043, count = 10 } },
					specialConditions = {
						{
							condition = QuestRequirements.RubelsteinLegacy.SaidRubelsteinsChecksum,
							requiredOutcome = true,
						},
					},
				},
			})
	end)
	:Register()

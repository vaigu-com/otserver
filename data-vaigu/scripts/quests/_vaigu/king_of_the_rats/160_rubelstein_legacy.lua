local quest = Quest(LOCALIZERS.RubelsteinLegacy)

quest
	:Storage(function()
		Storage.RubelsteinLegacy = {
			Mission01 = NextStorage(),
			RubelsteinScroll = NextStorage(),
			RubelsteinChecksum = NextStorage(),
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
	end)
	:Mission(Storage.RubelsteinLegacy.Mission01)
	:State(
		QuestState.RubelsteinLegacy.Mission01.TalkToRubelstein,
		QuestFactory.Dialog("Rubelstein", {
			[{ "mission" }] = {
				text = "Thanks for helping me get out. Keep this - it's my cigarette case that I got for my eighteenth birthday. Personally I don't smoke , so maybe you'll find a better use for it.",
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
	)
	:State(
		QuestState.RubelsteinLegacy.Mission01.TalkToMareesha,
		QuestFactory.Dialog("Mareesha", {
			[{ "czek", "token", "bon", "nagroda", "reward" }] = {
				text = "I can pay you any amount admitted in a token, effectively charging the party that signed it.",
			},
			[{ ANY_MESSAGE }] = {
				text = "Here, take your money.",
				nextState = { [Storage.PerIustitiaAdAstra.HelpedRubelstein] = 3 },
				rewards = { { id = 3043, count = 10 } },
				specialConditions = {
					{
						condition = PER_IUSTITIA_AD_ASTRA_SPECIAL_CONDITIONS.saidRubelsteinsChecksum,
						requiredOutcome = true,
					},
				},
			},
		})
	)
	:Register()

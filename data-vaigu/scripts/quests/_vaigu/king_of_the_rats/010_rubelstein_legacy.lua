local quest = Quest(LOCALIZERS.RubelsteinLegacy)

quest
	:Storage(function()
		Storage.RubelsteinLegacy = {
			Mission01 = NextStorage(),
			RubelsteinScroll = NextStorage(),
			RubelsteinChecksum = NextStorage()
		}
		QuestState.RubelsteinLegacy = {
			Mission01 = {
				TalkToRubelstein = 1,
				TalkToNomad = 2,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.RubelsteinLegacy = {
			rubelsteinScroll = {
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
						QuestKeyItems.RubelsteinLegacy.rubelsteinScroll,
					},
				},
				nextState = { [Storage.RubelsteinLegacy.Mission01] = QuestState.RubelsteinLegacy.Mission01.TalkToNomad },
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

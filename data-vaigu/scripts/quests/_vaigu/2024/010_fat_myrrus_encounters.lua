local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.FatMyrrusEncounters = NextStorage()
	end)
	:Constant(function() end)
	:Questlog(function() end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))

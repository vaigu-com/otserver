--[[

local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		rawset(Storage, "OneTimeEscorts", {})
	end)
	:Constant(function()
		QuestState.OneTimeEscorts = {}
	end)
	:NoQuestlog()
	:Register()
]]--
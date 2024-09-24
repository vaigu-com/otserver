	:Script(function(storageToRequiredState)
local static = {
	{ position = Position(4702, 785, 7), id = 2660, aid = Storage.SprawiedliwyWobecNarodow.Cuckoo },
	{ position = Position(4695, 790, 7), id = 2915, aid = Storage.SprawiedliwyWobecNarodow.Lamp },
}

local desertQuestTwoInit = GlobalEvent("sprawiedliwyWobecNarodowInit")
function desertQuestTwoInit.onStartup()
	LoadStartupItems(static)
end
desertQuestTwoInit:register()
end)

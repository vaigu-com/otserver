-- Vaigu custom
local boostedCreatureAnnouncementInit = GlobalEvent("BoostedCreatureAnnouncementInit")
function boostedCreatureAnnouncementInit.onStartup()
	local booostedCreatures = Game.getBoostedCreatures()
	local names = ""
	for _, name in pairs(booostedCreatures) do
		names = names .. ", " .. name
	end
	names = names:sub(1, -2)
	logger.info(T("Today boosted creatures: :names:", { names = names }))
end
boostedCreatureAnnouncementInit:register()

local function onThink()
	local loops = 0
	local raidIndex = math.random(1, #LUA_RAIDS_CHANCE.raids)
	local raidToStart = nil
	while loops < #LUA_RAIDS_CHANCE.raids and raidToStart == nil do
		if math.random(1, 100000) <= LUA_RAIDS_CHANCE.raids[raidIndex].spawnInterval then
			--Check timeBetweenOtherRaids
			local currentTime = os.time()
			local raid = LUA_RAID_CONFIG[LUA_RAIDS_CHANCE.raids[raidIndex].name]
			if
				(raid.secondsBetweenOtherRaids == nil or currentTime - LUA_RAIDS_CHANCE.lastRaidTime > raid.secondsBetweenOtherRaids)
				and ((raid.secondsBetweenRerunning == nil or raid.lastRunTime == nil) or currentTime - raid.lastRunTime > raid.secondsBetweenRerunning)
				and (raid.minPlayersOnline == nil or raid.minPlayersOnline <= #Game.getPlayers())
				and (raid.daySinceStart == nil or raid.daySinceStart >= DAY_SINCE_START)
			then
				raidToStart = LUA_RAIDS_CHANCE.raids[raidIndex].name
			end
		end
		loops = loops + 1
		raidIndex = raidIndex + 1
		if raidIndex > #LUA_RAIDS_CHANCE.raids then
			raidIndex = 1
		end
	end
	if raidToStart ~= nil then
		print("Randomly Starting Raid: " .. raidToStart)
		StartRaid(raidToStart)
	end
	return true
end

local globalevent = GlobalEvent("LuaRaids")

function globalevent.onThink(...)
	return onThink()
end

globalevent:interval(10 * 60 * 1000) --10min
globalevent:register()

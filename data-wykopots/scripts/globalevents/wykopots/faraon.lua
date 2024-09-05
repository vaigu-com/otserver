local config = {
	-- Weekly
	["Monday"] = { bossName = "Ashmunrah" },
	["Tuesday"] = { bossName = "Dipthrah" },
	["Wednesday"] = { bossName = "Mahrdis" },
	["Thursday"] = { bossName = "Omruc" },
	["Friday"] = { bossName = "Rahemos" },
	["Saturday"] = { bossName = "Thalas" },
	["Sunday"] = { bossName = "Vashresamun" },
}

local faraon = GlobalEvent("faraon")
function faraon.onTime(interval)
	local day, date = os.date("%A"), getRealDate()
	local bossDays = {}
	if config[day] then
		bossDays[#bossDays + 1] = config[day]
	end
	if config[date] then
		bossDays[#bossDays + 1] = config[date]
	end
	if #bossDays == 0 then
		return true
	end

	for i = 1, #bossDays do
		local settings = bossDays[i]
		if settings then
			local rand = math.random(1, 3)
			if rand == 1 then
				local bossPosition = Position(6709, 1302, 12)
				local boss = Game.createMonster(settings.bossName, bossPosition, true, true)
			end
		end
	end
	return true
end

local randtime = math.random(6, 23) -- spawn od 6 do 23
faraon:time("" .. randtime .. ":40:00")
faraon:register()

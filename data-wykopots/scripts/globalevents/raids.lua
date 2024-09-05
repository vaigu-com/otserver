local RandHour = math.random(1, 24)
local RandMin = math.random(0, 59)

local raids = {
	-- Weekly
	--Segunda-Feira
	["Monday"] = {
		["21:00"] = { raidName = "Piraci" },
	},

	--Terça-Feira
	["Tuesday"] = {
		["21:00"] = { raidName = "Grynch" },
	},

	--Quarta-Feira
	["Wednesday"] = {
		["21:00"] = { raidName = "Dryad" },
	},

	--Quinta-Feira
	["Thursday"] = {
		["21:00"] = { raidName = "Gobliny" },
	},

	--Sexta-feira
	["Friday"] = {
		["21:00"] = { raidName = "Lizardape" },
	},

	--Sábado
	["Saturday"] = {
		["21:00"] = { raidName = "Piracimirko" },
	},

	--Domingo
	["Sunday"] = {
		["21:00"] = { raidName = "barbarian" },
	},

	-- By date (Day/Month)
	["31/10"] = {
		["21:00"] = { raidName = "wolfy" },
	},
}

local globalevent = GlobalEvent("Raids")

function globalevent.onThink(...)
	local day, date = os.date("%A"), getRealDate()

	local raidDays = {}
	if raids[day] then --dodawany dany raid do tabelki
		raidDays[#raidDays + 1] = raids[day]
	end
	if raids[date] then --dodawany dany raid do tabelki
		raidDays[#raidDays + 1] = raids[date]
	end

	if #raidDays == 0 then --jak nic nie ma w tabelce to elo
		return true
	end

	for i = 1, #raidDays do
		local settings = raidDays[i][getRealTime()] --jak wybil czas danego raidu
		if settings and not settings.alreadyExecuted then -- jak czas wybil i jeszcze go nie bylo
			Game.startRaid(settings.raidName) -- robiony raid
			settings.alreadyExecuted = true
		end
	end

	return true
end

globalevent:interval(1 * 60 * 1000) --1min
globalevent:register()

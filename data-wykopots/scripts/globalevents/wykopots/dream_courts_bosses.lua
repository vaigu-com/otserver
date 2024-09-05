local setting = {
	["Monday"] = 1, --maxx
	["Tuesday"] = 2, --alpt
	["Wednesday"] = 3, -- izcan
	["Thursday"] = 4, -- plague
	["Friday"] = 5, --malofur
	["Saturday"] = 0, --rand
	["Sunday"] = 0, --rand
}

local dreambosses = GlobalEvent("dream courts bosses")
function dreambosses.onStartup()
	local day = setting[os.date("%A")]
	if day == 0 then
		local rand = math.random(1, 5)
		Game.setStorageValue(GlobalStorage.DreamBoss, rand)
	else
		Game.setStorageValue(GlobalStorage.DreamBoss, day)
	end
end

dreambosses:register()

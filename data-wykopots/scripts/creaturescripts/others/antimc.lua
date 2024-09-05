local AccForIp = 6

local playerLogin = CreatureEvent("AntiMc")

function playerLogin.onLogin(player)
	local mc = 0
	for _, check in ipairs(Game.getPlayers()) do
		if player:getIp() == check:getIp() then
			mc = mc + 1
			if mc > AccForIp then
				return false
			end
		end
	end

	return true
end

playerLogin:register()

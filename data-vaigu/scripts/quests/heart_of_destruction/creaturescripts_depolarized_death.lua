local upConer = Position(32192, 31311, 14) -- upLeftCorner
local downConer = Position(32225, 31343, 14) -- downRightCorner
local roomArea = Area(upConer, downConer)

local function setStorage()
	CreatureList():Area(roomArea):FilterByPlayer():ForEach(function(player)
		if player:getStorageValueByKey(14322) < 1 then
			player:setStorageValueByKey(14322, 1) -- Access to boss Anomaly
		end
	end)
end

local depolarizedDeath = CreatureEvent("DepolarizedDeath")
function depolarizedDeath.onDeath(creature)
	Game.setStorageValueByKey(14323, Game.getStorageValueByKey(14323) + 1)
	if Game.getStorageValueByKey(14323) == 10 then
		setStorage()
		creature:say("You have reached enough charges to pass further into the destruction!", TALKTYPE_MONSTER_YELL, isInGhostMode, pid, { x = 32209, y = 31326, z = 14 })
		Game.setStorageValueByKey(14323, -1)
	end
	return true
end

depolarizedDeath:register()

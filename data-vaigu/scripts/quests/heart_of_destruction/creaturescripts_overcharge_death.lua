local upConer = Position(32133, 31341, 14) -- upLeftCorner
local downConer = Position(32174, 31375, 15) -- downRightCorner
local roomArea = Area(upConer, downConer)

local function setStorage()
	CreatureList():Area(roomArea):FilterByPlayer():ForEach(function(player)
		if player:getStorageValueByKey(14320) < 1 then
			player:setStorageValueByKey(14320, 1) -- Access to boss Anomaly
		end
	end)
end

local overchargeDeath = CreatureEvent("OverchargeDeath")
function overchargeDeath.onDeath(creature)
	Game.setStorageValueByKey(14321, Game.getStorageValueByKey(14321) + 1)

	if Game.getStorageValueByKey(14321) == 5 then
		setStorage()
		creature:say("You have reached enough charges to pass further into the destruction!", TALKTYPE_MONSTER_YELL, isInGhostMode, pid, { x = 32162, y = 31356, z = 15 })
		Game.setStorageValueByKey(14321, -1)
	end

	return true
end

overchargeDeath:register()

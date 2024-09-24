	:Script(function(storageToRequiredState)
	:MonsterEvent(function()
local zulZulowDeath = CreatureEvent("ZulZulowDeath")
function zulZulowDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	local deathPos = creature:getPosition()
	local name = creature:getName()

	addEvent(function()
		for _ = 1, 2 do
			Game.createMonster(name, deathPos)
		end
	end, 1500)
	return true
end

zulZulowDeath:register()
end)
end)

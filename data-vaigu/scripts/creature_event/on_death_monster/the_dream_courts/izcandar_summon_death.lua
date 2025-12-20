local izcandarSummonDeath = CreatureEvent("IzcandarSummonDeath")
function izcandarSummonDeath.onDeath(creature)
	if not creature or not creature:isMonster() then -- éMonstro!
		return true
	end
	local monster = creature:getName():lower()
	if monster == "the cold of winter" then
		izcandarSummon = izcandarSummon - 1
	elseif monster == "the heat of summer" then
		izcandarSummon = izcandarSummon - 1
	end
	return true
end

izcandarSummonDeath:register()

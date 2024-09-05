local shocksDeath = CreatureEvent("ShocksDeath")
function shocksDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	local name = creature:getName():lower()
	if name == "foreshock" then
		local monster = Game.createMonster("aftershock", { x = 5441, y = 1376, z = 14 }, false, true)
		monster:addHealth(-monster:getHealth() + aftershockHealth, COMBAT_PHYSICALDAMAGE)
		Game.createMonster("spark of destruction", { x = 5436, y = 1374, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5438, y = 1379, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5443, y = 1379, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5445, y = 1374, z = 14 }, false, true)
	end

	if name == "aftershock" then
		local pos = creature:getPosition()
		local monster = Game.createMonster("realityquake", pos, false, true)
		Game.createMonster("spark of destruction", { x = 5436, y = 1374, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5438, y = 1379, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5443, y = 1379, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5445, y = 1374, z = 14 }, false, true)
	end
	return true
end
shocksDeath:register()

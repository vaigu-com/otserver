local anomalyTransform = CreatureEvent("AnomalyTransform")
function anomalyTransform.onThink(creature)
	if not creature or not creature:isMonster() then
		return false
	end

	local hp = (creature:getHealth() / creature:getMaxHealth()) * 100
	if hp <= 75 and Game.getStorageValue(14322) == 0 then
		creature:remove()
		Game.createMonster("spark of destruction", { x = 5500, y = 1381, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1383, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1373, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5500, y = 1377, z = 14 }, false, true)
		Game.createMonster("charged anomaly", { x = 5504, y = 1377, z = 14 }, false, true)
		Game.setStorageValue(14322, 1)
	elseif hp <= 50 and Game.getStorageValue(14322) == 1 then
		creature:remove()
		Game.createMonster("spark of destruction", { x = 5500, y = 1381, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1383, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1373, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5500, y = 1377, z = 14 }, false, true)
		Game.createMonster("charged anomaly", { x = 5504, y = 1377, z = 14 }, false, true)
		Game.setStorageValue(14322, 2)
	elseif hp <= 25 and Game.getStorageValue(14322) == 2 then
		creature:remove()
		Game.createMonster("spark of destruction", { x = 5500, y = 1381, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1383, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1373, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5500, y = 1377, z = 14 }, false, true)
		Game.createMonster("charged anomaly", { x = 5504, y = 1377, z = 14 }, false, true)
		Game.setStorageValue(14322, 3)
	elseif hp <= 5 and Game.getStorageValue(14322) == 3 then
		creature:remove()
		Game.createMonster("spark of destruction", { x = 5500, y = 1381, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1383, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5507, y = 1373, z = 14 }, false, true)
		Game.createMonster("spark of destruction", { x = 5500, y = 1377, z = 14 }, false, true)
		Game.createMonster("charged anomaly", { x = 5504, y = 1377, z = 14 }, false, true)
		Game.setStorageValue(14322, 4)
	end
	return true
end

anomalyTransform:register()

print"creaturescripts_crackler_transform.lua start"
local cracklerTransformEvent = CreatureEvent("CracklerTransform")
function cracklerTransformEvent.onThink(creature)
	print("before creature")
	if not creature or not creature:isMonster() then
		return true
	end
	print("after creature")

	print("cracklerTransform", cracklerTransform)
	if cracklerTransform == true then
		print("inside cracklerTransform")
		local monster = Game.createMonster("depolarized crackler", creature:getPosition(), false, true)
		monster:addHealth(-monster:getHealth() + creature:getHealth(), COMBAT_PHYSICALDAMAGE)
		creature:remove()
	end

	return true
end

cracklerTransformEvent:register()
print"creaturescripts_crackler_transform.lua end"

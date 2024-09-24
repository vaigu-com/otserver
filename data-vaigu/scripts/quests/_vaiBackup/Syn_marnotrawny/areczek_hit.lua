	:MonsterEvent(function()
local areczek = CreatureEvent("HitAreczek")
function areczek.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if not (creature:getName():lower() == "areczek") then
		return
	end

	if primaryType == COMBAT_HEALING or secondaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if attacker then
		if primaryDamage > 0 or secondaryDamage > 0 then
			local pos = creature:getPosition()
			creature:remove()
			Game.createMonster("Areczek", pos)
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

areczek:register()
end)

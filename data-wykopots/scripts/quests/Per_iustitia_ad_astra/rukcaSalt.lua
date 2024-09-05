local dmg = 20000

local saltyTile = MoveEvent()

function saltyTile.onStepIn(creature, _, _, _)
	if creature:getName():lower() == "ruk'ca maw" then
		doTargetCombatHealth(0, creature, COMBAT_POISONDAMAGE, -dmg, -dmg, CONST_ME_STUN)
	end
end

saltyTile:aid(Storage.PerIustitiaAdAstra.SaltyTile)
saltyTile:register()

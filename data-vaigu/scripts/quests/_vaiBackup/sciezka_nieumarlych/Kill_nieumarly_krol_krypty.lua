	:MonsterEvent(function()
local krolKrypty = CreatureEvent("NieumarlyKrolKryptyKill")

function krolKrypty.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local pos = targetMonster:getPosition()
	local portal = Game.createItem(27590, 1, pos)
	portal:setActionId(Storage.PathOfTheUndead.BossRoomExit)
end

krolKrypty:register()
end)

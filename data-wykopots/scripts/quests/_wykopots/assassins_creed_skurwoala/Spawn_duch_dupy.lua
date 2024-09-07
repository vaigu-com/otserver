local princess = { name = "Ghasstly Princess", pos = { x = 5682, y = 1408, z = 7 } }

local chairIn = MoveEvent()

function chairIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.AssassinsCreedSkurwoala.Questline)

	if storageVal >= 17 then
		return false
	end
	local monster = Tile(princess.pos):getTopCreature()
	if monster then
		return false
	else
		Game.createNpc(princess.name, princess.pos)
	end
end

chairIn:aid(Storage.AssassinsCreedSkurwoala.GhostChair)
chairIn:register()

local chairOut = MoveEvent()

function chairOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local monster = Tile(princess.pos):getTopCreature()
	if monster and not Tile(fromPosition):getTopCreature() then
		monster:remove()
		Position(princess.pos):sendMagicEffect(CONST_ME_TELEPORT)
	end
end

chairOut:aid(Storage.AssassinsCreedSkurwoala.GhostChair)
chairOut:register()

	:Script(function(storageToRequiredState)
local toModern = Position(5513, 1554, 7)
local toRetro = RETRO_KNUROWO_ANCHOR:Moved(-63, -9, 0) -- 38f85df67705e9e59ab4b44bc8590644
local toKolumb = Position(5909, 1233, 6)

local tpToRetro = MoveEvent()
function tpToRetro.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= 1 then
		return false
	end
	player:teleportTo(toRetro)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tpToRetro:type("stepin")
tpToRetro:aid(Storage.FourActTragedy.Portals.ToRetro)
tpToRetro:register()

local tpToModern = MoveEvent()
function tpToModern.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	if player:getStorageValue(Storage.FourActTragedy.RetroKnurowoAccess) ~= 1 then
		return false
	end
	player:teleportTo(toModern)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tpToModern:type("stepin")
tpToModern:aid(Storage.FourActTragedy.Portals.ToPresent)
tpToModern:register()

local tpToKolumb = MoveEvent()
function tpToKolumb.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	player:teleportTo(toKolumb)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tpToKolumb:type("stepin")
tpToKolumb:aid(Storage.FourActTragedy.Portals.ToKolumb)
tpToKolumb:register()
end)

	:Script(function(storageToRequiredState)
local szczurKrolowConfig = {
	name = "rat of kings",
	pos = Position(6792, 558, 11),
}

local tileIn = MoveEvent()

function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline)

	if storageVal < 21 or storageVal > 23 then
		return false
	end

	local pos = szczurKrolowConfig.pos
	local tile = Tile(pos)
	if not tile then
		return false
	end
	local monster = tile:getTopCreature()
	if monster then
		return false
	else
		Game.createNpc(szczurKrolowConfig.name, pos, false, false)
		pos:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

tileIn:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
tileIn:register()

local tileOut = MoveEvent()

function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local pos = szczurKrolowConfig.pos
	local tile = Tile(pos)
	if not tile then
		return false
	end
	local monster = tile:getTopCreature()
	if monster and not Tile(fromPosition):getTopCreature() and string.lower(monster:getName()) == "rat of kings" then
		monster:remove()
		pos:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

tileOut:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
tileOut:register()
end)

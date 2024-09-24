	:Script(function(storageToRequiredState)
local szczurKrolowConfig = { name = "Astral Janus", pos = Position(5839, 790, 0) }

local tileIn = MoveEvent()

function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.PerIustitiaAdAstra.Questline)

	if storageVal == -1 then
		return false
	end
	if storageVal > 3 and storageVal < 27 then
		return false
	end

	local pos = Position(szczurKrolowConfig.pos)
	local tile = Tile(pos)
	if not tile then
		return false
	end
	local monster = tile:getTopCreature()
	if monster then
		return false
	else
		local npc = Game.createNpc(szczurKrolowConfig.name, pos, false, false)
	end
end

tileIn:aid(Storage.PerIustitiaAdAstra.JanuszTile)
tileIn:register()

local tileOut = MoveEvent()

function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local pos = Position(szczurKrolowConfig.pos)
	local tile = Tile(pos)
	if not tile then
		return false
	end
	local monster = tile:getTopCreature()
	if monster and not Tile(fromPosition):getTopCreature() and string.lower(monster:getName()) == "astral janus" then
		monster:remove()
		Position(pos):sendMagicEffect(CONST_ME_TELEPORT)
	end
end

tileOut:aid(Storage.PerIustitiaAdAstra.JanuszTile)
tileOut:register()
end)

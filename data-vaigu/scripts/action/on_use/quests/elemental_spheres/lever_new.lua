--[[
Storage.ElementalSpheres = {
	EntranceLeverPositions = {},
}

local vocationToOffering = {
	[VOCATION_PALADIN] = 942,
	[VOCATION_DRUID] = 947,
	[VOCATION_KNIGHT] = 948,
	[VOCATION_SORCERER] = 946,
}

local vocationToDestination = {
	[VOCATION_PALADIN] = Position(6231, 1010, 11),
	[VOCATION_DRUID] = Position(6229, 1013, 11),
	[VOCATION_KNIGHT] = Position(6226, 1010, 11),
	[VOCATION_SORCERER] = Position(6229, 1008, 11),
}

local bossArenaCorner1 = Position(6222, 1004, 11) -- upLeftCorner {x = 5491, y = 1432, z = 14}
local bossArenaCorner2 = Position(6235, 1017, 11) -- downRightCorner {x = 5517, y = 1457, z = 14}
local bossCorpseId1 = 8182
local bossCorpseId2 = 8181
local function clearBossArena()
	ItemExList():Area(Area(bossArenaCorner1, bossArenaCorner2)):FilterById(bossCorpseId1):ForEach(function(item)
		item:remove()
	end)
	ItemExList():Area(Area(bossArenaCorner1, bossArenaCorner2)):FilterById(bossCorpseId2):ForEach(function(item)
		item:remove()
	end)
end

local action = Action()
function action.onUse(leverUser, leverItem, fromPosition, target, toPosition, isHotkey)
	if leverItem.itemid ~= 2772 then
		FlipLever(leverItem)
		return true
	end

	local spectators = Game.getSpectators(Position(6229, 1011, 11), false, true, 30, 30, 30, 30) --{x = 6229, y = 1011, z = 11}
	if #spectators > 0 or Game.getStorageValueByKey(Storage.ElementalSphere.BossRoom) > 0 then
		leverUser:say("Poczekaj az zwolni sie miejsce.", TALKTYPE_MONSTER_SAY, false, 0, Position(6230, 1011, 10))
		return true
	end

	local players = Zone(Storage.ElementalSpheres.EntranceLeverPositions):getPlayers()
	if #players < 4 then
		leverUser:say("You need one of each profession to participate in this fight!", TALKTYPE_MONSTER_SAY, false, 0, Position(6230, 1011, 10))
		return true
	end

	for _, player in pairs(players) do
		local vocationId = player:getVocation():getBase():getId()
		local requiredOffering = vocationToOffering[vocationId]
		if not player:HasItems({ { id = requiredOffering } }) then
			leverUser:say("Each of participants needs to have a concentrated elemental material!", TALKTYPE_MONSTER_SAY, false, 0, Position(6230, 1011, 10))
			return true
		end
	end

	for _, player in pairs(players) do
		local currentPosition = player:getPosition()
		currentPosition:sendMagicEffect(CONST_ME_TELEPORT)

		local vocationId = player:getVocation():getBase():getId()
		local destination = vocationToDestination[vocationId]
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
	
    clearBossArena()
	
    FlipLever(leverItem)
	return true
end

action:uid(9024)
action:register()
]]

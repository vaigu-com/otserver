local hive = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hive
local lagoon = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Lagoon
local souleater = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Souleater
local waterWell = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.WaterWell
local hairycles = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hairycles
local hellspawns = Storage.TheThreeSramatiansAndTheDragon.Fireplaces.Hellspawns

local spawnTimer = 1000 * 2 * 60

local companyMembersNames = {
	"Moorin the second of the copper cowbell",
	"Brallin of the beech wall unit",
	"Giuseppe Four Cheeses",
	"Bilbeus",
}
local aidToCompany = { [hive] = nil, [lagoon] = nil, [souleater] = nil, [waterWell] = nil }

local aidToRequiredState = {
	[hive] = { min = 3, max = 6 },
	[lagoon] = { min = 8, max = 8 },
	[souleater] = { min = 10, max = 10 },
	[waterWell] = { min = 13, max = 16 },
	[hairycles] = { min = 18, max = 19 },
	[hellspawns] = { min = 20, max = 22 },
}

local litFireplaceId = 2000
local unlitFireplaceId = 1997

local function hasRequiredState(player, aid)
	local questState = player:getStorageValue(Storage.TheThreeSramatiansAndTheDragon.Questline)

	local states = aidToRequiredState[aid]
	local min = states.min
	local max = states.max
	return min <= questState and questState <= max
end

local function SpawnCompany(aid, fireplace)
	aidToCompany[aid] = {}
	local members = {}
	local pos = fireplace:getPosition()
	for _, name in pairs(companyMembersNames) do
		local member = Game.createNpc(name, pos)
		if member then
			member:setMasterPos(Position(pos))
			members[#members + 1] = member
		end
	end

	aidToCompany[aid] = members

	fireplace:transform(litFireplaceId)
	addEvent(function()
		fireplace:transform(unlitFireplaceId)
		fireplace:setActionId(aid)
		for _, member in pairs(aidToCompany[aid]) do
			member:remove()
		end
		aidToCompany[aid] = nil
	end, spawnTimer)
end

local function companyAlreadySpawnedAtAid(aid)
	return aidToCompany[aid] ~= nil
end

local fire = Action()
function fire.onUse(player, fireplace, fromPosition, target, toPosition, isHotkey)
	local aid = fireplace:getActionId()
	if companyAlreadySpawnedAtAid(aid) then
		return false
	end
	if not hasRequiredState(player, aid) then
		return false
	end
	SpawnCompany(aid, fireplace)
	return true
end

for _, storage in pairs(Storage.TheThreeSramatiansAndTheDragon.Fireplaces) do
	fire:aid(storage)
end
fire:register()

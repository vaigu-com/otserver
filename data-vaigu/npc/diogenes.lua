local name = "Diogenes"
local outfit = {
	lookType = 1020,
	lookHead = 42,
	lookBody = 21,
	lookLegs = 0,
	lookFeet = 114,
	lookAddons = 0,
}

local spawnLock = SpawnLocks.Steppes.TestNpc
local roomCorner1, roomCorner2 = Position(6235, 1026, 5), Position(6238, 1029, 5)
local roomArea = Area(roomCorner1, roomCorner2)
local onThink = function(npc, interval)
	local players = CreatureList():Area(roomArea):FilterByPlayer():Get()
	if TableSize(players) > 0 then
		spawnLock:Refresh()
	end

	if spawnLock:SecondsSinceRefresh() > 5 then
		spawnLock:Reset()
		npc:remove()
	end
end

local context = {
	name = name,
	outfit = outfit,
	greetJob = JOB_MAGIC,
	jobs = { JOB_MAGIC },
	customDialogs = customDialogs,
	checkInteraction = false,
	onThink = onThink,
	spawnedByScript = true,
}
NpcRegistry:AppendNpcData(context)

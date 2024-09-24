	:Script(function(storageToRequiredState)
local function areAllMachinePillarsLit(machineConfigs)
	for _, machineConfig in pairs(machineConfigs) do
		local pos = machineConfig.pillar.pos
		local litId = machineConfig.pillar.litId
		if not Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId) then
			return false
		end
	end
	return true
end

local function unlitAllMachinePillars(machineConfigs)
	for _, machineConfig in pairs(machineConfigs) do
		local pos = machineConfig.pillar.pos
		local unlitId = machineConfig.pillar.unlitId
		local litId = machineConfig.pillar.litId
		Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId):transform(unlitId)
	end
end

local tileBeforeBook = MoveEvent()

function tileBeforeBook.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	local machineConfigs = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.aidToMachineConfig
	if not areAllMachinePillarsLit(machineConfigs) then
		return
	end

	unlitAllMachinePillars(machineConfigs)

	local litBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.lit
	local unlitBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.unlit
	local pos = LIBRUM_VORTEX_ANCHOR:Moved(TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.pos)
	local bookStand = Tile(pos):getItemById(unlitBookId)
	bookStand:transform(litBookId)

	player:say(player:Localizer(Storage.TheaterOfCheapThrills.Questline):Get("The book has been unsealed. You have one minute before its closed."), TALKTYPE_MONSTER_SAY)
	addEvent(function()
		bookStand:transform(unlitBookId)
	end, 60 * 1000)
	return true
end

tileBeforeBook:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Book)
tileBeforeBook:type("stepin")
tileBeforeBook:register()

--book reward is defined in krol_szczurow_hub/_startup.luaa
end)

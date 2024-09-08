local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(13, -22, 1)
local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(21, -22, 1)
local countdownRunning = false

local redPos = DESERT_QUEST_TWO_ANCHOR:Moved(12, -13, 1)
local yellowPos = DESERT_QUEST_TWO_ANCHOR:Moved(17, -8, 1)
local bluePos = DESERT_QUEST_TWO_ANCHOR:Moved(22, -13, 1)

local colorToId = {
	["purple"] = 28131,
	["green"] = 23717,
	["orange"] = 2653,
	["brown"] = 5590,
}

local function getSelectedColorId()
	local red = Tile(redPos):getTopCreature()
	local yellow = Tile(yellowPos):getTopCreature()
	local blue = Tile(bluePos):getTopCreature()
	if yellow and red and blue then
		return colorToId["brown"]
	end
	if red and blue then
		return colorToId["purple"]
	end
	if blue and yellow then
		return colorToId["green"]
	end
	if yellow and red then
		return colorToId["orange"]
	end
end

local function getRequiredColor()
	return IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local item = pos:GetTopItem()
		return item
	end, { stopCondition = STOP_CONDITIONS.isNotNull })
end

local initializeIds = {
	28131,
	23717,
	2653,
	5590,
}
local function initialize()
	local lastRand = #initializeIds
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local item = pos:GetTopItem()
		if item then
			item:remove()
		end
		local randTableIndex = math.random(1, #initializeIds)
		if randTableIndex == lastRand then
			randTableIndex = (randTableIndex + 1) % #initializeIds + 1
		end
		lastRand = randTableIndex
		local randomItemId = initializeIds[randTableIndex]
		Game.createItem(randomItemId, 1, pos)
	end)
end

local lever = Action()
function lever.onUse(creature, _, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local _, requiredColor = getRequiredColor()
	local selectedColorId = getSelectedColorId()

	if not (requiredColor and selectedColorId) then
		initialize()
		return false
	end

	local requiredColorId = requiredColor:getId()
	if requiredColorId == selectedColorId then
		requiredColor:remove()
	else
		initialize()
		return false
	end

	local requiredColor2 = getRequiredColor()
	if not requiredColor2 then
		TrySpawnDQ2progressChest("RGB")
	end
	return false
end

lever:aid(Storage.DesertQuestTwo.Puzzles.RgbColors)
lever:register()

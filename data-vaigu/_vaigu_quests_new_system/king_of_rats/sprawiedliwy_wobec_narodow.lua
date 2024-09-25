local quest = Quest("three_sramatians_and_the_dragon")
quest:Script(function(storageToRequiredState)
local combination = {
	"even",
	"even",
	"odd",
	"even",
	"even",
}
local currentRequiredInputIndex = 1

local function getCurrentMinuteOddity()
	local minute = math.floor((os.time() / 60) % 60)
	if minute % 2 == 0 then
		return "even"
	end
	return "odd"
end

local cuckoo = Action()
function cuckoo.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local oddity = getCurrentMinuteOddity()
	local requiredOddity = combination[currentRequiredInputIndex]
	if oddity ~= requiredOddity then
		currentRequiredInputIndex = 1
		return
	end

	currentRequiredInputIndex = currentRequiredInputIndex + 1
	item:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
	return false
end

cuckoo:aid(Storage.SprawiedliwyWobecNarodow.Cuckoo)
cuckoo:register()

local secretEntrancePos = Position(4701, 787, 7)
local secretEntranceId = 567
local normalTileId = 24639
local entranceIsOpen = false

local lamp = Action()
function lamp.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if currentRequiredInputIndex <= #combination then
		currentRequiredInputIndex = 1
		return
	end

	if entranceIsOpen then
		return
	end

	Game.createItem(secretEntranceId, 1, secretEntrancePos)
	entranceIsOpen = true
	addEvent(function()
		Game.createItem(normalTileId, 1, secretEntrancePos)
		entranceIsOpen = false
	end, 10 * 1000)

	return false
end

lamp:aid(Storage.SprawiedliwyWobecNarodow.Lamp)
lamp:register()
end)

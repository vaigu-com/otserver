local idToStorageVal = { [596] = 1, [597] = 2, [598] = 4, [599] = 8, [924] = 16 }

local step_tile = MoveEvent()

local function IsFactor(number, factor)
	if (number % (factor * 2)) >= factor then
		return true
	end
	return false
end

local questlineStorage = Storage.PathOfTheUndead.Questline
local circleStorage = Storage.PathOfTheUndead.Circles

local function GetUncompletedCirclesCount(player)
	local storageVal = player:getStorageValue(circleStorage)
	local length = 0

	for _, value in pairs(idToStorageVal) do
		if not IsFactor(storageVal, value) then
			length = length + 1
		end
	end
	return length
end

function step_tile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local questlineStorageVal = player:getStorageValue(questlineStorage)
	if questlineStorageVal ~= 2 then
		return
	end

	local storageVal = player:getStorageValue(circleStorage)
	if storageVal < 0 then
		player:setStorageValue(circleStorage, 0)
	end

	local addend = idToStorageVal[item:getId()]
	if not IsFactor(storageVal, addend) then
		player:setStorageValue(circleStorage, player:getStorageValue(circleStorage) + addend)
		player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
		local firstStepMessage = player:Localizer(Storage.PathOfTheUndead.Questline):Get("You step on circle number ")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, firstStepMessage .. math.floor(math.log(addend, 2) + 1))
	end

	local circlesCount = GetUncompletedCirclesCount(player)
	if circlesCount ~= 0 then
		local standOn = player:Localizer(Storage.PathOfTheUndead.Questline):Get("To fulfill Gandalf's task you need to stand on ")
		local remaining = player:Localizer(Storage.PathOfTheUndead.Questline):Get(" remaining circles.")

		player:sendTextMessage(MESSAGE_FAILURE, standOn .. circlesCount .. remaining)
	end
end

step_tile:aid(Storage.PathOfTheUndead.Circles)
step_tile:type("stepin")
step_tile:register()

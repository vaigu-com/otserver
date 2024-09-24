	:Script(function(storageToRequiredState)
local config = {
	["success"] = "You succeeded in opening the gate! Talk back to engineer ghost and tell him about your success. Dont worry about closing gates - you can use shortcut door.",
}
local questStorage = Storage.CaveExplorerOnShield.Questline

local anthonyGate = MoveEvent()

function anthonyGate.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(questStorage) == 4 then
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		player:setStorageValue(questStorage, 5)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(Storage.CaveExplorerOnShield.Questline):Get(config["success"]))
	end
	return true
end

anthonyGate:aid(Storage.CaveExplorerOnShield.Misc.AnthonyGate)
anthonyGate:type("stepin")
anthonyGate:register()
end)

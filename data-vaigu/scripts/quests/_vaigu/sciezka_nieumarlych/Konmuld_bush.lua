local bushMessage =
	"enum ConditionType_t {\nCONDITION_NONE,\n    \nCONDITION_POISON = 1 << 0,\nCONDITION_FIRE = 1 << 1,\nCONDITION_ENERGY = 1 << 2,\nCONDITION_BLEEDING = 1 << 3,\nCONDITION_HASTE = 1 << 4,\nCONDITION_PARALYZE = 1 << 5,\nCONDITION_OUTFIT = 1 << 6,\nCONDITION_INVISIBLE = 1 << 7,\nCONDITION_LIGHT = 1 << 8,\nCONDITION_MANASHIELD = 1 << 9,\nCONDITION_INFIGHT = 1 << 10,\nCONDITION_DRUNK = 1 << 11,\nCONDITION_EXHAUST = 1 << 12, // unused\nCONDITION_REGENERATION = 1 << 13,\nCONDITION_SOUL = 1 << 14,\nCONDITION_DROWN = 1 << 15,\nCONDITION_MUTED = 1 << 16,\nCONDITION_CHANNELMUTEDTICKS = 1 << 17,\nCONDITION_YELLTICKS = 1 << 18,\nCONDITION_ATTRIBUTES = 1 << 19,\nCONDITION_FREEZING = 1 << 20,\nCONDITION_DAZZLED = 1 << 21,\nCONDITION_CURSED = 1 << 22,\nCONDITION_EXHAUST_COMBAT = 1 << 23, // unused\nCONDITION_EXHAUST_HEAL = 1 << 24, // unused\nCONDITION_PACIFIED = 1 << 25,\nCONDITION_SPELLCOOLDOWN = 1 << 26,\nCONDITION_SPELLGROUPCOOLDOWN = 1 << 27,\nCONDITION_ROOTED = 1 << 28,\n"

local bush = Action()

function bush.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return true
	end

	local storageval = player:getStorageValue(Storage.SciezkaNieumarlych.Questline)
	if storageval < 3 then
		return false
	end

	player:registerEvent("konmuldBushModalWindow")

	local title = "You read the following."
	local message = bushMessage

	local window = ModalWindow(item.actionid, title, message)
	window:addButton(101, "Close")
	window:setDefaultEscapeButton(101)
	window:sendToPlayer(player)
	player:unregisterEvent("konmuldBushModalWindow")
	return true
end

bush:aid(Storage.SciezkaNieumarlych.KonmuldBush)
bush:register()

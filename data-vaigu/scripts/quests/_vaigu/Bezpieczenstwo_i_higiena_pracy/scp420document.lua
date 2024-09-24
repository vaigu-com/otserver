	:Script(function(storageToRequiredState)
local document = Action()
function document.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local aid = item:getActionId()
	local translatedText = player:Localizer(nil):Get(item:getAttribute(ITEM_ATTRIBUTE_TEXT), { player = player, aid = aid })
	SimpleTextDisplay(player, item, translatedText)
	return true
end

document:aid(Storage.SafetyAndOccupationalHygiene.Scp420Document)
document:register()
end)

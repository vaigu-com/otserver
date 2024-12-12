local function onPamphlet(player, item)
	local aid = item:getActionId()
	local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
	local translatedText = player:Localizer(nil):Context({ aid = aid }):Get(text)
	SimpleTextDisplay(player, item, translatedText)
end

local dailyPamphletUse = Action()
function dailyPamphletUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	onPamphlet(player, item)
	return true
end

local dailyPamphletLoot = Look()
function dailyPamphletLoot.onLook(player, item)
	onPamphlet(player, item)
	return true
end
dailyPamphletLoot:aid(Storage.DesertQuestOne.Readable.FloorBooks)

for _, dailyTask in pairs(GetAllDailyTasks()) do
	local aid = dailyTask.storage
	dailyPamphletUse:aid(aid)
	dailyPamphletLoot:aid(aid)
end
dailyPamphletUse:register()
dailyPamphletLoot:regiser()

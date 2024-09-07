local dailyPamphlet = Action()
function dailyPamphlet.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local aid = item:getActionId()
	local translatedText = player:Localizer(nil):Context({ aid = aid }):Get(item:getAttribute(ITEM_ATTRIBUTE_TEXT))
	SimpleTextDisplay(player, item, translatedText)
	return true
end

for _, dailyTask in pairs(GetAllDailyTasks()) do
	dailyPamphlet:aid(dailyTask.storage)
	local pamphletState = CustomItemRegistry():Register(dailyTask.storage):GetState(dailyTask.storage)
	pamphletState.text = "DAILY_TASK_PAMPHLET_DESCRIPTION"
end
dailyPamphlet:register()

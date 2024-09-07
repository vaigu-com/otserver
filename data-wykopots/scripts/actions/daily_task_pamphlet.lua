local dailyPamphlet = Action()
function dailyPamphlet.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local aid = item:getActionId()
	local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
	--local text = CustomItemRegistry():GetState(aid).text
	local translatedText = player:Localizer(nil):Context({ aid = aid }):Get(text)
	SimpleTextDisplay(player, item, translatedText)
	return true
end

for _, dailyTask in pairs(GetAllDailyTasks()) do
	local aid = dailyTask.storage
	dailyPamphlet:aid(aid)
	local pamphletState = CustomItemRegistry():Register({ aid = aid }):GetState(dailyTask.storage)
	pamphletState.text = "DAILY_TASK_PAMPHLET_DESCRIPTION"
end
dailyPamphlet:register()

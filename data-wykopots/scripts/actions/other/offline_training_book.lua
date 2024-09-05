local text = "Szkolenie na statuetce jest darmowe. Nie potrzebujesz broni, aby trenowac. Wybierz wlasciwa statuetke!"

local offlineTrainingBook = Action()

function offlineTrainingBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:showTextDialog(item.itemid, text)
	return true
end

offlineTrainingBook:id(11441)
offlineTrainingBook:register()

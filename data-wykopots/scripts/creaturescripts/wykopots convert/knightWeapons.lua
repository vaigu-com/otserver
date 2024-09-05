local knightWeapons = CreatureEvent("knightWeapons")

function knightWeapons.onModalWindow(player, modalWindowId, buttonId, choiceId)
	local player = Player(player)
	local modal = ModalWindow(20, "Language", "Set your default language: ")
	modal:addButton(1, "Accept")
	modal:addButton(2, "Cancel")
	modal:addChoice(1, "Polski")
	modal:addChoice(2, "English")
	modal:setDefaultEnterButton(1)
	modal:setDefaultEscapeButton(2)

	if modalWindowId == 30 then
		if buttonId == 1 then
			player:addItem(3430, 1)
			player:addItem(3327, 1) --club -  daramian mace

			player:addItem(3359, 1)
			player:addItem(3354, 1)
			player:addItem(3372, 1)
			player:addItem(3552, 1)
			player:addItem(3572, 1)
			modal:sendToPlayer(player)
		elseif buttonId == 2 then
			player:addItem(3430, 1)
			player:addItem(7774, 1) --sword - jagged sword

			player:addItem(3359, 1)
			player:addItem(3354, 1)
			player:addItem(3372, 1)
			player:addItem(3552, 1)
			player:addItem(3572, 1)
			modal:sendToPlayer(player)
		elseif buttonId == 3 then
			player:addItem(3430, 1)
			player:addItem(7773, 1) --axe - steel axe

			player:addItem(3359, 1)
			player:addItem(3354, 1)
			player:addItem(3372, 1)
			player:addItem(3552, 1)
			player:addItem(3572, 1)
			modal:sendToPlayer(player)
		else
			player:sendTextMessage(32, "Skoro nie chcesz broni, sam wybiore...")
			player:addItem(3430, 1)
			player:addItem(7774, 1) --sword

			player:addItem(3359, 1)
			player:addItem(3354, 1)
			player:addItem(3372, 1)
			player:addItem(3552, 1)
			player:addItem(3572, 1)
			modal:sendToPlayer(player)
		end
	end
	return true
end

knightWeapons:register()

local config = {
	[0] = {
		--club, coat
		items = { { 3059, 1 }, { 3066, 1 }, { 7991, 1 }, { 7992, 1 }, { 3362, 1 }, { 3552, 1 }, { 3572, 1 } },
		--rope, shovel, red apple
		container = { { 3003, 1 }, { 266, 1 }, { 268, 1 }, { 8015, 20 }, { 7879, 1 } },
	},
	[1] = { --Sorcerer
		--spellbook, wand of vortex, magician's robe, mage hat, studded legs, leather boots, scarf
		items = { { 3059, 1 }, { 3074, 1 }, { 7991, 1 }, { 7992, 1 }, { 3362, 1 }, { 3552, 1 }, { 3572, 1 } },
		--rope, mana potion
		container = { { 3003, 1 }, { 266, 1 }, { 268, 1 }, { 8015, 20 }, { 7879, 1 } },
	},
	[2] = { -- Druid
		--spellbook, snakebite rod, magician's robe, mage hat, studded legs, leather boots, scarf
		items = { { 3059, 1 }, { 3066, 1 }, { 7991, 1 }, { 7992, 1 }, { 3362, 1 }, { 3552, 1 }, { 3572, 1 } },
		--rope, mana potion
		container = { { 3003, 1 }, { 266, 1 }, { 268, 1 }, { 8015, 20 }, { 7879, 1 } },
	},
	[3] = { --Paladin
		--steel shield, 5 spear, ranger's cloak, ranger legs, scarf, brass helmet
		items = { { 3430, 1 }, { 3277, 5 }, { 3571, 1 }, { 8095, 1 }, { 3552, 1 }, { 3572, 1 }, { 3354, 1 } },
		--rope, health potion, mana potion
		container = { { 3003, 1 }, { 266, 1 }, { 268, 1 }, { 8015, 20 }, { 7879, 1 } },
	},
	[4] = { --Knight
		--steel shield, brass armor, brass helmet, brass legs, scarf
		items = {},
		--items = {{3430, 1}, {3359, 1}, {3354, 1}, {3372, 1}, {3552, 1}, {3572, 1}}, -- knight dostaje w knightweapons.lua
		--rope, health potion, mana potion
		container = { { 3003, 1 }, { 266, 1 }, { 268, 1 }, { 8015, 20 }, { 7879, 1 } },
	},
}

local function setFreeSails(player)
	player:setStorageValue(Storage.FreeTravels, FREE_TRANSPORTS)
end
local firstLogin = CreatureEvent("FirstItems")

function firstLogin.onLogin(player)
	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation then
		return true
	end

	if player:getLastLoginSaved() ~= 0 then
		return true
	end

	setFreeSails(player)

	for i = 1, #targetVocation.items do
		player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
	end

	local backpack = player:getVocation():getId() == 0 and player:addItem(2853) or player:addItem(2854)
	if not backpack then
		return true
	end

	for i = 1, #targetVocation.container do
		backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
	end

	if player:getVocation():getId() == 4 then
		local modal = ModalWindow(30, "Wybor broni", "Jaka bron chcesz dostac? ")
		modal:addButton(1, "Club")
		modal:addButton(2, "Sword")
		modal:addButton(3, "Axe")
		modal:sendToPlayer(player)
	else
		local modal = ModalWindow(20, "Language", "Set your default language: ")
		modal:addButton(1, "Accept")
		modal:addButton(2, "Cancel")
		modal:addChoice(1, "Polski")
		modal:addChoice(2, "English")
		modal:setDefaultEnterButton(1)
		modal:setDefaultEscapeButton(2)
		modal:sendToPlayer(player)
	end

	return true
end

firstLogin:register()

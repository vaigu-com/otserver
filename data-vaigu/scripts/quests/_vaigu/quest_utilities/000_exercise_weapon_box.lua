Storage.ExerciseWeaponBox = {}
local boxId = 906
local boxKey = Storage.ExerciseWeaponBox

local confirmChoice = function(player, button, choice)
	if not choice then
		return true
	end

	local boxObject = choice.boxObject
	if not boxObject then
		return
	end

	if not player:CanAddItems({ { id = choice.id } }) then
		player:say("You cannot open this box now.", TALKTYPE_MONSTER_SAY)
		return true
	end

	player:TryCoalesceNewExerciseWeapon(choice.id, choice.charges, boxObject)
end

local chargesLimitPerItem = 50000 -- still below uint16_t max value
function Player:TryCoalesceNewExerciseWeapon(id, newWeaponCharges, boxObject)
	if newWeaponCharges > chargesLimitPerItem then
		self:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "[ExerciseWeaponBox] You cannot create this exercise weapon, beacuse charges are higher than the 50k limit. Please contact an admin.")
		return
	end

	local oldWeapon = self:getItemById(id, true)
	local oldWeaponCharges = 0
	if oldWeapon then
		oldWeaponCharges = oldWeapon:getCharges()
	end

	local totalCharges = oldWeaponCharges + newWeaponCharges
	if totalCharges > chargesLimitPerItem then
		self:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "[ExerciseWeaponBox] You cannot coalesce this exercise weapon, beacuse total charges are higher than the 50k limit.")
		return
	end

	local inbox = self:getSlotItem(CONST_SLOT_STORE_INBOX)
	local inboxItem = inbox:addItem(id, totalCharges)
	if inboxItem then
		boxObject:remove()
		if oldWeapon then
			oldWeapon:remove()
		end
		inboxItem:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
		inboxItem:setOwner(self)
	end
end

local exerciseWeaponChoice = {
	["sword"] = 28552,
	["axe"] = 28553,
	["club"] = 28554,
	["bow"] = 28555,
	["rod"] = 28556,
	["wand"] = 28557,
}

---@param charges number
function ExerciseWeaponBox(charges)
	local exerciseWeaponBoxItem = { id = boxId, key = boxKey, charges = charges }
	return exerciseWeaponBoxItem
end

local exerciseWeaponBox = Action()
function exerciseWeaponBox.onUse(player, boxObject, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local charges = boxObject:getCustomAttribute("charges")
	local title = player:Localizer(LOCALIZERS.Universal):Get("ExerciseWeaponBoxTitle")
	local message = player:Localizer(LOCALIZERS.Universal):Context({ charges = charges }):Get("ExerciseWeaponBoxMessage")
	local window = ModalWindow({ title = title, message = message })
	window:addButton(player:Localizer(LOCALIZERS.Universal):Get("ModalWindowOk"), confirmChoice)

	for name, id in pairs(exerciseWeaponChoice) do
		local choice = window:addChoice(name)
		choice.charges = charges
		choice.id = id
		choice.boxObject = boxObject
	end

	window:sendToPlayer(player)
	return true
end

exerciseWeaponBox:key(Storage.ExerciseWeaponBox)
exerciseWeaponBox:register()

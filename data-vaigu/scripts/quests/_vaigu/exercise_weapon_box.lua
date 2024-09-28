local boxId = 906
local boxAid = Storage.ExerciseWeaponBox

local confirmChoice = function(player, button, choice)
	if not choice then
		return true
	end
	if not player:TryRemoveItems({ { id = boxId, aid = boxAid } }) then
		return
	end

	local addedWeapon = player:AddCustomItem({ id = choice.id, charges = choice.charges })
	player:TryMergeExerciseWeapons(addedWeapon)
end

local exerciseWeaponChoice = {
	["sword"] = 28552,
	["axe"] = 28553,
	["club"] = 28554,
	["bow"] = 28555,
	["rod"] = 28556,
	["wand"] = 28557,
	["shield"] = 44065,
}

---@param charges number
function ExerciseWeaponBox(charges)
	local exerciseWeaponBoxItem = { id = boxId, aid = boxAid, charges = charges }
	return exerciseWeaponBoxItem
end

local exerciseWeaponBox = Action()
function exerciseWeaponBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local charges = item:getCustomAttribute("charges")
	local title = player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ExerciseWeaponBoxTitle")
	local message = player
		:Localizer(Storage.PerIustitiaAdAstra.Questline)
		:Context({ charges = charges })
		:Get("ExerciseWeaponBoxMessage")
		
	local window = ModalWindow({ title = title, message = message })
	window:addButton(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("ModalWindowOk"), confirmChoice)

	for name, id in pairs(exerciseWeaponChoice) do
		local choice = window:addChoice(name)
		choice.charges = charges
		choice.id = id
	end

	window:sendToPlayer(player)
	return true
end

exerciseWeaponBox:aid(Storage.ExerciseWeaponBox)
exerciseWeaponBox:register()

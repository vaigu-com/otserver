local updateStorages = {
	[Storage.PerIustitiaAdAstra.Questline] = 21,
	[Storage.PerIustitiaAdAstra.Mission05] = 6,
}

local hammerId = PER_IUSTITIA_AD_ASTRA_KEY_ITEMS["LECINA_HAMMER"].id
local pipeId = 20787

local item = Action()
function item.onUse(player, hammer, fromPosition, pipe, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if hammer:getId() ~= hammerId then
		return false
	end

	if pipe:getId() ~= pipeId then
		return false
	end

	if pipe:getActionId() ~= hammer:getActionId() then
		return false
	end

	if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) ~= 20 then
		return false
	end

	pipe:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:UpdateStorages(updateStorages)
	hammer:remove()
	return true
end

item:aid(Storage.PerIustitiaAdAstra.HammerUse)
item:register()

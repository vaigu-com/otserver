local updateStorages = {
	[Storage.AssassinsCreedSkurwoala.Questline] = 16,
	[Storage.AssassinsCreedSkurwoala.Mission05] = 3,
}

local config = { ["stand"] = "You have to be standing just before Ghasstly Princess's cave in order to use this flare." }

local flare = Action()

function flare.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= ASSASSINS_CREED_SKURWOALA_KEY_ITEMS.flare.id then
		return false
	end

	local storageVal = player:getStorageValue(Storage.AssassinsCreedSkurwoala.Questline)
	if storageVal ~= 15 then
		return false
	end

	local groundAid = Tile(player:getPosition()):getGround():getActionId()
	local itemAid = item:getActionId()
	if groundAid ~= itemAid then
		player:say(player:Localizer(Storage.AssassinsCreedSkurwoala.Questline):Get(config["stand"]), TALKTYPE_MONSTER_SAY)
		return false
	end

	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
	player:UpdateStorages(updateStorages)
	item:remove()
	return true
end

flare:aid(Storage.AssassinsCreedSkurwoala.KeyItems.Flare)
flare:register()

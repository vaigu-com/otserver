	:Script(function(storageToRequiredState)
local Monitor = Action()
function Monitor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if not player:TryTradeInItems({ PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.fuelRod }, { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.rocketFuel }) then
		player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You don't have any fuel rods."), TALKTYPE_MONSTER_SAY)
		return
	end

	player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("Rod synthesis successful."), TALKTYPE_MONSTER_SAY)

	return true
end

Monitor:aid(Storage.PerIustitiaAdAstra.ShipControl.RodMelter)
Monitor:register()
end)

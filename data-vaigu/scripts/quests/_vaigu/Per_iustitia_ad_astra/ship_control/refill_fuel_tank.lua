local function refillFuel(player)
	local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
	player:IncrementStorage(fuelStorage)
end

local function sendFuelStatus(player)
	local fuelStorage = Storage.PerIustitiaAdAstra.ShipControl.FuelLevel
	local fuelLevel = player:getStorageValue(fuelStorage)
	player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("Current fuel tank status: ") .. fuelLevel, TALKTYPE_MONSTER_SAY)
end

local valve = Action()
function valve.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if not player:TryRemoveItems({ PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.rocketFuel }) then
		player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You dont have any fuel."), TALKTYPE_MONSTER_SAY)
		sendFuelStatus(player)
		return
	end

	player:say(player:Localizer(Storage.PerIustitiaAdAstra.Questline):Get("You refilled the fuel tank."), TALKTYPE_MONSTER_SAY)
	refillFuel(player)
	sendFuelStatus(player)

	local trickle = Game.createItem(5662, 1, item:getPosition():Moved(2, 2, 0))
	addEvent(function()
		trickle:remove()
	end, 1000)
	return true
end

valve:aid(Storage.PerIustitiaAdAstra.ShipControl.FuelRefillLever)
valve:register()

local fuel = Action()
function fuel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return false
end

fuel:aid(Storage.PerIustitiaAdAstra.Rewards.RocketFuel)
fuel:register()

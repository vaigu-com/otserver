
local creatureevent = CreatureEvent("mountBonusSpeed")
function creatureevent.onLogin(player)
	player:UpdateMountbonusMovementSpeed()
    return true
end
creatureevent:register()

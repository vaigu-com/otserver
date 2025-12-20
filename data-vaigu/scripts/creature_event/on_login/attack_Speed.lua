local creatureevent = CreatureEvent("attackSpeed")
function creatureevent.onLogin(player)
	player:setAttackSpeed(player:getVocation():getAttackSpeed())
	return true
end
creatureevent:register()

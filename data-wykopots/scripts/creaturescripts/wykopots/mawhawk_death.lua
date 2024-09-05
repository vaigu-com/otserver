local mawhawkDeath = CreatureEvent("MawhawkDeath")
function mawhawkDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	setGlobalStorageValue(GlobalStorage.MawhawkState, 0)
	return true
end

mawhawkDeath:register()

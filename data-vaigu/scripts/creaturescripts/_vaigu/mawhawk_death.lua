local mawhawkDeath = CreatureEvent("MawhawkDeath")
function mawhawkDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	setStorageValueByKey(Storage.MawhawkState, 0)
	return true
end

mawhawkDeath:register()

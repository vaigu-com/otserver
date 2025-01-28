local adventurerBlessingLogin = CreatureEvent("AdventurerBlessingLogin")
function adventurerBlessingLogin.onLogin(cid)
	local player = Player(cid)
	return Blessings.doAdventurerBlessing(player)
end

--adventurerBlessingLogin:register()

local creatureevent = CreatureEvent("DemonKill")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if not (player:hasOutfit(542) or player:hasOutfit(541)) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Otrzymujesz Demon Outfit za pokonanie demona!")
			player:addOutfit(542)
			player:addOutfit(541)
		end
	end)
	return true
end

creatureevent:register()

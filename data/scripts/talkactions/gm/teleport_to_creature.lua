local teleportToCreature = TalkAction("/goto")

function teleportToCreature.onSay(player, words, creaturename)
	-- create log
	logCommand(player, words, creaturename)

	if creaturename == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end


	local target = Creature(creaturename)
	if target then
		player:teleportTo(target:getPosition())
		return
	end

	local originalName = GetNpcOriginalName(creaturename)
	local target2 = Creature(originalName)
	if target2 then
		player:teleportTo(target2:getPosition())
		return
	end

	player:sendCancelMessage("Creature not found.")
	return true
end

teleportToCreature:separator(" ")
teleportToCreature:groupType("gamemaster")
teleportToCreature:register()

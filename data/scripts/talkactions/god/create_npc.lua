local createNpc = TalkAction("/n")

function createNpc.onSay(player, words, creaturename)
	-- create log
	logCommand(player, words, creaturename)

	if creaturename == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end

	local position = player:getPosition()

	local npc = Game.createNpc(creaturename, position)
	if npc then
		npc:setMasterPos(position)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
		return
	end

	-- Player may pass either translated or original name
	local originalname = GetNpcOriginalName(creaturename)
	local npc2 = Game.createNpc(originalname, position)
	if npc2 then
		npc2:setMasterPos(position)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
		return
	end

	player:sendCancelMessage("There is not enough room.")
	position:sendMagicEffect(CONST_ME_POFF)
	return true
end

createNpc:separator(" ")
createNpc:groupType("god")
createNpc:register()

local keywordToPos = {
	d = Position(5889, 1558, 7),
	dqmain = Position(5227, 928, 8),
	dqstart = Position(5228, 929, 9),
	retro = Position(4759, 854, 7),
}

for keyword, pos in pairs(keywordToPos) do
	local command = "/" .. keyword
	local talkAction = TalkAction(command)
	function talkAction.onSay(player, words, param)
		player:teleportTo(pos)
		return false
	end
	talkAction:separator(" ")
	talkAction:groupType("gamemaster")
	talkAction:register()
end

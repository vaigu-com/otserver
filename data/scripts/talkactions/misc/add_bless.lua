local talkaction = TalkAction("/addbless")

function talkaction.onSay(player, words, param)
	local split = param:split(",")
	--if split[2] == nil then
	--	player:sendCancelMessage("Insufficient parameters.")
	--	return false
	--end

	local target = Player(split[1])
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	if target:getStorageValue(Storage.GetBless) <= 0 then
		target:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		target:setStorageValue(Storage.GetBless, 1)
		for i = 2, 6 do
			target:addBlessing(i, 1)
		end
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()

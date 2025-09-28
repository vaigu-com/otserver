local playerLoggedInEarlier = {}

function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		if not playerLoggedInEarlier[player:getId()] then
			playerLoggedInEarlier[player:getId()] = true
			player:onRequestedMissions(player:getTrackedMissionIds())
			player:sendQuestLogMainPage()
			return
		end

		local missionStorages = {}
		local missionsCount = msg:getByte()
		for _ = 1, missionsCount do
			missionStorages[#missionStorages + 1] = msg:getU16()
		end
		player:onRequestedMissions(missionStorages)
	end
end

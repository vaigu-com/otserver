local playerIdFirstLoginSinceStart = {}

function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		if not playerIdFirstLoginSinceStart[player:getId()] then
			playerIdFirstLoginSinceStart[player:getId()] = true
			player:resetTrackedMissions(player:getTrackedMissionIds())
			player:sendQuestLogMainPage()
			return
		end

		local missionStorages = {}
		local missionsCount = msg:getByte()
		for _ = 1, missionsCount do
			missionStorages[#missionStorages + 1] = msg:getU16()
		end
		player:resetTrackedMissions(missionStorages)
	end
end

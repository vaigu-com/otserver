FIRST_REQUEST = "FIRST_REQUEST"
function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		if player:getStorageValueByKey(Storage.FirstTrackerRequest) == FIRST_REQUEST then
			player:setStorageValueByKey(Storage.FirstTrackerRequest, MISSION_NOT_STARTED)
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

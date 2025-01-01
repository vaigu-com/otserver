function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		local missionStorages = {}
		local missionsCount = msg:getByte()
		for i = 1, missionsCount do
			missionStorages[#missionStorages + 1] = msg:getU16()
		end
		player:resetTrackedMissions(missionStorages)
	end
end

local linkedChestScope = Scope("LinkedChest")
local chestType = {
	Annhilator = linkedChestScope:Get("Annhilator"),
	Arena1 = linkedChestScope:Get("Arena1"),
	Arena2 = linkedChestScope:Get("Arena2"),
	Arena3 = linkedChestScope:Get("Arena3"),
	PitsOfInferno = linkedChestScope:Get("PitsOfInferno"),
	Inquisition = linkedChestScope:Get("Inquisition"),
	OrcFortress = linkedChestScope:Get("OrcFortress"),
	DemonOak = linkedChestScope:Get("DemonOak"),
}

local linked = Action()
function linked.onUse(player, chest, fromPosition, target, toPosition, isHotkey)
	local key = chest:getKey()
	if player:getStorageValueByKey(key) == MISSION_FINISHED then
		SendChestIsEmpty(player, chest:getId())
		return true
	end

	local rewards = ExtractChestContent(chest)
	if player:TryAddItems(rewards) then
		player:setStorageValueByKey(key, MISSION_FINISHED)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end
for _, key in pairs(chestType) do
	linked:key(key)
end
linked:register()

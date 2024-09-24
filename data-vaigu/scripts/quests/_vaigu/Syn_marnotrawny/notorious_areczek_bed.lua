	:Script(function(storageToRequiredState)
local occupiedToEmpty = {
	[710] = 738,
	[711] = 739,
}
local emptyToOccupied = SwappedKeyValue(occupiedToEmpty)

function SwapNotoriousAreczekBed()
	local bedPositions = {
		northBedPos = JANUSZEX_ANCHOR:Moved(-87, -52, -1),
		southBedPos = JANUSZEX_ANCHOR:Moved(-87, -51, -1),
	}
	for _, pos in pairs(bedPositions) do
		local bed = pos:GetTopItem()
		local oldId = bed:getId()
		local newId = occupiedToEmpty[oldId] or emptyToOccupied[oldId]
		bed:transform(newId)
	end
end

local bed = Action()
function bed.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if player:getStorageValue(Storage.ProdigalSon.Questline) == 11 then
		local spectators = Game.getSpectators(fromPosition, true, true, 7, 7, 5, 5)
		for i = 1, #spectators do
			local translatedMessage = spectators[i]:Localizer(Storage.ProdigalSon.Questline):Get("Alright! I YIELD! We will disband our union. Now give me some peace, im sick.")
			spectators[i]:say(translatedMessage, TALKTYPE_MONSTER_SAY, true, spectators[i], fromPosition)
		end
		return true
	end

	if player:getStorageValue(Storage.ProdigalSon.Questline) == 10 then
		local aid = item:getActionId()
		if Game.getStorageValue(aid) == 1 then
			return true
		end
		if Game.createMonster("Notorious Areczek", player:getPosition()) then
			Game.setStorageValue(aid, 1)
			SwapNotoriousAreczekBed()
		end
		return true
	end

	return true
end
bed:aid(Storage.ProdigalSon.AreczekLeaderBed)
bed:register()
end)

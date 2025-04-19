return {
	["WEEKLY_OCELLATUS_MEDAL_QUEST_STATUS"] = function(context)
		local weeksSinceStart = math.ceil(DAYS_SINCE_START / 7)
		local carrotsMade = context.player:getStorageValueByKey(Storage.FashionistaOnanista.CarrotsMade)
		local remainingQuestRepeats = weeksSinceStart - carrotsMade
		if remainingQuestRepeats <= 0 then
			return "You supplied Ocellatus for the week."
		elseif remainingQuestRepeats > 1 then
			return T("Bring 10 medals of honour to Ocellatus for his weekly meat beating competition. He acutally organized competition in the previous weeks, but had no medals to honour the winners. Therefore you can bring him medals a total of :remainingQuestRepeats: times.", { remainingQuestRepeats = remainingQuestRepeats })
		else
			return "Bring 10 medals of honour to Ocellatus for his weekly meat beating competition."
		end
	end,
}

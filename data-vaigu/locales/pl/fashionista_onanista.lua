return {
	["WEEKLY_OCELLATUS_MEDAL_QUEST_STATUS"] = function(context)
		local weeksSinceStart = math.ceil(DAYS_SINCE_START / 7)
		local carrotsMade = context.player:getStorageValueByKey(Storage.FashionistaOnanista.CarrotsMade)
		local remainingQuestRepeats = weeksSinceStart - carrotsMade
		if remainingQuestRepeats <= 0 then
			return "Dostarczyles Oskarkowi medale na ten tydzien."
		elseif remainingQuestRepeats >1  then
			return T("Przynies 10 medali honoru do Oskarka na jego cotygodniowe zawody w waleniu konia. Oskarek organizowal zawody w poprzednich tygodniach, ale nie mial z czego rozdac podbitych medali. Mozesz oddac Oskarkowi medale jeszcze :remainingQuestRepeats: razy.", { remainingQuestRepeats = remainingQuestRepeats })
		else
			return "Przynies 10 medali honoru do Oskarka na jego cotygodniowe zawody w waleniu konia."
		end
	end,
}

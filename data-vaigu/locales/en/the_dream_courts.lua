local wardstoneKeyToName = {
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Knurow] = "South of knurow",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Desolation] = "Desolation near hive",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Syberia] = "West Syberia",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Caribbean] = "Caribbean",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.OgreVillage] = "Ogre village",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.BonebeastIsthmus] = "Bonebeast Isthmus",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.DemonSkeletonCave] = "Mutated town cave",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.PirateIsland] = "Pirate island",
}

return {
	--Questlog
	["DREAM_TALISMAN_STATUS"] = function(context)
		local player = context.player
		local str = "You already got those ward stones energized:"
		for _, key in pairs(QuestConstants.TheDreamCourts.UnlockableWardstones) do
			local status = "-"
			if player:getStorageValueByKey(key) == ACCESS_GRANTED then
				status = "energized!"
			end
			str = str .. T("\n:name:: :status:", { name = wardstoneKeyToName[key], status = status })
		end
		return str
	end,
	["The Dream Courts"] = "The Dream Courts",
	["Court legate asked you to charge eight wardstones that will weaken the Nightmare Beast. Look at your dream talisman to see which wardtones you already visited."] = "Court legate asked you to charge eight wardstones that will weaken the Nightmare Beast. Look at your dream talisman to see which wardtones you already visited.",
	["You must kill the Nightmare Beast."] = "You must kill the Nightmare Beast.",
	["By defeating the dreadful Nightmare Beast you did the Winter Court and the Summer Court alike a great favor. From now on, the dream elves will regard you as a friend."] = "By defeating the dreadful Nightmare Beast you did the Winter Court and the Summer Court alike a great favor. From now on, the dream elves will regard you as a friend.",
	["Haunted House"] = "Haunted House",
	["A tormented soul trusted you with the secret of this house. Reveal a hidden portal within!"] = "A tormented soul trusted you with the secret of this house. Reveal a hidden portal within!",
	["You have gained an access to the deepest mysteries of the dream courts. You can now activate ward stone and fight Faceless Bane."] = "You have gained an access to the deepest mysteries of the dream courts. You can now activate ward stone and fight Faceless Bane.",
	["The Keys"] = "The Keys",
	["Find all keys to unlock the Dream Doors."] = "Find all keys to unlock the Dream Doors.",
	["You found the keys to unlock the Dream Doors in the Labyrinth of Summer's and Winter's Dreams."] = "You found the keys to unlock the Dream Doors in the Labyrinth of Summer's and Winter's Dreams.",
}

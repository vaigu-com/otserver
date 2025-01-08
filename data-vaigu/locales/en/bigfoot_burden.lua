return {
    --Questlog
    ["Bigfoot's Burden"] = "Bigfoot's Burden",
	["Reputation points"] = "Reputation points",
	["Current reputation points"] = function(context)
		return string.format("Currently You have %d reputation points.", math.max(context.player:getStorageValueByKey(921), 0))
	end,
	["Daily Minor: Crystal Keeper"] = "Daily Minor: Crystal Keeper",
	["Daily Minor: Crystal Keeper Status"] = function(context)
		return string.format("Use the repair crystal to repair five damaged blue crystal in the crystal caves. Damaged crystals will not glow. %d/5", math.max(context.player:getStorageValueByKey(932), 0))
	end,
	["Daily Minor: Raiders of the lost Spark"] = "Daily Minor: Raiders of the lost Spark",
	["Daily Minor: Raiders of the lost Spark Status"] = function(context)
		return string.format("Kill Crystal Crushers and use discharger item on the corpse to collect their charges. Gather 7 charges and report back. %d/7", math.max(context.player:getStorageValueByKey(934), 0))
	end,
	["Daily Minor Plus: Exterminators"] = "Daily Minor Plus: Exterminators",
	["Daily Minor Plus: Exterminators Status"] = function(context)
		return string.format("Kill 10 of the wigglers for the gnomes. Then report back to the gnomes. %d/10", math.max(context.player:getStorageValueByKey(937), 0))
	end,
	["Daily Minor Plus: Mushroom Digger"] = "Daily Minor Plus: Mushroom Digger",
	["Daily Minor Plus: Mushroom Digger Status"] = function(context)
		return string.format("Find a truffle sniffing pig and lure it around. Occasionally it will unearth some truffles. Use the baby pig on the truffles to feed it 3 times. Then report back to the gnomes. %d/3", math.max(context.player:getStorageValueByKey(940), 0))
	end,
	["Daily Major Advanced: Spores"] = "Daily Major Advanced: Spores",
	["Gather spores in the correct order. Your spore gathering list will display the next color you have to look for."] = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
	["Daily Major Advanced: Yet Another Grinding"] = "Daily Major Advanced: Yet Another Grinding",
	["Gather a grindstone from the lava area and report back."] = "Gather a grindstone from the lava area and report back.",
	["Daily Major: Matchmaker"] = "Daily Major: Matchmaker",
	["You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them."] = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
	["Daily Major: The Tinker's Bell"] = "Daily Major: The Tinker's Bell",
	["Daily Major: The Tinker's Bell Status"] = function(context)
		return string.format("Use the harmonic bell on the mad golems in the golem workshop so that they will automatically be teleported to the gnomish workshops. Then report back to the gnomes. %d/4.", math.max(context.player:getStorageValueByKey(946), 0))
	end,
}

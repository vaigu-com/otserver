return {
	["I love human meat. Why don't you sell me your family for some soup? Or maybe would you like to be my assistant?\nNevermind, firstly you need to prove you are worthy. Then I will give you my old tool which I used to use before I have enjoyed human meat. Bring me 5 vampire teeth please, they are very good for making needles. Go now, otherwise I will get you."] = "I love human meat. Why don't you sell me your family for some soup? Or maybe would you like to be my assistant?\nNevermind, firstly you need to prove you are worthy. Then I will give you my old tool which I used to use before I have enjoyed human meat. Bring me 5 vampire teeth please, they are very good for making needles. Go now, otherwise I will get you.",
	["You did your task very well, you will use these tools properly for sure. Come back to me when you have decided you want to know the real taste."] = "You did your task very well, you will use these tools properly for sure. Come back to me when you have decided you want to know the real taste.",
	["Why are you coming back without vampire teeth? Should I be taking yours instead?\nCome back when you have proven that you are worthy of using this tool."] = "Why are you coming back without vampire teeth? Should I be taking yours instead?\nCome back when you have proven that you are worthy of using this tool.",
	["So you want to help me again? Listen, recently I've been sewing a little bit, but human skin itself its not enough.\nI will need some different colours and materials. Bring me 2 pieces of {skin} of each type.\nIf you do that I will teach you everything about skinning."] = "So you want to help me again? Listen, recently I've been sewing a little bit, but human skin itself its not enough.\nI will need some different colours and materials. Bring me 2 pieces of {skin} of each type.\nIf you do that I will teach you everything about skinning.",
	["Yes! Now I have a proper assortment. Maybe I will sew something for you.\nAbout skinning... it didn't go very well. I assume it was your first time skinning.\nRemember, you must start cutting from armpit and cut straight down.\nSo if you know now how to skin people, go and train a little bit. If you want anything else just come back to me for different task."] = "Yes! Now I have a proper assortment. Maybe I will sew something for you.\nAbout skinning... it didn't go very well. I assume it was your first time skinning.\nRemember, you must start cutting from armpit and cut straight down.\nSo if you know now how to skin people, go and train a little bit. If you want anything else just come back to me for different task.",
	["Ahh yes, something to do? I'm going for annual meeting for cannibals and I need to prepare some meals, so I won't come empty handed.\nSo If you know secret skinning techniques already you can help me to gather ingredients. Bring me 15 human hearts."] = "Ahh yes, something to do? I'm going for annual meeting for cannibals and I need to prepare some meals, so I won't come empty handed.\nSo If you know secret skinning techniques already you can help me to gather ingredients. Bring me 15 human hearts.",
	["You need to be more careful, some of them are really creased..\nWait, that one is a liver and it looks like it belonged to an alcoholic. Despite that I'm inviting you to the cannibals club. Take this uniform! Take also my vest in gratitude, I'm not using it anymore."] = "You need to be more careful, some of them are really creased..\nWait, that one is a liver and it looks like it belonged to an alcoholic. Despite that I'm inviting you to the cannibals club. Take this uniform! Take also my vest in gratitude, I'm not using it anymore.",
	["Come back when you get 15 hearts"] = "Come back when you get 15 hearts",
	["LECTER_LISTS_REQUIRED_SKINS"] = function(context)
		return "Fine me those skins, two of each:\n" .. RequiredItemNamesToString(QuestKeyItems.SilenceOfTheLambs.Skins)
	end,
	--Questlog
	["The Silence of the Lambs"] = "The Silence of the Lambs",
	["The test of Strength"] = "The test of Strength",
	["Lecter asked you for 5 vampire teeth."] = "Lecter asked you for 5 vampire teeth.",
	["Ask Lecter for a new mission."] = "Ask Lecter for a new mission.",
	["In exchange for your help, Lecter bestowed you with his old soul-extraction tool."] = "In exchange for your help, Lecter bestowed you with his old soul-extraction tool.",
	["Fashionable clothes"] = "Fashionable clothes",
	["Lecter asked you to bring him 2 leathers of every kind."] = "Lecter asked you to bring him 2 leathers of every kind.",
	["For your help you have been taught how to skin human carcass."] = "For your help you have been taught how to skin human carcass.",
	["Rub Meat With Lecter"] = "Rub Meat With Lecter",
	["Lecter wants you to hoard 15 human hearts. He needs them for his cannibals party."] = "Lecter wants you to hoard 15 human hearts. He needs them for his cannibals party.",
	["In exchange for this favor you have been introduced to the cannibal club. You also received their outfits."] = "In exchange for this favor you have been introduced to the cannibal club. You also received their outfits.",
	["Hearts collected"] = "Hearts collected",
	["Hearts collected Status"] = function(context)
		return string.format("Amount of hearts collected: %d / 15", context.player:getStorageValueByKey(11074))
	end,
	["Livers collected"] = "Livers collected",
	["Livers collected Status"] = function(context)
		return string.format("Amount of livers collected: %d / 20", context.player:getStorageValueByKey(11075))
	end,
}

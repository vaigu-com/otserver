return {
	["Select task you're interested in: "] = "Select task you're interested in: ",
	["Available Task list"] = "Available Task list",
	["Select task you want to cancel: "] = "Select task you want to cancel: ",
	["Ongoing tasks list:"] = "Ongoing tasks list:",
	["You don't have any active tasks. Ask me for {tasks} to sign up for one."] = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
	["Great job!"] = "Great job!",
	["Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!",
	["Finish one of {tasks}, then we can talk about reward."] = "Finish one of {tasks}, then we can talk about reward.",
	["TASKS_HELP_WINDOW_INFO"] = function()
		return T("Finishing tasks grants you experience points, money, store coins and after each task you can face the corresponding boss.\n\nYou can have up to :maxTasks: active tasks at the time.", { maxTasks = #Storage.Tasks.PlayerOngoingTasks })
	end,
	["TASK_REWARDS_DIALOG"] = function(context)
		local task = context.task
		return T("Your rewards for :name: task is: :exp: experience points, :money: gold and ability to fight with the boss :bossName: (details in questlog).\n You received :points: store coins and task points", {
			name = task.name,
			exp = task.exp,
			money = task.money,
			bossName = task.bossName,
			points = task.tibiaCoins,
		})
	end,
	["TASK_READY_TO_TURN_IN"] = function(context)
		return T("Task for :name: is finshed! You can now face the boss and go to The Great Tracker for reward!", { name = context.task.name })
	end,
	["YOU_HAVE_MAX_ONGOING_TASKS"] = function()
		local maxOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
		return T("You have :maxOngoingTasks: already. You can {cancel} one of them if you want.", { maxOngoingTasks = maxOngoingTasks })
	end,
	["TASK_CURRENT_KILLS"] = function(context)
		local task = context.task
		local currentKills = context.player:getStorageValueByKey(task.storage)
		local name = task.name
		local requiredKills = task.requiredKills
		currentKills = ParseCurrentKills(currentKills, requiredKills)
		return T("Task for :name:: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["YOU_DONT_HAVE_REQUIRED_TASK_KILLS"] = function(context)
		local task = context.task
		local player = context.player
		local currentKills = player:getStorageValueByKey(task.storage)
		local requiredKills = task.requiredKills
		local name = task.name
		return T("You didn't execute enough monsters for the :name: task. Your current progress: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
    ["YOU_CURRENTLY_HAVE_N_TASK_POINTS"] = function(context)
		local points = context.player:getStorageValueByKey(Storage.Tasks.TaskPoints)
		return T("Currently you have :points: task points. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues.", { points = points })
	end,
	["THIS_TROPHY_WILL_COST_YOU_N"] = function(context)
		return T("Which one would you like to buy? It will cost you :cost: task points: {bronze hunter trophy}, {silver hunter trophy}, {gold hunter trophy}, {gozzler trophy}, {hellflayer trophy} and {sea serpent doll}.", { cost = context.keywordConfig.cost })
	end,
	["YOU_WANT_TO_BUY_TROHPY_NAME"] = function(context)
		return T("Would you like to buy :name: for :cost: Task Poins?", { name = context.msg:lower(), cost = context.keywordConfig.cost })
	end,
	["YOU_DONT_HAVE_ENOUGH_TASK_POINTS"] = function(context)
		local current = context.player:getStorageValueByKey(Storage.Tasks.TaskPoints)
		local required = context.keywordConfig.cost or PlayerCustomDialogDataRegistry:Get(context.player).requiredTaskPoints
		local diff = required - current
		return T("You dont have enough points. You need :required: points to buy that. You currently have :current: points meaning you need to accumulate :diff: more points.", { current = current, required = required, diff = diff })
	end,
	["YOU_WANT_TO_BUY_ANTELOPE"] = function(context)
		return T("Do you want to exchange :cost: points for Antelope mount?", { cost = context.keywordConfig.cost })
	end,
	["LIST_IMBUING_NAMES"] = function()
		local translatedString = "I can sell creature product bundles for the following imbuings:"

		local categories = GetImbuingCategories()
		for _, category in pairs(categories) do
			translatedString = translatedString .. T("\n:categoryName:: ", { categoryName = category.categoryName })
			for _, imbuementName in pairs(category.imbuements) do
				translatedString = translatedString .. T("{:imbuementName:}, ", { imbuementName = imbuementName })
			end
		end
		translatedString = string.sub(translatedString, 1, -3) .. "."
		return translatedString
	end,
	["YOU_SELECTED_IMBUING_NAME"] = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local imbuementName = bundleData.name
		return T("What level of :imbuementName: imbuement are you interested in: {basic}, {intricate}, {powerful}?", { imbuementName = imbuementName })
	end,
	["YOU_SELECTED_IMBUING_LEVEL"] = function(context)
		local bundleLevelData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local levelName = bundleLevelData.levelName
		local imbuementName = bundleLevelData.name
		local moneyCost = bundleLevelData.moneyCost
		local taskPointsCost = bundleLevelData.taskPointsCost
		local message = T("Do you want to buy :levelName: :imbuementName: for :moneyCost: gold and :taskPointsCost: task points?\nThis bundle contains:", {
			levelName = levelName,
			imbuementName = imbuementName,
			moneyCost = moneyCost,
			taskPointsCost = taskPointsCost,
		})
		for _, item in pairs(bundleLevelData.items) do
			local itemName = ItemType(item.id):getName()
			local count = item.count
			message = message .. T("\n:count: :itemName:", { itemName = itemName, count = count })
		end
		return message
	end,
	["YOU_WANT_BUY_ABILITY_POWEFUL_IMBUEMENT"] = function(context)
		return T("Do you want to buy ability to make powerful imbues? It's gonna cost you :cost: task points.", { cost = context.keywordConfig.cost })
	end,
	["You already have this mount."] = "You already have this mount.",
	["I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}."] = "I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}.",
	["You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues."] = "You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues.",
	["You already got it."] = "You already got it.",
	["Do you want to buy ability to make powerful imbues?"] = "Do you want to buy ability to make powerful imbues?",
	["You don't yet have the {ability} to buy this level of bundle yet."] = "You don't yet have the {ability} to buy this level of bundle yet.",
	["You dont have enough cap or slots for these items."] = "You dont have enough cap or slots for these items.",
    --Questlog
	["Tasks"] = "Tasks",
	["Task informations"] = "Task informations",
	["TASK_MISSION_NAME"] = function(context)
		return T(":name:", { name = context.task.name })
	end,
	["TASK_MISSION_DESCRIPTION"] = function(context)
		local player = context.player
		local task = context.task

		local storage = task.storage
		local name = task.name
		local requiredKills = task.requiredKills
		local currentKills = player:getStorageValueByKey(storage)
		currentKills = ParseCurrentKills(currentKills, requiredKills)
		return T(":name: killed: :currentKills:/:requiredKills:.", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_NAME"] = function(context)
		return T("Fight with :bossName:", { bossName = context.task.bossName })
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION"] = function(context)
		local bossLocationDescription = context.player:Localizer(LOCALIZERS.Tasks):Get(context.task.name)
		return bossLocationDescription
	end,
	["Apes"] = "The Gorilla lives in monkey camp on eastern side of the mountain range in the jungle.",
	["Carniphilas"] = "Deathbine settled down somewhere near rocks on a bamboo clearing. The area is known from their crowdedness of Terror Birds and Carniphilas.",
	["Crocodiles"] = "His lair is said to be under a waterfall teeming with crocodiles.",
	["Cyclops"] = "The old cyclops was seen in the depths of a cave at the northern gate of MirkoTown.",
	["Dragons"] = "The old dragon lives around the volcano to the north of Mirko Town.",
	["Gargoyles"] = "The gargoyle cave is located at the top of the mountains inhabited by cyclops.",
	["Mammoths"] = "The entrance to the Bloodtusk cave is somewhere on the Siberian surface.",
	["Minos (Horned Fox)"] = "The rumors says that one of the minotaur leaders is hiding in their settlement north of MirkoTown.",
	["Mutated Humans"] = "His hideout is located under the cemetery in the village of mutants.",
	["Orcs"] = "Bibby spent most of his time in the northern orc fortress, probably still there.",
	["Rotworms"] = "The White Pale lair lays somewhere in eastern undergrounds of MirkoTown",
	["Stone Golems"] = "Grorlam is hiding in a small cave inhabited by elementals to the northeast of Hurghada.",
	["Tarantulas"] = "In ruins to the west of Kongo there were quite a few tarantulas, Hide might hid there.",
	["Terramites"] = "Thermite is hiding in a small hole in the eastern part of the desert.",
	["Tortoises"] = "There is a hovel in the north-east of jungle, where Thorner resides.",
	["Weak undeads"] = "The cemetery on east of Mirko Town is haunted by Ripper now and again. He is probably hiding there.",
	["Ancient Scarabs"] = "The most vicious scarab has its lair located underneath dry plains in the south of steppes.",
	["Bonebeasts"] = "Rumours mention that desert Wyrms are guarding entrance to his lair, but this time it would really seem it's just rumours",
	["Crystal Spiders"] = "Bloodweb's hiding place is located underneath certain rocks, in the northern part of Sybir.",
	["Giant Spiders"] = "South of Knurowo is a place swarming with spiders. Perhaps the most dangerous one is there as well.",
	["Ice Golems"] = "The teleport to the Shardhead's chamber is in the north of Sybir. There are Crystal Spiders and Ice Golems hanging around in its vicinity",
	["Lancer Beetles"] = "The murderous worm is hiding under the contaminated area in the north of steppes",
	["Mutated Bats"] = "The contaminated mountains have become a home to mutated bats and rats. Bruise Payne is hiding in these rocks",
	["Mutated Rats"] = "The entrance to Esmeralda's hideout is somewhere near cliffs inhabited by mutated rats, in the heart of steppes.",
	["Mutated Tigers"] = "The entrance to the tiger's den is located near a mountain inhabited by tigers of the steppes.",
	["Necromancers"] = "The lord of necromancers is located somewhere near Mirko Town cemetery",
	["Ogres"] = "The master of ogres lives in their biggest settlement on steppes",
	["Pirates"] = "The pirate's captain is hiding somewhere on their island for sure",
	["Stampors"] = "Tromphonyte is hiding in the Stampors den.",
	["Wailing Widows"] = "Fiery widow has its own cave in the southern-west ends of desert.",
	["Wyverns"] = "Reptilia can be bested at the mountain inhabited by jungle wyverns.",
	["Behemoths"] = "The grotto of the humongous behemoths is located underneath the swamp in the west of the jungle. If you dare, you can wander there and look for Stonecracker.",
	["Brimstone Bug"] = "In the subterranean grounds under acid-tainted area of steppes, the Brimstone Bugs are feeling at home. The Sulphur Scuttler has to be hiding there.",
	["Demons"] = "Demonica is hiding in the unholy depths under the undead village.",
	["Destroyers"] = "A whole lot of destroyers are inside caves at the eastern part of desert. You can search these for Bretzecutioner.",
	["Drakens"] = "If you manage to make it through the Draken Towers, the teleport will lead you to the plain ruled by their commander - Paiz the Pauperizer.",
	["Frost Dragons"] = "Frosty is hiding inside one of the mountains in Sybir.",
	["Ghastly Dragons"] = "Den of Ghastly Dragons is located in the caves between desert and jungle. Ethershreck also has made this place his home.",
	["Hellhound"] = "The path to the hellish Kerberos is guarded by Demons and Hellhounds. However this is only a myth..",
	["Hellspawns"] = "Between two waterfalls in the jungle there is a path to the primordial ruins. A lot of Hellspawns are nesting there, Flameborn may be lurking there as well.",
	["High Class Lizards"] = "The chamber of lizard's commander - Fazzrah is located in their village in steppes.",
	["Hydras"] = "A bunch of Hydras inhabit the southern part of jungle's marshes. The Many usually resides here.",
	["Killer Caimans"] = "The deadliest of crocodiles is hiding under a river on eastern end of the steppes.",
	["Medusa"] = "Madeusae leader's Gorgo has its grotto located in subterranean ruins, which are guarded by her children.",
	["Nightmares"] = "The chamber of Tormentor is located in in a place where heroes have to face their nightmares.",
	["Quaras"] = "The only way to travel to the island where Thul resides, is to sail there by ship.",
	["Sea Serpents"] = "The rock bottom of the great lake is infested by Sea Serpents. In the depths, there lives the legendary Leviathan.",
	["Serpent Spawns"] = "In the western part of the jungle, one of the hills is inhabited by Serpent Spawns. The Noxious Spawn could be hiding there.",
	["Undead Dragons"] = "In the underground ruins, which entrance is guarded by Medusae and Serpent Spawns, there are Undead Dragons guarding their leader.",
	["Werewolves"] = "Beyond the caves haunted by nightstalkers, there is a place occupied by werewolves. They may be hiding The Hemming there.",
}

return {
	["Select task you're interested in: "] = "Wybierz interesujace cie zadanie:  ",
	["Available Task list"] = "Lista dostepnych taskow",
	["Select task you want to cancel: "] = "Anuluj wybrany task: ",
	["Ongoing tasks list:"] = "Wziete taski:",
	["You don't have any active tasks. Ask me for {tasks} to sign up for one."] = "Nie masz aktywnych zadan. Zapytaj mnie o {taski}, aby rozpoczac zadanie.",
	["Great job!"] = "Dobra robota!",
	["Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Posiadam paczki creature productow na kazdy z {imbuingow}. Kosztowac cie to bedzie troche zlota oraz {punktow}.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Siemaneczko, widze ze zadanie o ktore cie prosilem zostalo wykonane. Nalezy ci sie {nagroda}!",
	["Finish one of {tasks}, then we can talk about reward."] = "Ukoncz jakis z {taskow}, to porozmawiamy o nagrodzie.",
	["TASKS_HELP_WINDOW_INFO"] = function()
		return T("Za wykonywanie taskow dostajesz nagrody w postaci: expa, pieniedzy, osiagniec od CV oraz mozliwosci walki z bossami.\n\nMozesz posiadac jednoczesnie :maxTasks: zadania.", { maxTasks = #Storage.Tasks.PlayerOngoingTasks })
	end,
	["TASK_REWARDS_DIALOG"] = function(context)
		local task = context.task
		return T("Nagroda za task na :name: to: :exp: puktow doswiadczenia, :money: zlota oraz mozliwosc walki z bossem :bossName: (szczegoly w questlogu).\n Utrzymujesz :points: coiny oraz punkty taskow.", {
			name = task.name,
			exp = task.exp,
			money = task.money,
			bossName = task.bossName,
			points = task.tibiaCoins,
		})
	end,
	["TASK_READY_TO_TURN_IN"] = function(context)
		return T("Task na :name: zostal zakonczony! Mozesz zmierzyc sie z bossem oraz udac do npc po nagrode.", { name = context.task.name })
	end,
	["YOU_HAVE_MAX_ONGOING_TASKS"] = function()
		local maxOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
		return T("Posiadasz :maxOngoingTasks: zadania. {Anuluj} je, aby wziac nowe.", { maxOngoingTasks = maxOngoingTasks })
	end,
	["TASK_CURRENT_KILLS"] = function(context)
		local task = context.task
		local currentKills = context.player:getStorageValueByKey(task.storage)
		local name = task.name
		local requiredKills = task.requiredKills
		currentKills = ParseCurrentKills(currentKills, requiredKills)
		return T("Task na :name:: :currentKills:/:requiredKills: ", {
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
		return T("Nie zabiles wystarczajacej ilosci stworow do taska na :name:. Twoj aktualny postep to: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	--Task Points
	["YOU_CURRENTLY_HAVE_N_TASK_POINTS"] = function(context)
		local points = context.player:getStorageValueByKey(Storage.Tasks.TaskPoints)
		return T("Aktualnie posiadasz :points: punktow taskow.  Mozesz wymienic je na kilka {trofeow}, {wierzchowca} oraz {mozliwosc} nasycania na najwyzszy poziom.", { points = points })
	end,
	["THIS_TROPHY_WILL_COST_YOU_N"] = function(context)
		return T("Ktore chcial bys zakupic? Kosztowac cie to bedzie :cost: punktow taskow: {bronze hunter trophy}, {silver hunter trophy}, {gold hunter trophy}, {gozzler trophy}, {hellflayer trophy} oraz {sea serpent doll}.", { cost = context.keywordConfig.cost })
	end,
	["YOU_WANT_TO_BUY_TROHPY_NAME"] = function(context)
		return T("Czy chcesz kupic :name: za :cost: punktow taskowych?", { name = context.msg:lower(), cost = context.keywordConfig.cost })
	end,
	["YOU_DONT_HAVE_ENOUGH_TASK_POINTS"] = function(context)
		local current = context.player:getStorageValueByKey(Storage.Tasks.TaskPoints)
		local required = context.keywordConfig.cost or PlayerCustomDialogDataRegistry:Get(context.player).requiredTaskPoints
		local diff = required - current
		return T("Nie posiadasz odpowiedniej liczby punktow taskowych. Potrzebuejsz :required: punktow aby to kupic. Posiadasz :current: punktow, co oznacza, ze potrzebuejesz jeszcze :diff: punktow.", { current = current, required = required, diff = diff })
	end,
	["YOU_WANT_TO_BUY_ANTELOPE"] = function(context)
		return T("Czy chcesz wymienic :cost: punktow taskowych na na wierzchowca Antelope?", { cost = context.keywordConfig.cost })
	end,
	["LIST_IMBUING_NAMES"] = function()
		local translatedString = "Sprzedaje paczki z produktami, ktore umozliwiaja dokonanie nasycenia. Oto oferowane przeze rodzaje:"

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
		return T("Jakim poziomem nasycenia :imbuementName: jestes zainteresowany : {basic}, {intricate}, {powerful}?", { imbuementName = imbuementName })
	end,
	["YOU_SELECTED_IMBUING_LEVEL"] = function(context)
		local bundleLevelData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local levelName = bundleLevelData.levelName
		local imbuementName = bundleLevelData.name
		local moneyCost = bundleLevelData.moneyCost
		local taskPointsCost = bundleLevelData.taskPointsCost
		local message = T("Czy chcesz kupic :levelName: :imbuementName: za :moneyCost: zlota oraz :taskPointsCost: punktow taskowych?\nTa pazcka zawiera:", {
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
		return T("Czy chcesz kupic mozliwosc nasycania najwyzszego poziomu (powerful) za :cost: punktow taskowych?", { cost = context.keywordConfig.cost })
	end,
	["You already have this mount."] = "Juz posiadasz tego wierzchowca.",
	["I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}."] = "Posiadam paczki creature productow na kazdy z {imbuingow}. Kosztowac cie to bedzie troche zlota oraz {punktow}.",
	["You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues."] = "Nie posiadasz zadnych punktow. Otrzymasz je po wykonaniu ktoregos z taskow lub zadan z tablicy. Mozesz wymienic je na kilka {trofeow}, {wierzchowca} oraz {mozliwosc} nasycania na najwyzszy poziom.",
	["You already got it."] = "Juz to kupiles.",
	["Do you want to buy ability to make powerful imbues?"] = "Chcesz zakupic mozliwosc nasycania na najwyzszy trzeci poziom?",
	["You don't yet have the {ability} to buy this level of bundle yet."] = "Nie mozesz jeszcze nasycac tego poziomu. Zapytaj mnie o {mozliwosc} nasycania, to powiem ci co i jak.",
	["You dont have enough cap or slots for these items."] = "Nie masz miejsca w plecaku, albo nie bedziesz w stanie udzwignac tych przedmiotow.",
	--Questlog
	["Tasks"] = "Taski",
	["Task informations"] = "Informacje o taskach",
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
		return T("Zabitych :name:: :currentKills:/:requiredKills:.", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_NAME"] = function(context)
		return T("Walka z :bossName:", { bossName = context.task.bossName })
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION"] = function(context)
		local bossLocationDescription = context.player:Localizer(LOCALIZERS.Tasks):Get(context.task.name)
		return bossLocationDescription
	end,
	["Apes"] = "Gorila mieszka w malej osadzie malp na wschodniej czesci pasma gor w dzungli.",
	["Carniphilas"] = "Deathbine ulokowal sie gdzies przy skalach na bambusowej polanie, ktora jest siedliskiem Terror Birdow oraz Carniphili.",
	["Crocodiles"] = "Jego legowisko podobno znajduje sie pod wodospadem, a w okolicy kreci sie sporo krokodyli.",
	["Cyclops"] = "Stary cyklop widywany byl w jaskini przy polnocnej bramie Mirko Town.",
	["Dragons"] = "Stara smoczyca przesiaduje w wulkanie na polnocy Mirko Town.",
	["Gargoyles"] = "Grota gargulca znajduje sie na szczycie gor zamieszkalych przez cyklopy.",
	["Mammoths"] = "Wejscie do groty Bloodtuska znajduje sie na powierzchni Sybiru.",
	["Minos (Horned Fox)"] = "Jeden z przywodcow minotaurow podobno ukrywa sie w ich osadzie na polnoc od Mirko Town.",
	["Mutated Humans"] = "Jego kryjowka znajduje sie pod cmentarzem we wiosce zmutowancow.",
	["Orcs"] = "Bibby najczesciej przesiadywal w polnocnej fortecy orkow, zapewne nadal tam jast.",
	["Rotworms"] = "Odnajdz legowisko White Pale pod MirkoTown.",
	["Stone Golems"] = "Grorlam ukrywa sie w malej jaskini zasiedlonej przez zwyiolaki na polnocny wschod od Hurghady.",
	["Tarantulas"] = "W pewnych ruinach na zachod Kongo zaleglo sie sporo tarantul, Hide sie tam schowal.",
	["Terramites"] = "Thermite ukrywa sie w malej dziurze na wschodzie pustyni.",
	["Tortoises"] = "Thorner swoja kryjowke posiada w polnocno zachodniej czesci dzunglii.",
	["Weak undeads"] = "Cmentarz na wschodzie Mirko Town jest czasem nawiedzany przez Rippera. Pewnie gdzies tam sie ukrywa.",
	["Ancient Scarabs"] = "Najgrozniejszy z skarabeuszy swoje legowisko posiada pod wysuszonymi polami na poludniu stepow.",
	["Bonebeasts"] = "Podobno wejscia do jego kryjowki strzega pustynne Wyrmy, jednak zdaje sie, ze to tylko pogloski.",
	["Crystal Spiders"] = "Legowisko Bloodweba znajduje sie na pewnych skalach lezacych na polnocy Sybiru.",
	["Giant Spiders"] = "Na poludnie od Knurowa zaleglo sie sporo pajakow, byc moze tam znajduje sie najgrozniejszy z nich.",
	["Ice Golems"] = "Teleport do komnaty Shardheada znajduje sie na polnocy Sybiru, w okolicy kreca sie Crystal Spidery oraz Ice Golemy.",
	["Lancer Beetles"] = "Smiercionosny robal ukrywa sie pod skazonym terenem na polnocy stepow.",
	["Mutated Bats"] = "Skazone gory staly sie legowiskiem zmutowanych nietoperzy oraz szczurow, Bruise Payne ukrywa sie w skalach.",
	["Mutated Rats"] = "Wejscie do kryjowki Esmeraldy znajduje sie gdzies na skalach zamieszkalych przez zmutowane sczury w centrum stepow.",
	["Mutated Tigers"] = "Wejscie do tygrysiej nory znajduje sie w jednej z gor zasiedlonych przez tygrysy na stepach.",
	["Necromancers"] = "Komnata wladcy nekromantow znajduje sie gdzies pod cmentarzem mirko town.",
	["Ogres"] = "Mistrz ogrow mieszka w ich najwiekszej wiosce na stepie.",
	["Pirates"] = "Kapitan piratow z pewnoscia ukrywa sie gdzies na ich wyspie.",
	["Stampors"] = "Tromphonyte ukrywa sie w jaskiniach zasiedlonych przez Stampory.",
	["Wailing Widows"] = "Plomienista pajeczyca posiada swoja grote pod poludniowo zachodnim kancem pustyni.",
	["Wyverns"] = "Reptilie pokonac mozna na jednej z gor zasiedlonych przez wyverny w dzungli.",
	["Behemoths"] = "Grota olbrzymich Behemothow znajduje sie pod bagnami na zachodzie dzungli. Jesli nie brak ci odwagi mozesz poszukac tam Stonecrackera.",
	["Brimstone Bug"] = "W podziemiach pod terenami skazonymi kwasem na polnocy Stepu radioaktywne Brimstone Bugi czuja sie doskonale, Sulphur Scuttler musi sie tam ukrywac.",
	["Demons"] = "Teleport znajduje sie gdzies na mapie, znajdz go!",
	["Destroyers"] = "Sporo niszczycieli znajduje sie w podziemiach na wschodzie pustyni, mozesz rozejrzec sie tam w poszukiwaniu Bretzecutionera.",
	["Drakens"] = "Jesli uda ci sie przedostac przez wieze Drakenow, teleport poprowadzi cie do siedziby ich wladcy - Paiz the Pauperizera.",
	["Frost Dragons"] = "Frosty ukrywa sie w jednej z gor na Sybirze.",
	["Ghastly Dragons"] = "Legowisko upiornych smokow znajduje sie w poziemiach pomiedzy pustynia a dzungla, Ethershreck takze sie tam zagniezdzil.",
	["Hellhound"] = "Dostep do piekielnego Kerberosa strzezony jest przez Demony oraz Hellhoundy, jednak to tylko legendy...",
	["Hellspawns"] = "Pomiedzy wodospadami w dzungli znajduje sie zejscie do zapomnianych ruin. Zaleglo sie tam wiele Hellspawnow, Flameborn pewnie sie tam ukrywa.",
	["High Class Lizards"] = "Komnata przywodcy jaszczuroludzi - Fazzraha znajduje sie w ich wiosce na stepach.",
	["Hydras"] = "Na poludniu bagien w dzungli zamieszkalo kilka hydr, The Many przebywa tam najczesciej.",
	["Killer Caimans"] = "Najgrozniejszy z krokodyli ukrywa sie pod rzeka na wschodnim krancu stepow.",
	["Medusa"] = "Grota przywodczyni Meduz - Gorgo znajduje sie w podziemnych ruinach, ktorch strzega jej podopieczne.",
	["Nightmares"] = "Komnata Tromentora znajduje sie w miejscu, gdzie bohaterowie walcza z koszmarami.",
	["Quaras"] = "Na wyspe, gdzie przesiaduje Thul, trzeba dostac sie przeplywajac statkiem.",
	["Sea Serpents"] = "Dno wielkiego jeziora zasiedlone jest przez Morskie Weze, w jego glebinach mieszka legendarny Leviathan.",
	["Serpent Spawns"] = "Na zachodzie dzunglii jedne ze wzgorzy zamieszkale sa przez Serpent Spawny, The Noxious Spawn mogl sie tam ukryc.",
	["Undead Dragons"] = "W podziemnych ruinach, do ktorych dojscia strzega Meduzy oraz Serpent Spawny znajduja sie nieumarle smoki broniace swojego przywodcy - Zanekepha.",
	["Werewolves"] = "W jaskiniach za miastem w ktorym strasza nocni przesladowcy przesiaduja wilkolaki, zapewne ukrywaja tam Hemminga.",
}

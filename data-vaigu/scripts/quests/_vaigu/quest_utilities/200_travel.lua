local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:Storage(function() end)
	:Constant(function()
		FREE_TRAVELS_COUNT = 10

		TRAVEL_METHOD = {
			SHIP = "TRAVEL_METHOD.SHIP",
			CARPET = "TRAVEL_METHOD.CARPET",
			TRAIN = "TRAVEL_METHOD.TRAIN",
			CAMEL = "TRAVEL_METHOD.CAMEL",
		}

		UNIVERSAL_TRAVEL_KEYWORD = "travel"

		TRAVEL_KEYWORDS = {
			UNIVERSAL_TRAVEL_KEYWORD,
			"sail",
			"ship",
			"ride",
			"fly",
			"podroz",
			"plynac",
			"statek",
			"zegluje",
			"statku",
			"zegluj",
			"zegluga",
			"poleciec",
			"pojechac",
			"jazda",
			"jedziemy",
			"podwiezc",
		}

		DEFAULT_TRAVEL_PRICE = 200
		TRAVEL_ROUTES = {
			ALI_BABA_CARPET = {
				{ toPos = Position(7273, 1104, 3), name = "Maioor'ka" },
				{ toPos = Position(7027, 1201, 2), name = "Cairo Fornia" },
				{ toPos = Position(7493, 1731, 6), name = "Orshaawa" },
				{ toPos = Position(6739, 1280, 4), name = "Hurghada" },
				{ toPos = Position(6972, 784, 4), name = "Kongo" },
				{ toPos = Position(6044, 1282, 3), name = "Zasrane", requiredState = { [Storage.GrapplingHook] = ACCESS_GRANTED } },
				{ toPos = Position(7352, 1512, 2), name = "Caribbean", minLevel = 60 },
			},
			PIRATE_SHIP = {
				{ toPos = Position(5689, 1465, 6), name = "Phantom Port", requiredState = { [Storage.AvastYe.ShipDestinations.PhantomPort] = ACCESS_GRANTED } },
				{ toPos = Position(6750, 2584, 6), name = "Pirate Island", requiredState = { [Storage.AvastYe.ShipDestinations.PirateIsland] = ACCESS_GRANTED } },
				{ toPos = Position(6846, 1425, 6), name = "Port Louse", requiredState = { [Storage.AvastYe.ShipDestinations.PortLouse] = ACCESS_GRANTED } },
				{ toPos = Position(6335, 1357, 6), name = "Wyrm Cliffs", requiredState = { [Storage.AvastYe.ShipDestinations.WyrmCliffs] = ACCESS_GRANTED } },
				{ toPos = Position(7058, 1426, 6), name = "Naga Island", requiredState = { [Storage.AvastYe.ShipDestinations.NagaIsland] = ACCESS_GRANTED } },
			},
			CRISTOPHER_COLUMBUS_SHIP = {
				{ toPos = Position(5909, 1233, 6), name = "North Mirko" },
				{ toPos = Position(6247, 1023, 6), name = "Steppes" },
				{ toPos = Position(5747, 1217, 6), name = "Bornholm", minLevel = 50 },
				{ toPos = Position(5665, 1280, 7), name = "Quara Island" },
				{ toPos = KRAKEN_ANCHOR, name = "Leviathan", minLevel = 50, requiredState = { [Storage.FourActTragedy.LeviathanAccess] = ACCESS_GRANTED } },
			},
			JACK_SPARROW_SHIP = {
				{ toPos = Position(5980, 1502, 6), name = "Mirko Town" },
				{ toPos = Position(6740, 1357, 6), name = "Hurghada" },
				{ toPos = Position(7074, 801, 6), name = "Kongo" },
				{ toPos = Position(5539, 1509, 6), name = "Knurowo" },
				{ toPos = Position(6602, 1877, 7), name = "Syberia" },
				{ toPos = Position(6421, 727, 7), name = "Prague North", minLevel = 60 },
				{ toPos = Position(7311, 1082, 6), name = "Maioor'ka" },
				{ toPos = Position(7933, 1546, 6), name = "Bydgoshch" },
			},
			TARZAN_SHIP = {
				{ toPos = Position(7038, 837, 7), name = "Kongo" },
				{ toPos = Position(6563, 701, 7), name = "Ornuld Camp" },
				{ toPos = Position(6730, 705, 7), name = "Heart of the Jungle" },
				{ toPos = Position(6879, 743, 7), name = "Mundral Daycare" },
				{ toPos = Position(6436, 792, 7), name = "Stankass", minLevel = 60 },
				{ toPos = Position(6693, 676, 7), name = "Celebimber's Post" },
				{ toPos = Position(6640, 771, 7), name = "Waterfall" },
			},
			FISHERMAN_SHIP = {
				{ toPos = Position(5801, 1649, 7), name = "Mirkotown Slums" },
				{ toPos = Position(6028, 1944, 7), name = "Elf Fortress" },
				{ toPos = Position(5876, 1755, 7), name = "Cyclops Hills" },
			},
			VAVZHEEK_TRAIN = {
				{ toPos = Position(7550, 962, 13), name = "Januszex", requiredState = { [Storage.ProdigalSon.TrainDestinations.ToJanuszex] = ACCESS_GRANTED } },
				{ toPos = Position(7876, 1434, 9), name = "Bydgoshch" },
				{ toPos = Position(6462, 1125, 14), name = "Hurghada underground" },
			},
			ZONG_CAMEL = {
				{ toPos = Position(7009, 1131, 7), name = "Draw well" },
				{ toPos = Position(6919, 1331, 7), name = "Water elemental cave" },
				{ toPos = Position(6485, 1276, 7), name = "Mareesha camp" },
				{ toPos = Position(6637, 1332, 7), name = "Hurghada outskirts" },
				{ toPos = Position(7021, 1210, 7), name = "Cairo Fornia" },
			},
		}
		local function createHelpDialog(player, _, _)
			player:showTextDialog(2994, player:Localizer(LOCALIZERS.Universal):Context({ price = DEFAULT_TRAVEL_PRICE }):Get("TravelHelpDialog"))
		end

		local function chargeForTravel(player, price)
			local freeSailsLeft = player:getStorageValueByKey(Storage.FreeTravels)
			if freeSailsLeft > 0 then
				player:setStorageValueByKey(Storage.FreeTravels, freeSailsLeft - 1)
				return true
			end

			return player:removeMoney(price)
		end

		local function teleportToDestination(player, choice)
			local toPos = choice.toPos
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(toPos)
			toPos:sendMagicEffect(CONST_ME_TELEPORT)
		end

		local function errorMessageIfHasNoAccess(player, travelData)
			if travelData.requiredState and not player:HasRequiredStates(travelData.requiredState) then
				return "TRAVEL_YOU_NEED_ACCESS"
			end

			local minLevel = travelData.minLevel or 0
			if player:getLevel() < minLevel then
				return "TRAVEL_YOU_NEED_LEVEL"
			end

			return nil
		end

		local function confirmDestination(player, _, choice)
			if not (choice and choice.travelData) then
				player:sendCancelMessage("An error has occurred, please contact your administrator.")
				return true
			end
			local travelData = choice.travelData

			if player:isPzLocked() then
				player:sendCancelMessage(player:Localizer(LOCALIZERS.Universal):Context({ minLevel = travelData.minLevel }):Get("TRAVEL_YOU_NEED_LEVEL"))
				createHelpDialog(player, "ship")
				return
			end

			local errorMessage = errorMessageIfHasNoAccess(player, travelData)
			if errorMessage then
				player:sendCancelMessage(player:Localizer(LOCALIZERS.Universal):Context({ minLevel = travelData.minLevel }):Get(errorMessage))
				return
			end

			if not chargeForTravel(player, travelData.price or DEFAULT_TRAVEL_PRICE) then
				player:sendCancelMessage(player:Localizer(LOCALIZERS.Universal):Get("You dont have enough money."))
				return
			end

			teleportToDestination(player, travelData)
		end

		local travelMethodToWindowTitle = {
			[TRAVEL_METHOD.SHIP] = "ShipWindowTitle",
			[TRAVEL_METHOD.CARPET] = "CarpetWindowTitle",
			[TRAVEL_METHOD.TRAIN] = "TrainWindowTitle",
		}
		local travelMethodToWindowMessage = {
			[TRAVEL_METHOD.SHIP] = "ShipWindowMessage",
			[TRAVEL_METHOD.CARPET] = "CarpetWindowMessage",
			[TRAVEL_METHOD.TRAIN] = "TraintWindowMessage",
		}
		function CreateTravelWindow(context)
			local player = context.player
			local travelRoutes = context.travelRoutes
			local travelMethod = context.travelMethod

			local title = player:Localizer(LOCALIZERS.Universal):Get(travelMethodToWindowTitle[travelMethod])
			local message = player:Localizer(LOCALIZERS.Universal):Get(travelMethodToWindowMessage[travelMethod])
			local window = ModalWindow({ title = title, message = message })

			for _, travelData in pairs(travelRoutes) do
				local translatedName = player:Localizer(LOCALIZERS.TravelName):Get(travelData.name)
				if not translatedName then
					translatedName = travelData.name
				end
				if errorMessageIfHasNoAccess(player, travelData) then
					translatedName = "(-) " .. translatedName
				end
				local choice = window:addChoice(translatedName)
				choice.travelData = travelData
			end

			window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Select"), confirmDestination)
			window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Cancel"))
			window:addButton(player:Localizer(LOCALIZERS.Universal):Get("Help"), createHelpDialog)
			window:sendToPlayer(player)
		end
	end)
	:NoQuestlog()
	:Register()

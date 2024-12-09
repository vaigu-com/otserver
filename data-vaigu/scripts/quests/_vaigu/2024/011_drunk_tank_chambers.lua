local quest = Quest(LOCALIZERS)

local vocationToMission = {
	[VOCATION.BASE_ID.DRUID] = Storage.DrunkTankChambers.UltimateManaPotion,
	[VOCATION.BASE_ID.KNIGHT] = Storage.DrunkTankChambers.MediumManaPotion,
	[VOCATION.BASE_ID.SORCERER] = Storage.DrunkTankChambers.UltimateManaPotion,
	[VOCATION.BASE_ID.PALADIN] = Storage.DrunkTankChambers.GreatManaPotion,
}

local function grantVocationPotionAccess(context)
	local missionStorage = vocationToMission[context.player:getVocation():getBase():getId()]
	context.player:setStorageValue(missionStorage, ACCESS_GRANTED)
end

local localSupportFinished = {
	[Storage.LocalSupport.Biodegradable] = MISSION_FINISHED,
	[Storage.LocalSupport.BudgetRecycling] = MISSION_FINISHED,
	[Storage.LocalSupport.Discernment] = MISSION_FINISHED,
	[Storage.LocalSupport.FreakingRats] = MISSION_FINISHED,
	[Storage.LocalSupport.LostCrystalBall] = MISSION_FINISHED,
	[Storage.LocalSupport.OcellatusXD] = MISSION_FINISHED,
	[Storage.LocalSupport.TwoMarlinQuest] = MISSION_FINISHED,
	[Storage.LocalSupport.UnwantedGuests] = MISSION_FINISHED,
	[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
}

quest
	:Storage(function()
		Storage.DrunkTankChambers = {
			Mission01 = NextStorage(),
			GlowingWaterVial = NextStorage(),
			FilledVial = NextStorage(),
			BullSpoogeChurn = NextStorage(),
			FilledChurn = NextStorage(),
			Hallucinogen = NextStorage(),
			Bookcase = NextStorage(),

			MediumManaPotion = NextStorage(),
			GreatManaPotion = NextStorage(),
			UltimateManaPotion = NextStorage(),
		}
	end)
	:Constant(function() end)
	:Questlog(function() end)
	:Mission(Storage.DrunkTankChambers.Mission01)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Commissioner Fisher", {
			[{ GREET }] = {
				text = "I see you have made a great effort to help our city people. For that I would like to thank you personally. Please visit Vislav Shivka, he has a {tactical task} for you, if you know what i mean.",
				requiredState = localSupportFinished,
			},
			[{ "tactical task", "zadanie bojowe" }] = {
				text = "If you would like to expand your vocation expertise, you should meet Vislav Shivka. While he is a master imbiber of magical elixirs himself, he is also capable of teaching his 'craft' to others. Ask him about tactical task and he will surely guide you. Tell him that i sent u there or he might not want to share this knowledge with you.",
				nextState = {
					[Storage.DrunkTankChambers.Mission01] = _38f,
				},
				requiredState = localSupportFinished,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "tactical task", "zadanie bojowe", "mission", "misja" }] = {
				text = "Even strongers potions? Life is not a game, my friend. But if Fisher vouched for you, i suppose i can {teach} you then.",
			},
			[{ "teach", "nauczyc" }] = {
				text = "I learned how to safely drink potions thanks to my excessive drinking habits. You can probably reach same results in 10-15 years. But i suppose you are looking for a faster {method}.",
			},
			[{ "method", "sposob" }] = {
				text = "This metod was devised by my mentor, sensei Sy-Fu. You have visit the floating naga temple. Its rumored that they keep their special glowing water there. The temple is located halfway between our city and Hurgaha. You will also need churn of bull's spooge. You can find it at bulltaur canteen. Take this vial and churn, you will need it to store those liquids. Both of those ingredients will be needed for the next step. Come back when you are done with your task.",
				rewards = {
					{ id = 21766, aid = Storage.DrunkTankChambers.GlowingWaterVial },
					{ id = 32011, aid = Storage.DrunkTankChambers.BullSpoogeChurn },
				},
				nextState = {
					[Storage.DrunkTankChambers.Mission01] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Yes, there are ingredients i was talking about. Now, let me use my ferment-o-matic to instantly create this concoction for you. Take it to the Orshaawa catacombs. When you are there, stand before the door, drink this potion, and the following delirium should allow you to hallucinate yourself going through that door. Inside you shall find what you need to complete your training.",
				requiredItems = {
					{ id = 2874, aid = Storage.DrunkTankChambers.FilledVial },
					{ id = 32198, aid = Storage.DrunkTankChambers.FilledChurn },
				},
				rewards = {
					{ id = 31350, aid = Storage.DrunkTankChambers.Hallucinogen },
				},
				nextState = {
					[Storage.DrunkTankChambers.Mission01] = _38f,
				},
			},
		}),
		QuestFactory.Script(function(missionState)
			local glowingVial = Action()
			function glowingVial.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return false
				end
				if target == nil or target:getId() ~= 38526 or target:getActionId() ~= Storage.DrunkTankChambers.GlowingWaterVial then
					return false
				end

				toPosition:sendMagicEffect(CONST_ME_POFF)
				item:remove()
				player:AddCustomItem({ id = 2874, aid = Storage.DrunkTankChambers.FilledVial })
			end
			glowingVial:aid(Storage.DrunkTankChambers.GlowingWaterVial)
			glowingVial:register()
		end),
		QuestFactory.StartupItems({
			{ id = 38526, pos = { 6284, 1420, 1 }, aid = Storage.DrunkTankChambers.GlowingWaterVial },
		}),
		QuestFactory.Script(function(missionState)
			local spoogeChurn = Action()
			function spoogeChurn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return false
				end

				if target == nil or target:getId() ~= 38526 or target:getActionId() ~= Storage.DrunkTankChambers.BullSpoogeChurn then
					return false
				end

				toPosition:sendMagicEffect(CONST_ME_POFF)
				item:remove()
				player:AddCustomItem({ id = 32198, aid = Storage.DrunkTankChambers.FilledChurn, name = "churn of bull's 'milk'" })
			end
			spoogeChurn:aid(Storage.DrunkTankChambers.BullSpoogeChurn)
			spoogeChurn:register()
		end),
		QuestFactory.StartupItems({
			{ id = 2531, pos = { 7392, 1332, 7 }, aid = Storage.DrunkTankChambers.BullSpoogeChurn },
			{ id = 2533, pos = { 7392, 1333, 7 }, aid = Storage.DrunkTankChambers.BullSpoogeChurn },
			{ id = 2532, pos = { 7393, 1332, 7 }, aid = Storage.DrunkTankChambers.BullSpoogeChurn },
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Script(function()
			local poison = Condition(CONDITION_POISON)
			poison:setParameter(CONDITION_PARAM_DELAYED, 1)
			poison:addDamage(25, 3000, -45)

			local beforeDoor = Position(7645, 1832, 12)
			local inside = Position(7643, 1832, 12)

			local hallucinogen = Action()
			function hallucinogen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				player:addCondition(poison)

				if fromPosition ~= beforeDoor then
					return false
				end

				player:teleportTo(inside)
			end
			hallucinogen:aid(Storage.DrunkTankChambers.Hallucinogen)
			hallucinogen:register()
		end),
		QuestFactory.StartupItems({
			{
				id = 2438,
				position = { 7642, 1832, 12 },
				aid = Storage.DrunkTankChambers.Bookcase,
				requiredItems = {
					{ id = 31350, aid = Storage.DrunkTankChambers.Hallucinogen },
				},
				actionsOnSuccess = {
					{ action = grantVocationPotionAccess },
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Good job",
			},
		})
	)
	:Register()

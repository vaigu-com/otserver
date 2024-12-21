local quest = Quest("path_of_the_undead")
quest
	:Storage(function()
		Storage.PathOfTheUndead = {
			Mission01 = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Circles = NextStorage(),
			KonmuldBush = NextStorage(),
			UpperLever = NextStorage(),
			CursedChest = NextStorage(),
			GuardianSkull = NextStorage(),
			GuardianGateTile = NextStorage(),
			RitualLocus = NextStorage(),
			BossBook = NextStorage(),
			BossRoomExit = NextStorage(),
			SkipDoor = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Path of the Undead",
			startStorageId = Storage.PathOfTheUndead.Mission01,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Test of Strength",
					storageId = Storage.PathOfTheUndead.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "Gandalf told you about the history of Mirkotown. Now, ask him what conditions you need to fulfill to get his help.",
						[2] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
					},
				},
				[2] = {
					name = "Endurance Test",
					storageId = Storage.PathOfTheUndead.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
						[2] = "Gandalf has blessed you and advised you to go to Konmuld for further instructions.",
					},
				},
				[3] = {
					name = "The Final Battle",
					storageId = Storage.PathOfTheUndead.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Gather the necessary items, summon, and ultimately defeat the Undead Crypt King.",
						[2] = "You have defeated the Undead Crypt King. Return to Gandalf for your reward.",
						[3] = "Gandalf misplaced a certain item intended as a reward, but you have received his other gifts.",
					},
				},
			},
		}
	end)
	:Script(function(missionState)
		local book = Action()

		function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local pos = item:getPosition()
			pos:sendMagicEffect(CONST_ME_THUNDER)
			pos:sendMagicEffect(CONST_ME_TELEPORT)
			Game.createMonster("Nieumarly Krol Krypty", pos, true, true)
			item:remove()
			return true
		end

		book:aid(Storage.PathOfTheUndead.BossBook)
		book:register()
	end)
	:Script(function(missionState)
		local conditions = {
			CONDITION_POISON, -- utori pox
			CONDITION_FIRE, -- utori flam
			CONDITION_ENERGY, -- utori vis
			CONDITION_BLEEDING, -- utori kor
			CONDITION_HASTE, -- utani hur
			CONDITION_INVISIBLE, -- utana vid/stealth ring
			CONDITION_MANASHIELD, -- utamo vita/ering
			CONDITION_INFIGHT, -- any attack spell
			CONDITION_DRUNK, -- drink beer
			CONDITION_DROWN, -- special chest
			CONDITION_MUTED, -- spam
			CONDITION_FREEZING, -- special chest
			CONDITION_DAZZLED, -- utori san
			CONDITION_CURSED, -- utori mort
		}

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			for _, identifier in pairs(conditions) do
				local condition = Condition(identifier)
				condition:setParameter(CONDITION_PARAM_DELAYED, 1)
				condition:setParameter(CONDITION_PARAM_TICKS, 200000)
				condition:addDamage(5000, 2000, -50)
				player:addCondition(condition)
			end
		end

		lever:aid(44433)
		lever:register()
	end)
	:Script(function(missionState)
		local conditions = {}

		do
			local condition = Condition(CONDITION_FREEZING)
			condition:setParameter(CONDITION_PARAM_DELAYED, 1)
			condition:addDamage(5000, 3000, -50)

			conditions[#conditions + 1] = condition
		end

		do
			local condition = Condition(CONDITION_DROWN)
			condition:setParameter(CONDITION_PARAM_DELAYED, 1)
			condition:addDamage(5000, 2000, -50)

			conditions[#conditions + 1] = condition
		end

		local chest = Action()

		function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return true
			end
			for _, condition in pairs(conditions) do
				player:addCondition(condition)
			end
			player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			return true
		end

		chest:aid(Storage.PathOfTheUndead.CursedChest)
		chest:register()
	end)
	:Script(function(missionState)
		local conditions = {
			CONDITION_POISON, --utori pox
			CONDITION_FIRE, --utori flam
			CONDITION_ENERGY, --utori vis

			CONDITION_BLEEDING, --utori kor
			CONDITION_HASTE, --utani hur
			CONDITION_INVISIBLE, --utana vid/stealth ring

			CONDITION_MANASHIELD, --utamo vita/ering
			CONDITION_INFIGHT, -- any attack spell
			CONDITION_DRUNK, -- drink beer

			CONDITION_DROWN, -- special chest
			CONDITION_MUTED, -- spam
			CONDITION_FREEZING, -- special chest

			CONDITION_DAZZLED, --utori san
			CONDITION_CURSED, --utori mort
		}

		function Player:CountConditions()
			local counter = 0

			for _, condition in pairs(conditions) do
				if self:hasCondition(condition) then
					counter = counter + 1
				end
			end

			if not self:hasCondition(CONDITION_REGENERATION) then
				counter = counter + 1
			end
			return counter
		end

		local idToCreatureName = {
			[7575] = "Cipociamkacz",
			[7568] = "PatriotaPL",
			[7574] = "CalaNapszut",
		}

		local skull = Action()

		local spawnstates = {
			[7575] = 0,
			[7568] = 0,
			[7574] = 0,
		}

		local requiredCount = #conditions - 1

		function skull.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local id = item:getId()
			if spawnstates[id] == 1 then
				return false
			end

			local conditionsCount = player:CountConditions()
			if conditionsCount >= requiredCount then
				for _, condition in pairs(conditions) do
					player:removeCondition(condition)
				end
				spawnstates[id] = 1
				Game.createMonster(idToCreatureName[id], player:getPosition(), true, true)
			end
			return false
		end

		skull:aid(Storage.PathOfTheUndead.GuardianSkull)
		skull:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CalaNapszutDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["CalaNapszut"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CipociamkaczDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["Cipociamkacz"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local krolKrypty = CreatureEvent("CryptKingKill")

		function krolKrypty.onDeath(creature)
			local targetMonster = creature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return true
			end

			local pos = targetMonster:getPosition()
			local portal = Game.createItem(27590, 1, pos)
			portal:setActionId(Storage.PathOfTheUndead.BossRoomExit)
		end

		krolKrypty:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("PatriotaPLDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["PatriotaPL"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:Script(function(missionState)
		local bushMessage =
			"enum ConditionType_t {\nCONDITION_NONE,\n    \nCONDITION_POISON = 1 << 0,\nCONDITION_FIRE = 1 << 1,\nCONDITION_ENERGY = 1 << 2,\nCONDITION_BLEEDING = 1 << 3,\nCONDITION_HASTE = 1 << 4,\nCONDITION_PARALYZE = 1 << 5,\nCONDITION_OUTFIT = 1 << 6,\nCONDITION_INVISIBLE = 1 << 7,\nCONDITION_LIGHT = 1 << 8,\nCONDITION_MANASHIELD = 1 << 9,\nCONDITION_INFIGHT = 1 << 10,\nCONDITION_DRUNK = 1 << 11,\nCONDITION_EXHAUST = 1 << 12, // unused\nCONDITION_REGENERATION = 1 << 13,\nCONDITION_SOUL = 1 << 14,\nCONDITION_DROWN = 1 << 15,\nCONDITION_MUTED = 1 << 16,\nCONDITION_CHANNELMUTEDTICKS = 1 << 17,\nCONDITION_YELLTICKS = 1 << 18,\nCONDITION_ATTRIBUTES = 1 << 19,\nCONDITION_FREEZING = 1 << 20,\nCONDITION_DAZZLED = 1 << 21,\nCONDITION_CURSED = 1 << 22,\nCONDITION_EXHAUST_COMBAT = 1 << 23, // unused\nCONDITION_EXHAUST_HEAL = 1 << 24, // unused\nCONDITION_PACIFIED = 1 << 25,\nCONDITION_SPELLCOOLDOWN = 1 << 26,\nCONDITION_SPELLGROUPCOOLDOWN = 1 << 27,\nCONDITION_ROOTED = 1 << 28,\n"

		local bush = Action()

		function bush.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return true
			end

			local storageval = player:getStorageValue(Storage.PathOfTheUndead.Mission01)
			if storageval < 3 then
				return false
			end

			player:registerEvent("konmuldBushModalWindow")

			local title = "You read the following."
			local message = bushMessage

			local window = ModalWindow(item.actionid, title, message)
			window:addButton(101, "Close")
			window:setDefaultEscapeButton(101)
			window:sendToPlayer(player)
			player:unregisterEvent("konmuldBushModalWindow")
			return true
		end

		bush:aid(Storage.PathOfTheUndead.KonmuldBush)
		bush:register()
	end)
	:MonsterEvent(function()
		local smallArea = createCombatArea(AREA_PLUS3)
		local exori = Combat()
		exori:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		exori:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		exori:setArea(smallArea)
		exori:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

		local lagaDyga = CreatureEvent("LagaDygaDeath")
		function lagaDyga.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			doCombat(creature, exori, { type = 2, pos = creature:getPosition() })
			return true
		end

		lagaDyga:register()
	end)
	:Script(function(missionState)
		local idToStorageVal = { [596] = 1, [597] = 2, [598] = 4, [599] = 8, [924] = 16 }

		local step_tile = MoveEvent()

		local function IsFactor(number, factor)
			if (number % (factor * 2)) >= factor then
				return true
			end
			return false
		end

		local questlineStorage = Storage.PathOfTheUndead.Mission01
		local circleStorage = Storage.PathOfTheUndead.Circles

		local function GetUncompletedCirclesCount(player)
			local storageVal = player:getStorageValue(circleStorage)
			local length = 0

			for _, value in pairs(idToStorageVal) do
				if not IsFactor(storageVal, value) then
					length = length + 1
				end
			end
			return length
		end

		function step_tile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local questlineStorageVal = player:getStorageValue(questlineStorage)
			if questlineStorageVal ~= 2 then
				return
			end

			local storageVal = player:getStorageValue(circleStorage)
			if storageVal < 0 then
				player:setStorageValue(circleStorage, 0)
			end

			local addend = idToStorageVal[item:getId()]
			if not IsFactor(storageVal, addend) then
				player:setStorageValue(circleStorage, player:getStorageValue(circleStorage) + addend)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				local firstStepMessage = player:Localizer(Storage.PathOfTheUndead.Mission01):Get("You step on circle number ")
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, firstStepMessage .. math.floor(math.log(addend, 2) + 1))
			end

			local circlesCount = GetUncompletedCirclesCount(player)
			if circlesCount ~= 0 then
				local standOn = player:Localizer(Storage.PathOfTheUndead.Mission01):Get("To fulfill Gandalf's task you need to stand on ")
				local remaining = player:Localizer(Storage.PathOfTheUndead.Mission01):Get(" remaining circles.")

				player:sendTextMessage(MESSAGE_FAILURE, standOn .. circlesCount .. remaining)
			end
		end

		step_tile:aid(Storage.PathOfTheUndead.Circles)
		step_tile:type("stepin")
		step_tile:register()
	end)
	:Script(function(missionState)
		local doors = {
			{ pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -8, y = 12, z = 1 })), id = 1564 },
			{ pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -9, y = 12, z = 1 })), id = 1563 },
		}

		local function eachTileHasItem(top_left, down_right, id, anchor)
			if anchor then
				top_left = anchor:Moved(top_left)
				down_right = anchor:Moved(down_right)
			end

			for i = top_left.x, down_right.x do
				for j = top_left.y, down_right.y do
					local pos = Position(i, j, top_left.z)
					if not pos:hasItem(id) then
						return false
					end
				end
			end
			return true
		end

		local beforeGate = MoveEvent()

		function beforeGate.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end
			if not eachTileHasItem(Vector(-12, 15, 1), Vector(-10, 15, 1), 12952, PATH_OF_THE_UNDEAD_ANCHOR) then
				return false
			end
			for _, door in pairs(doors) do
				local pos = door.pos
				local id = door.id
				local tile = Tile(pos)
				if tile:getItemById(id) then
					tile:getItemById(id):remove()
					pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
				end
			end
			player:setStorageValue(Storage.PathOfTheUndead.SkipDoor, 1)
		end

		beforeGate:aid(Storage.PathOfTheUndead.GuardianGateTile)
		beforeGate:type("stepin")
		beforeGate:register()
	end)
	:Script(function(missionState)
		local bossRoomPos = PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -60, y = -14, z = 0 })

		local workingTeleportId = 23483

		local nextRequiredThrowId = { 5901, 3465, 5467, 10316, 18935, 7993 }

		local ritualStateToNextPotId = { [2] = 1997, [3] = 2002, [4] = 2003 }

		local ritualState = 1

		local ritualPot = nil

		local function openPortal(pos)
			local portal = Game.createItem(workingTeleportId, 1, pos)
			portal:setActionId(Storage.PathOfTheUndead.RitualLocus)
			ritualPot:remove()
		end

		local function tryProgressRitualPot(pos)
			local nextRitualPotId = ritualStateToNextPotId[ritualState]
			if nextRitualPotId then
				ritualPot:transform(nextRitualPotId)
			else
				pos:sendMagicEffect(CONST_ME_WATERSPLASH)
			end
		end

		local ritualLocus = MoveEvent()
		function ritualLocus.onAddItem(moveitem, tileitem, position)
			if not moveitem then
				return false
			end

			if ritualPot == nil then
				ritualPot = Tile(PATH_OF_THE_UNDEAD_ANCHOR:Moved(1, -35, -1)):getItemById(1996)
			end

			local nextThrowId = nextRequiredThrowId[ritualState]
			local moveitemId = moveitem:getId()

			if moveitemId ~= nextThrowId then
				return false
			end

			ritualState = ritualState + 1
			moveitem:remove()
			tryProgressRitualPot(tileitem:getPosition())
			if ritualState > #nextRequiredThrowId then
				openPortal(tileitem:getPosition())
			end
			return true
		end

		ritualLocus:type("additem")
		ritualLocus:aid(Storage.PathOfTheUndead.RitualLocus)
		ritualLocus:register()

		local step_tile = MoveEvent()

		function step_tile.onStepIn(player, stepInItem, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end
			local portal = Tile(toPosition):getItemById(workingTeleportId)
			if not portal then
				return
			end
			player:teleportTo(bossRoomPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end

		step_tile:aid(Storage.PathOfTheUndead.RitualLocus)
		step_tile:type("stepin")
		step_tile:register()
	end)
	:Script(function(missionState)
		local gatePositions = {
			{ x = -12, y = 37, z = -2 },
			{ x = -11, y = 37, z = -2 },
		}
		local gateId = 2182

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			for _, relativePos in pairs(gatePositions) do
				local pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved(relativePos))
				local tile = Tile(pos)
				local gate = tile:getItemById(gateId)
				if gate then
					gate:remove()
				else
					Game.createItem(gateId, 1, pos)
				end
				toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			return true
		end

		lever:aid(Storage.PathOfTheUndead.UpperLever)
		lever:register()
	end)
	:Mission()
	:State()
	:Dialog("Gandalf", {
		[{ GREET }] = {
			text = "Hello. What brings you here?",
		},
		[{ "oprocz tego ludzie", "aside from that people" }] = {
			text = "It was many years ago. One day, in Mirkotown, the Undead King of the Crypt appeared, causing havoc among our residents. The city slowly turned into a ruin until 9:37 PM when one of the houses was blown up using dark magic. In that same house, there was a laundry basket, and inside it, a holy relic - socks with John Paul, which flew and landed in the hands of the Crypt King. At that moment, he howled with a demonic voice, 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ' and immediately became paralyzed. Without a second thought, all defenders gathered to seal his soul. On the same day, we locked his soul in the banshee cave. The remains of his body were scattered across the desert to prevent any attempts at reanimation. I thought his spirit would be neutralized in the cave, but as I recently found out, he managed to escape from there. I don't know how strong he is right now, but he will surely try to regenerate. We must ultimately destroy him! It won't be an easy task, and before I entrust it to you, you will need to prove to me that you are worthy of leading this crusade. Return to me when you fulfill all my {conditions}.",
			nextState = {
				[Storage.PathOfTheUndead.Mission01] = 1,
			},
			requiredState = {
				[Storage.Finished.AssassinsCreedSquurvaali] = 1,
				[Storage.Finished.ImRestingHere] = 1,
				[Storage.Finished.SultanPrime] = 1,
				[Storage.ChesterTheDwarf.Mission03] = State.ChesterTheDwarf.Mission03.Finished,
			},
			textNoRequiredState = "It's interesting that you know our password. Nevertheless, I have no task for you or anything to interest you with.",
		},
		[{ "king", "crypt king", "king of the crypt", "krol krypty", "krol" }] = {
			text = "If you really know what danger he is, deal with his ally first - Sultan of Phantasms. Also deal with that swindler, Chester, who tried to fuck me over in Down's Labyrinth.",
		},
	})
	:State()
	:Dialog("Gandalf", {
		[{ GREET }] = {
			text = "Welcome again. Are you ready to accept my {conditions}?",
		},
		[{ "conditions", "warunki" }] = {
			text = "Allakhazam!!!1. Oh, wait, that's not all. I forgot that you also need to visit the magic circles. Each circle consists of 6 stones in 3 different colors, with a special grid in the middle. Stand on all five grids, and I will be able to bless you. I won't tell you where the circles are because you can ask the owners of magic shops in towns about it. Talk to them, and they will guide you to the circles. Just write 'circle' to them, and they will explain everything to you.",
			nextState = {
				[Storage.PathOfTheUndead.Mission01] = 2,
				[Storage.PathOfTheUndead.Mission02] = 1,
				[Storage.PathOfTheUndead.Circles] = 0,
			},
			requiredState = {
				[Storage.PitsOfInferno.OneThrone] = { min = 1 },
				[Storage.Finished.YalahariQuest] = { min = 1 },
				[Storage.WayOfTheDruid.CouncilOfDruids] = { min = 7 },
			},
			textNoRequiredState = "My conditions are to complete the following tasks: Druid Path, Yalahar Quest. While you know the secret password, I also want other druids and elves to vouch for you. Additionally, you must visit at least one poi throne. If you are ready, ask me again about {conditions}.",
		},
	})
	:State()
	:Dialog("Gandalf", {
		[{ "mission" }] = {
			text = "Hocus Pocus! Now everything should work. Something very dark lurks in the pyramid's underground. Ask Konmuld for advice, and maybe you will escape from there alive. Oh, I almost forgot: from now on, you can now use the sealed doors in the pyramid.",
			nextState = {
				[Storage.PathOfTheUndead.Mission02] = 2,
				[Storage.PathOfTheUndead.Mission03] = 1,
			},
			requiredState = {
				[Storage.PathOfTheUndead.Circles] = 31,
			},
			textNoRequiredState = "Ask the individual owners of magic shops about the locations of the circles.",
		},
	})
	:Mission()
	:State()
	:Dialog("Konmuld", {
		{
			[{ "mission", "misja", "krol krypty", "crypt king", "the king of the crypt", "king", "krol" }] = {
				text = "Gandalf sent you here, right? If you want to go to the down pyramid, you need to know that there is an Undead Crypt King waiting, and that {encounter} him will not be easy by any means. To summon him, you will need a few ingredients. Take the most necessary things: wood, cauldron, vial and lighter. For the ritual you will need {bones} so foul that they lower the wavelength of the light around. Plus the {signet ring} of an undead lord, and a {cloak} made of the skin of unbaptized children. If you're going to collect these items, ask me about the {ritual}.",
			},
			[{ "walka", "encounter", "fight" }] = {
				text = "The Crypt King is skilled in many areas, not just magic. In addition to the standard set of spells of a generic villain, such as summoning the undead and shooting lasers, he can use spells from other universes. Apparently his mother had allowed him to play WoW when he was little, and now he has mastered some of the skills available there. He studied the 'sciences' of goblins, so he can quickly construct bombs. If I remember correctly, you'll probably have to cover the bombs with your body so they don't blow up the entire platform. The last thing you need to know is that the Vault King is constantly increasing his damage, so he is unwilling to change his current target.",
			},
			[{ "kosci", "bone", "bones" }] = {
				text = "It's called Unholy Bone.",
			},
			[{ "sygnet", "signet", "pierscien", "seal" }] = {
				text = "This ring has vanished somewhere, maybe {Grave Digger} will tell you more about it.",
			},
			[{ "grave digger" }] = {
				text = "He sells equipment in Mirko, I think you know him.",
			},
			[{ "plaszcz", "cape" }] = {
				text = "Only the one group could create such a thing - PiS cultists from Sybir",
			},
			[{ "rytual", "ritual" }] = {
				text = "Before you start, you must summon three guards whose skeletons are blocking access to the ritual site. You'll probably have to defeat them to get further. To summon each of them, you will show perseverance to people unknown to this world. This will require you to have fourteen different {effects}. Somewhere in the depths of the dungeons you will find a circle made of stones. It is where the ritual of summoning the Crypt King will take place",
			},
			[{ "effects", "efektow", "efekty" }] = {
				text = "I managed to extract this knowledge from the ancient collections in the library of the Lvivversity of Archmages. If you think you can read these notes - I hid the scroll under the bush to the right. And remember, not all of the effects listed there are real - apparently this document was written on the knee.",
			},
		},
	})
	:Dialog("Grave Digger", {
		[{ "sygnet", "signet", "piescien", "seal" }] = {
			text = "I don't know how you know about this ring, but if you want to find it, listen. It was in the Diremaw caves under the cultist swamp. As I approached the Fire Fucker's cave, he roared so hard that I shit myself and started running away as fast as I could. In this haste, one of the dummy atifacts I used for... never mind, fell out of my backpack. Inside the dummy I had dropped there was a ring. If I remember correctly, this dummy was supposed to imitate a precious miniature of the ship. Coming back to how I escaped, all I remember is waking up in the temple. If you want, you can look for that ring, I don't need it anymore.",
		},
	})
	:Script(function(missionState)
		local updateStorages = {
			[Storage.PathOfTheUndead.Mission01] = 4,
			[Storage.PathOfTheUndead.Mission03] = 2,
		}

		local exitPos = PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = 4, y = -32, z = -2 })
		local portal = MoveEvent()

		function portal.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			if player:HasExactMissionState(missionState) then
				player:UpdateStorages(updateStorages)
			end

			player:teleportTo(exitPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end

		portal:aid(Storage.PathOfTheUndead.BossRoomExit)
		portal:type("stepin")
		portal:register()
	end)
	:State()
	:Dialog("Gandalf", {
		[{ "mission" }] = {
			text = "Here is your reward for your effort. Wait, wait... where is my backpack!? It was probably Chester doing. Well, I guess your bonus reward is gone.",
			nextState = {
				[Storage.PathOfTheUndead.Mission03] = 3,
				[Storage.Finished.PathOfTheUndead] = 1,
				[Storage.ChesterTheDwarf.Mission04] = 1,
			},
			expReward = 25000000,
		},
	})
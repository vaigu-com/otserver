local quest = Quest("cave_explorer_on_shield")
quest
	:Storage(function()
		Storage.CaveExplorerOnShield = {
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Rewards = { Firebug = NextStorage(), GermiChest = NextStorage() },
			Misc = {
				AnthonyGate = NextStorage(),
				Punchcard = NextStorage(),
				FirebugFireplace = NextStorage(),
			},
		}
	end)
	:Questline(function()
		Quests[NextQuestId()] = {
			name = "Cave Explorer on Shield",
			startStorageId = Storage.CaveExplorerOnShield.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "First Mission",
					storageId = Storage.CaveExplorerOnShield.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 7,
					states = {
						[1] = "Find the page.",
						[2] = "You found the page. Show it to Germi.",
						[3] = "Talk to Germi to get him to open the door for you.",
						[4] = "Find the Engineer's Ghost and help him.",
						[5] = "You've opened the gate, return to the Engineer.",
						[6] = "You greeted the Engineer, return to Germi.",
						[7] = "Mission completed.",
					},
				},
				[2] = {
					name = "Notes from the Conversation",
					storageId = Storage.CaveExplorerOnShield.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 1,
					states = { [1] = "GERMI_NOTES" },
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local config = {
			["success"] = "You succeeded in opening the gate! Talk back to engineer ghost and tell him about your success. Dont worry about closing gates - you can use shortcut door.",
		}
		local questStorage = Storage.CaveExplorerOnShield.Questline

		local anthonyGate = MoveEvent()

		function anthonyGate.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValue(questStorage) == 4 then
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
				player:setStorageValue(questStorage, 5)
				player:sendTextMessage(
					MESSAGE_EVENT_ADVANCE,
					player:Localizer(Storage.CaveExplorerOnShield.Questline):Get(config["success"])
				)
			end
			return true
		end

		anthonyGate:aid(Storage.CaveExplorerOnShield.Misc.AnthonyGate)
		anthonyGate:type("stepin")
		anthonyGate:register()
	end)
	:Script(function(storageToRequiredState)
		local function movePlayersFromArea(topLeft, downRight, safePos)
			CreatureList():Area(topLeft, downRight):FilteredByPlayer():MovedToPos(safePos)
		end

		local topLeft = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -42, y = 55, z = 3 })
		local downRight = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 72, z = 3 })
		local passage_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 67, z = 3 })
		local portal_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -33, y = 60, z = 3 })

		local function tryUseFrozenFireplace(fireplace)
			local unlit = 1997
			local lit = 22077
			local start =
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.IceRoomStart])

			fireplace:transform(lit)

			local tile = Tile(passage_pos)
			if tile:getItemById(2129) then
				tile:getItemById(2129):remove()
			else
				return false
			end

			movePlayersFromArea(topLeft, downRight, start)

			local portal = Game.createItem(1949, 1, portal_pos)
			portal:setActionId(Storage.DesertQuestOne.Portals.IceRoomReward)

			addEvent(function()
				fireplace:transform(unlit)
			end, 1000 * 28)

			addEvent(function()
				passage_pos:MoveThings(start)
				movePlayersFromArea(topLeft, downRight, start)
				portal:remove()
				Game.createItem(2129, 1, passage_pos)
			end, 1000 * 30)

			return true
		end

		local ghost_name = "Ghost of Germi the Journeyman"
		local ghostPos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 82, y = 52, z = -2 })
		local floorEffect = 8827
		local unlit = 2001
		local lit = 22076
		local function tryUseGermiFireplace(fireplace)
			fireplace:transform(lit)

			local npc = Game.createNpc(ghost_name, ghostPos)

			local floorEffectItem = Game.createItem(floorEffect, 1, ghostPos)
			floorEffectItem:setUniqueId(1000)

			addEvent(function()
				npc:remove()
				floorEffectItem:remove()
				fireplace:transform(unlit)
				fireplace:setActionId(Storage.CaveExplorerOnShield.Misc.FirebugFireplace)
			end, 1000 * 120 * 2)

			return true
		end

		local fireBugId = 5467
		local ghost_fireplace_pos = Position(DESERT_QUEST_ONE_ANCHOR:Moved({ x = 77, y = 53, z = -2 }))
		local frozen_fireplace_pos = Position(DESERT_QUEST_ONE_ANCHOR:Moved({ x = -25, y = 66, z = 3 }))

		local function playerIsUsingBugOnFireplace(item, fireplace)
			if item:getId() ~= fireBugId then
				return false
			end
			if fireplace:getActionId() ~= Storage.CaveExplorerOnShield.Misc.FirebugFireplace then
				return false
			end
			return true
		end
		local firebug = Action()
		function firebug.onUse(player, item, fromPosition, fireplace, toPosition, isHotkey)
			if not playerIsUsingBugOnFireplace(item, fireplace) then
				return false
			end

			if toPosition == ghost_fireplace_pos and fireplace.itemid == 2001 then
				tryUseGermiFireplace(fireplace)
			elseif toPosition == frozen_fireplace_pos and fireplace.itemid == 1997 then
				tryUseFrozenFireplace(fireplace)
			end

			return true
		end

		firebug:aid(Storage.CaveExplorerOnShield.Misc.FirebugFireplace)
		firebug:register()
	end)
	:Script(function(storageToRequiredState)
		local punchcard = Action()

		function punchcard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not target then
				return false
			end
			if item:getActionId() and not (item:getActionId() == Storage.CaveExplorerOnShield.Misc.Punchcard) then
				return false
			end
			if target:getActionId() and not (target:getActionId() == Storage.CaveExplorerOnShield.Misc.Punchcard) then
				return false
			end
			if not (target:getId() == 8342) then
				return false
			end
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end

			local pos = target:getPosition()
			pos.y = pos.y - 1
			pos.x = pos.x + 1

			pos:sendMagicEffect(CONST_ME_SMOKE)
			addEvent(function()
				pos:sendMagicEffect(CONST_ME_SMOKE)
			end, 500 * 1)
			addEvent(function()
				pos:sendMagicEffect(CONST_ME_SMOKE)
			end, 1000 * 1)
			addEvent(function()
				RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
				RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
			end, 2000 * 1)
			return true
		end

		punchcard:aid(Storage.CaveExplorerOnShield.Misc.Punchcard)
		punchcard:register()

		local doorPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED[1].offPos)
		local safePos = doorPos:Moved(-1, 0, 0)

		local tile = MoveEvent()
		function tile.onStepIn(player, item, toPosition, fromPosition)
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end
			if not player:isPlayer() then
				return false
			end
			if item.itemid == CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.punchcard.id then
				return false
			end
			if not Tile(toPosition):getItemById(355) then
				return false
			end

			local pos = item:getPosition()
			pos.y = pos.y - 1

			pos:sendMagicEffect(CONST_ME_SMOKE)

			addEvent(function()
				doorPos:MoveThings(safePos)
				RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
				RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
				ChangeItemsActionId(
					DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED,
					Storage.CaveExplorerOnShield.Misc.Punchcard,
					DESERT_QUEST_ONE_ANCHOR
				)
			end, 1000 * 1)
		end

		tile:aid(Storage.CaveExplorerOnShield.Misc.Punchcard)
		tile:type("stepin")
		tile:register()
	end)

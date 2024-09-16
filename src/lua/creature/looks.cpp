/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "pch.hpp"

#include "lua/creature/Looks.hpp"
#include "items/bed.hpp"
#include "items/containers/container.hpp"
#include "game/game.hpp"
#include "creatures/combat/spells.hpp"
#include "items/containers/rewards/rewardchest.hpp"
#include "enums/account_group_type.hpp"

Looks::Looks() = default;
Looks::~Looks() = default;

void Looks::clear() {
	useItemMap.clear();
	uniqueItemMap.clear();
	actionItemMap.clear();
	actionPositionMap.clear();
}

bool Looks::registerLuaItemEvent(const std::shared_ptr<Look> look) {
	auto itemIdVector = look->getItemIdsVector();
	if (itemIdVector.empty()) {
		return false;
	}

	std::vector<uint16_t> tmpVector;
	tmpVector.reserve(itemIdVector.size());

	for (const auto &itemId : itemIdVector) {
		// Check if the item is already registered and prevent it from being registered again
		if (hasItemId(itemId)) {
			g_logger().warn(
				"[{}] - Duplicate "
				"registered item with id: {} in range from id: {}, to id: {}, for script: {}",
				__FUNCTION__,
				itemId,
				itemIdVector.at(0),
				itemIdVector.at(itemIdVector.size() - 1),
				look->getScriptInterface()->getLoadingScriptName()
			);
			continue;
		}

		// Register item in the look item map
		setItemId(itemId, look);
		tmpVector.emplace_back(itemId);
	}

	itemIdVector = std::move(tmpVector);
	return !itemIdVector.empty();
}

bool Looks::registerLuaUniqueEvent(const std::shared_ptr<Look> look) {
	auto uniqueIdVector = look->getUniqueIdsVector();
	if (uniqueIdVector.empty()) {
		return false;
	}

	std::vector<uint16_t> tmpVector;
	tmpVector.reserve(uniqueIdVector.size());

	for (const auto &uniqueId : uniqueIdVector) {
		// Check if the unique is already registered and prevent it from being registered again
		if (!hasUniqueId(uniqueId)) {
			// Register unique id the unique item map
			setUniqueId(uniqueId, look);
			tmpVector.emplace_back(uniqueId);
		} else {
			g_logger().warn(
				"[{}] duplicate registered item with uid: {} in range from uid: {}, to uid: {}, for script: {}",
				__FUNCTION__,
				uniqueId,
				uniqueIdVector.at(0),
				uniqueIdVector.at(uniqueIdVector.size() - 1),
				look->getScriptInterface()->getLoadingScriptName()
			);
		}
	}

	uniqueIdVector = std::move(tmpVector);
	return !uniqueIdVector.empty();
}

bool Looks::registerLuaActionEvent(const std::shared_ptr<Look> look) {
	auto actionIdVector = look->getActionIdsVector();
	if (actionIdVector.empty()) {
		return false;
	}

	std::vector<uint16_t> tmpVector;
	tmpVector.reserve(actionIdVector.size());

	for (const auto &actionId : actionIdVector) {
		// Check if the unique is already registered and prevent it from being registered again
		if (!hasActionId(actionId)) {
			// Register look in the look item map
			setActionId(actionId, look);
			tmpVector.emplace_back(actionId);
		} else {
			g_logger().warn(
				"[{}] duplicate registered item with aid: {} in range from aid: {}, to aid: {}, for script: {}",
				__FUNCTION__,
				actionId,
				actionIdVector.at(0),
				actionIdVector.at(actionIdVector.size() - 1),
				look->getScriptInterface()->getLoadingScriptName()
			);
		}
	}

	actionIdVector = std::move(tmpVector);
	return !actionIdVector.empty();
}

bool Looks::registerLuaPositionEvent(const std::shared_ptr<Look> look) {
	auto positionVector = look->getPositionsVector();
	if (positionVector.empty()) {
		return false;
	}

	std::vector<Position> tmpVector;
	tmpVector.reserve(positionVector.size());

	for (const auto &position : positionVector) {
		// Check if the position is already registered and prevent it from being registered again
		if (!hasPosition(position)) {
			// Register position in the look position map
			setPosition(position, look);
			tmpVector.emplace_back(position);
		} else {
			g_logger().warn(
				"[{}] duplicate registered script with range position: {}, for script: {}",
				__FUNCTION__,
				position.toString(),
				look->getScriptInterface()->getLoadingScriptName()
			);
		}
	}

	positionVector = std::move(tmpVector);
	return !positionVector.empty();
}

bool Looks::registerLuaEvent(const std::shared_ptr<Look> look) {
	std::vector<std::function<bool(const std::shared_ptr<Look> &)>> luaEventCallbacks = {
		[this](const std::shared_ptr<Look> &look) { return registerLuaItemEvent(look); },
		[this](const std::shared_ptr<Look> &look) { return registerLuaUniqueEvent(look); },
		[this](const std::shared_ptr<Look> &look) { return registerLuaActionEvent(look); },
		[this](const std::shared_ptr<Look> &look) { return registerLuaPositionEvent(look); }
	};
	// Call all register lua events
	bool registeredAny = false;
	for (const auto &callback : luaEventCallbacks) {
		if (callback(look)) {
			registeredAny = true;
		}
	}

	if (registeredAny) {
		return true;
	}

	g_logger().warn(
		"[{}] missing id/aid/uid/position for one script event, for script: {}",
		__FUNCTION__,
		look->getScriptInterface()->getLoadingScriptName()
	);

	return false;
	// Code was unreachable
	// g_logger().debug("[{}] missing or incorrect script: {}", __FUNCTION__, look->getScriptInterface()->getLoadingScriptName());
	// return false;
}

ReturnValue Looks::canLook(std::shared_ptr<Player> player, const Position &pos) {
	if (pos.x != 0xFFFF) {
		const Position &playerPos = player->getPosition();
		if (playerPos.z != pos.z) {
			return playerPos.z > pos.z ? RETURNVALUE_FIRSTGOUPSTAIRS : RETURNVALUE_FIRSTGODOWNSTAIRS;
		}

		if (!Position::areInRange<1, 1>(playerPos, pos)) {
			return RETURNVALUE_TOOFARAWAY;
		}
	}
	return RETURNVALUE_NOERROR;
}

ReturnValue Looks::canLook(std::shared_ptr<Player> player, const Position &pos, std::shared_ptr<Item> item) {
	const std::shared_ptr<Look> look = getLook(item);
	if (look != nullptr) {
		return look->canExecuteLook(player, pos);
	}
	return RETURNVALUE_NOERROR;
}

std::shared_ptr<Look> Looks::getLook(std::shared_ptr<Item> item) {
	if (item->hasAttribute(ItemAttribute_t::UNIQUEID)) {
		auto it = uniqueItemMap.find(item->getAttribute<uint16_t>(ItemAttribute_t::UNIQUEID));
		if (it != uniqueItemMap.end()) {
			return it->second;
		}
	}

	if (item->hasAttribute(ItemAttribute_t::ACTIONID)) {
		auto it = actionItemMap.find(item->getAttribute<uint16_t>(ItemAttribute_t::ACTIONID));
		if (it != actionItemMap.end()) {
			return it->second;
		}
	}

	auto it = useItemMap.find(item->getID());
	if (it != useItemMap.end()) {
		return it->second;
	}

	if (auto iteratePositions = actionPositionMap.find(item->getPosition());
	    iteratePositions != actionPositionMap.end()) {
		if (std::shared_ptr<Tile> tile = item->getTile();
		    tile) {
			if (std::shared_ptr<Player> player = item->getHoldingPlayer();
			    player && item->getTopParent() == player) {
				g_logger().debug("[Looks::getAction] - The position only is valid for use item in the map, player name {}", player->getName());
				return nullptr;
			}

			return iteratePositions->second;
		}
	}

	return nullptr;
}

/*
ReturnValue Looks::internalLookItem(std::shared_ptr<Player> player, const Position &fromPos, uint8_t stackPos, std::shared_ptr<Item> item, const Position &toPos) {
        if (std::shared_ptr<Door> door = item->getDoor()) {
                if (!door->canUse(player)) {
                        return RETURNVALUE_CANNOTUSETHISOBJECT;
                }
        }

        auto itemId = item->getID();
        const ItemType &itemType = Item::items[itemId];
        auto transformTo = itemType.m_transformOnUse;
        const std::shared_ptr<Look> look = getLook(item);
        if (!look && transformTo > 0 && itemId != transformTo) {
                if (g_game().transformItem(item, transformTo) == nullptr) {
                        g_logger().warn("[{}] item with id {} failed to transform to item {}", __FUNCTION__, itemId, transformTo);
                        return RETURNVALUE_CANNOTUSETHISOBJECT;
                }

                return RETURNVALUE_NOERROR;
        } else if (transformTo > 0 && look) {
                g_logger().warn("[{}] item with id {} already have look registered and cannot be use transformTo tag", __FUNCTION__, itemId);
        }

        if (look != nullptr) {
                if (look->isLoadedCallback()) {
                        if (look->executeLook(player, item, fromPos, nullptr, fromPos)) {
                                return RETURNVALUE_NOERROR;
                        }
                        if (item->isRemoved()) {
                                return RETURNVALUE_CANNOTUSETHISOBJECT;
                        }
                } else if (look->useFunction && look->useFunction(player, item, fromPos, nullptr, toPos)) {
                        return RETURNVALUE_NOERROR;
                }
        }

        return RETURNVALUE_CANNOTUSETHISOBJECT;
}
*/

bool Looks::lookItemEx(std::shared_ptr<Player> player, const Position &fromPos, const Position &toPos, uint8_t toStackPos, std::shared_ptr<Item> item, std::shared_ptr<Creature> creature /* = nullptr*/) {
	if (item == nullptr) {
		return false;
	}
	const ItemType &it = Item::items[item->getID()];

	const std::shared_ptr<Look> look = getLook(item);
	if (look == nullptr) {
		return false;
	}

	if (look->useFunction) {
		if (look->useFunction(player, item, fromPos, look->getTarget(player, creature, toPos, toStackPos), toPos)) {
			return true;
		}
	}
	if (look->isLoadedCallback()) {
		if (look->executeLook(player, item, fromPos, creature, toPos)) {
			return true;
		}
		if (item->isRemoved()) {
			return true;
		}
	}

	return false;
}

/*
 ================
 Look interface
 ================
*/

// Look constructor
Look::Look(LuaScriptInterface* interface) :
	Script(interface) { }

ReturnValue Look::canExecuteLook(std::shared_ptr<Player> player, const Position &toPos) {
	if (!allowFarUse) {
		return g_looks().canLook(player, toPos);
	}
	return RETURNVALUE_NOERROR;
}

std::shared_ptr<Thing> Look::getTarget(std::shared_ptr<Player> player, std::shared_ptr<Creature> targetCreature, const Position &toPosition, uint8_t toStackPos) const {
	if (targetCreature != nullptr) {
		return targetCreature;
	}
	return g_game().internalGetThing(player, toPosition, toStackPos, 0, STACKPOS_USETARGET);
}

bool Look::executeLook(std::shared_ptr<Player> player, std::shared_ptr<Item> item, const Position &fromPosition, std::shared_ptr<Thing> target, const Position &toPosition) {
	// onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if (!getScriptInterface()->reserveScriptEnv()) {
		g_logger().error("[Look::executeLook - Player {}, on item {}] "
		                 "Call stack overflow. Too many lua script calls being nested.",
		                 player->getName(), item->getName());
		return false;
	}

	ScriptEnvironment* scriptEnvironment = getScriptInterface()->getScriptEnv();
	scriptEnvironment->setScriptId(getScriptId(), getScriptInterface());

	lua_State* L = getScriptInterface()->getLuaState();

	getScriptInterface()->pushFunction(getScriptId());

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushThing(L, item);
	LuaScriptInterface::pushPosition(L, fromPosition);

	LuaScriptInterface::pushThing(L, target);
	LuaScriptInterface::pushPosition(L, toPosition);

	return getScriptInterface()->callFunction(5);
}

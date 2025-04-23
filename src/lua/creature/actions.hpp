/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "declarations.hpp"

class Action;
class LuaScriptInterface;
class Player;
class Item;
class Creature;
class Thing;

struct Position;

class Action {
public:
	explicit Action();

	// Scripting
	virtual bool executeUse(const std::shared_ptr<Player> &player, const std::shared_ptr<Item> &item, const Position &fromPosition, const std::shared_ptr<Thing> &target, const Position &toPosition, bool isHotkey);

	bool getAllowFarUse() const {
		return allowFarUse;
	}

	void setAllowFarUse(bool allow) {
		allowFarUse = allow;
	}

	bool getCheckLineOfSight() const {
		return checkLineOfSight;
	}

	void setCheckLineOfSight(bool state) {
		checkLineOfSight = state;
	}

	bool getCheckFloor() const {
		return checkFloor;
	}

	void setCheckFloor(bool state) {
		checkFloor = state;
	}

	std::vector<uint16_t> getItemIdsVector() const {
		return itemIds;
	}

	void setItemIdsVector(uint16_t id) {
		itemIds.emplace_back(id);
	}

	std::vector<uint16_t> getUniqueIdsVector() const {
		return uniqueIds;
	}

	void setUniqueIdsVector(uint16_t id) {
		uniqueIds.emplace_back(id);
	}

	std::vector<uint16_t> getActionIdsVector() const {
		return actionIds;
	}

	void setActionIdsVector(uint16_t id) {
		actionIds.emplace_back(id);
	}

	std::vector<Position> getPositionsVector() const {
		return positions;
	}

	void setPositionsVector(Position pos) {
		positions.emplace_back(pos);
	}

	bool hasPosition(Position position) {
		return std::ranges::find_if(positions.begin(), positions.end(), [position](Position storedPosition) {
				   if (storedPosition == position) {
					   return true;
				   }
				   return false;
			   })
			!= positions.end();
	}

	std::vector<std::string> getKeysVector() const {
		return keys;
	}

	void setKeysVector(std::string key) {
		keys.emplace_back(key);
	}

	bool hasKey(std::string key) {
		return std::ranges::find_if(keys.begin(), keys.end(), [key](std::string storedKey) {
				   if (storedKey == key) {
					   return true;
				   }
				   return false;
			   })
			!= keys.end();
	}

	virtual ReturnValue canExecuteAction(const std::shared_ptr<Player> &player, const Position &toPos);

	virtual bool hasOwnErrorHandler() {
		return false;
	}

	virtual std::shared_ptr<Thing> getTarget(const std::shared_ptr<Player> &player, const std::shared_ptr<Creature> &targetCreature, const Position &toPosition, uint8_t toStackPos) const;

	LuaScriptInterface* getScriptInterface() const;
	bool loadScriptId();
	int32_t getScriptId() const;
	void setScriptId(int32_t newScriptId);
	bool isLoadedScriptId() const;

private:
	int32_t m_scriptId {};

	std::function<bool(
		const std::shared_ptr<Player> &player, const std::shared_ptr<Item> &item,
		const Position &fromPosition, const std::shared_ptr<Thing> &target,
		const Position &toPosition, bool isHotkey
	)>
		useFunction = nullptr;

	// Atributes
	bool allowFarUse = false;
	bool checkFloor = true;
	bool checkLineOfSight = true;

	// IDs
	std::vector<uint16_t> itemIds;
	std::vector<uint16_t> uniqueIds;
	std::vector<uint16_t> actionIds;
	std::vector<Position> positions;
	std::vector<std::string> keys;

	friend class Actions;
};

class Actions {
public:
	Actions();
	~Actions();

	// non-copyable
	Actions(const Actions &) = delete;
	Actions &operator=(const Actions &) = delete;

	static Actions &getInstance();

	bool useItem(const std::shared_ptr<Player> &player, const Position &pos, uint8_t index, const std::shared_ptr<Item> &item, bool isHotkey);
	bool useItemEx(const std::shared_ptr<Player> &player, const Position &fromPos, const Position &toPos, uint8_t toStackPos, const std::shared_ptr<Item> &item, bool isHotkey, const std::shared_ptr<Creature> &creature = nullptr);

	ReturnValue canUse(const std::shared_ptr<Player> &player, const Position &pos) const;
	ReturnValue canUse(const std::shared_ptr<Player> &player, const Position &pos, const std::shared_ptr<Item> &item);
	ReturnValue canUseFar(const std::shared_ptr<Creature> &creature, const Position &toPos, bool checkLineOfSight, bool checkFloor) const;

	bool registerLuaItemEvent(const std::shared_ptr<Action> &action);
	bool registerLuaUniqueEvent(const std::shared_ptr<Action> &action);
	bool registerLuaActionEvent(const std::shared_ptr<Action> &action);
	bool registerLuaPositionEvent(const std::shared_ptr<Action> &action);
	bool registerLuaKeyEvent(const std::shared_ptr<Action> &action);
	bool registerLuaEvent(const std::shared_ptr<Action> &action);
	// Clear maps for reloading
	void clear();

private:
	bool hasPosition(const Position &position) const {
		if (auto it = positionItemMap.find(position);
		    it != positionItemMap.end()) {
			return true;
		}
		return false;
	}

	[[nodiscard]] std::map<Position, std::shared_ptr<Action>> getPositionsMap() const {
		return positionItemMap;
	}

	void setPosition(const Position &position, const std::shared_ptr<Action> &action) {
		positionItemMap.try_emplace(position, action);
	}

	bool hasItemId(uint16_t itemId) const {
		if (const auto it = useItemMap.find(itemId);
		    it != useItemMap.end()) {
			return true;
		}
		return false;
	}

	void setItemId(uint16_t itemId, const std::shared_ptr<Action> &action) {
		useItemMap.try_emplace(itemId, action);
	}

	bool hasUniqueId(uint16_t uniqueId) const {
		if (const auto it = uniqueItemMap.find(uniqueId);
		    it != uniqueItemMap.end()) {
			return true;
		}
		return false;
	}

	void setUniqueId(uint16_t uniqueId, const std::shared_ptr<Action> &action) {
		uniqueItemMap.try_emplace(uniqueId, action);
	}

	bool hasActionId(uint16_t actionId) const {
		if (const auto it = actionItemMap.find(actionId);
		    it != actionItemMap.end()) {
			return true;
		}
		return false;
	}

	void setActionId(uint16_t actionId, const std::shared_ptr<Action> &action) {
		actionItemMap.try_emplace(actionId, action);
	}

	void setKey(std::string key, const std::shared_ptr<Action> action) {
		keyItemMap.try_emplace(key, action);
	}

	bool hasKey(std::string key) const {
		if (auto it = keyItemMap.find(key);
		    it != keyItemMap.end()) {
			return true;
		}
		return false;
	}
	ReturnValue internalUseItem(const std::shared_ptr<Player> &player, const Position &pos, uint8_t index, const std::shared_ptr<Item> &item, bool isHotkey);
	static void showUseHotkeyMessage(const std::shared_ptr<Player> &player, const std::shared_ptr<Item> &item, uint32_t count);

	using ActionUseMap = std::map<uint16_t, std::shared_ptr<Action>>;
	ActionUseMap useItemMap;
	ActionUseMap uniqueItemMap;
	ActionUseMap actionItemMap;
	std::map<Position, std::shared_ptr<Action>> positionItemMap;
	std::map<std::string, std::shared_ptr<Action>> keyItemMap;

	std::shared_ptr<Action> getAction(const std::shared_ptr<Item> &item);
};

constexpr auto g_actions = Actions::getInstance;

/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "lua/scripts/scripts.hpp"
#include "declarations.hpp"
#include "lua/scripts/luascript.hpp"

class Look;
class Position;

class Look : public Script {
public:
	explicit Look(LuaScriptInterface* interface);

	// Scripting
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

	std::shared_ptr<Thing> getTarget(std::shared_ptr<Player> player, std::shared_ptr<Creature> targetCreature, const Position &toPosition, uint8_t toStackPos) const;

	virtual ReturnValue canExecuteLook(std::shared_ptr<Player> player, const Position &toPos);
	bool executeLook(std::shared_ptr<Player> player, std::shared_ptr<Item> item, const Position &fromPosition, std::shared_ptr<Thing> target, const Position &toPosition);

	virtual bool hasOwnErrorHandler() {
		return false;
	}

private:
	std::string getScriptTypeName() const override {
		return "onLook";
	}

	std::function<bool(
		std::shared_ptr<Player> player, std::shared_ptr<Item> item,
		const Position &fromPosition, std::shared_ptr<Thing> target,
		const Position &toPosition
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

	friend class Looks;
};

class Looks final : public Scripts {
public:
	Looks();
	~Looks();

	// non-copyable
	Looks(const Looks &) = delete;
	Looks &operator=(const Looks &) = delete;

	static Looks &getInstance() {
		return inject<Looks>();
	}

	bool lookItemEx(std::shared_ptr<Player> player, const Position &fromPos, const Position &toPos, uint8_t stackPos, std::shared_ptr<Item> item, std::shared_ptr<Creature> creature = nullptr);
	std::shared_ptr<Look> getLook(std::shared_ptr<Item> item);

	ReturnValue canLook(std::shared_ptr<Player> player, const Position &pos);
	ReturnValue canLook(std::shared_ptr<Player> player, const Position &pos, std::shared_ptr<Item> item);

	bool registerLuaItemEvent(const std::shared_ptr<Look> look);
	bool registerLuaUniqueEvent(const std::shared_ptr<Look> look);
	bool registerLuaActionEvent(const std::shared_ptr<Look> look);
	bool registerLuaPositionEvent(const std::shared_ptr<Look> look);
	bool registerLuaKeyEvent(const std::shared_ptr<Look> look);
	bool registerLuaEvent(const std::shared_ptr<Look> look);
	// Clear maps for reloading
	void clear();

private:
	bool hasPosition(Position position) const {
		if (auto it = positionItemMap.find(position);
		    it != positionItemMap.end()) {
			return true;
		}
		return false;
	}

	[[nodiscard]] std::map<Position, std::shared_ptr<Look>> getPositionsMap() const {
		return positionItemMap;
	}

	void setPosition(Position position, std::shared_ptr<Look> look) {
		positionItemMap.try_emplace(position, look);
	}

	bool hasItemId(uint16_t itemId) const {
		if (auto it = useItemMap.find(itemId);
		    it != useItemMap.end()) {
			return true;
		}
		return false;
	}

	void setItemId(uint16_t itemId, const std::shared_ptr<Look> action) {
		useItemMap.try_emplace(itemId, action);
	}

	bool hasUniqueId(uint16_t uniqueId) const {
		if (auto it = uniqueItemMap.find(uniqueId);
		    it != uniqueItemMap.end()) {
			return true;
		}
		return false;
	}

	void setUniqueId(uint16_t uniqueId, const std::shared_ptr<Look> action) {
		uniqueItemMap.try_emplace(uniqueId, action);
	}

	bool hasActionId(uint16_t actionId) const {
		if (auto it = actionItemMap.find(actionId);
		    it != actionItemMap.end()) {
			return true;
		}
		return false;
	}

	void setActionId(uint16_t actionId, const std::shared_ptr<Look> action) {
		actionItemMap.try_emplace(actionId, action);
	}

	void setKey(std::string key, const std::shared_ptr<Look> action) {
		keyItemMap.try_emplace(key, action);
	}

	bool hasKey(std::string key) const {
		if (auto it = keyItemMap.find(key);
			it != keyItemMap.end()) {
			return true;
		}
		return false;
	}

	// ReturnValue internalLookItem(std::shared_ptr<Player> player, const Position &fromPos, uint8_t stackPos, std::shared_ptr<Item> item, const Position &toPos);

	using LookMap = std::map<uint16_t, std::shared_ptr<Look>>;
	LookMap useItemMap;
	LookMap uniqueItemMap;
	LookMap actionItemMap;
	std::map<Position, std::shared_ptr<Look>> positionItemMap;
	std::map<std::string, std::shared_ptr<Look>> keyItemMap;
};

constexpr auto g_looks = Looks::getInstance;

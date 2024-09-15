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

	std::vector<Position> getPositions() const {
		return positions;
	}
	void setPositions(Position pos) {
		positions.emplace_back(pos);
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
	bool registerLuaEvent(const std::shared_ptr<Look> look);
	// Clear maps for reloading
	void clear();

private:
	bool hasPosition(Position position) const {
		if (auto it = actionPositionMap.find(position);
		    it != actionPositionMap.end()) {
			return true;
		}
		return false;
	}

	[[nodiscard]] std::map<Position, std::shared_ptr<Look>> getPositionsMap() const {
		return actionPositionMap;
	}

	void setPosition(Position position, std::shared_ptr<Look> action) {
		actionPositionMap.try_emplace(position, action);
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

	// ReturnValue internalLookItem(std::shared_ptr<Player> player, const Position &fromPos, uint8_t stackPos, std::shared_ptr<Item> item, const Position &toPos);

	using LookMap = std::map<uint16_t, std::shared_ptr<Look>>;
	LookMap useItemMap;
	LookMap uniqueItemMap;
	LookMap actionItemMap;
	std::map<Position, std::shared_ptr<Look>> actionPositionMap;
};

constexpr auto g_looks = Looks::getInstance;

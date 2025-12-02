/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

// TODO: Remove circular includes (maybe shared_ptr?)
#include "server/network/message/networkmessage.hpp"

#include "config/configmanager.hpp"

#include "utils/tools.hpp"

class PreySlot;
class TaskHuntingSlot;
class TaskHuntingOption;
class NetworkMessage;
class Player;

static const uint8_t PreyGridSize = 9;

enum PreySlot_t : uint8_t {
	PreySlot_One = 0,
	PreySlot_Two = 1,
	PreySlot_Three = 2,

	PreySlot_First = PreySlot_One,
	PreySlot_Last = PreySlot_Three
};

enum PreyDataState_t : uint8_t {
	PreyDataState_Locked = 0,
	PreyDataState_Inactive = 1,
	PreyDataState_Active = 2,
	PreyDataState_Selection = 3,
	PreyDataState_SelectionChangeMonster = 4,
	PreyDataState_ListSelection = 5,
	PreyDataState_WildcardSelection = 6
};

enum PreyBonus_t : uint8_t {
	PreyBonus_Damage = 0,
	PreyBonus_Defense = 1,
	PreyBonus_Experience = 2,
	PreyBonus_Loot = 3,
	PreyBonus_None = 4, // Do not send this to client

	PreyBonus_First = PreyBonus_Damage,
	PreyBonus_Last = PreyBonus_Loot
};

enum PreyStars_t : uint8_t {
	PreyStars_0 = 0,
	PreyStars_1 = 1,
	PreyStars_2 = 2,
	PreyStars_3 = 3,
	PreyStars_4 = 4,
	PreyStars_5 = 5,
	PreyStars_6 = 6,
	PreyStars_7 = 7,
	PreyStars_8 = 8,
	PreyStars_9 = 9,
	PreyStars_10 = 10,
	PreyStars_Min = PreyStars_1,
	PreyStars_Max = PreyStars_10
};

enum PreyOption_t : uint8_t {
	PreyOption_None = 0,
	PreyOption_AutomaticReroll = 1,
	PreyOption_Locked = 2
};

enum PreyAction_t : uint8_t {
	PreyAction_GridReroll = 0,
	PreyAction_BonusReroll = 1,
	PreyAction_GridSelection = 2,
	PreyAction_ListAll_Cards = 3,
	PreyAction_ListAll_Selection = 4,
	PreyAction_Option = 5
};

enum PreyTaskDataState_t : uint8_t {
	PreyTaskDataState_Locked = 0,
	PreyTaskDataState_Inactive = 1,
	PreyTaskDataState_Selection = 2,
	PreyTaskDataState_ListSelection = 3,
	PreyTaskDataState_Active = 4,
	PreyTaskDataState_Completed = 5
};

enum PreyTaskAction_t : uint8_t {
	PreyTaskAction_ListReroll = 0,
	PreyTaskAction_RewardsReroll = 1,
	PreyTaskAction_ListAll_Cards = 2,
	PreyTaskAction_MonsterSelection = 3,
	PreyTaskAction_Cancel = 4,
	PreyTaskAction_Claim = 5
};

enum PreyTaskDifficult_t : uint8_t {
	PreyTaskDifficult_None = 0,
	PreyTaskDifficult_Easy = 1,
	PreyTaskDifficult_Medium = 2,
	PreyTaskDifficult_Hard = 3,

	PreyTaskDifficult_First = PreyTaskDifficult_Easy,
	PreyTaskDifficult_Last = PreyTaskDifficult_Hard
};

class NetworkMessage;

// Vaigu custom
class PreyMonster {
public:
	uint16_t raceid;
	std::string name;
	uint32_t difficulty;
};

// Vaigu custom
class PreyMonsterBuilder {
private:
	std::vector<PreyMonster> monsters;

public:
	void init();
	void filterByLevel(uint32_t level);
	void filterByBlacklist(std::vector<uint16_t> raceIdBlacklist);
	void trim(uint16_t newSize);
	std::vector<PreyMonster> get();
};

class PreySlot {
public:
	PreySlot() = default;
	explicit PreySlot(PreySlot_t id);
	virtual ~PreySlot() = default;

	bool isOccupied() const {
		return selectedRaceId != 0 && bonusTimeLeft > 0;
	}

	bool canSelect() const {
		return (state == PreyDataState_Selection || state == PreyDataState_SelectionChangeMonster || state == PreyDataState_ListSelection || state == PreyDataState_Inactive);
	}

	// Vaigu custom
	void updateBonusPercentage() {
		if (bonus == PreyBonus_Damage) {
			bonusPercentage = 4 * bonusRarity + 25;
		} else if (bonus == PreyBonus_Defense) {
			bonusPercentage = 3 * bonusRarity + 15;
		} else if (bonus == PreyBonus_Experience) {
			bonusPercentage = 3 * bonusRarity + 20;
		} else if (bonus == PreyBonus_Loot) {
			bonusPercentage = 8 * bonusRarity + 20;
		}
	}

	// Vaigu custom
	void refreshBonus(
		bool maintainOption = true,
		bool maintainState = true,
		bool maintainMonster = true,
		bool maintainTime = true,

		PreyOption_t nextOption = PreyOption_None,
		PreyDataState_t nextState = PreyDataState_Selection,
		uint16_t nextRaceId = 0,

		bool maintainBonusType = true,
		bool refreshTime = false,
		bool rerollType = false,
		bool rerollRarity = false,
		uint16_t rarityPenalty = 0
	) {
		if (!maintainMonster) {
			selectedRaceId = nextRaceId;
			removeMonsterType(nextRaceId);
		}
		if (!maintainOption) {
			option = nextOption;
		}
		if (!maintainState) {
			state = nextState;
		}

		if (rarityPenalty > 0) {
			if (rarityPenalty > bonusRarity) {
				rarityPenalty = bonusRarity;
			}
			bonusRarity = bonusRarity - rarityPenalty;
			bonusRarity = std::clamp((int)bonusRarity, 1, 10);
		}

		if (!maintainBonusType) {
			bonus = PreyBonus_None;
		}
		if (refreshTime) {
			bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
		} else if (maintainTime) {
			bonusTimeLeft = bonusTimeLeft;
		} else {
			bonusTimeLeft = 0;
		}
		if (rerollType) {
			rerollBonusType();
		}
		if (rerollRarity) {
			rerollBonusRarity();
		}
		updateBonusPercentage();
	}

	std::vector<uint16_t> failstack = std::vector<uint16_t>(11);

	const std::map<uint8_t, uint8_t> starsToUpgradeChance = {
		{ PreyStars_1, 90 },
		{ PreyStars_2, 90 },
		{ PreyStars_3, 70 },
		{ PreyStars_4, 70 },
		{ PreyStars_5, 50 },
		{ PreyStars_6, 50 },
		{ PreyStars_7, 40 },
		{ PreyStars_8, 40 },
		{ PreyStars_9, 40 },
		{ PreyStars_Max, 100 },
	};

	const uint16_t failstackBonus = 5;
	void rerollBonusRarity() {
		const uint8_t roll = uniform_random(1, 100) + failstack.at(bonusRarity);
		const uint8_t requiredRollForUpgrade = 100 - starsToUpgradeChance.at(bonusRarity);
		if (roll >= requiredRollForUpgrade) {
			failstack.at(bonusRarity) = 0;
			bonusRarity++;
		} else {
			failstack.at(bonusRarity) = failstack.at(bonusRarity) + failstackBonus;
			bonusRarity--;
		}

		bonusRarity = std::clamp((int)bonusRarity, 1, 10);
		updateBonusPercentage();
	}

	void rerollBonusType() {
		if (bonusRarity >= PreyStars_Max) {
			bonus = static_cast<PreyBonus_t>((bonus + 1) % static_cast<int>(PreyBonus_Last + 1));
		} else {
			bonus = static_cast<PreyBonus_t>(uniform_random(PreyBonus_First, PreyBonus_Last));
		}
	}

	void removeMonsterType(uint16_t raceId) {
		raceIdList.erase(std::remove(raceIdList.begin(), raceIdList.end(), raceId), raceIdList.end());
	}

	void reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level);

	PreySlot_t id = PreySlot_First;
	PreyBonus_t bonus = PreyBonus_None;
	PreyDataState_t state = PreyDataState_Locked;
	PreyOption_t option = PreyOption_None;

	std::vector<uint16_t> raceIdList;

	uint8_t bonusRarity = 1;

	uint16_t selectedRaceId = 0;
	uint16_t bonusPercentage = 0;
	uint16_t bonusTimeLeft = 0;

	int64_t freeRerollTimeStamp = 0;
};

class TaskHuntingSlot {
public:
	TaskHuntingSlot() = default;
	explicit TaskHuntingSlot(PreySlot_t id);
	virtual ~TaskHuntingSlot() = default;

	bool isOccupied() const {
		return selectedRaceId != 0;
	}

	bool canSelect() const {
		return (state == PreyTaskDataState_Selection || state == PreyTaskDataState_ListSelection);
	}

	void eraseTask() {
		upgrade = false;
		state = PreyTaskDataState_Selection;
		selectedRaceId = 0;
		currentKills = 0;
		rarity = 1;
	}

	void removeMonsterType(uint16_t raceId) {
		raceIdList.erase(std::remove(raceIdList.begin(), raceIdList.end(), raceId), raceIdList.end());
	}

	bool isCreatureOnList(uint16_t raceId) const {
		auto it = std::find_if(raceIdList.begin(), raceIdList.end(), [raceId](uint16_t it) {
			return it == raceId;
		});

		return it != raceIdList.end();
	}

	void reloadReward();
	void reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level);

	PreySlot_t id = PreySlot_First;
	PreyTaskDataState_t state = PreyTaskDataState_Inactive;

	bool upgrade = false;

	uint8_t rarity = 1;

	uint16_t selectedRaceId = 0;
	uint16_t currentKills = 0;

	int64_t disabledUntilTimeStamp = 0;
	int64_t freeRerollTimeStamp = 0;

	std::vector<uint16_t> raceIdList;
};

class TaskHuntingOption {
public:
	TaskHuntingOption() = default;
	virtual ~TaskHuntingOption() = default;

	PreyTaskDifficult_t difficult = PreyTaskDifficult_None;
	uint8_t rarity = 1;

	uint16_t firstKills = 0;
	uint16_t secondKills = 0;

	uint16_t firstReward = 0;
	uint16_t secondReward = 0;
};

static const std::unique_ptr<PreySlot> &PreySlotNull {};
static const std::unique_ptr<TaskHuntingSlot> &TaskHuntingSlotNull {};
static const std::unique_ptr<TaskHuntingOption> &TaskHuntingOptionNull {};

class IOPrey {
public:
	IOPrey() = default;

	// non-copyable
	IOPrey(const IOPrey &) = delete;
	void operator=(const IOPrey &) = delete;

	static IOPrey &getInstance();

	// Vaigu custom
	std::unordered_set<std::string> loadWhitelist();
	void initializePreyMonsters();

	void reducePlayerPreyTime(std::shared_ptr<Player> player, uint8_t time, uint16_t raceId) const;
	void updatePlayerPreyStatus(std::shared_ptr<Player> player) const;
	void parsePreyAction(std::shared_ptr<Player> player, PreySlot_t slotId, PreyAction_t action, PreyOption_t option, int8_t index, uint16_t raceId) const;

	void parseTaskHuntingAction(const std::shared_ptr<Player> &player, PreySlot_t slotId, PreyTaskAction_t action, bool upgrade, uint16_t raceId) const;

	void initializeTaskHuntOptions();
	const std::unique_ptr<TaskHuntingOption> &getTaskRewardOption(const std::unique_ptr<TaskHuntingSlot> &slot) const;

	NetworkMessage getTaskHuntingBaseDate() const;

	NetworkMessage m_baseDataMessage;
	std::vector<std::unique_ptr<TaskHuntingOption>> taskOption;

	// Vaigu custom
	std::vector<PreyMonster> preyMonsters;
	bool initialized = false;
};

constexpr auto g_ioprey = IOPrey::getInstance;

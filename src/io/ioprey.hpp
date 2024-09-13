/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "lib/di/container.hpp"
#include "server/network/protocol/protocolgame.hpp"

class PreySlot;
class TaskHuntingSlot;
class TaskHuntingOption;

static const std::unique_ptr<PreySlot> &PreySlotNull {};
static const std::unique_ptr<TaskHuntingSlot> &TaskHuntingSlotNull {};
static const std::unique_ptr<TaskHuntingOption> &TaskHuntingOptionNull {};

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

enum PreyOption_t : uint8_t {
	PreyOption_None = 0,
	PreyOption_AutomaticReroll = 1,
	PreyOption_Locked = 2
};

enum PreyAction_t : uint8_t {
	PreyAction_ListReroll = 0,
	PreyAction_BonusReroll = 1,
	PreyAction_MonsterSelection = 2,
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
	void eraseBonus(bool maintainBonus = false) {
		if (!maintainBonus) {
			bonus = PreyBonus_None;
			if (bonusRarity > 4) {
				bonusRarity = bonusRarity - (int)floor(bonusRarity * 0.33);
			}
		} else {
			bonusRarity = bonusRarity - (int)floor(log2(bonusRarity));
		}
		bonusRarity = std::clamp((int)bonusRarity, 1, 10);

		state = PreyDataState_Selection;
		option = PreyOption_None;
		selectedRaceId = 0;
		bonusTimeLeft = 0;
		updateBonusPercentage();
	}

	void refreshBonus(
		 bool maintainOption = true, 
		 bool maintainState = true,
		 bool maintainMonster = true, 

		PreyOption_t nextOption = PreyOption_None,
		PreyDataState_t nextState =   PreyDataState_Active,
		uint16_t nextRaceId = 0,

		bool maintainBonusType = true,
		 bool refreshTime = false,
		 bool isReroll = false,
		 bool rarityPenalty = 0, 

		){

		if (!maintainType) {
			bonus = nextBonusType;
		}
		if (!maintainMonster) {
			selectedRaceId = nextRaceId;
			removeMonsterType(nextRaceId);
		}
		if (!maintainOption) {
			option = nextOption;
		}
		if (!maintainState){
			state = nextState;
		}
		if (maintainTime)

		if (rarityPenalty > 0) {
			bonusRarity = bonusRarity - rarityPenalty;
			bonusRarity = std::clamp((int)bonusRarity, 1, 10);
		}

		if (refreshTime) {
			bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME, __FUNCTION__));
		} else {
			bonusTimeLeft = 0;
		}
		if(isReroll){
			rerollBonusType();
			rerollBonusValue();
		}
		updateBonusPercentage();
	}

	uint16_t failstack[11];

	std::map<uint8_t, uint8_t> rarityToUpgradeChance = {
		{ 1, 90 },
		{ 2, 90 },
		{ 3, 70 },
		{ 4, 70 },
		{ 5, 50 },
		{ 6, 40 },
		{ 7, 30 },
		{ 8, 20 },
		{ 9, 15 },
		{ 10, 100 },
	};

	void rerollBonusValue() {
		failstack = std::clamp(player.kv()->scoped("failstack")->scoped("prey")->get(), 1, 10);
		uint8_t roll = uniform_random(1, 100);
		uint8_t requiredRollForUpgrade = 100 - rarityToUpgradeChance[bonusRarity];
		if ((roll + failstack[bonusRarity]) >= requiredRollForUpgrade) {
			bonusRarity++;
			failstack[bonusRarity] = 0;
		} else {
			failstack[bonusRarity]++;
			bonusRarity--;
		}
		bonusRarity = std::clamp((int)bonusRarity, 1, 10);
		
		updateBonusPercentage();
	}
	player.kv()->scoped("failstack")->scoped("prey")->set(failstack);
	void rerollBonusType() {
		bonus = static_cast<PreyBonus_t>(uniform_random(PreyBonus_First, PreyBonus_Last));
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

class IOPrey {
public:
	IOPrey() = default;

	// non-copyable
	IOPrey(const IOPrey &) = delete;
	void operator=(const IOPrey &) = delete;

	static IOPrey &getInstance() {
		return inject<IOPrey>();
	}

	// Vaigu custom
	std::unordered_set<std::string> loadWhitelist();
	void initializePreyMonsters();

	void reducePlayerPreyTime(std::shared_ptr<Player> player, uint8_t time, uint16_t raceId) const;
	void updatePlayerPreyStatus(std::shared_ptr<Player> player) const;
	void parsePreyAction(std::shared_ptr<Player> player, PreySlot_t slotId, PreyAction_t action, PreyOption_t option, int8_t index, uint16_t raceId) const;

	void parseTaskHuntingAction(std::shared_ptr<Player> player, PreySlot_t slotId, PreyTaskAction_t action, bool upgrade, uint16_t raceId) const;

	void initializeTaskHuntOptions();
	const std::unique_ptr<TaskHuntingOption> &getTaskRewardOption(const std::unique_ptr<TaskHuntingSlot> &slot) const;

	NetworkMessage getTaskHuntingBaseDate() const {
		return baseDataMessage;
	}

	NetworkMessage baseDataMessage;
	std::vector<std::unique_ptr<TaskHuntingOption>> taskOption;

	// Vaigu custom
	std::vector<PreyMonster> preyMonsters;
	std::unordered_set<std::string> whitelist = {
		"Rotworm", "Carrion Worm",
		"Skeleton", "Ghoul", "Skeleton Warrior", "Mummy", "Crypt Shambler", "Zombie", "Demon Skeleton",
		"Rat", "Cave Rat", "Badger", "Snake", "Bat", "Wolf", "Winter Wolf", "Bug", "Sandcrawler", "Wasp",
		"Hyaena", "Bear", "Lion", "Larva", "Scorpion", "Toad", "Boar",
		"Salamander", "Marsh Stalker", "Emerald Damselfly",
		"Troll", "Troll Champion", "Swamp Troll",
		"Cyclops", "Cyclops Drone", "Cyclops Smith",
		"Frost Giant", "Frost Giantess",
		"Dark Magician", "Dark Apprentice",
		"Monk",
		"Bonelord",
		"Dworc Venomsniper", "Dworc Voodoomaster", "Dworc Fleshhunter",
		"Dragon", "Dragon Hatchling", "Dragon Lord Hatchling",
		"Dwarf", "Dwarf Guard", "Dwarf Geomancer", "Dwarf Soldier",
		"Elf", "Elf Scout", "Elf Arcanist",
		"Goblin", "Goblin Scavenger", "Goblin Assassin",
		"Earth Elemental", "Fire Elemental", "Water Elemental", "Energy Elemental",
		"Gargoyle",
		"Stone Golem",
		"Corym Charlatan", "Corym Skirmisher", "Corym Vanguard",
		"Merlkin", "Kongra", "Sibang",
		"Minotaur", "Minotaur Guard", "Minotaur Mage", "Minotaur Archer",
		"Nomad",
		"Amazon", "Valkyrie", "Witch",
		"Hunter", "Poacher",
		"Orc", "Orc Berserker", "Orc Leader", "Orc Shaman", "Orc Spearman", "Orc Warlord", "Orc Rider", "Orc Warrior",
		"Rotworm Queen",
		"Tarantula", "Spider", "Poison Spider",
		"Giant Spider", "Crystal Spider", "Wailing Widow",
		"Terramite",
		"Lizard Templar", "Lizard Sentinel", "Lizard Snakecharmer",
		"Tortoise", "Thornback Tortoise",
		"Ancient Scarab", "Scarab",
		"Smuggler", "Wild Warrior", "Bandit", "Stalker",
		"Carniphila", "Centipede", "Elephant",
		"Crocodile",
		"Mammoth",
		"Blood Crab",
		"Mutated Human", "Mutated Rat", "Mutated Tiger",
		"Lancer Beetle",
		"Necromancer", "Vampire", "Blood Hand", "Blood Priest", "Priestess",
		"Swarmer", "Spitter", "Insectoid Worker", "Crawler", "Waspoid",
		"Stampor",
		"Forest Fury",
		"Roaring Lion",
		"Wyvern",
		"Bonebeast",
		"Pirate Buccaneer", "Pirate Ghost", "Pirate Marauder", "Pirate Skeleton", "Pirate Cutthroat",
		"Blue Djinn", "Green Djinn", "Efreet", "Marid",
		"Ghoulish Hyaena", "Sandstone Scorpion", "Shadow Pupil", "Putrid Mummy",
		"Carniphila",
		"Souleater",
		"Pirate Buccaneer", "Pirate Ghost", "Pirate Marauder", "Pirate Skeleton", "Pirate Cutthroat", "Pirate Corsair",
		"Blue Djinn", "Green Djinn", "Efreet", "Marid",
		"Dragon", "Dragon Hatchling", "Dragon Lord Hatchling", "Frost Dragon Hatchling", "Dragon Lord", "Frost Dragon",
		"Corym Charlatan", "Corym Skirmisher", "Corym Vanguard",
		"Killer Caiman",
		"Bonelord", "Elder Bonelord",
		"Hydra",
		"Medusa",
		"Wyrm", "Elder Wyrm",
		"Wyvern",
		"Tarantula", "Giant Spider", "Crystal Spider", "Wailing Widow",
		"Ghastly Dragon",
		"Ancient Scarab", "Scarab",
		"Bonebeast",
		"Ice Golem",
		"Hero", "Vicious Squire", "Renegade Knight", "Vile Grandmaster", "Cult Enforcer", "Cult Scholar", "Cult Believer",
		"Enlightened Of The Cult", "Acolyte Of The Cult", "Adept Of The Cult",
		"Behemoth",
		"Serpent Spawn",
		"Demon", "Destroyer", "Plaguesmith",
		"Warlock",
		"Infernalist",
		"Bog Raider",
		"Lich",
		"Faun", "Dark Faun", "Boogy", "Nymph", "Pixie", "Pooka", "Swan Maiden", "Twisted Pooka",
		"Deepling Brawler", "Deepling Guard", "Deepling Master Librarian", "Deepling Warrior",
		"Lizard Chosen", "Lizard Dragon Priest", "Lizard High Guard", "Lizard Legionnaire", "Lizard Zaogun",
		"Earth Elemental", "Fire Elemental", "Water Elemental", "Energy Elemental",
		"Massive Energy Elemental", "Massive Fire Elemental", "Massive Water Elemental", "Massive Earth Elemental",
		"Minotaur Amazon", "Minotaur Hunter", "Mooh'Tah Warrior", "Worm Priestess",
		"Mutated Bat", "Mutated Human", "Mutated Rat", "Mutated Tiger",
		"Necromancer", "Vampire", "Blood Hand", "Blood Priest", "Priestess",
		"Blood Crab",
		"Nightmare", "Nightmare Scion",
		"Ogre Brute", "Ogre Savage", "Ogre Shaman", "Clomp",
		"Quara Constrictor", "Quara Hydromancer", "Quara Mantassin", "Quara Pincher", "Quara Predator",
		"Sea Serpent", "Young Sea Serpent", "Seacrest Serpent",
		"Silencer", "Shock Head", "Frazzlemaw",
		"Enfeebled Silencer", "Weakened Frazzlemaw",
		"Swarmer", "Spitter", "Insectoid Worker", "Crawler", "Waspoid", "Spidris", "Kollos",
		"Lancer Beetle", "Brimstone Bug",
		"Draken Spellweaver", "Draken Warmaster",
		"Stampor",
		"Grim Reaper", "Fury",
		"Roaring Lion",
		"Worker Golem", "War Golem",
		"Werewolf", "Werebear", "Wereboar", "Werebadger", "Werefox",
		"Hellspawn",
		"Vampire Bride", "Vampire Viscount",
		"Yielothax",
		"Drillworm", "Deepworm", "Diremaw",
		"Barbarian Bloodwalker", "Barbarian Brutetamer", "Barbarian Headsplitter", "Barbarian Skullhunter", "Ice Witch",
		"Nightstalker",
		"Metal Gargoyle",
		"Elder Mummy", "Putrid Mummy", "Shaburak Demon", "Askarak Demon",
		"Metal Gargoyle",
		"Souleater",
		"Vampire Bride",
		"Ancient Scarab",
		"Killer Caiman",
		"Spitter", "Crawler", "Waspoid", "Spidris", "Kollos",
		"Dragon Lord Hatchling", "Frost Dragon Hatchling", "Dragon Lord", "Frost Dragon",
		"Hydra", "Serpent Spawn", "Medusa",
		"Wyrm", "Elder Wyrm",
		"Giant Spider", "Wailing Widow", "Crystal Spider",
		"Hero", "Vicious Squire", "Renegade Knight", "Vile Grandmaster", "Cult Enforcer", "Cult Scholar", "Cult Believer",
		"Enlightened Of The Cult", "Acolyte Of The Cult", "Adept Of The Cult",
		"Behemoth",
		"Warlock",
		"Infernalist",
		"Bog Raider",
		"Faun", "Dark Faun", "Boogy", "Nymph", "Pixie", "Pooka", "Swan Maiden", "Twisted Pooka",
		"Lizard Chosen", "Lizard Dragon Priest", "Lizard High Guard", "Lizard Legionnaire", "Lizard Zaogun",
		"Earth Elemental", "Water Elemental", "Energy Elemental",
		"Massive Energy Elemental", "Massive Fire Elemental", "Massive Water Elemental", "Massive Earth Elemental",
		"Minotaur Amazon", "Execowtioner", "Minotaur Hunter", "Mooh'Tah Warrior", "Worm Priestess", "Execowtioner",
		"Blood Beast", "Rot Elemental", "Devourer", "Glooth Anemone",
		"Glooth Bandit", "Glooth Brigand", "Glooth Golem",
		"Nightmare", "Nightmare Scion",
		"Ogre Brute", "Ogre Savage", "Ogre Shaman", "Clomp",
		"Quara Constrictor", "Quara Hydromancer", "Quara Mantassin", "Quara Pincher", "Quara Predator",
		"Sea Serpent", "Young Sea Serpent", "Seacrest Serpent",
		"Worker Golem", "War Golem",
		"Werewolf", "Werebear", "Wereboar", "Werebadger", "Werefox",
		"Hellspawn",
		"Lost Berserker", "Lost Basher", "Lost Husher", "Lost Thrower",
		"Cliff Strider", "Orewalker", "Weeper", "Ironblight", "Lava Golem",
		"Humongous Fungus", "Hideous Fungus",
		"Tunnel Tyrant", "Cave Devourer", "Chasm Spawn", "Deepworm", "Diremaw",
		"Plaguesmith", "Demon", "Defiler", "Destroyer", "Hand of Cursed Fate", "Hellhound", "Juggernaut", "Dark Torturer", "Blightwalker",
		"Hellfire Fighter", "Grim Reaper", "Fury",
		"Phantasm",
		"Undead Dragon", "Ghastly Dragon",
		"Draken Elite", "Draken Spellweaver", "Draken Warmaster", "Draken Abomination",
		"Silencer", "Shock Head", "Guzzlemaw", "Frazzlemaw",
		"Enfeebled Silencer", "Weakened Frazzlemaw",
		"Retching Horror", "Choking Fear",
		"Shiversleep", "Sight Of Surrender", "Demon Outcast",
		"Sparkion", "Yielothax", "Reality Reaver", "Breach Brood", "Dread Intruder",
		"Deepling Brawler", "Deepling Elite", "Deepling Guard", "Deepling Master Librarian", "Deepling Tyrant", "Deepling Warrior",
		"Grimeleech", "Vexclaw", "Hellflayer",
		"Thantaursus", "Insane Siren", "Soul-broken Harbinger", "Crazed Winter Vanguard", "Crazed Summer Vanguard", "Crazed Summer Rearguard", "Crazed Winter Rearguard", "Arachnophobica",
		"Burster Spectre", "Gazer Spectre", "Ripper Spectre",
		"Dawnfire Asura", "Midnight Asura", "Frost Flower Asura", "True Dawnfire Asura", "True Frost Flower Asura", "True Midnight Asura",
		"Floating Savant",
		"Adult Goanna", "Young Goanna", "Black Sphinx Acolyte", "Burning Gladiator", "Crypt Warden", "Feral Sphinx", "Lamassu", "Priestess of the Wild Sun", "Sphinx",
		"Ogre Ruffian", "Ogre Sage", "Ogre Rowdy",
		"Cobra Vizier", "Cobra Assassin", "Cobra Scout",
		"Falcon Paladin", "Falcon Knight",
		"Skeleton Elite Warrior", "Undead Elite Gladiator",
		"Deathling Spellsinger", "Deathling Scout",
		"Moohtant", "Shaburak Demon", "Askarak Demon",
		"White Lion", "Werelion", "Werelioness"
	};
};

constexpr auto g_ioprey = IOPrey::getInstance;

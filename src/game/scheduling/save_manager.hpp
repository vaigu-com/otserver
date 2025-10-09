/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "lib/thread/thread_pool.hpp"

class KVStore;
class Logger;
class Game;
class Player;
class Guild;

struct SaveContext {
	const std::vector<CoinTransactionEntry> &newCoinTransactions;
	const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Player>> &players;
	const std::vector<std::string>& offlinePlayerGuids;
	const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Guild>> &guilds;

	SaveContext(
		const std::vector<CoinTransactionEntry> &newCoinTransactions_,
		const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Player>> &players_,
		const std::vector<std::string>& offlinePlayerGuids_,
		const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Guild>> &guilds_
	) :
		newCoinTransactions(newCoinTransactions_),
		players(players_),
		offlinePlayerGuids(offlinePlayerGuids_),
		guilds(guilds_)
		{ }
};

class SaveManager {
public:
	explicit SaveManager(ThreadPool &threadPool, KVStore &kvStore, Logger &logger, Game &game);

	SaveManager(const SaveManager &) = delete;
	void operator=(const SaveManager &) = delete;

	static SaveManager &getInstance();

	void saveAll();
	void scheduleAll();

private:
	std::vector<std::string> flushOffline(const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Player>>& players);
	void saveAllInner(const SaveContext &saveContext);

	void saveMap();
	void saveKV();
	void saveGuild(std::shared_ptr<Guild> guild);
	void savePlayer(std::shared_ptr<Player> player);

	void setSuccesfulSaveTimestamp();

	std::atomic<std::chrono::steady_clock::time_point> m_scheduledAt;
	phmap::parallel_flat_hash_map<uint32_t, std::chrono::steady_clock::time_point> m_playerMap;

	ThreadPool &threadPool;
	KVStore &kv;
	Logger &logger;
	Game &game;

#ifndef OS_WINDOWS
	pid_t child_saver_pid;
#endif
};

constexpr auto g_saveManager = SaveManager::getInstance;

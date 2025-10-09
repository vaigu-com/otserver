/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "game/scheduling/save_manager.hpp"

#ifndef OS_WINDOWS
	#include <sys/file.h>
	#include <unistd.h>
	#include <fcntl.h>
	#include <unistd.h>
	#include <sys/wait.h>
#endif

#include "game/scheduling/dispatcher.hpp"
#include "config/configmanager.hpp"
#include "creatures/players/grouping/guild.hpp"
#include "game/game.hpp"
#include "io/ioguild.hpp"
#include "io/iologindata.hpp"
#include "kv/kv.hpp"
#include "lib/di/container.hpp"
#include "creatures/players/player.hpp"
#include "server/network/protocol/protocolgame.hpp"
#include "account/account.hpp"
#include "io/iomarket.hpp"

SaveManager::SaveManager(ThreadPool &threadPool, KVStore &kvStore, Logger &logger, Game &game) :
	threadPool(threadPool), kv(kvStore), logger(logger), game(game)
#ifndef OS_WINDOWS
	,
	child_saver_pid(-1)
#endif
{
}

SaveManager &SaveManager::getInstance() {
	return inject<SaveManager>();
}

std::vector<std::string> SaveManager::flushOffline(const phmap::parallel_flat_hash_map<uint32_t, std::shared_ptr<Player>>& players){
	std::vector<std::string> justLoggedOutPlayerGuids;
	for (const auto &[_, player] : players) {
		logger.warn("after save - handling player {}", player->getName());
		if (player->isLoggingOut()) {
			logger.warn("player {} is logging out",player->getName());
			player->setLoggingOut(false);
			player->setOnline(false);
		} else if (!player->isOffline()) {
			player->loginPosition = player->getPosition();
		}
		if (!player->isOnline()) {
			logger.warn("player {} is not online");
			g_game().removePlayer(player);
			player->setRemoved();
			justLoggedOutPlayerGuids.push_back(std::to_string(player->getGUID()));
		}
	}
	return justLoggedOutPlayerGuids;
}

#ifndef OS_WINDOWS
void SaveManager::saveAll() {

	class ResourceGuard {
	public:
		~ResourceGuard() {
			_exit(0);
		}
	};

	if (child_saver_pid != -1) {
		int status;
		pid_t wait_result = waitpid(child_saver_pid, &status, WNOHANG);

		if (wait_result == -1) {
			logger.error("waitpid failed: {}", strerror(errno));
		} else if (wait_result == 0) {
			logger.info("Child process has not exited yet. Skipping save.");
			return;
		} else if (WIFEXITED(status)) {
			logger.info("Process {} exited with status {}", wait_result, WEXITSTATUS(status));
		} else if (WIFSIGNALED(status)) {
			logger.error("Process {} was killed by signal {}", wait_result, WTERMSIG(status));
		} else if (WIFSTOPPED(status)) {
			logger.error("Process {} was stopped by signal {}", wait_result, WSTOPSIG(status));
		} else {
			logger.error("Process {} changed state", wait_result);
		}

		child_saver_pid = -1;
	}

	const auto players = game.getPlayers();
	const auto offlinePlayerGuids = flushOffline(players);
	const auto newCoinTransactions = g_accountRepository().flushCoinTransactionEntries();
	const auto guilds = game.getGuilds();

	pid_t pid = fork();
	if (pid < 0) {
		perror("Fork failed");
		throw std::runtime_error("Fork failed");
	} else if (pid == 0) {
		ResourceGuard guard;

		if (!Database::getInstance().connect()) {
			throw std::runtime_error("Failed to connect to database.");
		}

		saveAllInner({newCoinTransactions, players, offlinePlayerGuids, guilds});

		fflush(stdout);
	} else {
		child_saver_pid = pid;
	}
}
#endif

#ifdef OS_WINDOWS
void SaveManager::saveAll() {
	static bool saving = false;
	if (saving) {
		g_game().broadcastMessage(fmt::format("{} - OS_WINDOWS - cannot save during another save", __FUNCTION__), MESSAGE_ADMINISTRATOR);
		g_logger().warn("{} - OS_WINDOWS - cannot save during another save", __FUNCTION__);
		return;
	}
	saving = true;
	const auto players = game.getPlayers();
	const auto offlinePlayerGuids = flushOffline(players);
	const auto newCoinTransactions = g_accountRepository().flushCoinTransactionEntries();
	const auto guilds = game.getGuilds();

	saveAllInner({newCoinTransactions, players, offlinePlayerGuids, guilds});
	saving = false;

	fflush(stdout);
}
#endif

void SaveManager::saveAllInner(const SaveContext &context) {
	Benchmark bm_saveAll;
	logger.info("Saving server...");
	const auto newCoinTransactions = context.newCoinTransactions;
	const auto players = context.players;
	const auto offlinePlayerGuids = context.offlinePlayerGuids;
	const auto guilds = context.guilds;

	for (const auto &[_, player] : players) {
		if (!player->isLoggingOut() && !player->isOffline()) {
			player->loginPosition = player->getPosition();
		}
	}
	const auto result = DBTransaction::executeWithinTransaction([this, newCoinTransactions, players, offlinePlayerGuids, guilds] {
		for (const auto &[_, player] : players) {
			logger.warn("saving player {}",player->getName());
			savePlayer(player);
			player->account->save();
		}

		for (const auto &[_, guild] : guilds) {
			saveGuild(guild);
		}

		saveMap();
		saveKV();
		g_accountRepository().saveCoinTransactionEntries(newCoinTransactions);
		g_iomarket().save();

		setSuccesfulSaveTimestamp();
		return true;
	});
	logger.info("{} - callbackResult: {}, status: {}", __FUNCTION__, result.callbackResult, result.status);
	if (result.status == COMMITTED) {
		kv.eraseOfflineKv(offlinePlayerGuids);
		g_iomarket().cleanAfterSave();
		logger.info("Server saved in {} milliseconds.", bm_saveAll.duration());
	} else {
		logger.error("{} - Server save failed after {} seconds", __FUNCTION__, bm_saveAll.duration());
		logger.info("{} - callbackResult: {}, status: {}", __FUNCTION__, result.callbackResult, result.status);
		while(true){

		}
	}
}

void SaveManager::scheduleAll() {
	auto scheduledAt = std::chrono::steady_clock::now();
	m_scheduledAt = scheduledAt;

	// Disable save async if the config is set to false
	if (!g_configManager().getBoolean(TOGGLE_SAVE_ASYNC)) {
		saveAll();
		return;
	}

	threadPool.detach_task([this, scheduledAt]() {
		if (m_scheduledAt.load() != scheduledAt) {
			logger.warn("Skipping save for server because another save has been scheduled.");
			return;
		}
		saveAll();
	});
}

void SaveManager::savePlayer(std::shared_ptr<Player> player) {
	Benchmark bm_savePlayer;
	if (g_game().getGameState() == GAME_STATE_NORMAL) {
		logger.debug("Saving player {}.", player->getName());
	}

	IOLoginData::savePlayer(player);

	auto duration = bm_savePlayer.duration();
	logger.debug("Saving player {} took {} milliseconds.", player->getName(), duration);
}

void SaveManager::saveGuild(std::shared_ptr<Guild> guild) {
	if (!guild) {
		logger.debug("Failed to save guild because guild is null.");
		return;
	}

	Benchmark bm_saveGuild;
	logger.debug("Saving guild {}...", guild->getName());
	IOGuild::saveGuild(guild);

	auto duration = bm_saveGuild.duration();
	logger.debug("Saving guild {} took {} milliseconds.", guild->getName(), duration);
}

void SaveManager::saveMap() {
	Benchmark bm_saveMap;
	logger.debug("Saving map...");
	Map::save();

	auto duration = bm_saveMap.duration();
	logger.debug("Map saved in {} milliseconds.", duration);
}

void SaveManager::saveKV() {
	Benchmark bm_saveKV;
	logger.debug("Saving key-value store...");
	bool saveSuccess = kv.saveAll();
	if (!saveSuccess) {
		throw DatabaseException("Could not save not loaded account in function: " + std::string(__FUNCTION__));
		logger.error("Failed to save key-value store.");
	}
	auto duration = bm_saveKV.duration();
	logger.debug("Key-value store saved in {} milliseconds.", duration);
}

void SaveManager::setSuccesfulSaveTimestamp() {
	Database &db = Database::getInstance();
	std::ostringstream query;
	query.str("");
	query << "REPLACE INTO `server_config` (config, value) VALUES ('save_date', NOW())";
	db.executeQuery(query.str());
}

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
	for (const auto &[_, player] : players) {
		if (player->isLoggingOut()) {
			player->setLoggingOut(false);
			player->setOnline(false);
		} else if (!player->isOffline()) {
			player->loginPosition = player->getPosition();
		}
		if (!player->isOnline()) {
			g_game().removePlayer(std::shared_ptr<Player>(player));
			player->setRemoved();
		}
	}
	auto newCoinTransactions = g_accountRepository().flushCoinTransactionEntries();
	auto guilds = game.getGuilds();

	pid_t pid = fork();

	if (pid < 0) {
		perror("Fork failed");
		throw std::runtime_error("Fork failed");
	} else if (pid == 0) {
		ResourceGuard guard;
		Benchmark bm_saveAll;

		logger.info("Saving server...");

		if (!Database::getInstance().connect()) {
			throw std::runtime_error("Failed to connect to database.");
		}

		DBTransaction::executeWithinTransaction([this, players, newCoinTransactions, guilds] {
			for (const auto &[_, player] : players) {
				savePlayer(player);
				const auto account = player->account->save();
			}

			for (const auto &[_, guild] : guilds) {
				saveGuild(guild);
			}

			saveMap();
			saveKV();
			g_accountRepository().saveCoinTransactionEntries(newCoinTransactions);
			setSuccesfulSaveTimestamp();
			return true;
		});

		logger.info("Server saved in {} milliseconds.", bm_saveAll.duration());

		fflush(stdout);
	} else {
		child_saver_pid = pid;
	}
}
#endif

#ifdef OS_WINDOWS
void SaveManager::saveAll() {
	const auto players = game.getPlayers();
	for (const auto &[_, player] : players) {
		if (player->isLoggingOut()) {
			player->setLoggingOut(false);
			player->setOnline(false);
		} else if (!player->isOffline()) {
			player->loginPosition = player->getPosition();
		}
		if (!player->isOnline()) {
			g_game().removePlayer(std::shared_ptr<Player>(player));
			player->setRemoved();
		}
	}
	auto newCoinTransactions = g_accountRepository().flushCoinTransactionEntries();
	auto guilds = game.getGuilds();
	Benchmark bm_saveAll;

	logger.info("Saving server...");

	if (!Database::getInstance().connect()) {
		throw std::runtime_error("Failed to connect to database.");
	}

	DBTransaction::executeWithinTransaction([this, players, newCoinTransactions, guilds] {
		for (const auto &[_, player] : players) {
			savePlayer(player);
			const auto account = player->account->save();
		}

		for (const auto &[_, guild] : guilds) {
			saveGuild(guild);
		}

		saveMap();
		saveKV();
		g_accountRepository().saveCoinTransactionEntries(newCoinTransactions);
		setSuccesfulSaveTimestamp();
		return true;
	});

	logger.info("Server saved in {} milliseconds.", bm_saveAll.duration());

	fflush(stdout);
}
#endif

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

bool SaveManager::savePlayer(std::shared_ptr<Player> player) {
	if (!player) {
		logger.debug("Failed to save player because player is null.");
		return false;
	}

	Benchmark bm_savePlayer;
	m_playerMap.erase(player->getGUID());
	if (g_game().getGameState() == GAME_STATE_NORMAL) {
		logger.debug("Saving player {}.", player->getName());
	}

	bool saveSuccess = IOLoginData::savePlayer(player);
	// g_kv().savePlayer(player->getGUID());
	if (!saveSuccess) {
		logger.error("Failed to save player {}.", player->getName());
	}

	auto duration = bm_savePlayer.duration();
	logger.debug("Saving player {} took {} milliseconds.", player->getName(), duration);
	return saveSuccess;
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
	bool saveSuccess = Map::save();
	if (!saveSuccess) {
		logger.error("Failed to save map.");
	}

	auto duration = bm_saveMap.duration();
	logger.debug("Map saved in {} milliseconds.", duration);
}

void SaveManager::saveKV() {
	Benchmark bm_saveKV;
	logger.debug("Saving key-value store...");
	bool saveSuccess = kv.saveAll();
	if (!saveSuccess) {
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

/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "kv/kv.hpp"

#include "lib/di/container.hpp"
#include "database/database.hpp"

int64_t KV::lastTimestamp_ = 0;
uint64_t KV::counter_ = 0;
std::mutex KV::mutex_ = {};

KVStore &KVStore::getInstance() {
	return inject<KVStore>();
}

void KVStore::set(const std::string &key, const std::initializer_list<ValueWrapper> &init_list) {
	const ValueWrapper wrappedInitList(init_list);
	set(key, wrappedInitList);
}

void KVStore::set(const std::string &key, const std::initializer_list<std::pair<const std::string, ValueWrapper>> &init_list) {
	const ValueWrapper wrappedInitList(init_list);
	set(key, wrappedInitList);
}

void KVStore::set(const std::string &key, const ValueWrapper &value) {
	{
		std::scoped_lock lock(mutex_);
		setLocked(key, value);
	}
}

void KVStore::setLocked(const std::string &key, const ValueWrapper &value) {
	auto it = store_.find(key);
	if (it != store_.end()) {
		it->second.first = value;
		lruQueue_.splice(lruQueue_.begin(), lruQueue_, it->second.second);
	} else {
		lruQueue_.push_front(key);
		store_.try_emplace(key, std::make_pair(value, lruQueue_.begin()));
	}
}

std::optional<ValueWrapper> KVStore::get(const std::string &key, bool forceLoad /*= false*/) {
	logger.trace("KVStore::get({})", key);

	{
		std::scoped_lock lock(mutex_);
		if (!forceLoad) {
			auto it = store_.find(key);
			if (it != store_.end()) {
				auto &[value, lruIt] = it->second;
				if (value.isDeleted()) {
					lruQueue_.splice(lruQueue_.end(), lruQueue_, lruIt);
					return std::nullopt;
				}
				lruQueue_.splice(lruQueue_.begin(), lruQueue_, lruIt);
				return value;
			}
			return std::nullopt;
		}
	}

	auto value = load(key);
	if (value) {
		{
			std::scoped_lock lock(mutex_);
			setLocked(key, *value);
		}
	}
	return value;
}

std::unordered_set<std::string> KVStore::keys(const std::string &prefix /*= ""*/) {
	std::unordered_set<std::string> keys;

	{
		std::scoped_lock lock(mutex_);
		for (const auto &[key, value] : store_) {
			if (key.find(prefix) == 0 && !value.first.isDeleted()) {
				std::string suffix = key.substr(prefix.size());
				keys.insert(suffix);
			}
		}
	}

	for (const auto &key : loadPrefix(prefix)) {
		keys.insert(key);
	}

	return keys;
}

void KV::remove(const std::string &key) {
	set(key, ValueWrapper::deleted());
}

std::shared_ptr<KV> KVStore::scoped(const std::string &scope) {
	logger.trace("KVStore::scoped({})", scope);
	return std::make_shared<ScopedKV>(logger, *this, scope);
}

void KVStore::loadByPlayerGUID(uint32_t playerGUID) {
	const auto playerDotGuidPrefix = playerPrefix.data() + std::to_string(playerGUID);
	const auto &playerKeys = keys(playerDotGuidPrefix);
	for (const auto playerKey : playerKeys) {
		auto value = load(playerDotGuidPrefix + playerKey);
		if (value) {
			{
				std::scoped_lock lock(mutex_);
				setLocked(playerDotGuidPrefix + playerKey, *value);
			}
		}
	}
}

void KVStore::eraseOfflineKv(const std::vector<std::string> &justLoggedOutPlayerGuids) {
	if (justLoggedOutPlayerGuids.empty()) {
		return;
	}

	std::vector<std::string> keys_to_remove;

	store_.for_each([&](const auto& kv) {
		const std::string& key = kv.first;
		if (key.rfind(playerPrefix, 0) != 0) {
			return;
		}

		size_t dot = key.find('.', playerPrefix.size());
		if (dot == std::string::npos) {
			return;
		}

		std::string_view guid(key.data() + playerPrefix.size(), dot - playerPrefix.size());
		if (std::find(justLoggedOutPlayerGuids.begin(), justLoggedOutPlayerGuids.end(), guid) != justLoggedOutPlayerGuids.end()){
			keys_to_remove.push_back(key);
		}
	});

	for (const auto& key : keys_to_remove) {
		store_.erase(key);
	}
}

/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "account/account.hpp"

struct AccountInfo;

enum class CoinType : uint8_t;
enum class CoinTransactionType : uint8_t;

class AccountRepository {
public:
	AccountRepository() = default;
	virtual ~AccountRepository() = default;

	// Singleton - ensures we don't accidentally copy it
	AccountRepository(const AccountRepository &) = delete;
	void operator=(const AccountRepository &) = delete;

	static AccountRepository &getInstance();

	virtual bool loadByID(const uint32_t &id, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual bool loadByEmailOrName(bool oldProtocol, const std::string &emailOrName, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual bool loadBySession(const std::string &email, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual	uint32_t getNewDonationCoins(const uint32_t &id) = 0;
	virtual	void flushNewDonationCoins(const uint32_t &id) = 0;
	virtual bool save(const std::unique_ptr<AccountInfo> &accInfo) = 0;

	virtual bool getCharacterByAccountIdAndName(const uint32_t &id, const std::string &name) = 0;

	virtual bool getPassword(const uint32_t &id, std::string &password) = 0;

	// Vaigu custom
	virtual std::vector<CoinTransactionEntry> flushCoinTransactionEntries() = 0;
	virtual void saveCoinTransactionEntries(std::vector<CoinTransactionEntry> entries) = 0;

	virtual bool registerCoinsTransaction(
		const uint32_t &id,
		CoinTransactionType type,
		uint32_t coins,
		CoinType coinType,
		const std::string &description
	) = 0;
};

constexpr auto g_accountRepository = AccountRepository::getInstance;

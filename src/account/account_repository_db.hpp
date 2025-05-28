/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "account/account_repository.hpp"
#include "account/account.hpp"

enum class CoinType : uint8_t;
enum class CoinTransactionType : uint8_t;

class AccountRepositoryDB final : public AccountRepository {
public:
	AccountRepositoryDB();

	bool loadByID(const uint32_t &id, std::unique_ptr<AccountInfo> &acc) override;
	bool loadByEmailOrName(bool oldProtocol, const std::string &emailOrName, std::unique_ptr<AccountInfo> &acc) override;
	bool loadBySession(const std::string &esseionKey, std::unique_ptr<AccountInfo> &acc) override;
	bool save(const std::unique_ptr<AccountInfo> &accInfo) override;

	bool getCharacterByAccountIdAndName(const uint32_t &id, const std::string &name) override;

	bool getPassword(const uint32_t &id, std::string &password) override;

	std::vector<CoinTransactionEntry> flushCoinTransactionEntries() override;
	void saveCoinTransactionEntries(std::vector<CoinTransactionEntry> entries) override;

	bool registerCoinsTransaction(
		const uint32_t &id,
		CoinTransactionType type,
		uint32_t coins,
		CoinType coinType,
		const std::string &description
	) override;

private:
	bool load(const std::string &query, std::unique_ptr<AccountInfo> &acc);
	bool loadAccountPlayers(std::unique_ptr<AccountInfo> &acc) const;
	void setupLoyaltyInfo(std::unique_ptr<AccountInfo> &acc);
	std::vector<CoinTransactionEntry> newCoinTransactionEntries;
};

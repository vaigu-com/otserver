/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "database/database.hpp"
#include "declarations.hpp"
#include "iomarket_container.hpp"
#include "lib/di/container.hpp"
#include "config/configmanager.hpp"

class IOMarket {
public:
	IOMarket() = default;

	static IOMarket &getInstance() {
		return inject<IOMarket>();
	}

	using StatisticsMap = std::map<uint16_t, std::map<uint8_t, MarketStatistics>>;
	const StatisticsMap &getPurchaseStatistics() {
		return purchaseStatistics;
	}
	const StatisticsMap &getSaleStatistics() {
		return saleStatistics;
	}
	void save();
	void cleanAfterSave();
	void initialize();
	const MarketActiveOfferList getOffers(MarketAction_t action, uint32_t playerId);
	MarketActiveOfferList getOffers(MarketAction_t action, uint16_t itemId, uint8_t tier);
	MarketActiveOfferList getOffers(MarketAction_t action);
	const MarketHistoricOfferList getHistoricOffers(MarketAction_t action, uint32_t playerId);
	void updateStatistics();
	uint32_t countPlayerActiveOffers(uint32_t playerId) {
		return _countPlayerActiveOffers(playerId);
	}
	void createOffer(uint32_t playerId, MarketAction_t marketAction, uint32_t itemId, uint16_t amount, uint64_t price, uint8_t tier, bool anonymous, std::string playerName);
	const MarketActiveOffer getOfferByCounter(uint32_t expiryTimestamp, uint16_t counter);
	void decrementAndAppendToHistory(const MarketActiveOffer &boughtOutOffer, uint16_t boughtAmount, uint32_t acceptingPlayerId);
	void cancelAndAppendToHistory(const MarketActiveOffer &cancelledOffer);

private:
	// [uint16_t = item id, [uint8_t = item tier, MarketStatistics = structure of the statistics]]
	StatisticsMap purchaseStatistics;
	StatisticsMap saleStatistics;

	MarketActiveOfferList newActive;
	MarketActiveOfferList getNewActive() {
		return newActive;
	}
	bool initialized = false;

	MarketOfferNewContainer activeOffers;
	HistoricMarketOfferContainer historicOffers;

	static uint8_t extractTierOrZero(const std::string &string) {
		auto tier = static_cast<uint8_t>(std::atoi(string.c_str()));
		if (tier > g_configManager().getNumber(FORGE_MAX_ITEM_TIER)) {
			g_logger().error("{} - Failed to get number value {} for tier table result", __FUNCTION__, tier);
			return 0;
		}

		return tier;
	}

	MarketOfferNewContainer &getActiveOfferContainer() {
		return activeOffers;
	}
	HistoricMarketOfferContainer &getHistoricOfferContainer() {
		return historicOffers;
	}

	void commitNewHistory();
	void commitModifiedActive();
	void commitNewActive();

	void initializeActive();
	void initializeHistoric();

	void moveExpiredActiveToNewHistoric();
	static void dropZeroAmountOffers();

	void appendToNewActive(const MarketActiveOffer &offer);

	uint32_t _countPlayerActiveOffers(uint32_t playerId);

	auto _getActiveOffer(uint32_t expiryTimestamp, uint16_t counter) {
		const auto &index = getActiveOfferContainer().get<by_expiryTimestamp_counter>();
		return *index.find(std::make_tuple(expiryTimestamp, counter));
	}
	const auto _getActiveOffersIndex(MarketAction_t action, uint16_t itemId, uint8_t tier) {
		const auto &index = getActiveOfferContainer().get<by_action_itemId_tier>();
		return index.equal_range(std::make_tuple(action, itemId, tier));
	}
	const auto _getActiveOffersIndex(uint32_t playerId, MarketAction_t action) {
		const auto &index = getActiveOfferContainer().get<by_player_action>();
		return index.equal_range(std::make_tuple(playerId, action));
	}
	const auto _getActiveOffersIndex(MarketAction_t action) {
		const auto &index = getActiveOfferContainer().get<by_action>();
		return index.equal_range(action);
	}
	const auto _getHistoricOffers(uint32_t playerId, MarketAction_t action) {
		const auto &index = getHistoricOfferContainer().get<historic_by_player_action>();
		return index.equal_range(std::make_tuple(playerId, action));
	}

	const MarketHistoricOfferList getNewHistoric() {
		return newHistoric;
	}

	MarketHistoricOfferList newHistoric;
};

constexpr auto g_iomarket = IOMarket::getInstance;

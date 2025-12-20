#pragma once

#include "config/configmanager.hpp"

#include "boost/multi_index_container.hpp"
#include "boost/multi_index/hashed_index.hpp"
#include "boost/multi_index/composite_key.hpp"
#include "boost/multi_index/member.hpp"
#include "creatures/creatures_definitions.hpp"
#include "boost/multi_index/sequenced_index.hpp"
#include "database/database.hpp"

#include <google/protobuf/stubs/port.h>

using namespace boost::multi_index;

class IOMarketContainerHelper {
public:
	static void initializeMaxActiveId() {
		std::string query = "SELECT MAX(id) AS max_id FROM market_offers;";
		currentActiveId = calculateNextId(query);
	}

	static uint32_t nextActiveId() {
		currentActiveId = currentActiveId + 1;
		return currentActiveId;
	}

	static void initializeMaxHistoricId() {
		std::string query = "SELECT MAX(id) AS max_id FROM market_history;";
		currentHistoricId = calculateNextId(query);
	}

	static uint32_t nextHistoricId() {
		currentHistoricId = currentHistoricId + 1;
		return currentHistoricId;
	}

private:
	static uint32_t currentActiveId;
	static uint32_t currentHistoricId;
	static constexpr uint32_t defaultMaxId = 1U;
	static uint32_t calculateNextId(const std::string &query) {
		DBResult_ptr result = g_database().storeQuery(query);
		if (!result) {
			return defaultMaxId;
		}

		const uint32_t maxDatabaseId = result->getNumber<uint32_t>("max_id");
		const uint32_t nextId = maxDatabaseId + 1U;
		return nextId;
	}
};

static uint32_t getCurrentTimestamp() {
	auto nowTimePoint = std::chrono::system_clock::now();
	auto now = std::chrono::time_point_cast<std::chrono::seconds>(nowTimePoint).time_since_epoch().count();
	return now;
}

struct MarketHistoricOffer {
	const uint32_t id;
	const uint32_t activeOfferId;
	const MarketOfferState_t offerState;
	const MarketAction_t marketAction;
	const uint32_t playerId;

	const uint16_t itemId;
	const uint16_t amount;
	const uint64_t price;
	const uint8_t tier;
	const uint32_t expiryTimestamp;
};
using MarketHistoricOfferList = std::list<MarketHistoricOffer>;

struct MarketActiveOffer {
public:
	static MarketActiveOffer FromDatabase(uint32_t id, uint32_t playerId, MarketAction_t marketAction, uint16_t itemId, uint16_t amount, uint32_t expiryTimestamp, bool isAnonymous, uint64_t price, uint8_t tier, std::string playerName) {
		const auto state = getCurrentTimestamp() > expiryTimestamp ? OFFERSTATE_EXPIRED : OFFERSTATE_ACTIVE;
		const auto counter = (id ^ 0xABCDEF) & 0xFFFF;
		return MarketActiveOffer(id, playerId, marketAction, itemId, amount, expiryTimestamp, isAnonymous, price, tier, state, counter, std::move(playerName), false);
	}
	static MarketActiveOffer FromPlayerPacket(
		uint32_t playerId,
		MarketAction_t marketAction,
		uint16_t itemId,
		uint16_t amount,
		uint64_t price,
		uint8_t tier,
		bool isAnonymous,
		std::string playerName
	) {
		const auto id = IOMarketContainerHelper::nextActiveId();
		const auto counter = (id ^ 0xABCDEF) & 0xFFFF;
		const auto expiryTimestamp = getCurrentTimestamp() + g_configManager().getNumber(MARKET_OFFER_DURATION);

		return MarketActiveOffer(id, playerId, marketAction, itemId, amount, expiryTimestamp, isAnonymous, price, tier, OFFERSTATE_ACTIVE, counter, std::move(playerName), true);
	}
	// Runtime + database
	const uint32_t id;
	const uint32_t playerId;
	const MarketAction_t marketAction;
	const uint16_t itemId;
	uint16_t amount;

	const uint32_t expiryTimestamp;
	const bool isAnonymous;
	const uint64_t price;
	const uint8_t tier;
	const MarketOfferState_t state;

	// Runtime only
	const uint16_t counter;
	const std::string playerName;
	bool modified;

private:
	MarketActiveOffer(uint32_t id, uint32_t playerId, MarketAction_t marketAction, uint16_t itemId, uint16_t amount, uint32_t expiryTimestamp, bool isAnonymous, uint64_t price, uint8_t tier, MarketOfferState_t state, uint16_t counter, std::string playerName, bool modified) :
		id(id),
		playerId(playerId),
		marketAction(marketAction),
		itemId(itemId),
		amount(amount),
		expiryTimestamp(expiryTimestamp),
		isAnonymous(isAnonymous),
		price(price),
		tier(tier),
		state(state),
		counter(counter),
		playerName(std::move(playerName)),
		modified(modified) { }
};
using MarketActiveOfferList = std::list<MarketActiveOffer>;

struct by_id { };
struct by_expiryTimestamp_counter { };
struct by_action_itemId_tier { };
struct by_player_action { };
struct by_player { };
struct by_action { };
struct by_state { };
struct by_modified { };
struct by_all { };

using MarketOfferNewContainer = multi_index_container<
	MarketActiveOffer,
	indexed_by<
		hashed_unique<tag<by_id>, member<MarketActiveOffer, const uint32_t, &MarketActiveOffer::id>>,
		hashed_unique<tag<by_expiryTimestamp_counter>, composite_key<MarketActiveOffer, member<MarketActiveOffer, const uint32_t, &MarketActiveOffer::expiryTimestamp>, member<MarketActiveOffer, const uint16_t, &MarketActiveOffer::counter>>>,
		hashed_non_unique<tag<by_action_itemId_tier>, composite_key<MarketActiveOffer, member<MarketActiveOffer, const MarketAction_t, &MarketActiveOffer::marketAction>, member<MarketActiveOffer, const uint16_t, &MarketActiveOffer::itemId>, member<MarketActiveOffer, const uint8_t, &MarketActiveOffer::tier>>>,
		hashed_non_unique<tag<by_player_action>, composite_key<MarketActiveOffer, member<MarketActiveOffer, const uint32_t, &MarketActiveOffer::playerId>, member<MarketActiveOffer, const MarketAction_t, &MarketActiveOffer::marketAction>>>,
		hashed_non_unique<tag<by_player>, member<MarketActiveOffer, const uint32_t, &MarketActiveOffer::playerId>>,
		hashed_non_unique<tag<by_action>, member<MarketActiveOffer, const MarketAction_t, &MarketActiveOffer::marketAction>>,
		hashed_non_unique<tag<by_state>, member<MarketActiveOffer, const MarketOfferState_t, &MarketActiveOffer::state>>,
		hashed_non_unique<tag<by_modified>, member<MarketActiveOffer, const bool, &MarketActiveOffer::modified>>>>;

struct historic_by_player_action { };

using HistoricMarketOfferContainer = multi_index_container<
	MarketHistoricOffer,
	indexed_by<
		hashed_non_unique<tag<historic_by_player_action>, composite_key<MarketHistoricOffer, member<MarketHistoricOffer, const uint32_t, &MarketHistoricOffer::playerId>, member<MarketHistoricOffer, const MarketAction_t, &MarketHistoricOffer::marketAction>>>>>;

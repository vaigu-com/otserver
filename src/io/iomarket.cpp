/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "io/iomarket.hpp"

#include "config/configmanager.hpp"
#include "database/databasetasks.hpp"
#include "game/game.hpp"
#include "game/scheduling/dispatcher.hpp"
#include "game/scheduling/save_manager.hpp"
#include "io/iologindata.hpp"
#include "items/containers/inbox/inbox.hpp"
#include "creatures/players/player.hpp"

const MarketActiveOfferList IOMarket::getOffers(MarketAction_t action, uint32_t playerId) {
	MarketActiveOfferList activeOffers;
	auto &range = _getActiveOffersIndex(playerId, action);
	for (auto it = range.first; it != range.second; ++it) {
		activeOffers.push_back(*it);
	}
	return activeOffers;
}
MarketActiveOfferList IOMarket::getOffers(MarketAction_t action, uint16_t itemId, uint8_t tier) {
	MarketActiveOfferList activeOffers;
	auto &range = _getActiveOffersIndex(action, itemId, tier);
	for (auto it = range.first; it != range.second; ++it) {
		activeOffers.push_back(*it);
	}
	return activeOffers;
}

MarketActiveOfferList IOMarket::getOffers(MarketAction_t action) {
	MarketActiveOfferList activeOffers;
	auto &range = _getActiveOffersIndex(action);
	for (auto it = range.first; it != range.second; ++it) {
		activeOffers.push_back(*it);
	}
	return activeOffers;
}

const MarketHistoricOfferList IOMarket::getHistoricOffers(MarketAction_t action, uint32_t playerId) {
	MarketHistoricOfferList historicOffers;
	auto range = _getHistoricOffers(playerId, action);
	for (auto it = range.first; it != range.second; ++it) {
		historicOffers.push_back(*it);
	}
	return historicOffers;
}

const MarketActiveOffer IOMarket::getOfferByCounter(uint32_t expiryTimestamp, uint16_t counter) {
	return _getActiveOffer(expiryTimestamp, counter);
}

void IOMarket::createOffer(uint32_t playerId, MarketAction_t marketAction, uint32_t itemId, uint16_t amount, uint64_t price, uint8_t tier, bool anonymous, std::string playerName) {
	auto newOffer = MarketActiveOffer::FromPlayerPacket(
		playerId,
		marketAction,
		itemId,
		amount,
		price,
		tier,
		anonymous,
		playerName
	);
	getActiveOfferContainer().insert(newOffer);
	appendToNewActive(newOffer);
}

void IOMarket::updateStatistics() {
	auto query = fmt::format(
		"SELECT market_action, item_id, COUNT(price) AS num, MIN(price) AS min, MAX(price) AS max, SUM(price) AS sum, tier "
		"FROM market_history "
		"WHERE offer_state = '{}' "
		"GROUP BY item_id, market_action, tier",
		OFFERSTATE_ACCEPTED
	);

	DBResult_ptr result = g_database().storeQuery(query);
	if (!result) {
		return;
	}

	do {
		MarketStatistics* statistics = nullptr;
		const auto tier = extractTierOrZero(result->getString("tier"));
		auto itemId = result->getNumber<uint16_t>("item_id");
		auto marketAction = result->getNumber<uint16_t>("market_action");
		if (marketAction == CREATE_SELL__ACCEPT_BUY) {
			statistics = &purchaseStatistics[itemId][tier];
		} else if (marketAction == CREATE_BUY__ACCEPT_SELL) {
			statistics = &saleStatistics[itemId][tier];
		}

		statistics->numTransactions = result->getNumber<uint32_t>("num");
		statistics->lowestPrice = result->getNumber<uint64_t>("min");
		statistics->totalPrice = result->getNumber<uint64_t>("sum");
		statistics->highestPrice = result->getNumber<uint64_t>("max");
	} while (result->next());
}

void IOMarket::commitNewHistory() const {
	const auto &newHistory = getNewHistoric();
	if (newHistory.empty()) {
		return;
	}

	std::ostringstream query;
	query << "INSERT INTO market_history (id, active_offer_id, player_id, market_action, item_id, amount, price, expiry_timestamp, offer_state, tier) VALUES ";

	bool first = true;
	for (const auto &offer : newHistory) {
		if (!first) {
			query << ", ";
		}
		first = false;

		query << "("
			  << offer.id << ", "
			  << offer.activeOfferId << ", "
			  << offer.playerId << ", "
			  << static_cast<uint32_t>(offer.marketAction) << ", "
			  << offer.itemId << ", "
			  << offer.amount << ", "
			  << offer.price << ", "
			  << offer.expiryTimestamp << ", "
			  << static_cast<uint32_t>(offer.offerState) << ", "
			  << static_cast<uint32_t>(offer.tier)
			  << ")";
	}
	query << " ON DUPLICATE KEY UPDATE id = id";

	Database &db = Database::getInstance();
	if (!db.executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to save new historic offers");
	}
}

void IOMarket::commitDeleteBoughtoutCancelledActive() const {
	if (boughtoutCancelledActive.empty()) {
		return;
	}

	std::ostringstream query;
	query << "DELETE FROM market_offers WHERE id IN (";

	bool first = true;
	for (const auto &offer : boughtoutCancelledActive) {
		if (!first) {
			query << ", ";
		}
		query << offer.id;
		first = false;
	}

	query << ")";

	if (!Database::getInstance().executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to delete bought-out active offers");
	}
}

void IOMarket::resetModifiedStatus() {
	auto &index = getActiveOfferContainer().get<by_modified>();
	auto range = index.equal_range(true);
	if (range.first == range.second) {
		return;
	}

	for (auto it = range.first; it != range.second; ++it) {
		index.modify(it, [](MarketActiveOffer &offer) {
			offer.modified = false;
		});
	}
}

void IOMarket::commitModifiedActive() const {
	const auto &index = getActiveOfferContainer().get<by_modified>();
	auto range = index.equal_range(true);
	if (range.first == range.second) {
		return;
	}

	std::ostringstream query;
	query << "INSERT INTO market_offers (id, player_id, market_action, item_id, amount, expiry_timestamp, anonymous, price, tier) VALUES ";

	bool first = true;
	for (auto it = range.first; it != range.second; ++it) {
		const auto &offer = *it;
		if (!first) {
			query << ", ";
		}
		query << "("
			  << offer.id << ", "
			  << offer.playerId << ", "
			  << static_cast<uint32_t>(offer.marketAction) << ", "
			  << offer.itemId << ", "
			  << offer.amount << ", "
			  << offer.expiryTimestamp << ", "
			  << (offer.isAnonymous ? 1 : 0) << ", "
			  << offer.price << ", "
			  << static_cast<uint32_t>(offer.tier) << ")";
		first = false;
	}

	query << " ON DUPLICATE KEY UPDATE "
		  << "player_id=VALUES(player_id), market_action=VALUES(market_action), item_id=VALUES(item_id), "
		  << "amount=VALUES(amount), expiry_timestamp=VALUES(expiry_timestamp), anonymous=VALUES(anonymous), "
		  << "price=VALUES(price), tier=VALUES(tier)";

	if (!Database::getInstance().executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to save active modified offers");
	}
}

void IOMarket::commitNewActive() const {
	const auto &newActive = getNewActive();
	if (newActive.empty()) {
		return;
	}

	std::ostringstream query;
	query << "INSERT INTO market_offers (id, player_id, market_action, item_id, amount, expiry_timestamp, anonymous, price, tier) VALUES ";

	bool first = true;
	for (const auto &offer : newActive) {
		if (!first) {
			query << ", ";
		}
		query << "("
			  << offer.id << ", "
			  << offer.playerId << ", "
			  << static_cast<uint32_t>(offer.marketAction) << ", "
			  << offer.itemId << ", "
			  << offer.amount << ", "
			  << offer.expiryTimestamp << ", "
			  << (offer.isAnonymous ? 1 : 0) << ", "
			  << offer.price << ", "
			  << static_cast<uint32_t>(offer.tier) << ") ";
		first = false;
	}
	query << " ON DUPLICATE KEY UPDATE id = id";
	
	Database &db = Database::getInstance();
	if (!db.executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to save active new offers");
	}
}

uint32_t IOMarket::_countPlayerActiveOffers(uint32_t playerId) {
	const auto &index = getActiveOfferContainer().get<by_player>();
	return index.count(playerId);
}

void IOMarket::initializeActive() {
	std::string query = "SELECT `id`, `player_id`, `market_action`, `item_id`, `amount`, `expiry_timestamp`, `anonymous`, `price`, `tier`, "
						"(SELECT `name` FROM `players` WHERE `id` = `player_id`) AS `player_name` "
						"FROM `market_offers`";

	DBResult_ptr result = g_database().storeQuery(query);
	if (!result) {
		return;
	}

	do {
		const auto id = result->getNumber<uint32_t>("id");
		const auto price = result->getNumber<uint64_t>("price");
		const auto expiryTimestamp = result->getNumber<uint32_t>("expiry_timestamp");
		const auto amount = result->getNumber<uint16_t>("amount");

		const auto itemId = result->getNumber<uint16_t>("item_id");
		const auto tier = extractTierOrZero(result->getString("tier"));
		const auto isAnonymous = result->getNumber<uint16_t>("anonymous") == 1;
		const auto playerName = isAnonymous ? "Anonymous" : result->getString("player_name");

		const auto marketAction = result->getNumber<MarketAction_t>("market_action");
		const auto playerId = result->getNumber<uint16_t>("player_id");

		MarketActiveOffer offer = MarketActiveOffer::FromDatabase(
			id,
			playerId,
			marketAction,
			itemId,
			amount,
			expiryTimestamp,
			isAnonymous,
			price,
			tier,
			playerName
		);

		getActiveOfferContainer().insert(offer);
	} while (result->next());
}

void IOMarket::initializeHistoric() {
	std::string query = "SELECT `id`, `active_offer_id`, `player_id`, `market_action`, `item_id`, `amount`, `price`, `expiry_timestamp`, `offer_state`, `tier` "
						"FROM `market_history`";

	DBResult_ptr result = g_database().storeQuery(query);
	if (!result) {
		return;
	}

	do {
		const auto id = result->getNumber<uint32_t>("id");
		const auto activeOfferId = result->getNumber<uint32_t>("active_offer_id");
		const auto playerId = result->getNumber<uint16_t>("player_id");
		const auto marketAction = result->getNumber<MarketAction_t>("market_action");
		const auto itemId = result->getNumber<uint16_t>("item_id");
		const auto amount = result->getNumber<uint16_t>("amount");
		const auto price = result->getNumber<uint64_t>("price");
		const auto expiryTimestamp = result->getNumber<uint32_t>("expiry_timestamp");
		const auto offerState = result->getNumber<MarketOfferState_t>("offer_state");
		const auto tier = extractTierOrZero(result->getString("tier"));

		MarketHistoricOffer offer = MarketHistoricOffer(
			id,
			activeOfferId,
			offerState,
			marketAction,
			playerId,
			itemId,
			amount,
			price,
			tier,
			expiryTimestamp
		);

		getHistoricOfferContainer().insert(offer);
	} while (result->next());
}

void IOMarket::addRemainingItemToOwner(const MarketHistoricOffer &historicOffer) {
	const auto &player = g_game().getPlayerByGUID(historicOffer.playerId, true);
	if (!player) {
		g_logger().error("{} - cannot add item {} to unexisting player id {}", __FUNCTION__, historicOffer.itemId, historicOffer.playerId);
		return;
		//throw IOMarketException(fmt::format("{} - cannot add item {} to unexisting player id {}", __FUNCTION__, historicOffer.itemId, historicOffer.playerId));
	}

	if (historicOffer.marketAction == MarketAction_t::CANCEL_SELL) {
		const ItemType &itemType = Item::items[historicOffer.itemId];
		if (itemType.id == 0) {
			g_logger().error("{} - cannot add unexisting itemType {} to player id {}", __FUNCTION__, historicOffer.itemId, historicOffer.playerId);
			throw IOMarketException(fmt::format("{} - cannot add unexisting itemType {} to player id {}", __FUNCTION__, historicOffer.itemId, historicOffer.playerId));
		}

		const auto &playerInbox = player->getInbox();

		if (itemType.stackable) {
			uint16_t tmpAmount = historicOffer.amount;
			while (tmpAmount > 0) {
				uint16_t stackCount = std::min<uint16_t>(100, tmpAmount);
				const auto &item = Item::CreateItem(itemType.id, stackCount);
				if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
					g_logger().error("[{}] Ocurred an error to add item with id {} to player {}", __FUNCTION__, itemType.id, player->getName());

					break;
				}

				if (historicOffer.tier != 0) {
					item->setAttribute(ItemAttribute_t::TIER, historicOffer.tier);
				}

				tmpAmount -= stackCount;
			}
		} else {
			int32_t subType;
			if (itemType.charges != 0) {
				subType = itemType.charges;
			} else {
				subType = -1;
			}

			for (uint16_t i = 0; i < historicOffer.amount; ++i) {
				const auto &item = Item::CreateItem(itemType.id, subType);
				if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
					break;
				}

				if (historicOffer.tier != 0) {
					item->setAttribute(ItemAttribute_t::TIER, historicOffer.tier);
				}
			}
		}
	} else if (historicOffer.marketAction == MarketAction_t::CANCEL_BUY) {
		uint64_t totalPrice = historicOffer.price * historicOffer.amount;
		player->setBankBalance(player->getBankBalance() + totalPrice);
	}
}

void IOMarket::moveExpiredActiveToNewHistoric() {
	auto &index = getActiveOfferContainer().get<by_state>();
	auto range = index.equal_range(OFFERSTATE_EXPIRED);
	for (auto it = range.first; it != range.second;) {
		const auto historicOffer = MarketHistoricOffer(
			IOMarketContainerHelper::nextHistoricId(),
			it->id,
			OFFERSTATE_EXPIRED,
			it->marketAction,
			it->playerId,
			it->itemId,
			it->amount,
			it->price,
			it->tier,
			getCurrentTimestamp()
		);
		addRemainingItemToOwner(historicOffer);
		newHistoric.push_back(historicOffer);
		it = index.erase(it);
	}
}

void IOMarket::dropExpiredActive(){
	std::ostringstream query;
	query << "DELETE FROM `market_offers` WHERE UNIX_TIMESTAMP() > `expiry_timestamp`";
	Database &db = Database::getInstance();
	if (!db.executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to drop expired active offers");
	}
}

void IOMarket::dropZeroAmountOffers() {
	std::ostringstream query;
	query << "DELETE FROM `market_offers` WHERE `amount` = 0";
	Database &db = Database::getInstance();
	if (!db.executeQuery(query.str())) {
		throw DatabaseException("[" + std::string(__FUNCTION__) + "] - Failed to drop zero amount active offers");
	}
}

void IOMarket::initialize() {
	if (initialized) {
		return;
	}

	dropZeroAmountOffers();

	initializeActive();
	IOMarketContainerHelper::initializeMaxActiveId();

	initializeHistoric();
	IOMarketContainerHelper::initializeMaxHistoricId();

	moveExpiredActiveToNewHistoric();
	dropExpiredActive();

	initialized = true;
}

void IOMarket::decrementAndAppendToHistory(const MarketActiveOffer &boughtOutOffer, uint16_t boughtAmount, uint32_t acceptingPlayerId = 0) {
	auto &index = getActiveOfferContainer().get<by_id>();
	auto it = index.find(boughtOutOffer.id);
	if (it != index.end()) {
		const auto historicOfferCreator = MarketHistoricOffer(
			IOMarketContainerHelper::nextHistoricId(),
			it->id,
			OFFERSTATE_ACCEPTED,
			it->marketAction,
			it->playerId,
			it->itemId,
			boughtAmount,
			it->price,
			it->tier,
			getCurrentTimestamp()
		);
		newHistoric.push_back(historicOfferCreator);
		getHistoricOfferContainer().insert(historicOfferCreator);

		if (acceptingPlayerId != 0) {
			const auto historicOfferAcceptor = MarketHistoricOffer(
				IOMarketContainerHelper::nextHistoricId(),
				it->id,
				OFFERSTATE_ACCEPTED,
				it->marketAction == ACCEPT_BUY ? ACCEPT_SELL : ACCEPT_BUY,
				acceptingPlayerId,
				it->itemId,
				boughtAmount,
				it->price,
				it->tier,
				getCurrentTimestamp()
			);
			newHistoric.push_back(historicOfferAcceptor);
			getHistoricOfferContainer().insert(historicOfferCreator);
		}

		index.modify(it, [boughtAmount = boughtAmount](MarketActiveOffer &offer) {
			offer.amount = offer.amount - boughtAmount;
			offer.modified = true;
		});

		if (it->amount - boughtAmount <= 0) {
			boughtoutCancelledActive.push_back(*it);
			getActiveOfferContainer().erase(it);
		}
	}
}

void IOMarket::appendToNewActive(const MarketActiveOffer &offer) {
	newActive.push_back(offer);
}

void IOMarket::cancelAndAppendToHistory(const MarketActiveOffer &cancelledOffer) {
	auto &index = getActiveOfferContainer().get<by_id>();
	auto it = index.find(cancelledOffer.id);
	if (it != index.end()) {
		const auto historicOffer = MarketHistoricOffer(
			IOMarketContainerHelper::nextHistoricId(),
			it->id,
			OFFERSTATE_CANCELLED,
			it->marketAction,
			it->playerId,
			it->itemId,
			it->amount,
			it->price,
			it->tier,
			getCurrentTimestamp()
		);
		addRemainingItemToOwner(historicOffer);
		newHistoric.push_back(historicOffer);
		getHistoricOfferContainer().insert(historicOffer);
		boughtoutCancelledActive.push_back(cancelledOffer);
		getActiveOfferContainer().erase(it);
	}
}

void IOMarket::save() {
	commitNewHistory();

	commitDeleteBoughtoutCancelledActive();

	commitNewActive();

	commitModifiedActive();
	resetModifiedStatus();
}

void IOMarket::cleanAfterSave() {
	newHistoric.clear();
	newActive.clear();
}

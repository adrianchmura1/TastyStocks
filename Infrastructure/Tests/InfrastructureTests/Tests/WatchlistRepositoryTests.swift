//
//  WatchlistRepositoryTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
import WatchlistDomain
@testable import WatchlistInfrastructure

final class WatchlistRepositoryTests: XCTestCase {
    func testFetchActiveWatchlist() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let activeWatchlist = Watchlist(name: "Active Watchlist")
        database.setActive(id: activeWatchlist.id)
        database.addWatchlist(activeWatchlist)

        let stockDataResponse = [StockDataResponse(
            quote: QuoteResponse(
                latestPrice: 2,
                symbol: "AAPL",
                askPrice: 4.1,
                bidPrice: 4.0
            ))
        ]
        restService.refreshResult = .success(stockDataResponse)

        let expectation = XCTestExpectation(description: "Fetch active watchlist completion")

        // Act
        repository.fetchActiveWatchlist { result in
            // Assert
            switch result {
            case .success(let watchlist):
                XCTAssertEqual(watchlist, activeWatchlist)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testAddWatchlist() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let watchlist = Watchlist(name: "New Watchlist")

        // Act
        repository.addWatchlist(watchlist)

        // Assert
        XCTAssertTrue(database.watchlists.contains(where: { $0.id == watchlist.id }))
        XCTAssertEqual(database.activeWatchlistId, watchlist.id)
    }

    func testAddToActiveWatchlist() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let activeWatchlist = Watchlist(name: "Active Watchlist")
        database.setActive(id: activeWatchlist.id)
        database.addWatchlist(activeWatchlist)

        let symbolToAdd = "AAPL"

        // Act
        repository.addToActiveWatchlist(symbol: symbolToAdd)

        // Assert
        XCTAssertTrue(database.activeWatchlist!.quotes.contains(where: { $0.symbol == symbolToAdd }))
    }

    func testRemoveFromActive() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let activeWatchlist = Watchlist(name: "Active Watchlist")
        database.setActive(id: activeWatchlist.id)
        database.addWatchlist(activeWatchlist)

        let symbolToRemove = "AAPL"
        database.addToActive(symbol: symbolToRemove)

        // Act
        repository.removeFromActive(symbol: symbolToRemove)

        // Assert
        XCTAssertFalse(activeWatchlist.quotes.contains(where: { $0.symbol == symbolToRemove }))
    }

    func testRemoveWatchlist() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let watchlist1 = Watchlist(name: "Watchlist 1")
        let watchlist2 = Watchlist(name: "Watchlist 2")

        database.addWatchlist(watchlist1)
        database.addWatchlist(watchlist2)

        let watchlistToRemoveId = watchlist1.id

        // Act
        repository.removeWatchlist(id: watchlistToRemoveId)

        // Assert
        XCTAssertNil(database.watchlists.first(where: { $0.id == watchlistToRemoveId }))
    }

    func testSetActive() {
        // Arrange
        let database = MockWatchlistDatabase()
        let restService = MockWatchlistRestService()
        let repository = WatchlistRepository(database: database, restService: restService)

        let watchlist1 = Watchlist(name: "Watchlist 1")
        let watchlist2 = Watchlist(name: "Watchlist 2")

        database.addWatchlist(watchlist1)
        database.addWatchlist(watchlist2)

        let watchlistToSetActiveId = watchlist1.id

        // Act
        repository.setActive(id: watchlistToSetActiveId)

        // Assert
        XCTAssertEqual(database.activeWatchlistId, watchlistToSetActiveId)
        XCTAssertEqual(database.activeWatchlist?.id, watchlistToSetActiveId)
    }
}

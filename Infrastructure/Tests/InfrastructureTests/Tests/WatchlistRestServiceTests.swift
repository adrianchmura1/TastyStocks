//
//  WatchlistRestServiceTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import WatchlistDomain
@testable import WatchlistInfrastructure
import XCTest

final class WatchlistRestServiceTests: XCTestCase {
    var watchlistRestService: WatchlistRestService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        watchlistRestService = WatchlistRestService(networkService: mockNetworkService)
    }

    override func tearDown() {
        watchlistRestService = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testRefreshSuccess() {
        let mockResponse: [String: StockDataResponse] = [
            "AAPL": StockDataResponse(quote: QuoteResponse(latestPrice: 11, symbol: "AAPL", askPrice: 12, bidPrice: 13)),
            "MSFT": StockDataResponse(quote: QuoteResponse(latestPrice: 10, symbol: "MSFT", askPrice: 9, bidPrice: 8))
        ]

        mockNetworkService.expectedResult = Result<[String: StockDataResponse], Error>.success(mockResponse)

        let sampleWatchlist = Watchlist(name: "My Watchlist", quotes: [Quote(symbol: "AAPL"), Quote(symbol: "MSFT")])

        watchlistRestService.refresh(watchlist: sampleWatchlist) { result in
            switch result {
            case .success(let stockData):
                XCTAssertEqual(stockData.count, 2)
                let apple = stockData.first(where: { $0.quote.symbol == "AAPL" })!
                let msft = stockData.first(where: { $0.quote.symbol == "MSFT" })!

                XCTAssertEqual(apple.quote.latestPrice, 11)
                XCTAssertEqual(apple.quote.askPrice, 12)
                XCTAssertEqual(apple.quote.bidPrice, 13)
                XCTAssertEqual(msft.quote.latestPrice, 10)
                XCTAssertEqual(msft.quote.askPrice, 9)
                XCTAssertEqual(msft.quote.bidPrice, 8)
            case .failure:
                XCTFail("Refreshing watchlist unexpectedly failed.")
            }
        }
    }

    func testRefreshFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkService.expectedResult = Result<[String: StockDataResponse], Error>.failure(expectedError)

        let sampleWatchlist = Watchlist(name: "My Watchlist", quotes: [Quote(symbol: "AAPL"), Quote(symbol: "MSFT")])

        watchlistRestService.refresh(watchlist: sampleWatchlist) { result in
            switch result {
            case .success:
                XCTFail("Refreshing watchlist unexpectedly succeeded.")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, expectedError)
            }
        }
    }
}

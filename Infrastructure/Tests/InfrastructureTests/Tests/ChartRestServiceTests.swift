//
//  ChartRestServiceTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistInfrastructure
import WatchlistDomain

final class ChartRestServiceTests: XCTestCase {
    var chartRestService: ChartRestService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        chartRestService = ChartRestService(networkService: mockNetworkService)
    }

    override func tearDown() {
        chartRestService = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchHistoricalDataSuccess() {
        let mockResponse = [
            SymbolQuotesDataResponse(open: 100.0, close: 110.0, high: 120.0, low: 90.0),
            SymbolQuotesDataResponse(open: 120.0, close: 130.0, high: 140.0, low: 110.0)
        ]

        mockNetworkService.expectedResult = Result<[SymbolQuotesDataResponse], Error>.success(mockResponse)

        chartRestService.fetchHistoricalData(for: "AAPL") { result in
            switch result {
            case .success(let symbolPriceHistory):
                XCTAssertEqual(symbolPriceHistory.days.count, mockResponse.count)
            case .failure:
                XCTFail("Fetching historical data unexpectedly failed.")
            }
        }
    }

    func testFetchHistoricalDataFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkService.expectedResult = Result<[SymbolQuotesDataResponse], Error>.failure(expectedError)

        chartRestService.fetchHistoricalData(for: "AAPL") { result in
            switch result {
            case .success:
                XCTFail("Fetching historical data unexpectedly succeeded.")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, expectedError)
            }
        }
    }
}

//
//  SymbolHistoryRepositoryTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import XCTest
import WatchlistDomain
@testable import WatchlistInfrastructure

final class SymbolHistoryRepositoryTests: XCTestCase {
    func testFetchLatestPriceSuccess() {
        // Arrange
        let mockSymbol = "AAPL"
        let mockPriceHistory = SymbolPriceHistory(days: [DayPriceInfo(open: 150.0, close: 152.5, high: 155.0, low: 149.0)])
        let mockRestService = MockChartRestService()
        mockRestService.fetchHistoricalDataResult = .success(mockPriceHistory)

        let repository = SymbolHistoryRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Fetch latest price completion")

        // Act
        repository.fetchLatestPrice(for: mockSymbol) { result in
            // Assert
            switch result {
            case .success(let priceHistory):
                XCTAssertEqual(priceHistory, mockPriceHistory)
            case .failure:
                XCTFail("Expected success, but got failure.")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchLatestPriceFailure() {
        // Arrange
        let mockSymbol = "AAPL"
        let mockError = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        let mockRestService = MockChartRestService()
        mockRestService.fetchHistoricalDataResult = .failure(mockError)

        let repository = SymbolHistoryRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Fetch latest price completion")

        // Act
        repository.fetchLatestPrice(for: mockSymbol) { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure, but got success.")
            case .failure(let error):
                XCTAssertEqual(error as NSError, mockError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

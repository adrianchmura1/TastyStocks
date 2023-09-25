//
//  GetSymbolHistoryUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class GetSymbolHistoryUseCaseTests: XCTestCase {
    var getSymbolHistory: GetSymbolHistoryUseCase!
    var symbolHistoryRepository: MockSymbolHistoryRepository!

    override func setUp() {
        super.setUp()

        symbolHistoryRepository = MockSymbolHistoryRepository()
        getSymbolHistory = GetSymbolHistoryUseCase(repository: symbolHistoryRepository)
    }

    override func tearDown() {
        getSymbolHistory = nil
        symbolHistoryRepository = nil

        super.tearDown()
    }

    func testSuccess() {
        // Arrange
        let expectedDays = [DayPriceInfo(open: 100, close: 110, high: 120, low: 90)]
        symbolHistoryRepository.mockResult = .success(SymbolPriceHistory(days: expectedDays))

        // Act
        var resultDays: [DayPriceInfo]?
        var resultError: Error?

        let expectation = XCTestExpectation(description: "Completion called")
        getSymbolHistory.execute(for: "AAPL") { result in
            switch result {
            case .success(let history):
                resultDays = history.days
            case .failure(let error):
                resultError = error
            }
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNil(resultError, "Expected no error")
        XCTAssertEqual(resultDays, expectedDays, "Expected days to match")
    }

    func testFailure() {
        // Arrange
        symbolHistoryRepository.mockResult = .failure(MockSymbolHistoryRepository.MockError.unknown)

        // Act
        var resultDays: [DayPriceInfo]?
        var resultError: Error?

        let expectation = XCTestExpectation(description: "Completion called")
        getSymbolHistory.execute(for: "INVALID_SYMBOL") { result in
            switch result {
            case .success(let history):
                resultDays = history.days
            case .failure(let error):
                resultError = error
            }
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNotNil(resultError, "Expected an error")
        XCTAssertEqual(resultError as? MockSymbolHistoryRepository.MockError, MockSymbolHistoryRepository.MockError.unknown, "Expected unknown error")
        XCTAssertNil(resultDays, "Expected no days")
    }
}

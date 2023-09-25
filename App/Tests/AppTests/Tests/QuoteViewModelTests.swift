//
//  QuoteViewModelTests.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import XCTest
@testable import Watchlist
import WatchlistDomain

final class QuoteViewModelTests: XCTestCase {
    var viewModel: QuoteViewModel!
    var mockGetSymbolHistoryUseCase: MockGetSymbolHistoryUseCase!
    var mockGetQuoteUseCase: MockGetQuoteUseCase!
    var mockBackgroundQueue: MockQueue!
    var mockMainQueue: MockQueue!

    override func setUp() {
        super.setUp()

        mockGetSymbolHistoryUseCase = MockGetSymbolHistoryUseCase()
        mockGetQuoteUseCase = MockGetQuoteUseCase()
        mockBackgroundQueue = MockQueue()
        mockMainQueue = MockQueue()

        viewModel = QuoteViewModel(
            symbol: "AAPL",
            interactor: QuoteInteractor(
                getSymbolHistoryUseCaseProtocol: mockGetSymbolHistoryUseCase,
                getQuoteUseCase: mockGetQuoteUseCase
            ),
            backgroundQueue: mockBackgroundQueue,
            mainQueue: mockMainQueue
        )
    }

    func testOnAppearCallsStartLoading() {
        // Arrange
        let expectation = XCTestExpectation(description: "Start Loading Called")

        viewModel.action = { action in
            if case .startLoading = action {
                expectation.fulfill()
            }
        }

        // Act
        viewModel.onAppear()

        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testOnAppearCallsFetchChartData() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch Chart Data Called")

        mockGetSymbolHistoryUseCase.result = .success(SymbolPriceHistory(days: []))

        viewModel.action = { action in
            if case .finishLoading = action {
                expectation.fulfill()
            }
        }

        // Act
        viewModel.onAppear()

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockBackgroundQueue.asyncCalled)
        XCTAssertTrue(mockMainQueue.asyncCalled)
    }
}

class MockGetSymbolHistoryUseCase: GetSymbolHistoryUseCaseProtocol {
    struct MockError: Error {}

    var executeCalled = false
    var result: Result<SymbolPriceHistory, Error> = .failure(MockError())

    func execute(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        executeCalled = true
        completion(result)
    }
}

class MockGetQuoteUseCase: GetQuoteUseCaseProtocol {
    struct MockError: Error {}

    var executeCalled = false
    var result: Result<Quote, Error> = .failure(MockError())

    func execute(for symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        executeCalled = true
        completion(result)
    }
}

//
//  AddQuoteViewModelTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import Watchlist
import WatchlistDomain

final class AddQuoteViewModelTests: XCTestCase {
    var viewModel: AddQuoteViewModel!
    var mockSearchQuotesUseCase: MockSearchQuotesUseCase!

    override func setUp() {
        super.setUp()

        mockSearchQuotesUseCase = MockSearchQuotesUseCase()
        viewModel = AddQuoteViewModel(
            interactor: AddQuoteInteractor(
                searchQuotesUseCase: mockSearchQuotesUseCase,
                addSymbolUseCaseProtocol: MockAddSymbolUseCase()
            )
        )
    }

    func testFilterStockQuotesWithEmptyText() {
        // Arrange
        let searchText = ""

        // Act
        viewModel.filterStockQuotes(with: searchText)

        // Assert
        XCTAssertEqual(self.viewModel.filteredQuotes, [])
    }

    func testFilterStockQuotesWithNonEmptyText() {
        // Arrange
        let searchText = "AAPL"
        let mockedQuotes: [QuoteSearchResult] = [
            QuoteSearchResult(symbol: "AAPL", name: "Apple Inc."),
            QuoteSearchResult(symbol: "MSFT", name: "Microsoft Corporation")
        ]
        mockSearchQuotesUseCase.results = .success(mockedQuotes)
        let expectation = XCTestExpectation(description: "Filter Stock Quotes")

        // Act
        viewModel.filterStockQuotes(with: searchText)

        // Assert
        viewModel.action = { action in
            switch action {
            case .reload:
                XCTAssertEqual(self.viewModel.filteredQuotes.count, 2)
                XCTAssertEqual(self.viewModel.filteredQuotes[0].symbol, "AAPL")
                XCTAssertEqual(self.viewModel.filteredQuotes[1].symbol, "MSFT")
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

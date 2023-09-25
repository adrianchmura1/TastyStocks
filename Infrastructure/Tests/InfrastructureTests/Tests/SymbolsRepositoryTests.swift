//
//  SymbolsRepositoryTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain
import XCTest
@testable import WatchlistInfrastructure

final class SymbolsRepositoryTests: XCTestCase {
    func testFindSymbolSuccess() {
        // Arrange
        let searchText = "AAPL"
        let mockSearchResults: [WatchlistDomain.QuoteSearchResult] = [
            WatchlistDomain.QuoteSearchResult(symbol: "AAPL", name: "Apple Inc."),
            WatchlistDomain.QuoteSearchResult(symbol: "MSFT", name: "Microsoft Corporation")
        ]

        let mockRestService = MockSymbolsRestService()
        mockRestService.findSymbolResult = .success(mockSearchResults) // Set the result

        let repository = SymbolsRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Find symbol completion")

        // Act
        repository.findSymbol(text: searchText) { result in
            // Assert
            switch result {
            case .success(let searchResults):
                XCTAssertEqual(searchResults, mockSearchResults)
            case .failure:
                XCTFail("Expected success, but got failure.")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFindSymbolFailure() {
        // Arrange
        let searchText = "AAPL"
        let mockError = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)

        let mockRestService = MockSymbolsRestService()
        mockRestService.findSymbolResult = .failure(mockError)

        let repository = SymbolsRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Find symbol completion")

        // Act
        repository.findSymbol(text: searchText) { result in
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

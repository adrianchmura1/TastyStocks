//
//  File.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class GetQuoteUseCaseTests: XCTestCase {
    func testGetQuote_Success() {
        // Arrange
        let expectedQuote = Quote(symbol: "AAPL", bid: "150.0", ask: "155.0", last: "152.5")
        let repositoryMock = QuoteRepositoryMock()
        repositoryMock.mockResult = .success(expectedQuote)
        let useCase = GetQuoteUseCase(repository: repositoryMock)

        var receivedQuote: Quote?
        var receivedError: Error?

        // Act
        useCase.execute(for: "AAPL") { result in
            switch result {
            case .success(let quote):
                receivedQuote = quote
            case .failure(let error):
                receivedError = error
            }
        }

        // Assert
        XCTAssertNil(receivedError)
        XCTAssertNotNil(receivedQuote)
        XCTAssertEqual(receivedQuote, expectedQuote)
    }

    func testGetQuote_Failure() {
        // Arrange
        let expectedError = QuoteRepositoryMock.MockError.unknown
        let repositoryMock = QuoteRepositoryMock()
        repositoryMock.mockResult = .failure(expectedError)
        let useCase = GetQuoteUseCase(repository: repositoryMock)

        var receivedQuote: Quote?
        var receivedError: Error?

        // Act
        useCase.execute(for: "AAPL") { result in
            switch result {
            case .success(let quote):
                receivedQuote = quote
            case .failure(let error):
                receivedError = error
            }
        }

        // Assert
        XCTAssertNil(receivedQuote)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(receivedError as? QuoteRepositoryMock.MockError, expectedError)
    }
}

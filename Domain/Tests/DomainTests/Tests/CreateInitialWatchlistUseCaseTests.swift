//
//  CreateInitialWatchlistUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class CreateInitialWatchlistUseCaseTests: XCTestCase {
    func testExecute_WhenCreatingInitialWatchlistSucceeds_ReturnsInitialWatchlist() {
        // Arrange
        let initialWatchlistName = "My first list"
        let quotes = [Quote(symbol: "AAPL"), Quote(symbol: "MSFT"), Quote(symbol: "GOOG")]
        let expectedWatchlist = Watchlist(name: initialWatchlistName, quotes: quotes)

        let repositoryMock = MockWatchlistRepository()
        repositoryMock.mockedWatchlist = expectedWatchlist

        let useCase = CreateInitialWatchlistUseCase(repository: repositoryMock)

        var executionResult: Result<Watchlist?, Error>?

        // Act
        let expectation = self.expectation(description: "Create Initial Watchlist")
        useCase.execute { result in
            executionResult = result
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)

        // Assert
        guard case .success(let createdWatchlist) = executionResult else {
            XCTFail("Expected a success result")
            return
        }

        XCTAssertEqual(createdWatchlist, expectedWatchlist)
        XCTAssertTrue(repositoryMock.addWatchlistCalled)
    }
}

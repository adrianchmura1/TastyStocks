//
//  GetActiveWatchlistUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class GetActiveWatchlistUseCaseTests: XCTestCase {
    func testExecute_RepositoryReturnsActiveWatchlist() {
        // Arrange
        let expectedWatchlist = Watchlist(name: "My Watchlist", quotes: [Quote(symbol: "AAPL")])
        let repositoryMock = MockWatchlistRepository()
        repositoryMock.mockedWatchlist = expectedWatchlist

        var createInitialWatchlistUseCase = MockCreateInitialWatchlistUseCase(repository: repositoryMock)

        let useCase = GetActiveWatchlistUseCase(repository: repositoryMock, createInitialWatchlistUseCase: createInitialWatchlistUseCase)

        let expectation = XCTestExpectation(description: "Get active watchlist")

        var receivedWatchlist: Watchlist?
        var receivedError: Error?

        // Act
        useCase.execute { result in
            switch result {
            case .success(let watchlist):
                receivedWatchlist = watchlist
            case .failure(let error):
                receivedError = error
            }
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)

        XCTAssertNil(receivedError)
        XCTAssertEqual(receivedWatchlist, expectedWatchlist)
    }

    func testExecute_RepositoryReturnsNil() {
        // Arrange
        let repositoryMock = MockWatchlistRepository()
        repositoryMock.mockedWatchlist = nil
        let createInitialWatchlistUseCase = MockCreateInitialWatchlistUseCase(repository: repositoryMock)
        let useCase = GetActiveWatchlistUseCase(repository: repositoryMock, createInitialWatchlistUseCase: createInitialWatchlistUseCase)
        let expectation = XCTestExpectation(description: "Get active watchlist")
        var receivedError: Error?

        // Act
        useCase.execute { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                receivedError = error
            }
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)

        XCTAssertNil(receivedError)
        XCTAssertTrue(createInitialWatchlistUseCase.isCalled)
    }
}

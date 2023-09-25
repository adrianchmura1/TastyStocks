//
//  AddWatchlistUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class AddWatchlistUseCaseTests: XCTestCase {
    func testExecute_WhenAddingWatchlistSucceeds_ReturnsSuccess() {
        // Arrange
        let watchlistToAdd = Watchlist(name: "Test Watchlist", quotes: [])
        let repositoryMock = MockWatchlistRepository()
        let useCase = AddWatchlistUseCase(watchlistRepository: repositoryMock)

        // Act
        useCase.execute(watchlist: watchlistToAdd)

        // Assert
        XCTAssertTrue(repositoryMock.addWatchlistCalled)
        XCTAssertEqual(repositoryMock.addWatchlistParameter?.name, watchlistToAdd.name)
        XCTAssertEqual(repositoryMock.addWatchlistParameter?.quotes, watchlistToAdd.quotes)
    }
}

//
//  GetActiveWatchlistIdUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class GetActiveWatchlistIdUseCaseTests: XCTestCase {
    func testExecute_WhenRepositoryHasActiveWatchlistId_ReturnsWatchlistId() {
        // Arrange
        let expectedWatchlistId = "watchlist123"
        let repositoryMock = MockWatchlistRepository()
        repositoryMock.activeWatchlistId = expectedWatchlistId

        let useCase = GetActiveWatchlistIdUseCase(repository: repositoryMock)

        // Act
        let result = useCase.execute()

        // Assert
        XCTAssertEqual(result, expectedWatchlistId)
    }

    func testExecute_WhenRepositoryHasNoActiveWatchlistId_ReturnsNil() {
        // Arrange
        let repositoryMock = MockWatchlistRepository()
        repositoryMock.activeWatchlistId = nil

        let useCase = GetActiveWatchlistIdUseCase(repository: repositoryMock)

        // Act
        let result = useCase.execute()

        // Assert
        XCTAssertNil(result)
    }
}

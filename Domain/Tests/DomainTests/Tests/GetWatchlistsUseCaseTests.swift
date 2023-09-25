//
//  GetWatchlistsUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class GetWatchlistsUseCaseTests: XCTestCase {
    var useCase: GetWatchlistsUseCase!
    var mockRepository: MockWatchlistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockWatchlistRepository()
        useCase = GetWatchlistsUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testExecute_ReturnsWatchlistsFromRepository() {
        // Arrange
        let expectedWatchlists: [Watchlist] = [
            Watchlist(id: "1", name: "Watchlist 1", quotes: []),
            Watchlist(id: "2", name: "Watchlist 2", quotes: []),
            Watchlist(id: "3", name: "Watchlist 3", quotes: [])
        ]
        mockRepository.watchlists = expectedWatchlists

        // Act
        let resultWatchlists = useCase.execute()

        // Assert
        XCTAssertEqual(resultWatchlists, expectedWatchlists)
    }

    func testExecute_ReturnsEmptyArrayWhenRepositoryHasNoWatchlists() {
        // Arrange
        mockRepository.watchlists = []

        // Act
        let resultWatchlists = useCase.execute()

        // Assert
        XCTAssertTrue(resultWatchlists.isEmpty)
    }
}

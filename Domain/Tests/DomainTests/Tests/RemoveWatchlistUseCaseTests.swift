//
//  RemoveWatchlistUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

class RemoveWatchlistUseCaseTests: XCTestCase {
    var useCase: RemoveWatchlistUseCase!
    var mockRepository: MockWatchlistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockWatchlistRepository()
        useCase = RemoveWatchlistUseCase(repository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testExecute_RemovesWatchlistFromRepository() {
        // Arrange
        let watchlistIdToRemove = "123"

        // Act
        useCase.execute(for: watchlistIdToRemove)

        // Assert
        XCTAssertTrue(mockRepository.removeWatchlistCalled)
        XCTAssertEqual(mockRepository.removeWatchlistID, watchlistIdToRemove)
    }
}

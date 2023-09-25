//
//  SwitchWatchlistUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

class SwitchWatchlistUseCaseTests: XCTestCase {
    var useCase: SwitchWatchlistUseCase!
    var mockRepository: MockWatchlistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockWatchlistRepository()
        useCase = SwitchWatchlistUseCase(repository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testExecuteShouldSetWatchlistActive() {
        // Arrange
        let watchlistID = "123"

        // Act
        useCase.execute(for: watchlistID)

        // Assert
        XCTAssertTrue(mockRepository.setActiveCalled)
        XCTAssertEqual(mockRepository.setActiveID, watchlistID)
    }
}

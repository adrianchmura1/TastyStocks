//
//  RemoveSymbolUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

final class RemoveSymbolUseCaseTests: XCTestCase {
    var useCase: RemoveSymbolUseCase!
    var mockRepository: MockWatchlistRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockWatchlistRepository()
        useCase = RemoveSymbolUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testExecute_RemovesSymbolFromActiveWatchlist() {
        // Arrange
        let symbolToRemove = "AAPL"

        // Act
        useCase.execute(for: symbolToRemove)

        // Assert
        XCTAssertTrue(mockRepository.removeFromActiveCalled)
        XCTAssertEqual(mockRepository.removeFromActiveSymbol, symbolToRemove)
    }

    func testExecute_DoesNotRemoveSymbolWhenSymbolIsEmpty() {
        // Arrange
        let emptySymbol = ""

        // Act
        useCase.execute(for: emptySymbol)

        // Assert
        XCTAssertFalse(mockRepository.removeFromActiveCalled)
    }
}

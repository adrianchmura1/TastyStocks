//
//  AddSymbolUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import XCTest
@testable import WatchlistDomain

final class AddSymbolUseCaseTests: XCTestCase {
    func testExecute_WhenAddingSymbolToActiveWatchlistSucceeds_ReturnsSuccess() {
        // Arrange
        let symbolToAdd = "AAPL"
        let repositoryMock = MockWatchlistRepository()
        let useCase = AddSymbolUseCase(repository: repositoryMock)

        // Act
        useCase.execute(symbol: symbolToAdd)

        // Assert
        XCTAssertTrue(repositoryMock.addToActiveWatchlistCalled)
        XCTAssertEqual(repositoryMock.addToActiveWatchlistSymbol, symbolToAdd)
    }
}

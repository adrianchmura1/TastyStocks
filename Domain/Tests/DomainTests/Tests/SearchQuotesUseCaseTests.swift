//
//  SearchQuotesUseCaseTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistDomain

class SearchQuotesUseCaseTests: XCTestCase {
    func testSearchQuotesUseCaseSuccess() {
        // Arrange
        let mockSymbolsRepository = MockSymbolsRepository()
        let useCase = SearchQuotesUseCase(symbolsRepository: mockSymbolsRepository)
        let searchText = "AAPL"
        let expectation = expectation(description: "Expect to receive search results")
        
        // Act
        useCase.execute(text: searchText) { result in
            // Assert
            switch result {
            case .success(let results):
                XCTAssertTrue(results.count == 2)
                XCTAssertEqual(results[0].symbol, "AAPL")
                XCTAssertEqual(results[0].name, "Apple Inc.")
                XCTAssertEqual(results[1].symbol, "GOOGL")
                XCTAssertEqual(results[1].name, "Alphabet Inc.")
                
            case .failure(let error):
                XCTFail("Expected success but received error: \(error)")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSearchQuotesUseCaseFailure() {
        // Arrange
        let mockSymbolsRepository = MockSymbolsRepository()
        mockSymbolsRepository.shouldThrowError = true
        let useCase = SearchQuotesUseCase(symbolsRepository: mockSymbolsRepository)
        let searchText = "AAPL"
        let expectation = expectation(description: "Expect to receive an error")
        
        // Act
        useCase.execute(text: searchText) { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected error but received success")
                
            case .failure(let error):
                XCTAssertTrue(error is MockSymbolsRepository.SearchError)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

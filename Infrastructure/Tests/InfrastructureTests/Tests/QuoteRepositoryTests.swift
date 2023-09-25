//
//  QuoteRepositoryTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistInfrastructure
import WatchlistDomain

final class QuoteRepositoryTests: XCTestCase {
    func testFetchQuoteSuccess() {
        let mockQuote = Quote(symbol: "AAPL", bid: "150.0", ask: "155.0", last: "152.5")
        let mockRestService = MockQuoteRestService()
        mockRestService.fetchQuoteResult = .success(mockQuote)

        let repository = QuoteRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Fetch quote completion")

        repository.fetchQuote(symbol: "AAPL") { result in
            switch result {
            case .success(let quote):
                XCTAssertEqual(quote, mockQuote)
            case .failure:
                XCTFail("Expected success, but got failure.")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchQuoteFailure() {
        let mockError = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        let mockRestService = MockQuoteRestService()
        mockRestService.fetchQuoteResult = .failure(mockError)

        let repository = QuoteRepository(restService: mockRestService)
        let expectation = XCTestExpectation(description: "Fetch quote completion")

        repository.fetchQuote(symbol: "AAPL") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success.")
            case .failure(let error):
                XCTAssertEqual(error as NSError, mockError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}

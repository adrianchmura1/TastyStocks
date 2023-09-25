//
//  QuoteRestServiceTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistInfrastructure
import WatchlistDomain

final class QuoteRestServiceTests: XCTestCase {
    var quoteRestService: QuoteRestService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        quoteRestService = QuoteRestService(networkService: mockNetworkService)
    }

    override func tearDown() {
        quoteRestService = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchQuoteSuccess() {
        let mockResponse = QuoteResponse(
            latestPrice: 150.0,
            symbol: "AAPL",
            askPrice: 149,
            bidPrice: 149.2
        )

        mockNetworkService.expectedResult = Result<QuoteResponse, Error>.success(mockResponse)

        quoteRestService.fetchQuote(symbol: "AAPL") { result in
            switch result {
            case .success(let quote):
                XCTAssertEqual(quote.symbol, mockResponse.symbol)
                XCTAssertEqual(quote.last, String(mockResponse.latestPrice!))
            case .failure:
                XCTFail("Fetching quote unexpectedly failed.")
            }
        }
    }

    func testFetchQuoteFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkService.expectedResult = Result<QuoteResponse, Error>.failure(expectedError)

        quoteRestService.fetchQuote(symbol: "AAPL") { result in
            switch result {
            case .success:
                XCTFail("Fetching quote unexpectedly succeeded.")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, expectedError)
            }
        }
    }
}

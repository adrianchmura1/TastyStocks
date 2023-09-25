//
//  SymbolsRestServiceTests.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
import Foundation
@testable import WatchlistInfrastructure
import WatchlistDomain

final class SymbolsRestServiceTests: XCTestCase {
    var symbolsRestService: SymbolsRestService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        symbolsRestService = SymbolsRestService(networkService: mockNetworkService)
    }

    override func tearDown() {
        symbolsRestService = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFindSymbolSuccess() {
        let mockResponse = SymbolSearchResponse(
            data: SymbolSearchDataResponse(
                items: [
                    SymbolSearchDataItemResponse(symbol: "AAPL", description: "Apple Inc."),
                    SymbolSearchDataItemResponse(symbol: "MSFT", description: "Microsoft Corporation")
                ]
            )
        )

        mockNetworkService.expectedResult = Result<SymbolSearchResponse, Error>.success(mockResponse)

        symbolsRestService.findSymbol(text: "Apple") { result in
            switch result {
            case .success(let searchResults):
                XCTAssertEqual(searchResults.count, 2)
                XCTAssertEqual(searchResults[0].symbol, "AAPL")
                XCTAssertEqual(searchResults[0].name, "Apple Inc.")
                XCTAssertEqual(searchResults[1].symbol, "MSFT")
                XCTAssertEqual(searchResults[1].name, "Microsoft Corporation")
            case .failure:
                XCTFail("Finding symbols unexpectedly failed.")
            }
        }
    }

    func testFindSymbolFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkService.expectedResult = Result<SymbolSearchResponse, Error>.failure(expectedError)

        symbolsRestService.findSymbol(text: "Apple") { result in
            switch result {
            case .success:
                XCTFail("Finding symbols unexpectedly succeeded.")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, expectedError)
            }
        }
    }
}

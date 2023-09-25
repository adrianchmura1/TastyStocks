//
//  MockSearchQuotesUseCase.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import Watchlist
import WatchlistDomain

final class MockSearchQuotesUseCase: SearchQuotesUseCaseProtocol {
    var searchText: String?
    var executeCalled = false
    var results: Result<[QuoteSearchResult], Error> = .success([])

    func execute(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void) {
        searchText = text
        executeCalled = true
        completion(results)
    }
}

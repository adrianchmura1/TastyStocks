//
//  MockSymbolsRestService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain
@testable import WatchlistInfrastructure

final class MockSymbolsRestService: SymbolsRestServiceProtocol {
    var findSymbolText: String?
    var findSymbolResult: Result<[WatchlistDomain.QuoteSearchResult], Error>?

    func findSymbol(text: String, completion: @escaping (Result<[WatchlistDomain.QuoteSearchResult], Error>) -> Void) {
        findSymbolText = text
        if let result = findSymbolResult {
            completion(result)
        }
    }
}

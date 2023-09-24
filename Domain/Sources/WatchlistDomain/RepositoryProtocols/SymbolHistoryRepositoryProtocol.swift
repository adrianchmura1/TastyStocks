//
//  QuotesRepositoryProtocol.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

public protocol SymbolHistoryRepositoryProtocol: AnyObject {
    func fetchLatestPrice(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void)
}

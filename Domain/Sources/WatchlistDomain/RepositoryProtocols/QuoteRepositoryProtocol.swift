//
//  QuoteRepositoryProtocol.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

public protocol QuoteRepositoryProtocol: AnyObject {
    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void)
}

//
//  SymbolsRepositoryProtocol.swift
//  
//
//  Created by Adrian Chmura on 22/09/2023.
//

import Foundation

public protocol SymbolsRepositoryProtocol: AnyObject {
    func findSymbol(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void)
}

//
//  SearchQuotesUseCase.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation

public protocol SearchQuotesUseCaseProtocol: AnyObject {
    func execute(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void)
}

final class SearchQuotesUseCase: SearchQuotesUseCaseProtocol {
    private let symbolsRepository: SymbolsRepositoryProtocol

    init(symbolsRepository: SymbolsRepositoryProtocol) {
        self.symbolsRepository = symbolsRepository
    }

    func execute(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void) {
        symbolsRepository.findSymbol(text: text, completion: completion)
    }
}

//
//  AddQuoteInteractor.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import WatchlistDomain

final class AddQuoteInteractor {
    private let searchQuotesUseCase: SearchQuotesUseCaseProtocol
    private let addSymbolUseCaseProtocol: AddSymbolUseCaseProtocol

    init(searchQuotesUseCase: SearchQuotesUseCaseProtocol, addSymbolUseCaseProtocol: AddSymbolUseCaseProtocol) {
        self.searchQuotesUseCase = searchQuotesUseCase
        self.addSymbolUseCaseProtocol = addSymbolUseCaseProtocol
    }

    func search(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void) {
        searchQuotesUseCase.execute(text: text, completion: completion)
    }

    func add(symbol: String) {
        addSymbolUseCaseProtocol.execute(symbol: symbol)
    }
}

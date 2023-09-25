//
//  QuoteInteractor.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import WatchlistDomain

final class QuoteInteractor {
    private let getSymbolHistoryUseCaseProtocol: GetSymbolHistoryUseCaseProtocol
    private let getQuoteUseCase: GetQuoteUseCaseProtocol

    init(getSymbolHistoryUseCaseProtocol: GetSymbolHistoryUseCaseProtocol, getQuoteUseCase: GetQuoteUseCaseProtocol) {
        self.getSymbolHistoryUseCaseProtocol = getSymbolHistoryUseCaseProtocol
        self.getQuoteUseCase = getQuoteUseCase
    }

    func fetchHistory(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        getSymbolHistoryUseCaseProtocol.execute(for: symbol, completion: completion)
    }

    func getQuote(for symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        getQuoteUseCase.execute(for: symbol, completion: completion)
    }
}

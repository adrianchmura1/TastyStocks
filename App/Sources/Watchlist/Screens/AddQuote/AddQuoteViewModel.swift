//
//  AddQuoteViewModel.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation

final class AddQuoteViewModel {
    enum Action {
        case reload
        case finished
    }

    var action: ((Action) -> Void)?
    var filteredQuotes: [StockQuote] = []

    private let interactor: AddQuoteInteractor

    private var stockQuotes: [StockQuote] = dummyStockQuotes

    init(interactor: AddQuoteInteractor) {
        self.interactor = interactor
    }

    func filterStockQuotes(with searchText: String) {
        filteredQuotes = stockQuotes.filter { $0.symbol.contains(searchText.uppercased()) }
        action?(.reload)
    }

    func didSelectRow(at indexPath: IndexPath) {
        let symbol = filteredQuotes[indexPath.row].symbol
        interactor.add(symbol: symbol)
        action?(.finished)
    }
}

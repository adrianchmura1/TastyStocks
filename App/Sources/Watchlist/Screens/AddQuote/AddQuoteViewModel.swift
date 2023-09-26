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
        case startLoading
        case finishLoading
        case showError
    }

    var action: ((Action) -> Void)?
    var filteredQuotes: [StockQuote] = []

    private let interactor: AddQuoteInteractor
    private let backgroundQueue: Queue
    private let mainQueue: Queue

    init(
        backgroundQueue: Queue = DefaultBackgroundQueue(),
        mainQueue: Queue = DefaultMainQueue(),
        interactor: AddQuoteInteractor
    ) {
        self.interactor = interactor
        self.backgroundQueue = backgroundQueue
        self.mainQueue = mainQueue
    }

    func filterStockQuotes(with searchText: String) {
        guard !searchText.isEmpty else {
            filteredQuotes = []
            self.action?(.reload)
            return
        }

        action?(.startLoading)
        backgroundQueue.async {
            self.interactor.search(text: searchText) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let results):
                    self.filteredQuotes = results.map { StockQuote(symbol: $0.symbol, name: $0.name) }
                case .failure:
                    self.action?(.showError)
                }

                mainQueue.async {
                    self.action?(.reload)
                    self.action?(.finishLoading)
                }
            }
        }
    }

    func didSelectRow(at indexPath: IndexPath) {
        let symbol = filteredQuotes[indexPath.row].symbol
        interactor.add(symbol: symbol)
        action?(.finished)
    }
}

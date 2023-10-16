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

    private var searchWorkItem: DispatchWorkItem?

    func textDidChange(with searchText: String) {
        searchWorkItem?.cancel()

        guard !searchText.isEmpty else {
            filteredQuotes = []
            self.action?(.reload)
            return
        }

        searchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            self.action?(.startLoading)

            backgroundQueue.async {
                self.interactor.search(text: searchText) { [weak self] result in
                    guard let self = self else { return }
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem!)
    }

    func didSelectRow(at indexPath: IndexPath) {
        let symbol = filteredQuotes[indexPath.row].symbol
        interactor.add(symbol: symbol)
        action?(.finished)
    }
}

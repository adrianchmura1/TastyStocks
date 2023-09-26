//
//  QuoteViewModel.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation
import DGCharts
import WatchlistDomain

final class QuoteViewModel {
    enum Action {
        case refreshChart(CandleChartDataSet)
        case startLoading
        case finishLoading
        case updateQuote(QuotePresentable)
        case showError
    }

    let symbol: String

    var action: ((Action) -> Void)?

    var title: String {
        "\(symbol) Quote"
    }

    private let interactor: QuoteInteractor
    private let backgroundQueue: Queue
    private let mainQueue: Queue

    private var timer: Timer?

    init(
        symbol: String,
        interactor: QuoteInteractor,
        backgroundQueue: Queue = DefaultBackgroundQueue(),
        mainQueue: Queue = DefaultMainQueue()
    ) {
        self.symbol = symbol
        self.interactor = interactor
        self.backgroundQueue = backgroundQueue
        self.mainQueue = mainQueue
    }

    func onAppear() {
        action?(.startLoading)
        fetchChartData()
        startTimer()
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }

    private func startTimer() {
        fetchQuote()
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                self?.fetchQuote()
            }
        }
    }

    private func fetchChartData() {
        backgroundQueue.async {
            self.interactor.fetchHistory(for: self.symbol) { [weak self] result in
                self?.mainQueue.async { // Execute on main queue
                    guard let self = self else { return }
                    switch result {
                    case .success(let priceHistory):
                        self.action?(.refreshChart(self.mapToCandleChartDataSet(priceHistory: priceHistory)))
                    case .failure:
                        self.action?(.showError)
                    }
                    self.action?(.finishLoading)
                }
            }
        }
    }

    private func fetchQuote() {
        backgroundQueue.async {
            self.interactor.getQuote(for: self.symbol) { [weak self] result in
                self?.mainQueue.async {
                    switch result {
                    case .success(let quote):
                        self?.action?(.updateQuote(QuoteMapper.mapToQuotePresentable(quote: quote)))
                    case .failure:
                        self?.action?(.showError)
                    }
                }
            }
        }
    }

    private func mapToCandleChartDataSet(priceHistory: SymbolPriceHistory) -> CandleChartDataSet {
        let entries: [ChartDataEntry] = priceHistory.days.enumerated().map { (index, info) in
            CandleChartDataEntry(x: Double(index), shadowH: info.high, shadowL: info.low, open: info.open, close: info.close)
        }

        return CandleChartDataSet(entries: entries, label: "30-Day Price")
    }
}

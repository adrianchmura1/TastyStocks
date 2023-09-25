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
    }

    let symbol: String

    var action: ((Action) -> Void)?

    var title: String {
        "\(symbol) Quote"
    }

    private let interactor: QuoteInteractor

    private var timer: Timer?

    init(symbol: String, interactor: QuoteInteractor) {
        self.symbol = symbol
        self.interactor = interactor
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
        DispatchQueue.global().async {
            self.interactor.fetchHistory(for: self.symbol) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self else { return }
                    switch result {
                    case .success(let priceHistory):
                        self.action?(.refreshChart(self.mapToCandleChartDataSet(priceHistory: priceHistory)))
                    case .failure:
                        // TODO: Show error view
                        print("Error")
                    }
                    self.action?(.finishLoading)
                }
            }
        }
    }

    private func fetchQuote() {
        DispatchQueue.global().async {
            self.interactor.getQuote(for: self.symbol) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let quote):
                        self?.action?(.updateQuote(QuoteMapper.mapToQuotePresentable(quote: quote)))
                    case .failure:
                        // TODO: Handle error
                        break
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

//
//  File.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import UIKit
import SnapKit
import DGCharts
import WatchlistDomain

final class QuoteInteractor {
    private let getSymbolHistoryUseCaseProtocol: GetSymbolHistoryUseCaseProtocol

    init(getSymbolHistoryUseCaseProtocol: GetSymbolHistoryUseCaseProtocol) {
        self.getSymbolHistoryUseCaseProtocol = getSymbolHistoryUseCaseProtocol
    }

    func fetchHistory(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        getSymbolHistoryUseCaseProtocol.execute(for: symbol, completion: completion)
    }
}

final class QuoteViewModel {
    enum Action {
        case refreshChart(CandleChartDataSet)
    }

    let symbol: String

    var action: ((Action) -> Void)?

    var title: String {
        "\(symbol) Quote"
    }

    private let interactor: QuoteInteractor

    init(symbol: String, interactor: QuoteInteractor) {
        self.symbol = symbol
        self.interactor = interactor
    }

    func onAppear() {
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

final class QuoteViewController: UIViewController {
    private let symbolLabel = UILabel()
    private let bidLabel = UILabel()
    private let askLabel = UILabel()
    private let chartView = CandleStickChartView()

    private let viewModel: QuoteViewModel

    init(viewModel: QuoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

        setupUI()

        viewModel.action = { [weak self] action in
            switch action {
            case .refreshChart(let candleChartDataSet):
                self?.configureChartData(with: candleChartDataSet)
            }
        }

        viewModel.onAppear()
    }

    private func setupUI() {
        view.backgroundColor = .white

        symbolLabel.text = viewModel.symbol
//        bidLabel.text = "Bid Price: \(viewModel.quote?.bidPrice ?? "N/A")"
//        askLabel.text = "Ask Price: \(viewModel.quote?.askPrice ?? "N/A")"

        view.addSubview(symbolLabel)
        view.addSubview(bidLabel)
        view.addSubview(askLabel)
        view.addSubview(chartView)

        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        bidLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        askLabel.snp.makeConstraints { make in
            make.top.equalTo(bidLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        chartView.snp.makeConstraints { make in
            make.top.equalTo(askLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureChartData(with dataSet: CandleChartDataSet) {
        dataSet.setColor(.blue)
        dataSet.decreasingColor = .red
        dataSet.increasingColor = .green
        dataSet.shadowColor = .gray
        dataSet.shadowWidth = 0.7

        let chartData = CandleChartData(dataSet: dataSet)
        chartView.data = chartData

        chartView.chartDescription.text = "Stock Price Candlestick Chart"
        chartView.legend.enabled = false
    }
}

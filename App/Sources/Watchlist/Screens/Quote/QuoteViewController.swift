//
//  QuoteViewController.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import UIKit
import SnapKit
import DGCharts
import WatchlistDomain

final class QuoteViewController: UIViewController {
    private let symbolLabel = UILabel()
    private let bidLabel = UILabel()
    private let askLabel = UILabel()
    private let chartView = CandleStickChartView()

    private let viewModel: QuoteViewModel

    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.hidesWhenStopped = true
        return spinner
    }()

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
            case .startLoading:
                self?.setLoading(true)
            case .finishLoading:
                self?.setLoading(false)
            case .updateQuote(let quotePresentable):
                self?.updateLabels(with: quotePresentable)
            }
        }

        viewModel.onAppear()
    }

    private func setLoading(_ loading: Bool) {
        loadingSpinner.isHidden = !loading
        bidLabel.isHidden = loading
        askLabel.isHidden = loading
        chartView.isHidden = loading
    }

    private func updateLabels(with model: QuotePresentable) {
        bidLabel.text = "Bid Price: \(model.bidPrice)"
        askLabel.text = "Ask Price: \(model.askPrice)"
    }

    private func setupUI() {
        view.backgroundColor = ColorPaletteManager.shared.currentPalette.backgroundColor

        symbolLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
        bidLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
        askLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor

        symbolLabel.text = viewModel.symbol

        view.addSubview(symbolLabel)
        view.addSubview(bidLabel)
        view.addSubview(askLabel)
        view.addSubview(chartView)
        view.addSubview(loadingSpinner)

        bidLabel.text = "Bid Price: "
        askLabel.text = "Ask Price: "

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

        loadingSpinner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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

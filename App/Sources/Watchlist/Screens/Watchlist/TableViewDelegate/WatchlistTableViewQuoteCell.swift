//
//  WatchlistTableViewQuoteCell.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import UIKit
import SnapKit

final class WatchlistTableViewQuoteCell: UITableViewCell {
    private let symbolLabel = UILabel()
    private let lastPriceLabel = UILabel()
    private let bidPriceLabel = UILabel()
    private let askPriceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with symbol: String, lastPrice: String, bidPrice: String, askPrice: String) {
        symbolLabel.text = symbol
        lastPriceLabel.text = lastPrice
        bidPriceLabel.text = bidPrice
        askPriceLabel.text = askPrice
    }

    private func setupUI() {
        contentView.backgroundColor = ColorPaletteManager.shared.currentPalette.backgroundColor
        contentView.addSubview(symbolLabel)
        contentView.addSubview(lastPriceLabel)
        contentView.addSubview(bidPriceLabel)
        contentView.addSubview(askPriceLabel)

        symbolLabel.font = UIFont.systemFont(ofSize: 16)
        lastPriceLabel.font = UIFont.systemFont(ofSize: 16)
        bidPriceLabel.font = UIFont.systemFont(ofSize: 16)
        askPriceLabel.font = UIFont.systemFont(ofSize: 16)

        symbolLabel.textAlignment = .left
        lastPriceLabel.textAlignment = .right
        bidPriceLabel.textAlignment = .right
        askPriceLabel.textAlignment = .right

        symbolLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
        lastPriceLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
        bidPriceLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
        askPriceLabel.textColor = ColorPaletteManager.shared.currentPalette.textColor
    }

    private func setupConstraints() {
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        lastPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolLabel.snp.trailing).offset(10)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
        }

        bidPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(lastPriceLabel.snp.trailing).offset(10)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
        }

        askPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(bidPriceLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
        }
    }
}


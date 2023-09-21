//
//  HeaderView.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import UIKit
import SnapKit

final class HeaderView: UIView {
    let titleLabel = UILabel()
    let latestLabel = UILabel()
    let bidLabel = UILabel()
    let askLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .lightGray

        titleLabel.text = "SYMBOL"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        latestLabel.text = "LATEST"
        latestLabel.textAlignment = .center
        latestLabel.font = UIFont.boldSystemFont(ofSize: 14)
        latestLabel.translatesAutoresizingMaskIntoConstraints = false

        bidLabel.text = "BID"
        bidLabel.textAlignment = .center
        bidLabel.font = UIFont.boldSystemFont(ofSize: 14)
        bidLabel.translatesAutoresizingMaskIntoConstraints = false

        askLabel.text = "ASK"
        askLabel.textAlignment = .center
        askLabel.font = UIFont.boldSystemFont(ofSize: 14)
        askLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        addSubview(latestLabel)
        addSubview(bidLabel)
        addSubview(askLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalToSuperview()
        }

        latestLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
        }

        bidLabel.snp.makeConstraints { make in
            make.leading.equalTo(latestLabel.snp.trailing).offset(10)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
        }

        askLabel.snp.makeConstraints { make in
            make.leading.equalTo(bidLabel.snp.trailing).offset(10)
            make.width.equalTo(70)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

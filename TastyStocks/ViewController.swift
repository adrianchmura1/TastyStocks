//
//  ViewController.swift
//  TastyStocks
//
//  Created by Adrian Chmura on 15/09/2023.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private lazy var testView: UIView = {
        let view = UILabel()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        build()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func build() {
        view.backgroundColor = .blue
        view.addSubview(testView)

        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

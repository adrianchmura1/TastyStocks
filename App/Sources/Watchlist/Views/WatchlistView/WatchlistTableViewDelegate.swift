//
//  File.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit

final class WatchListTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let viewModel: WatchListViewModel

    init(viewModel: WatchListViewModel) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = viewModel.quote(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let quoteCell = cell as? WatchlistTableViewQuoteCell {
            quoteCell.configure(with: quote.symbol, lastPrice: quote.lastPrice, bidPrice: quote.bidPrice, askPrice: quote.askPrice)
        }
        return cell
    }
}

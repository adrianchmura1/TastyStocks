//
//  AddQuoteTableViewDelegate.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import UIKit

final class AddQuoteTableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let viewModel: AddQuoteViewModel

    init(viewModel: AddQuoteViewModel) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredQuotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let stockQuote = viewModel.filteredQuotes[indexPath.row]
        cell.textLabel?.text = "\(stockQuote.symbol) - \(stockQuote.name)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

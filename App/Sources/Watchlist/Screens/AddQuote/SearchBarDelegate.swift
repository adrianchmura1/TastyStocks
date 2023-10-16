//
//  SearchBarDelegate.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import UIKit

final class SearchBarDelegate: NSObject, UISearchBarDelegate {
    let viewModel: AddQuoteViewModel

    init(viewModel: AddQuoteViewModel) {
        self.viewModel = viewModel
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(with: searchText)
    }
}

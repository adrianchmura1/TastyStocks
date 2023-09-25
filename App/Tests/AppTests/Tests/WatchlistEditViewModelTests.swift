//
//  WatchlistEditViewModelTests.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import XCTest
@testable import Watchlist
import WatchlistDomain

final class WatchlistEditViewModelTests: XCTestCase {
    var viewModel: WatchlistEditViewModel!
    var mockAddWatchlistUseCase: MockAddWatchlistUseCase!
    var mockGetWatchlistsUseCase: MockGetWatchlistsUseCase!
    var mockSwitchWatchlistUseCase: MockSwitchWatchlistUseCase!
    var mockRemoveWatchlistUseCase: MockRemoveWatchlistUseCase!
    var mockGetActiveWatchlistIdUseCase: MockGetActiveWatchlistIdUseCase!

    override func setUp() {
        super.setUp()

        mockAddWatchlistUseCase = MockAddWatchlistUseCase()
        mockGetWatchlistsUseCase = MockGetWatchlistsUseCase()
        mockSwitchWatchlistUseCase = MockSwitchWatchlistUseCase()
        mockRemoveWatchlistUseCase = MockRemoveWatchlistUseCase()
        mockGetActiveWatchlistIdUseCase = MockGetActiveWatchlistIdUseCase()

        let mockInteractor = WatchlistEditInteractor(
            addWatchlistUseCase: mockAddWatchlistUseCase,
            getWatchlistsUseCase: mockGetWatchlistsUseCase,
            switchWatchlistUseCase: mockSwitchWatchlistUseCase,
            removeWatchlistUseCase: mockRemoveWatchlistUseCase,
            getActiveWatchlistIdUseCase: mockGetActiveWatchlistIdUseCase
        )

        viewModel = WatchlistEditViewModel(interactor: mockInteractor)
    }

    func testOnAppearReloadsWatchlists() {
        mockGetWatchlistsUseCase.watchlists = [
            Watchlist(id: "1", name: "Watchlist 1"),
            Watchlist(id: "2", name: "Watchlist 2")
        ]

        viewModel.onAppear()

        XCTAssertTrue(mockGetWatchlistsUseCase.isCalled)
    }

    func testAddWatchlist() {
        viewModel.addWatchlist(withName: "New Watchlist")

        XCTAssertTrue(mockAddWatchlistUseCase.isCalled)
    }

}

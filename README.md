# TastyStocks

TastyStocks is a Swift iOS application for tracking and managing stock portfolios. It is fully configured with Swift Package Manager (SPM) for managing both local packages and third-party libraries.

## Project Overview

TastyStocks is organized into several modules:

- **Coordinators**: This module handles the navigation flow and coordination between different screens in the app.

- **Watchlist**: The core module of the app, responsible for displaying and managing watchlists of stocks.

- **WatchlistDomain**: Contains the domain logic, models, and business rules for handling watchlists and stock data.

- **WatchlistInfrastructure**: Provides implementations for interacting with external services, such as fetching stock data.

## Getting Started

### Requirements

- Xcode (11.0+)
- Swift (5.0+)

### Installation

1. Clone the repository to your local machine.
2. Open the project in Xcode:
```shell
cd TastyStocks
open TastyStocks.xcodeproj
```
3. Update `iexToken` property of `Infrastructure/Sources/Environment/EnvironmentManager.swift` to match a valid one


### Running the App

To run the app:

- Build and run the app by pressing Cmd+R or going to "Product" > "Run."
- The app should launch in the iOS Simulator, and you can begin using it to track and manage your stock portfolios.
Running Tests

### Testing the app
- You can run tests for all modules (Coordinators, Watchlist, WatchlistDomain, WatchlistInfrastructure) by pressing Cmd+U or going to "Product" > "Test."
- The test suite will execute, and you can view the results in the Xcode Test Navigator.

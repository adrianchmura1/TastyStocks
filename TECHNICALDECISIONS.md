# Technical Decisions

## Architecture Overview

TastyStocks is designed using the principles of Domain-Driven Design (DDD) to ensure a clean and modular architecture. The project is divided into three main modules: Watchlist, WatchlistDomain, and WatchlistInfrastructure, each serving distinct roles in the application.

### WatchlistDomain

The WatchlistDomain module is the core of the application, encapsulating the business logic and domain entities. It is designed to be platform-agnostic and can potentially be used across different platforms, even if they are developed in different programming languages.

### Watchlist

The Watchlist module follows the MVVM (Model-View-ViewModel) architecture pattern combined with Coordinators for navigation. The main purpose of this module is to provide a user interface for managing watchlists and stock portfolios. The architecture in this module is structured as follows:

- **AppCoordinator**: The top-level coordinator that manages the overall flow of the application.
- **WatchlistCoordinator**: A coordinator dedicated to managing the Watchlist module's navigation and coordination.
- **ViewModel**: Each screen in the Watchlist module has a corresponding ViewModel, which acts as the intermediary between the View and the underlying business logic. These ViewModels abstract interactions with the domain layer, providing a clean and testable interface.

The Watchlist module's architecture promotes separation of concerns, making it easier to develop, test, and maintain.

### ViewModel and Interactors

The ViewModel in the Watchlist module depends on an interactor, which serves as a facade over multiple use cases. This approach improves code readability and reduces ViewModel complexity, as it abstracts away the underlying business logic into a single dependency. This interactor helps organize and manage the interaction between the ViewModel and the domain layer efficiently.

### WatchlistInfrastructure

The WatchlistInfrastructure module is responsible for handling data storage and network interactions. It abstracts the implementation details of data sources, such as databases and REST services, from the domain layer. This module includes the following key components:

- **Databases**: Provides data storage capabilities using a local database.
- **RestServices**: Manages communication with external RESTful APIs.
- **Repository**: Acts as a facade over databases and RestServices, ensuring that the domain layer does not need to know if it is interacting with the network or local storage. The Repository pattern simplifies data access and decouples the domain from specific data sources.

## Abstraction and Testability

One of the key principles in this project is the use of protocols to abstract various components. This approach enhances flexibility and testability by allowing easy replacement of implementations. For instance, use cases and network services can be swapped with mock implementations during testing, ensuring that unit tests remain isolated and focused.

By adhering to the principles of DDD, MVVM, Coordinators, and protocol-based abstractions, TastyStocks achieves a clean, maintainable, and testable architecture that promotes code reusability and separation of concerns.

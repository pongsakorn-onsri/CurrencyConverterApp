import Foundation

protocol DestinationCurrencyListViewModel {
    var sourceCurrency: CurrencySymbol { get }
    var items: [CurrencyRate] { get }
    
    func fetchCurrencyRates() async throws
    func getRate(currency: CurrencySymbol) -> Double?
}

final class DestinationCurrencyListViewModelImpl: DestinationCurrencyListViewModel {
    private(set) var sourceCurrency: CurrencySymbol
    private(set) var items: [CurrencyRate]
    private let networkService: NetworkService
    
    init(
        sourceCurrency: CurrencySymbol,
        items: [CurrencyRate] = DestinationCurrencyListViewModelImpl.items,
        networkService: NetworkService = URLSessionService()
    ) {
        self.sourceCurrency = sourceCurrency
        self.items = items.filter { $0.symbol != sourceCurrency }
        self.networkService = networkService
    }
    
    func fetchCurrencyRates() async throws {
        let response = try await networkService.requestExchangeRate(symbol: sourceCurrency.rawValue)
        items = items.map {
            CurrencyRate(symbol: $0.symbol, rate: response.rates[$0.symbol.rawValue])
        }
    }
    
    func getRate(currency: CurrencySymbol) -> Double? {
        items.first(where: { $0.symbol == currency })?.rate
    }
}

private extension DestinationCurrencyListViewModelImpl {
    static let items: [CurrencyRate] = CurrencySymbol.allCases.map { CurrencyRate(symbol: $0, rate: nil) }
}

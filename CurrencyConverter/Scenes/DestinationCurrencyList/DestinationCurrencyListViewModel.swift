import Foundation

final class DestinationCurrencyListViewModel {
    private(set) var sourceCurrency: CurrencySymbol
    private(set) var items: [CurrencyRate]
    
    init(sourceCurrency: CurrencySymbol, items: [CurrencyRate] = DestinationCurrencyListViewModel.items ) {
        self.sourceCurrency = sourceCurrency
        self.items = items.filter { $0.symbol != sourceCurrency }
    }
    
    func fetchCurrencyRates() async throws {
        let response = try await APIRequest.exchangeRate(sourceCurrency).request()
        items = items.map {
            CurrencyRate(symbol: $0.symbol, rate: response.rates[$0.symbol.rawValue])
        }
    }
    
    func getRate(currency: CurrencySymbol) -> Double? {
        items.first(where: { $0.symbol == currency })?.rate
    }
}

private extension DestinationCurrencyListViewModel {
    static let items: [CurrencyRate] = CurrencySymbol.allCases.map { CurrencyRate(symbol: $0, rate: nil) }
}

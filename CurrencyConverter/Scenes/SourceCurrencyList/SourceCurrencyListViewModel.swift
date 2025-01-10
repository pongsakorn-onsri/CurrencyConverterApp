import Foundation

final class SourceCurrencyListViewModel {
    private(set) var items: [CurrencySymbol]
    
    init(items: [CurrencySymbol] = CurrencySymbol.allCases) {
        self.items = items
    }
}

import Foundation

protocol SourceCurrencyListViewModel {
    var items: [CurrencySymbol] { get }
}

final class SourceCurrencyListViewModelImpl: SourceCurrencyListViewModel {
    private(set) var items: [CurrencySymbol]
    
    init(items: [CurrencySymbol] = CurrencySymbol.allCases) {
        self.items = items
    }
}

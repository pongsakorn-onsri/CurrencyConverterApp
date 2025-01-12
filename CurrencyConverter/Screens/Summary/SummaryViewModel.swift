import Foundation

protocol SummaryViewModel {
    var source: InputCurrency { get }
    var destination: InputCurrency { get }
    var rate: Double { get }
    func save()
}

final class SummaryViewModelImpl: SummaryViewModel {
    let source: InputCurrency
    let destination: InputCurrency
    let rate: Double
    let persistence: Persistence
    
    init(
        source: InputCurrency = .init(amount: 100, currency: .USD),
        destination: InputCurrency = .init(amount: 2536673333333, currency: .VND),
        rate: Double = 25366.73,
        persistence: Persistence = LocalStorage()
    ) {
        self.source = source
        self.destination = destination
        self.rate = rate
        self.persistence = persistence
    }
    
    func save() {
        let items: [HistoryItem] = persistence.getValueList(for: HistoryItem.key)
        let newHistoryItem = HistoryItem(source: source, destination: destination, rate: rate)
        persistence.saveValue(items: [newHistoryItem] + items, for: HistoryItem.key)
    }
}

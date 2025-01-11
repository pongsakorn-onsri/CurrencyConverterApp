import Foundation

protocol HistoryListViewModel {
    var items: [HistoryItem] { get }
    func fetchHistory() async -> [HistoryItem] 
}

final class HistoryListViewModelImpl: HistoryListViewModel {
    
    var items: [HistoryItem] = []
    
    init(items: [HistoryItem] = []) {
        self.items = items
    }
    
    func fetchHistory() async -> [HistoryItem] {
        let cached = [HistoryItem(source: .init(amount: 10, currency: .USD), destination: .init(amount: 100000, currency: .VND), rate: 0.1), HistoryItem(source: .init(amount: 10, currency: .USD), destination: .init(amount: 100000, currency: .VND), rate: 0.1)]
        self.items = cached
        return self.items
    }
}

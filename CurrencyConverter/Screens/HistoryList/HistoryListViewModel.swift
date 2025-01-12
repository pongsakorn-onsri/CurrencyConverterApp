import Foundation

protocol HistoryListViewModel {
    var items: [HistoryItem] { get }
    func fetchHistory() async -> [HistoryItem] 
}

final class HistoryListViewModelImpl: HistoryListViewModel {
    
    var items: [HistoryItem] = []
    let persistence: Persistence
    
    init(persistence: Persistence = LocalStorage()) {
        self.persistence = persistence
    }
    
    func fetchHistory() async -> [HistoryItem] {
        items = persistence.getValueList(for: HistoryItem.key)
        return items
    }
}

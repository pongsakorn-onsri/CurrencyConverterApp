import Foundation

protocol Persistence {
    var historyItems: [HistoryItem] { get }
    func save(item: HistoryItem)
}

final class LocalStorage: Persistence {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var historyItems: [HistoryItem] {
        guard let data = userDefaults.object(forKey: HistoryItem.key) as? Data else {
            return []
        }
        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([HistoryItem].self, from: data) else {
            return []
        }
        return items
    }
    
    func save(item: HistoryItem) {
        let items = [item] + historyItems
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: HistoryItem.key)
        }
    }
}

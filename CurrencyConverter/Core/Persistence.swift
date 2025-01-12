import Foundation

protocol Persistence {
    func getValueList<T: Decodable>(for key: String) -> [T]
    func saveValue<T: Encodable>(items: [T], for key: String)
}

final class LocalStorage: Persistence {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func getValueList<T>(for key: String) -> [T] where T : Decodable {
        guard let data = userDefaults.object(forKey: key) as? Data else {
            return []
        }
        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([T].self, from: data) else {
            return []
        }
        return items
    }
    
    func saveValue<T>(items: [T], for key: String) where T : Encodable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: key)
        }
    }
}

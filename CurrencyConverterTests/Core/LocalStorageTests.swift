import Testing
import Foundation
@testable import CurrencyConverter

@Suite(.tags(.core))
struct LocalStorageTests {
    let persistence: Persistence
    
    init() {
        self.persistence = LocalStorage(userDefaults: UserDefaultMock())
    }
    
    @Test
    func whenGetValueAndNoData() async throws {
        let items: [String] = persistence.getValueList(for: "key")
        #expect(items.isEmpty)
    }
    
    @Test
    func whenGetValueAndDecodeFailed() async throws {
        let items: [Int] = persistence.getValueList(for: "test")
        #expect(items.isEmpty)
    }

    @Test
    func whenSaveValueAndGetResult() async throws {
        persistence.saveValue(items: ["test"], for: "test")
        let items: [String] = persistence.getValueList(for: "test")
        #expect(items == ["test"])
    }
}

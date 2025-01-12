import Foundation

class UserDefaultMock: UserDefaults {
    convenience init() {
        self.init(suiteName: "Test")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removeSuite(named: suitename!)
        super.init(suiteName: suitename)
    }
}

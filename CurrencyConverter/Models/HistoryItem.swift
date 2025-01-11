import Foundation

struct HistoryItem: Codable {
    var source: InputCurrency
    var destination: InputCurrency
    var rate: Double
}

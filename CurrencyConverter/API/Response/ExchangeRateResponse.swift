import Foundation

struct ExchangeRateResponse: Codable {
    let base: String
    let date: String
    let timeLastUpdated: TimeInterval
    let rates: [String: Double]
}

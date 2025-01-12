import Foundation

enum APIRequest {
    case exchangeRate(symbol: String)
}

extension APIRequest {
    var urlString: String {
        switch self {
        case .exchangeRate(let symbol):
            return "https://api.exchangerate-api.com/v4/latest/\(symbol.uppercased())"
        }
    }
}

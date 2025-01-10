import Foundation

enum APIError: Error {
    case invalidURL
    case decodeResponseFailed
}

enum APIRequest {
    case exchangeRate(CurrencySymbol)
    
    func request(session: URLSession = .shared) async throws -> ExchangeRateResponse {
        switch self {
        case let .exchangeRate(currencySymbol):
            let url = URL(string: "https://api.exchangerate-api.com/v4/latest/\(currencySymbol.rawValue.uppercased())")
            guard let url else {
                throw APIError.invalidURL
            }
            let request = URLRequest(url: url)
            let (data, _) = try await session.data(for: request)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ExchangeRateResponse.self, from: data)
                return response
            } catch {
                throw APIError.decodeResponseFailed
            }
        }
    }
}

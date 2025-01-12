import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case decodeResponseFailed
    case notFound
    
    var errorDescription: String? {
        return switch self {
        case .invalidURL: 
            "The Request URL is invalid or incorrect format."
        case .decodeResponseFailed:
            "Response from API was decoding failed. please check model mapping or naming properties"
        case .notFound:
            "Not found response from API. please check URL again."
        }
    }
}

enum APIRequest {
    case exchangeRate(CurrencySymbol)
    
    func request(session: URLSession = .shared) async throws -> ExchangeRateResponse {
        switch self {
        case let .exchangeRate(currencySymbol):
            let url = URL(string: "https://api.exchangerate-api.com/v4/latest/\(currencySymbol.rawValue)")
            guard let url else {
                throw APIError.invalidURL
            }
            let request = URLRequest(url: url)
            let (data, response) = try await session.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw APIError.notFound
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let rateResponse = try decoder.decode(ExchangeRateResponse.self, from: data)
                return rateResponse
            } catch {
                throw APIError.decodeResponseFailed
            }
        }
    }
}

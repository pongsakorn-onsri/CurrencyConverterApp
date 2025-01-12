import CurrencyConverter
import Foundation

final class NetworkServiceMock: NetworkService {
    
    var apiError: APIError?
    
    func requestExchangeRate<T: Decodable>(symbol: String) async throws -> T {
        if let apiError {
            throw apiError
        }
        let response = """
        {"base":"USD","date":"2025-01-12","time_last_updated":1736640001,"rates":{"USD":1}}
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let rateResponse = try decoder.decode(T.self, from: response.data(using: .utf8)!)
            return rateResponse
        } catch {
            throw APIError.decodeResponseFailed
        }
    }
}

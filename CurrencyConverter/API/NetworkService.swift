import Foundation

protocol NetworkService {
    func requestExchangeRate<T: Decodable>(symbol: String) async throws -> T
}

final class URLSessionService: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestExchangeRate<T: Decodable>(symbol: String) async throws -> T {
        let url = URL(string: APIRequest.exchangeRate(symbol: symbol).urlString)
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
            let rateResponse = try decoder.decode(T.self, from: data)
            return rateResponse
        } catch {
            throw APIError.decodeResponseFailed
        }
    }
}

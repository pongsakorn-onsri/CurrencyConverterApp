import Foundation

public enum APIError: LocalizedError {
    case invalidURL
    case decodeResponseFailed
    case notFound
    
    public var errorDescription: String? {
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

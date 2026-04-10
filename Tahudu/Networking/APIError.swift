import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case decodingFailed(Error)
    case networkError(Error)
    case httpError(statusCode: Int, data: Data)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .httpError(let statusCode, _):
            return "HTTP Error \(statusCode)"
        case .unknown:
            return "Unknown error"
        }
    }
}

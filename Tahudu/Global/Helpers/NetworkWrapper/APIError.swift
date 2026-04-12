import Foundation

/// Represents errors that can occur during API requests.
enum APIError: LocalizedError {
    /// The URL provided was invalid or could not be constructed.
    case invalidURL
    /// Failed to decode the response data.
    case decodingFailed(Error)
    /// A network-level error occurred (e.g., no internet connection).
    case networkError(Error)
    /// The HTTP request returned an error status code.
    case httpError(statusCode: Int, data: Data)
    /// An unknown error occurred.
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

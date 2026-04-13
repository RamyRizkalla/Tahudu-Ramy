import Foundation

/// A generic API provider for executing network requests based on Endpoint definitions.
class APIProvider<E: Endpoint> {
  private let session: URLSession
  private let decoder: JSONDecoder
  private let stubBehavior: StubBehavior
  
  /// Initializes a new API provider.
  /// - Parameters:
  ///   - session: The URLSession to use for requests. Defaults to `.shared`.
  ///   - decoder: The JSONDecoder to use for decoding responses. Defaults to a new instance.
  ///   - stubBehavior: The stub behavior for testing. Defaults to `.never`.
  init(
    session: URLSession = .shared,
    decoder: JSONDecoder = .default,
    stubBehavior: StubBehavior = .never
  ) {
    self.session = session
    self.decoder = decoder
    self.stubBehavior = stubBehavior
  }
  
  /// Executes a request for the given endpoint and decodes the response.
  /// - Parameter endpoint: The endpoint to request data from.
  /// - Returns: The decoded response of the specified type.
  /// - Throws: An APIError if the request fails, returns an error status code, or decoding fails.
  func request<T: Decodable>(_ endpoint: E) async throws -> T {
    switch stubBehavior {
    case .immediate:
      return try decoder.decode(T.self, from: endpoint.sampleData)
      
    case .never:
      let request = try RequestBuilder.build(from: endpoint)
      let (data, response) = try await session.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.unknown
      }
      
      guard (200..<300).contains(httpResponse.statusCode) else {
        throw APIError.httpError(statusCode: httpResponse.statusCode, data: data)
      }
      
      do {
        return try decoder.decode(T.self, from: data)
      } catch {
        throw APIError.decodingFailed(error)
      }
    }
  }
}

extension APIProvider {
  /// Defines the stub behavior for testing purposes.
  enum StubBehavior {
    /// Execute actual network requests.
    case never
    /// Return sample data immediately without making network requests.
    case immediate
  }
}

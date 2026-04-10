import Foundation

class APIProvider<E: Endpoint> {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let stubBehavior: StubBehavior

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        stubBehavior: StubBehavior = .never
    ) {
        self.session = session
        self.decoder = decoder
        self.stubBehavior = stubBehavior
    }

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
  enum StubBehavior {
      case never
      case immediate
  }
}

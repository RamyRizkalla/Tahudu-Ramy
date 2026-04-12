import Foundation

/// Builds URLRequest instances from Endpoint definitions.
struct RequestBuilder {
  
  /// Constructs a URLRequest from an Endpoint protocol definition.
  /// - Parameter endpoint: The endpoint definition to build the request from.
  /// - Returns: A configured URLRequest ready for execution.
  /// - Throws: An error if URL construction or encoding fails.
  static func build(from endpoint: Endpoint) throws -> URLRequest {
    let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    
    if let headers = endpoint.headers {
      request.allHTTPHeaderFields = headers
    }
    
    switch endpoint.task {
    case .requestPlain:
      break
      
    case .requestParameters(let parameters, let encoding):
      switch encoding {
      case .url:
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        if let urlWithQuery = components?.url {
          request.url = urlWithQuery
        }
        
      case .json:
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
      }
      
    case .requestJSONEncodable(let encodable):
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      let encoder = JSONEncoder()
      request.httpBody = try encoder.encode(encodable)
    }
    
    return request
  }
}

import Foundation

/// Defines the structure of an API endpoint.
protocol Endpoint {
  /// The base URL for the API.
  var baseURL: URL { get }
  /// The path to append to the base URL.
  var path: String { get }
  /// The HTTP method to use for the request.
  var method: HTTPMethod { get }
  /// Optional headers to include in the request.
  var headers: [String: String]? { get }
  /// The task configuration for the request (parameters, encoding, etc.).
  var task: RequestTask { get }
  /// Sample data for testing or stubbing responses.
  var sampleData: Data { get }
}

/// HTTP methods supported by the API.
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

/// Defines how request data should be encoded and sent.
enum RequestTask {
  /// Parameter encoding options.
  enum ParameterEncoding {
    /// Encode parameters in the URL query string.
    case url
    /// Encode parameters as JSON in the request body.
    case json
  }
  /// A plain request with no parameters.
  case requestPlain
  /// A request with parameters encoded as URL or JSON.
  case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
  /// A request with an Encodable body.
  case requestJSONEncodable(Encodable)
}

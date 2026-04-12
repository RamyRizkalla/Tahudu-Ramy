import Foundation

protocol Endpoint {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var task: RequestTask { get }
  var sampleData: Data { get }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

enum RequestTask {
  enum ParameterEncoding {
    case url
    case json
  }
  case requestPlain
  case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
  case requestJSONEncodable(Encodable)
}

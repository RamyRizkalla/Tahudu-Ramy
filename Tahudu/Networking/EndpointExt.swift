import Foundation

extension Endpoint {
  var baseURL: URL {
    URL(string: "https://simplejsoncms.com")!
  }
  
  var sharedHeaders: [String: String]? {
    ["Accept": "application/json"]
  }
}

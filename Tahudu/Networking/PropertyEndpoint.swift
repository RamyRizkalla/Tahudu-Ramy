import Foundation

enum PropertyEndpoint: Endpoint {
  case listings
  
  var path: String {
    switch self {
    case .listings:
      return "/api/m6nfoc4jlw"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .listings:
      return .get
    }
  }
  
  var headers: [String: String]? {
    sharedHeaders
  }
  
  var task: RequestTask {
    switch self {
    case .listings:
      return .requestPlain
    }
  }
  
  var sampleData: Data {
    switch self {
    case .listings:
      guard let url = Bundle.main.url(forResource: "listings_sample", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
        return Data()
      }
      return data
    }
  }
}

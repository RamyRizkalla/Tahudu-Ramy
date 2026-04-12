//
//  PropertyAPI.swift
//  Tahudu
//

import Foundation

enum PropertyAPI: Endpoint {
    case listings

    var baseURL: URL {
        URL(string: "https://simplejsoncms.com")!
    }

    var path: String {
        switch self {
        case .listings:
            return "/api/m6nfoc4jlw"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }

    var task: RequestTask {
        .requestPlain
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

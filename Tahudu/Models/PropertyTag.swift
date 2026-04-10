import SwiftUI

enum PropertyTag: Hashable {
    case verified
    case newConstruction
    case liveViewing
    case other(String)

    init(rawValue: String) {
        switch rawValue.lowercased() {
        case "verified":
            self = .verified
        case "new_construction":
            self = .newConstruction
        case "live_viewing":
            self = .liveViewing
        default:
            self = .other(rawValue)
        }
    }

    var displayLabel: String {
        switch self {
        case .verified:
            return "VERIFIED"
        case .newConstruction:
            return "NEW CONSTRUCTION"
        case .liveViewing:
            return "LIVE VIEWING"
        case .other(let value):
            return value.uppercased()
        }
    }

    var badgeColor: Color {
        switch self {
        case .verified:
            return .green
        case .newConstruction:
            return .blue
        case .liveViewing:
            return .purple
        case .other:
            return .gray
        }
    }
}

import Foundation

final class SettingsViewModel {
  private(set) var settingsData: [Section]
  let screenTitle: String
  
  init(screenTitle: String) {
    self.settingsData = []
    self.screenTitle = screenTitle
  }
  
  func setupSettingsData() {
    settingsData = [
      .main(rows: [.language, .country, .notifications]),
      .secondary(rows: [.about, .feedback])
    ]
  }
}

// MARK: Sections & Rows

extension SettingsViewModel {
  enum Section {
    case main(rows: [Row])
    case secondary(rows: [Row])

    var rows: [Row] {
      switch self {
      case .main(let rows), .secondary(let rows):
        return rows
      }
    }
  }

  enum Row {
    case language
    case country
    case notifications
    case about
    case feedback

    private static let accessibilityIdentifier = AccessibilityIdentifier()

    var settingsItem: SettingsItem {
      switch self {
      case .language:
        let languageLocale = Locale.current.localizedString(forLanguageCode: Bundle.main.preferredLocalizations.first!)
        return SettingsItem(
          icon: .textformat,
          title: "Language",
          detailText: languageLocale,
          accessoryType: .disclosureIndicator,
          accessibilityIdentifier: accessibilityIdentifier
        )

      case .country:
        return SettingsItem(
          icon: .globe,
          title: "Country",
          detailText: "United Arab Emirates",
          accessoryType: .disclosureIndicator,
          accessibilityIdentifier: accessibilityIdentifier
        )

      case .notifications:
        return SettingsItem(
          icon: .appBadge,
          title: "Notifications",
          detailText: nil,
          accessoryType: .disclosureIndicator,
          accessibilityIdentifier: accessibilityIdentifier
        )

      case .about:
        return SettingsItem(
          icon: .infoCircle,
          title: "About",
          detailText: nil,
          accessoryType: .disclosureIndicator,
          accessibilityIdentifier: accessibilityIdentifier
        )

      case .feedback:
        return SettingsItem(
          icon: .textBubble,
          title: "Feedback",
          detailText: nil,
          accessoryType: .disclosureIndicator,
          accessibilityIdentifier: accessibilityIdentifier
        )
      }
    }
    
    var accessibilityIdentifier: String {
      let accessibilityIdentifier = Row.accessibilityIdentifier
      switch self {
      case .language:
        return accessibilityIdentifier.language
      case .country:
        return accessibilityIdentifier.country
      case .notifications:
        return accessibilityIdentifier.notifications
      case .about:
        return accessibilityIdentifier.about
      case .feedback:
        return accessibilityIdentifier.feedback
      }
    }
  }
}

// MARK: AccessibilityIdentifiers

private extension SettingsViewModel {
  struct AccessibilityIdentifier {
    let language: String
    let country: String
    let notifications: String
    let about: String
    let feedback: String
    
    init(base: String = "SettingsCell_") {
      self.language = base + "language"
      self.country = base + "country"
      self.notifications = base + "notifications"
      self.about = base + "about"
      self.feedback = base + "feedback"
    }
  }
}

extension Array where Element == SettingsViewModel.Section {
  subscript(indexPath: IndexPath) -> SettingsViewModel.Row {
      self[indexPath.section].rows[indexPath.row]
  }
}

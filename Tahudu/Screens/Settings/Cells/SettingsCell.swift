import UIKit

final class SettingsCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    setupAppearance()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupAppearance() {
    backgroundColor = .systemBackground
    selectionStyle = .default
  }
  
  func configure(with item: SettingsItem) {
    imageView?.image = UIImage(sfSymbol: item.icon, withConfiguration: UIImage.SymbolConfiguration(scale: .medium))
    textLabel?.text = item.title
    textLabel?.textColor = .label
    textLabel?.textAlignment = .natural
    detailTextLabel?.text = item.detailText
    detailTextLabel?.textColor = .secondaryLabel
    accessoryType = item.accessoryType
    accessibilityIdentifier = item.accessibilityIdentifier
  }
}

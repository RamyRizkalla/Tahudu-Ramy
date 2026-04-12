import UIKit

extension UITableView {
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: T.identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue cell with identifier \(T.identifier)")
    }
    return cell
  }
}

extension UITableViewCell {
  static var identifier: String {
    String(describing: self)
  }
}

import UIKit

extension UITableView {
  /// Registers a UITableViewCell class for use in the table view using the class name as the reuse identifier.
  /// - Parameter cellClass: The UITableViewCell class to register.
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: T.identifier)
  }

  /// Dequeues a reusable cell of the specified type for the given index path.
  /// - Parameter indexPath: The index path that specifies the location of the cell.
  /// - Returns: A dequeued cell of the specified type.
  /// - The function Crashes if the cell cannot be dequeued or cast to the expected type.
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue cell with identifier \(T.identifier)")
    }
    return cell
  }
}

private extension UITableViewCell {
  static var identifier: String {
    String(describing: self)
  }
}

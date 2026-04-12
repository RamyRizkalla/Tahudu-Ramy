import Foundation

extension String {
  var capitalizedFromSnakeCase: String {
    split(separator: "_").map { word in
      word.prefix(1).uppercased() + word.dropFirst().lowercased()
    }.joined(separator: " ")
  }
}

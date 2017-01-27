import Foundation
// import Cent
import GameKit
import Swift

extension String {
  /**
    Remove surrounding whitespace
  */
  func trim() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  /**
    Replace @what with @with in @self
  */
  func replace(_ what: String, _ with: String) -> String {
    return replacingOccurrences(of: what, with: with, options: .literal, range: nil)
  }

  /**
    Remove all occurrences of @what in @self
  */
  func remove(_ what: String) -> String {
    return replace(what, "")
  }

  /**
    Remove the last character, unless string is empty
  */
  func dropLast() -> String {
    if isEmpty { return self }
    let stop = index(startIndex, offsetBy: characters.count - 1)
    return substring(to: stop)
  }

  func inspecting() -> String {
    if isEmpty { return "NOP" }
    return "'" + replace("\n", "\\n").replace("'", "\\'") + "'"
  }
}

extension Array {
  func shuffle() -> [Any] {
    if #available(OSX 10.11, *) {
      return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self)
    } else {
      return self // TODO: Implement
    }
  }
}

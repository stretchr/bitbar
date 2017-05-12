import AppKit
import Swift
import Foundation
import Files

/**
  The PluginManager is responsible for
    1. Reading all files from @path as plugins
    2. Displaying a default message in the menu bar if no plugins were found
    3. Parsing the file name for each potential plugin to determine
      if it contains the correct meta data, i.e aFile.10d.sh
        1. File name
        2. Update sequence
        3. File ending
    4. Notifying the TrayDelegate if a plugin closes
*/
class PluginManager: Parent {
  weak var root: Parent?
  private let tray = Tray(title: "BitBar", isVisible: false)
  private let path: String
  private var errors = [Tray]() {
    didSet { verifyBar() }
  }
  internal var plugins = [Plugin]() {
    didSet { verifyBar() }
  }

  /**
    Read plugins from @path
  */
  init(path: String) {
    self.path = path
    self.loadPlugins()
    self.verifyBar()
    self.tray.root = self
  }

  /**
    Clean menu bar from error messages and plugins
  */
  func destroy() {
    plugins.forEach { plugin in plugin.destroy() }
    errors.forEach { title in title.hide() }
    plugins = []
    errors = []
  }
  deinit { destroy() }

  // Add plugin @name with @path to the list of plugins
  // Will fail with an error message if @name can't be parsed
  private func addPlugin(_ name: String, path: String) {
    switch fileFor(name: name) {
    case let Result.success(file, _):
      plugins.append(ExecutablePlugin(path: path, file: file))
    case Result.failure:
      errors.append(Tray(errors: [
        "An error occurred while reading file \(name) from \(path)",
        "Should be on the form {name}.{number}{unit}.{ext}, i.e 'aFile.10d.sh'",
        "Read the official documentation for more information",
      ]))
    }
  }

  // Parse @name on form {name}.{number}{unit}.{ext}
  // I.e aFile.10d.sh
  private func fileFor(name: String) -> Result<File> {
    return Pro.parse(Pro.getFile(), name)
  }

  // Ensure atleast one icon is vissble in the menu bar
  private func verifyBar() {
    if errors.isEmpty && plugins.isEmpty {
      tray.show()
    } else {
      tray.hide()
    }

    for error in errors {
      error.root = self
    }

    for plugin in plugins {
      plugin.root = self
    }
  }

  // Find all potential plugin files in {path}
  // and load them into BitBar
  private func loadPlugins() {
    do {
      for file in try Folder(path: path).files {
        if !file.name.hasPrefix(".") {
          addPlugin(file.name, path: file.path)
        }
      }
    } catch (let error) {
      errors.append(Tray(error: String(describing: error)))
    }
  }
}

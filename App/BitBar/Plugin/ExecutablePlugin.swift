import Swift
import Cocoa
import SwiftyTimer

class ExecutablePlugin: Plugin, ScriptDelegate {
  var script: Script?
  var timer: Timer?

  override init(path: String, file: File, manager: PluginManager) {
    super.init(path: path, file: file, manager: manager)
    script = Script(path: path, delegate: self)
    timer = Timer.every(getTime().seconds, scheduleDidTick)
    self.show()
  }

  override func show() {
    script?.start()
    timer?.start()
  }

  override func hide() {
    timer?.invalidate()
    script?.stop()
  }

  override func refresh() {
    script?.restart()
  }

  internal func scriptDidReceiveOutput(_ output: String) {
    didReceivedOutput(output)
  }

  internal func scriptDidReceiveError(_ error: String, _ code: Int32) {
    didReceiveError(error)
  }

  internal func scheduleDidTick() {
    script?.start()
  }
}

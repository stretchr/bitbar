import Cocoa
import AppKit
import EmitterKit

final class Menu: ItemBase, Menuable {
  internal var level: Int = 0
  internal var container: Container
  internal weak var parentable: Menuable?
  internal var menus = [Menu]()
  internal var event = Event<Void>()

  var aTitle: NSMutableAttributedString {
    get { return currentTitle() }
    set { attributedTitle = newValue }
  }

  /**
    @title A title to be displayed as an item in a menu bar
    @params Parameters read and parsed from stdin, i.e terminal=false
    @menus Sub menus for this item
    @level The number of levels down from the tray
  */
  init(_ title: String, container: Container = Container(), menus: [Menu] = [], level: Int = 0) {
    self.container = container
    self.level = level
    super.init(title)
    container.delegate = self
    add(menus: menus)
  }

  /**
    Same as above, but derives the @level from a @parent
  */
  convenience init(_ title: String, container: Container, menus: [Menu] = [], parent: Menuable) {
    self.init(title, container: container, menus: menus, level: parent.level + 1)
  }

  func submenu(didTriggerRefresh menu: Menuable) {
    parentable?.submenu(didTriggerRefresh: menu)
  }

  func refresh() {
    parentable?.submenu(didTriggerRefresh: self)
  }

  /**
    Add @menu to sub menu
  */
  func add(menu: NSMenuItem) {
    if hasDropdown() {
      addSub(menu)
    }
  }

  func add(error: String) {
    // TODO: Add an icon
    // set(title: "Received an error")
    // addSub(error)
  }

  /**
    Use @self as alternativ item
  */
  func useAsAlternate() {
    isAlternate = true
    keyEquivalentModifierMask = NSAlternateKeyMask
  }

  /**
    @state Used to turn the checkbox marker on/off
  */
  func update(state: Int) {
    self.state = state
  }

  /**
    Should refresh events cascade to its parent?
    Set by the refresh=bool attribute
  */
  func shouldRefresh() -> Bool {
    return container.shouldRefresh()
  }

  /**
    Should sub menus be disabled?
    Set by the dropdown=bool attribute
  */
  func hasDropdown() -> Bool {
    return container.hasDropdown()
  }

  /**
    Should the terminal be opened when clicked?
    Set by the terminal=bool attribute
  */
  func openTerminal() -> Bool {
    return container.openTerminal()
  }

  /**
    Menus starting with a dash "-" are considered separators
  */
  func isSeparator() -> Bool {
    return title.trim() == "-"
  }

  private func currentTitle() -> NSMutableAttributedString {
    guard let title = attributedTitle else {
      return NSMutableAttributedString(withDefaultFont: self.title)
    }

    return title.mutable()
  }

  required init(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

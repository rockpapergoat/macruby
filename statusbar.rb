#!/usr/local/bin/macruby
# cf. https://gist.github.com/245402/8a52e988c2e65be7e497850085034835aa6aaea2
#
framework 'Cocoa'

class StatusBar
# Initialize the stuff
#
# We build the status bar item menu
def self.setupMenu
  menu = NSMenu.new
  menu.initWithTitle 'LLSecStat'
  menu = NSMenu.new
  mi = NSMenuItem.new
  mi.title = 'Update'
  mi.action = 'update:'
  mi.target = self
  menu.addItem mi

  mi = NSMenuItem.new
  mi.title = 'Display status'
  mi.action = 'display:'
  mi.target = self
  menu.addItem mi

  mi = NSMenuItem.new
  mi.title = 'About LLSecStat'
  mi.action = 'about:'
  mi.target = self
  menu.addItem mi
  
#  mi = NSMenuItem.new
#  mi.title = 'Quit'
#  mi.action = 'quit:'
#  mi.target = self
#  menu.addItem mi

  menu
end

# Init the status bar
def self.initStatusBar(menu)
  status_bar = NSStatusBar.systemStatusBar
  status_item = status_bar.statusItemWithLength(NSVariableStatusItemLength)
  status_item.setMenu menu 
  img = NSImage.new.initWithContentsOfFile 'green.png'
  status_item.setImage(img)
end

#
# Menu Item Actions
#
def self.about(sender)
    alert = NSAlert.new
    alert.messageText = 'LLSecStat, Lincoln Labs, 2012'
    alert.informativeText = 'Nate St. Germain, 11-70'
    alert.alertStyle = NSInformationalAlertStyle
    alert.addButtonWithTitle("Thanks")
    response = alert.runModal
end


def self.update(sender)
  url = NSURL.URLWithString(ARGV[0])
#    alert = NSAlert.new
#    alert.messageText = 'LLSecStat, Lincoln Labs, 2012'
#    alert.informativeText = 'Nate St. Germain, 11-70'
#    alert.alertStyle = NSInformationalAlertStyle
#    alert.addButtonWithTitle("Thanks")
    response = NSWorkspace.sharedWorkspace.openURL(url)
end

def quit(sender)
  app = NSApplication.sharedApplication
  app.terminate(self)
end

def self.new
  # Rock'n Roll
  app = NSApplication.sharedApplication
  # Create the status bar item, add the menu and set the image
  initStatusBar(setupMenu)
  app.run  
end

end

StatusBar.new
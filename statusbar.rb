#!/usr/local/bin/macruby
# cf. https://gist.github.com/245402/8a52e988c2e65be7e497850085034835aa6aaea2
#
framework 'Cocoa'

class StatusBar

def self.set_menu_items
    @year = Time.now.year.to_s
    @title = 'Troll-o-matic'
    @author = 'nate'
    @icon = "trollface_big.png"
    @about = ["Troll-o-matic\nbendable pliers, inc.\n#{@year}", @author, "Thanks"]
    @menus = {"Update" => "update:", "Display" => "display:", "About #{@title}" => "about:"}
end

# We build the status bar item menu
def self.setup_menu(menus)
  menu = NSMenu.new
  menu.initWithTitle @title
  menu = NSMenu.new
  menus.each_pair do |k,v|
      mi = NSMenuItem.new
      mi.title = k
      mi.action = v
      mi.target = self
      menu.addItem mi
  end
  menu
end

# Init the status bar
def self.init_status_bar(menu)
  status_bar = NSStatusBar.systemStatusBar
  status_item = status_bar.statusItemWithLength(NSVariableStatusItemLength)
  status_item.setMenu menu
  img = NSImage.new.initWithContentsOfFile ARGV[0]
  status_item.setImage(img)
  status_item.setTitle("IT SEC STATUS: NORMAL")
end

#
# Menu Item Actions
#
def self.about(sender,about,icon)
    about = @about
    icon = @icon
    alert = NSAlert.new
    alert.messageText = about[0]
    alert.informativeText = about[1]
    alert.alertStyle = NSInformationalAlertStyle
    alert.addButtonWithTitle(about[2])
    alert.setIcon(NSImage.new.initWithContentsOfFile icon)
    response = alert.runModal
end


# set prefs

def self.set_prefs
  # writeToFile_atomically
end

# get prefs

def self.get_prefs(prefs)
  # test whether prefs exist here or outside at initialization?
  # if not, set_prefs with some defaults, then read them
  # https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html
  @config = load_plist File.read(prefs)
  # read: NSDictionary.dictionaryWithContentsOfFile
end


# parse rss feed

def self.parse_rss(feed)
  feed = NSURL.URLWithString(ARGV[1])
end

# scrape a page for something

def self.scrape_page(url)
  url = NSURL.URLWithString(url)
end

# display menu action

def self.display(sender)
  url = NSURL.URLWithString(ARGV[1])
  response = NSWorkspace.sharedWorkspace.openURL(url)
end


# update menu action

def self.update(sender)
  url = NSURL.URLWithString(ARGV[1])
  response = NSWorkspace.sharedWorkspace.openURL(url)
end

def quit(sender)
  app = NSApplication.sharedApplication
  app.terminate(self)
end

def self.new
    
    app = NSApplication.sharedApplication
    # Create the status bar item, add the menu and set the image
    init_status_bar(setup_menu(set_menu_items))
    app.run
end

end

StatusBar.new

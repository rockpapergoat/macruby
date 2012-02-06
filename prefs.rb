#!/usr/local/bin/macruby

def get_prefs(pref)
  @config = load_plist File.read(pref)
  #NSDictionary.dictionaryWithContentsOfFile(@config)
end

def get_repo(config)
    puts config["SoftwareRepoURL"]
end


get_prefs("/Library/Preferences/ManagedInstalls.plist")
get_repo(@config)

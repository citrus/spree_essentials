require "spree_core"
require "rdiscount"

require "spree_essentials/version"
require "spree_essentials/engine"

module SpreeEssentials
  
  class << self
  
    # Stores an essential-aware extension for use later
    def register(key, extension)
      essentials[key] = extension
    end
        
    # Looks up an extension name 
    def has?(essential)
      essentials.keys.include?(essential.to_sym)
    end
    
    # Returns the array of essential-aware extensions
    def essentials
      @essentials ||= {}
    end
    
  end
  
end

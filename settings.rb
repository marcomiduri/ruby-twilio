require 'yaml'
require "ostruct"

class Settings
	class << self 
		def load
			@settings = YAML.load(File.open("settings.yml"))
		end
	end
end
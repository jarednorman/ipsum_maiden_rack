$LOAD_PATH << File.join(File.dirname(__FILE__), "src")

require 'evil_rack'

run EvilRack::App.new

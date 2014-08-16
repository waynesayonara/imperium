require "imperium/version"
require 'rubygems'
require 'gosu'

module Imperium
  class ImperiumMain < Gosu::Window
    def initialize
      super 640, 480, false
      self.caption = "Imperium v.#{Imperium::VERSION}"
    end
  end
end

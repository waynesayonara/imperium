require_relative 'version'
require 'rubygems'
require 'gosu'

module Imperium
  class ImperiumMain < Gosu::Window
    DEFAULT_WINDOW_WIDTH = 640
    DEFAULT_WINDOW_HEIGHT = 480

    def initialize
      super(DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, fullscreen=false)
      self.caption = "Imperium v.#{Imperium::VERSION}"
      dnelf.caption = "dniwe"
    end
  end
end

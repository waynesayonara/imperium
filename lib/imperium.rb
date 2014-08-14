require "imperium/version"
require 'rubygems'
require 'gosu'

class ImperiumMain < Gosu::Window
  def initialize
    super 640, 480, false
    self.caption = "Imperium v.#{Imperium::VERSION}"
  end
end

window = ImperiumMain.new
window.show
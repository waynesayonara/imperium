require_relative '../test/spec_helper'
require 'imperium'

class ImperiumMainMock
  def stub(*args)
    true
  end

  alias initialize stub
end

GosuWindowBackup = Gosu::Window
Gosu.send(:remove_const, :Window)
Gosu::Window = ImperiumMainMock

GuiBackup = Imperium::ImperiumMain
Imperium.send(:remove_const, :ImperiumMain)

load 'imperium/imperium_main.rb' # reload gui.rb after stubbing

FakeGui = Imperium::ImperiumMain # catch the stubbed gui

Imperium.send(:remove_const, :ImperiumMain)
Imperium::ImperiumMain = GuiBackup # restore things
Gosu.send(:remove_const, :Window)
Gosu::Window = GosuWindowBackup

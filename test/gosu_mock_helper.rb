require_relative 'spec_helper'

$window_back_up
$window = Imperium::ImperiumMain.new

RSpec.configure do |config|
  # config.before(:all) do
  #   GosuWindowBackup ||= Gosu::Window
  #   GosuImageBackup ||= Gosu::Image
  #   Gosu.send(:remove_const, :Window)
  #   Gosu.send(:remove_const, :Image)
  #   Gosu::Window = GosuMock::Window
  #   Gosu::Image = GosuMock::Image
  #
  #   $window_back_up = $window
  #   $window = GosuMock::Window.new(200, 200, false)
  # end
  #
  # config.after(:all) do
  #   Gosu.send(:remove_const, :Window)
  #   Gosu.send(:remove_const, :Image)
  #   Gosu::Window = GosuWindowBackup
  #   Gosu::Image = GosuImageBackup
  #
  #   $window = $window_back_up
  #
  #   puts 'KKK' + $window.is_a?(Gosu::Window).to_s
  #
  #   Object.class_eval('Gosu::Image')
  # end

  # config.after(:each) do
  #   # clean up
  #   $window.drawing_events.clear
  # end
end

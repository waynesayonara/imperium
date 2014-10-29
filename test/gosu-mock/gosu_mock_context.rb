require_relative '../spec_helper'
require 'rspec/core/shared_context'

module GosuMockContext extend RSpec::Core::SharedContext
  before(:all) do
    if($window.is_a?(Imperium::ImperiumMain))
      GosuWindowBackup ||= Gosu::Window
      GosuImageBackup ||= Gosu::Image
      Gosu.send(:remove_const, :Window)
      Gosu.send(:remove_const, :Image)
      Gosu::Window = GosuMock::Window
      Gosu::Image = GosuMock::Image

      $window_back_up = $window
      $window = GosuMock::Window.new(200, 200, false)
    end
  end

  after(:all) do
    if(!$window.is_a?(Imperium::ImperiumMain))
      Gosu.send(:remove_const, :Window)
      Gosu.send(:remove_const, :Image)
      Gosu::Window = GosuWindowBackup
      Gosu::Image = GosuImageBackup

      $window = $window_back_up
    end
  end

  after(:each) do
    # clean up
    $window.drawing_events.clear
  end
end

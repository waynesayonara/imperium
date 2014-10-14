require 'rspec'
require_relative '../lib/imperium'
require_relative 'gosu_mock_helper'
require_relative '../test/gosu-mock/gosu_mock'

describe 'Imperium::MenuScene rendering' do
  class MockWindow < GosuMock::Window
    def initialize
      super(200,200,false)
      @image = Gosu::Image.new(self, 'picture.png', false)
    end

    def draw
      @image.draw(0, 0, 0) unless button_down?(5) # I haven't added the constants yet, but they'll come
    end
  end

  # examples of GUI tests, they don't really test imperium functionality
  it 'renders menu scene according to data model' do
    window = MockWindow.new
    window.do_tick
    file_name = window.drawing_events[0].content.filename
    expect(file_name).to be == 'picture.png'
  end

  it 'renders menu scene according to data model with lol' do
    window = MockWindow.new
    window.user_presses_button(5)
    window.do_tick

    expect(window.drawing_events.empty?).to be true
  end
end
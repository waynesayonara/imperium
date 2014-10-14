require 'rspec'
require_relative '../lib/imperium'
require_relative 'gosu_mock_helper'
require_relative '../test/gosu-mock/gosu_mock'

describe Imperium::MenuElementControl do
  @area
  @image_active
  @image_normal
  @action
  @valid_data_model

  before(:all) do
    @area = Imperium::Area.new(Imperium::Point.new(2, 3), 4, 5)
    @image_normal = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    @image_active = Gosu::Image.new($window, '../resources/menu/exit_selected.png', false)
    @action = lambda { raise StandardError.new 'click action!' }
    @valid_data_model = Imperium::DataModels::MenuSceneElementDataModel.new(@area, @image_active, @image_normal, @action)
  end

  it 'should render active image when hover is on' do
    @control = Imperium::MenuElementControl.new(@valid_data_model)

    @control.hover(true)
    @control.render_control

    expect($window.drawing_events.count).to be == 1
    drawing_event = $window.drawing_events[0]
    expect(drawing_event).not_to be_nil
    expect(drawing_event.options[:x]).to be == @area.top_point.x
    expect(drawing_event.options[:y]).to be == @area.top_point.y
    expect(drawing_event.options[:z]).to be == 0
    expect(drawing_event.content).to be == @image_active
  end

  it 'should render normal image when hover is off' do
    @control = Imperium::MenuElementControl.new(@valid_data_model)

    @control.hover(false)
    @control.render_control

    expect($window.drawing_events.count).to be == 1
    drawing_event = $window.drawing_events[0]
    expect(drawing_event).not_to be_nil
    expect(drawing_event.options[:x]).to be == @area.top_point.x
    expect(drawing_event.options[:y]).to be == @area.top_point.y
    expect(drawing_event.options[:z]).to be == 0
    expect(drawing_event.content).to be == @image_normal
  end

  it 'should call lambda action on click' do
    @control = Imperium::MenuElementControl.new(@valid_data_model)
    expect { @control.button_up(Gosu::MsLeft, @area.top_point) }.to raise_error(StandardError, 'click action!')
  end
end

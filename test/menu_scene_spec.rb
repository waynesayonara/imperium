require 'rspec'
require_relative '../lib/imperium'
require_relative '../test/gosu-mock/gosu_mock_context'

describe Imperium::MenuScene do
  include GosuMockContext

  @valid_area
  @valid_background_image
  @valid_image
  @valid_data_model

  before(:all) do
    @valid_area = Engine::Area.new(Engine::Point.new(1, 1), 1, 1)
    @valid_background_image = Gosu::Image.new($window, '../resources/menu/new_game.png', false)
    @valid_image = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    valid_action = lambda { puts 'action performed!' }

    @valid_data_model = Engine::DataModels::MenuSceneDataModel.new(
        @valid_background_image,
        {
            'elem1' => Engine::DataModels::MenuSceneElementDataModel.new(@valid_area, @valid_image, @valid_image, valid_action),
        })
  end

  it 'is initialized with valid data model' do
    menu_scene = nil
    expect{ menu_scene = Imperium::MenuScene.new(@valid_data_model) }.not_to raise_error
    expect(menu_scene.ui_controls.count).to be == @valid_data_model.menu_elements.values.count
    expect(menu_scene.ui_controls.map{ |c| c.area }).to contain_exactly(@valid_area)
  end

  it 'renders background and menu element controls' do
    menu_scene = Imperium::MenuScene.new(@valid_data_model)

    $window.drawing_events.clear
    menu_scene.render_scene

    drawing_events = $window.drawing_events
    expect(drawing_events).not_to be_nil
    expect(drawing_events.count).to be == 2

    background_drawing_event = drawing_events[0]
    expect(background_drawing_event.options[:x]).to be == 0
    expect(background_drawing_event.options[:y]).to be == 0
    expect(background_drawing_event.options[:z]).to be == 0
    expect(background_drawing_event.content).to be == @valid_background_image

    control_drawing_event = drawing_events[1]
    expect(control_drawing_event.options[:x]).to be == @valid_area.top_point.x
    expect(control_drawing_event.options[:y]).to be == @valid_area.top_point.y
    expect(control_drawing_event.options[:z]).to be == 0
    expect(control_drawing_event.content).to be == @valid_image
  end
end
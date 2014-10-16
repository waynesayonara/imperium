require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Engine::MenuScene do

  it 'can be initialized with valid data model' do
    valid_area = Engine::Area.new(Engine::Point.new(1, 1), 1, 1)
    valid_image = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    valid_action = lambda { puts 'action performed!' }

    @data_model = Engine::DataModels::MenuSceneDataModel.new(
                  valid_image,
                  {
                      'elem1' => Engine::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, valid_image, valid_action),
                      'elem2' => Engine::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, valid_image, valid_action)
                  })
    expect{ Engine::MenuScene.new(@data_model) }.not_to raise_error
  end
end
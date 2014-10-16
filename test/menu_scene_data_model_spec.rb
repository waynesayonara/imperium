require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Engine::DataModels::MenuSceneDataModel do

  before(:all) do
    @valid_image = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    @valid_area = Engine::Area.new(Engine::Point.new(1, 1), 1, 1)
    @valid_action =  lambda { puts 'action performed!' }
  end

  it 'can be initialized with a collection of MenuSceneElementDataModel' do
    valid_elem_data_model =
            {
                'elem1' => Imperium::DataModels::MenuSceneElementDataModel.new(@valid_area, @valid_image, @valid_image, @valid_action)
            }

    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, valid_elem_data_model)
    }.not_to raise_error
  end

  it 'cannot be initialized with invalid data' do
    expect{
      Engine::DataModels::MenuSceneDataModel.new(nil, 'someString')
    }.to raise_error ArgumentError
    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, nil)
    }.to raise_error ArgumentError
    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, 'someOtherString')
    }.to raise_error ArgumentError
    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, 'someOtherString')
    }.to raise_error ArgumentError
    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, {})
      }.to raise_error ArgumentError
    expect{
      Engine::DataModels::MenuSceneDataModel.new(@valid_image, { 'key1' => 1, 'key2' => 2 })
      }.to raise_error ArgumentError
  end

  it 'has background and elements accessor' do
    valid_area = Engine::Area.new(Engine::Point.new(1, 1), 1, 1)
    valid_image = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    valid_action = lambda { puts 'action performed!' }

    valid_elem_data_model =
        {
            'elem1' => Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, valid_image, valid_action)
        }


    data_model = Engine::DataModels::MenuSceneDataModel.new(@valid_image, valid_elem_data_model)

    expect(data_model.background).to be == @valid_image
    expect(data_model.menu_elements).to be == valid_elem_data_model
  end
end
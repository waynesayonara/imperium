require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::DataModels::MenuSceneElementDataModel do

  it 'should cannot be initialized with invalid values' do
    valid_area = Engine::Area.new(Engine::Point.new(1, 1), 1, 1)
    valid_image = Gosu::Image.new($window, '../resources/menu/exit.png', false)
    valid_action = lambda { puts 'action performed!' }

    expect { Imperium::DataModels::MenuSceneElementDataModel.new(nil, valid_image, valid_image, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, nil, valid_image, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, nil, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, valid_image, nil) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(Array.new, valid_image, valid_image, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, Array.new, valid_image, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, Array.new, valid_action) }.to raise_error ArgumentError
    expect { Imperium::DataModels::MenuSceneElementDataModel.new(valid_area, valid_image, valid_image, Array.new) }.to raise_error ArgumentError
  end
end
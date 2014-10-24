require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/imperium'

describe Imperium::DataModels::MenuSceneDataModelFactory do

  # dynamically calls all public methods in MenuSceneDataModelFactory
  # and checks whether calls to these method produce valid data models
  it 'should create a valid menu scene data model' do
    factory_methods = (Imperium::DataModels::MenuSceneDataModelFactory.public_methods - Object.public_methods)

    factory_methods.each do |method|
      data_model = Imperium::DataModels::MenuSceneDataModelFactory.send(method)
      expect { Imperium::MenuScene.new(data_model) }.not_to raise_error
    end
  end
end
require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::MenuScene do

  it 'can be initialized with valid data model' do
    @data_model = Imperium::DataModels::MenuSceneDataModel.new(
                  'background',
                  {
                      'elem1' => Imperium::DataModels::MenuSceneElementDataModel.new,
                      'elem2' => Imperium::DataModels::MenuSceneElementDataModel.new
                  })
    expect{ Imperium::MenuScene.new(@data_model) }.not_to raise_error
  end
end
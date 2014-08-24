require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::DataModels::MenuSceneDataModel do
  it 'can be initialized with a collection of MenuSceneElementDataModel' do
    expect{
      Imperium::DataModels::MenuSceneDataModel.new(
          'someString',
          {
              'elem1' => Imperium::DataModels::MenuSceneElementDataModel.new,
              'elem2' => Imperium::DataModels::MenuSceneElementDataModel.new
          })
    }.not_to raise_error
  end

  it 'cannot be initialized with invalid data' do
    expect{
      Imperium::DataModels::MenuSceneDataModel.new(nil, 'someString')
    }.to raise_error ArgumentError
    expect{
      Imperium::DataModels::MenuSceneDataModel.new('someString', nil)
    }.to raise_error ArgumentError
    expect{
      Imperium::DataModels::MenuSceneDataModel.new('someString', 'someOtherString')
    }.to raise_error ArgumentError
    expect{
      Imperium::DataModels::MenuSceneDataModel.new('someString', 'someOtherString')
    }.to raise_error ArgumentError
    expect{
      Imperium::DataModels::MenuSceneDataModel.new('someString', {})
      }.to raise_error ArgumentError
    expect{
      Imperium::DataModels::MenuSceneDataModel.new('someString', { 'key1' => 1, 'key2' => 2 })
      }.to raise_error ArgumentError
  end
end
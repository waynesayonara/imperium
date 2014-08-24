require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::Scene do

  class SceneImpl
    include Imperium::Scene
  end

  before(:each) do
    @mock = SceneImpl.new
  end

  it 'should respond to rendering' do
    expect(@mock).to respond_to(:render_scene)
  end

  it 'should respond to button down event' do
    expect(@mock).to respond_to(:button_down)
  end

  it 'should respond to button up event' do
    expect(@mock).to respond_to(:button_up)
  end

  it 'should have data model' do
    data_model = Array.new
    expect(@mock.data_model_type).to be nil
    expect(@mock.data_model).to be nil
    @mock.data_model_type = Array
    @mock.data_model = data_model
    expect(@mock.data_model).to be == data_model
  end

  it 'cannot set data model when data model type is nil' do
    expect(@mock.data_model_type).to be nil
    expect{ @mock.data_model = Array.new }.to raise_error StandardError
  end

  it 'cannot set wrong data model to scene' do
    @mock.data_model_type = Array
    data_model = Exception.new
    expect{ @mock.data_model = data_model }.to raise_error TypeError
  end
end
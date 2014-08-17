require 'rspec'
require 'rspec/expectations'
require_relative 'spec_helper'

describe 'Test environment is working' do
  it 'should pass always passing test' do
    expect(true).to be true
  end
end
require 'rspec'
require 'rspec/expectations'
require 'imperium'
require_relative 'spec_helper'

describe Imperium::ImperiumMain do
  it 'has version number in its caption' do
    instance = Imperium::ImperiumMain.new;
    expect(instance.caption).to include("some text. take 2 #{Imperium::VERSION}")
  end
end

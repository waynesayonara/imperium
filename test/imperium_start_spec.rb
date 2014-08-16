require 'rspec'
require 'rspec/expectations'
require 'imperium/imperium_main'
require 'rubygems'
require 'gosu'

describe Imperium::ImperiumMain do

  it 'should be a Gosu window' do
    expect(Imperium::ImperiumMain.new).to be_a Gosu::Window
  end
end
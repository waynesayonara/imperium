require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::Point do

  it 'should not accept negative coordinates' do
    point = Imperium::Point.new(3,5)
    expect(point.x).to be == 3
    expect(point.y).to be == 5
    point.x = 10
    point.y = 100
    expect(point.x).to be == 10
    expect(point.y).to be == 100

    expect { point.x = -8 }.to raise_error ArgumentError
    expect { point.y = -7 }.to raise_error ArgumentError
    expect(point.x).to be == 10
    expect(point.y).to be == 100
  end

  it 'should not accept invalid coordinates in constructor' do
    expect { Imperium::Point.new(-3,5) }.to raise_error ArgumentError
    expect { Imperium::Point.new(3,-5) }.to raise_error ArgumentError
    expect { Imperium::Point.new(3, nil) }.to raise_error ArgumentError
    expect { Imperium::Point.new(nil, 5) }.to raise_error ArgumentError
    expect { Imperium::Point.new(3, Array.new) }.to raise_error ArgumentError
  end

  it 'should return false for comparing unequal points' do
     expect(Imperium::Point.new(3,5)).not_to be eql Imperium::Point.new(4,5)
  end

  it 'should return true for comparing equal points' do
    expect(Imperium::Point.new(3,5)).to be == Imperium::Point.new(3,5)
  end
end
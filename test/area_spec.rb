require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Engine::Area do

  it 'should not accept invalid coordinates/size' do
    top_point = Engine::Point.new(5,7)
    area = Engine::Area.new(top_point, 10, 15)
    expect(area.top_point).to be == top_point
    expect(area.width).to be == 10
    expect(area.height).to be == 15

    another_point = Engine::Point.new(15, 25)
    area.top_point = another_point
    expect(area.top_point).to be == another_point

    area.width = 27
    expect(area.width).to be == 27

    area.height = 36
    expect(area.height).to be == 36

    expect { area.top_point = nil }.to raise_error ArgumentError
    expect { area.width = -10 }.to raise_error ArgumentError
    expect { area.width = nil }.to raise_error ArgumentError
    expect { area.height = -10 }.to raise_error ArgumentError
    expect { area.height = nil }.to raise_error ArgumentError

    expect { Engine::Area.new(top_point, -10, 15) }.to raise_error ArgumentError
    expect { Engine::Area.new(top_point, 10, -15) }.to raise_error ArgumentError
    expect { Engine::Area.new(top_point, nil, 15) }.to raise_error ArgumentError
    expect { Engine::Area.new(top_point, 10, nil) }.to raise_error ArgumentError
    expect { Engine::Area.new(nil, 10, 15) }.to raise_error ArgumentError
    expect { Engine::Area.new(Array.new, 10, 15) }.to raise_error ArgumentError
  end

  it 'correctly shows included points' do
    top_point = Engine::Point.new(2,2)
    area = Engine::Area.new(top_point, 10, 15)

    included_point1 = Engine::Point.new(2,2)
    included_point2 = Engine::Point.new(2,17)
    included_point3 = Engine::Point.new(12,2)
    included_point4 = Engine::Point.new(12,17)
    included_point5 = Engine::Point.new(5,5)
    included_point6 = Engine::Point.new(3,2)
    included_point7 = Engine::Point.new(10,10)
    excluded_point1 = Engine::Point.new(1,1)
    excluded_point2 = Engine::Point.new(1,10)
    excluded_point3 = Engine::Point.new(10,1)
    excluded_point4 = Engine::Point.new(13,5)
    excluded_point5 = Engine::Point.new(5,18)

    expect { area.includes?(nil) }.to raise_error ArgumentError
    expect { area.includes?(Array.new) }.to raise_error ArgumentError

    expect(area.includes?(included_point1)).to be true
    expect(area.includes?(included_point2)).to be true
    expect(area.includes?(included_point3)).to be true
    expect(area.includes?(included_point4)).to be true
    expect(area.includes?(included_point5)).to be true
    expect(area.includes?(included_point6)).to be true
    expect(area.includes?(included_point7)).to be true
    expect(area.includes?(excluded_point1)).to be false
    expect(area.includes?(excluded_point2)).to be false
    expect(area.includes?(excluded_point3)).to be false
    expect(area.includes?(excluded_point4)).to be false
    expect(area.includes?(excluded_point5)).to be false
  end
end
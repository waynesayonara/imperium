require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Engine::AreaPositioner do
  it 'cannot be initialized with invalid canvas size' do
    expect { Engine::AreaPositioner.new(1, -1) }.to raise_error ArgumentError
    expect { Engine::AreaPositioner.new(-1, 1) }.to raise_error ArgumentError
    expect { Engine::AreaPositioner.new(1, 1) }.not_to raise_error
    expect { Engine::AreaPositioner.new(0, 0) }.not_to raise_error
  end

  it 'aligns to top left by default' do
    positioner = Engine::AreaPositioner.new(10, 10)
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_top_point.y).to be == 0

    positioner.area_height(3)
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 3
    expect(positioner.get_area.width).to be == 0

    positioner.area_width(3)
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 3
    expect(positioner.get_area.width).to be == 3

    positioner.bottom_offset(1)
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 3
    expect(positioner.get_area.width).to be == 3

    positioner.right_offset(1)
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 3
    expect(positioner.get_area.width).to be == 3
  end

  it 'does bottom alignment' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        align_bottom
    expect(positioner.get_top_point.y).to be == 6
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 3

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        bottom_offset(2).
                                        align_bottom
    expect(positioner.get_top_point.y).to be == 4
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 3
  end

  it 'does top alignment' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        top_offset(2).
                                        align_top
    expect(positioner.get_top_point.y).to be == 2
    expect(positioner.get_top_point.x).to be == 0
  end

  it 'does right alignment' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        align_right
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_top_point.x).to be == 7
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 3

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        right_offset(2).
                                        align_right
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_top_point.x).to be == 5
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 3
  end

  it 'does left alignment' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(3).
                                        area_height(4).
                                        left_offset(2).
                                        align_left
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_top_point.x).to be == 2
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 3
  end

  it 'does vertical centering' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        center_vertically

    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        top_offset(2).
                                        center_vertically

    expect(positioner.get_top_point.y).to be == 4
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        bottom_offset(2).
                                        center_vertically

    expect(positioner.get_top_point.y).to be == 2
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        top_offset(2).
                                        bottom_offset(2).
                                        center_vertically

    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_top_point.x).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4
  end


  it 'does horizontal centering' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 3
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        left_offset(2).
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 4
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        right_offset(2).
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 2
    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        left_offset(2).
                                        right_offset(2).
                                        center_horizontally

    expect(positioner.get_top_point.y).to be == 0
    expect(positioner.get_top_point.x).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4
  end

  it 'does vertical and horizontal centering' do
    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        center_horizontally.
                                        center_vertically

    expect(positioner.get_top_point.x).to be == 3
    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        left_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 4
    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        left_offset(2).
                                        top_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 4
    expect(positioner.get_top_point.y).to be == 4
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        right_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 2
    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        right_offset(2).
                                        top_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.x).to be == 2
    expect(positioner.get_top_point.y).to be == 4
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        left_offset(2).
                                        right_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_top_point.x).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4

    positioner = Engine::AreaPositioner.new(10, 10).
                                        area_width(4).
                                        area_height(4).
                                        top_offset(2).
                                        bottom_offset(2).
                                        center_vertically.
                                        center_horizontally

    expect(positioner.get_top_point.y).to be == 3
    expect(positioner.get_top_point.x).to be == 3
    expect(positioner.get_area.height).to be == 4
    expect(positioner.get_area.width).to be == 4
  end
end
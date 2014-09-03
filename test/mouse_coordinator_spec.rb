require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::MouseCoordinator do
  class MouseCoordinatorImpl
    include Imperium::MouseCoordinator

    def process_movement_public(point)
      process_movement(point)
    end

    def process_click_public(button_id, point)
      process_click(button_id, point)
    end
  end

  class ControlImpl
    include Imperium::Control
  end

  class ThrowingSizableControlImpl
    include Imperium::Control

    @id

    def initialize(id, area)
      if(area.nil? || !area.is_a?(Imperium::Area))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Area}"
      end

      @id = id
      self.area = area
    end

    def is_active=(value)
      super value
    end

    protected
    def on_hover_activated
      raise StandardError.new "hover on at #{@id}!"
    end

    def on_hover_deactivated
      raise StandardError.new "hover off at #{@id}!"
    end

    def on_mouse_down(button_id)
      raise StandardError.new "mouse down at #{@id}!"
    end

    def on_mouse_up(button_id)
      raise StandardError.new "mouse up at #{@id}!"
    end

    def on_click(button_id)
      raise StandardError.new "click at #{@id}!"
    end
  end

  it 'adds and removes controls' do
    instance = MouseCoordinatorImpl.new
    expect(instance.ui_controls).to_not be_nil
    validControl = ControlImpl.new
    instance.add_control(validControl)
    expect(instance.ui_controls.count).to be == 1
    invalidControl = StandardError.new 'test'
    expect { instance.add_control(invalidControl) }.to raise_error ArgumentError
    expect { instance.add_control(nil) }.to raise_error ArgumentError

    instance.remove_control(invalidControl)
    expect(instance.ui_controls.count).to be == 1
    instance.remove_control(validControl)
    expect(instance.ui_controls.empty?).to be true
  end

  it 'cannot add control twice' do
    instance = MouseCoordinatorImpl.new
    firstControl = ControlImpl.new
    secondControl = ControlImpl.new

    instance.add_control(firstControl)
    expect(instance.ui_controls.count).to be == 1
    instance.add_control(secondControl)
    expect(instance.ui_controls.count).to be == 2
    expect { instance.add_control(firstControl) }.to raise_error ArgumentError
    expect(instance.ui_controls.count).to be == 2
  end

  it 'activates hover events on controls' do
    top_point = Imperium::Point.new(5, 3)
    area = Imperium::Area.new(top_point, 7, 9)
    throwingControl1 = ThrowingSizableControlImpl.new(1, area)
    instance = MouseCoordinatorImpl.new
    instance.add_control(throwingControl1)

    off_point = Imperium::Point.new(1, 1)
    on_point = Imperium::Point.new(10, 10)

    expect { instance.process_movement_public(off_point) }.not_to raise_error
    expect { instance.process_movement_public(on_point) }.to raise_error(StandardError, 'hover on at 1!')
    expect { instance.process_movement_public(off_point) }.to raise_error(StandardError, 'hover off at 1!')
  end

end
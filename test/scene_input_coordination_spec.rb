require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::Scene do
  class SceneImpl
    include Imperium::Scene
  end

  class ControlImpl
    include Imperium::Control

    def render_control
    end
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

    def render_control
      raise StandardError.new "rendered at #{@id}!"
    end

    def is_active
      super
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
      raise StandardError.new "button down at #{@id}!"
    end

    def on_mouse_up(button_id)
      raise StandardError.new "button up at #{@id}!"
    end
  end

  it 'adds and removes controls' do
    instance = SceneImpl.new
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
    instance = SceneImpl.new
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
    instance = SceneImpl.new
    expect{ instance.add_control(throwingControl1) }.to raise_error(StandardError, 'rendered at 1!')

    off_point = Imperium::Point.new(1, 1)
    on_point = Imperium::Point.new(10, 10)

    expect { instance.update(off_point) }.not_to raise_error
    expect(throwingControl1.is_active).to be false
    expect { instance.update(on_point) }.to raise_error(StandardError, 'hover on at 1!')
    expect(throwingControl1.is_active).to be true
    expect { instance.update(off_point) }.to raise_error(StandardError, 'hover off at 1!')
    expect(throwingControl1.is_active).to be false
  end

  it 'activates button_up/button_down on controls' do
    top_point = Imperium::Point.new(5, 3)
    area = Imperium::Area.new(top_point, 7, 9)
    area2 = Imperium::Area.new(top_point, 1, 1)
    throwingControl1 = ThrowingSizableControlImpl.new(1, area)
    throwingControl2 = ThrowingSizableControlImpl.new(2, area)
    instance = SceneImpl.new
    expect{ instance.add_control(throwingControl1) }.to raise_error(StandardError, 'rendered at 1!')
    expect{ instance.add_control(throwingControl2) }.to raise_error(StandardError, 'rendered at 2!')

    off_point = Imperium::Point.new(1, 1)
    on_point = Imperium::Point.new(10, 10)

    expect { instance.button_up(Gosu::Gp0Down, off_point) }.not_to raise_error
    expect { instance.button_down(Gosu::Gp0Down, on_point) }.to raise_error(StandardError, 'button down at 1!')
    expect(throwingControl1.is_active).to be true
    expect(throwingControl2.is_active).to be false
    expect { instance.button_up(Gosu::Gp0Down, on_point) }.to raise_error(StandardError, 'button up at 1!')
    expect(throwingControl1.is_active).to be false
    expect(throwingControl2.is_active).to be false
  end
end
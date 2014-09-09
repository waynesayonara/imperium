require 'rspec'
require 'rspec/expectations'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::Control do
  class ThrowingControlImpl
    include Imperium::Control

    def is_active=(value)
      super value
    end

    protected
    def on_hover_activated
      raise StandardError.new 'hover on!'
    end

    def on_hover_deactivated
      raise StandardError.new 'hover off!'
    end

    def on_mouse_down(button_id)
      raise StandardError.new 'mouse down!'
    end

    def on_mouse_up(button_id)
      raise StandardError.new 'mouse up!'
    end

    def on_click(button_id)
      raise StandardError.new 'click!'
    end
  end

  class ControlImpl
    include Imperium::Control

    def is_active=(value)
      super value
    end
  end

  it 'can be active or not' do
    instance = ControlImpl.new
    expect(instance.is_active).to be false
    instance.is_active= true
    expect(instance.is_active).to be true
    expect { instance.is_active = Array.new }.to raise_error ArgumentError
  end

  it 'responds to event methods' do
    instance = ControlImpl.new
    expect(instance).to respond_to(:hover)
    expect(instance).to respond_to(:button_up)
    expect(instance).to respond_to(:button_down)
  end

  it 'has area' do
    instance = ControlImpl.new
    expect(instance.area).to be_nil

    top_point = Imperium::Point.new(12, 13)
    area = Imperium::Area.new(top_point, 20, 10)
    instance.area = area
    expect(instance.area).to be == area
  end

  it 'cannot set invalid area' do
    instance = ControlImpl.new

    expect { instance.area = nil }.to raise_error ArgumentError
    expect { instance.area = Array.new }.to raise_error ArgumentError
  end

  it 'activates on hover' do
    instance = ControlImpl.new
    expect(instance.is_active).to be false
    instance.hover(true)
    expect(instance.is_active).to be true
    instance.hover(false)
    expect(instance.is_active).to be false
  end

  it 'calls hover implementations on event' do
    instance = ThrowingControlImpl.new
    expect { instance.hover(true) }.to raise_error(StandardError, 'hover on!')
    expect(instance.is_active).to be true
    expect { instance.hover(false) }.to raise_error(StandardError, 'hover off!')
    expect(instance.is_active).to be false
  end

  it 'activates on mouse_down and deactivates on mouse_up' do
    instance = ControlImpl.new
    expect(instance.is_active).to be false
    instance.button_down(Gosu::MsLeft)
    expect(instance.is_active).to be true
    instance.button_up(Gosu::MsLeft)
    expect(instance.is_active).to be false
  end

  it 'calls mouse_up and mouse_down implementations on event' do
    instance = ThrowingControlImpl.new
    expect { instance.button_down(Gosu::MsLeft) }.to raise_error(StandardError, 'mouse down!')
    expect(instance.is_active).to be true
    expect { instance.button_up(Gosu::MsLeft) }.to raise_error(StandardError, 'mouse up!')
    expect(instance.is_active).to be false
  end
end
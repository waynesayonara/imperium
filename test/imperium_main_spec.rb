require 'rspec'
require 'rspec/expectations'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::ImperiumMain do
  class SceneImpl
    include Imperium::Scene

    def render_scene(window)
    end
  end

  class ThrowingSceneImpl
    include Imperium::Scene

    def render_scene(window)
      raise StandardError.new 'rendered!'
    end

    def button_down(id, window)
      raise StandardError.new 'button down!'
    end

    def button_up(id, window)
      raise StandardError.new 'button up!'
    end
  end

  before(:all) do
    @instance = Imperium::ImperiumMain.new
    @menu_scene = SceneImpl.new
    @throwing_scene = ThrowingSceneImpl.new
  end

  it 'has version number in its caption' do
    expect(@instance.caption).to include("#{Imperium::VERSION}")
  end

  it 'pushes and pops scene' do
    expect(@instance.pop_scene).to be nil
    expect(@instance.push_scene(@menu_scene).size).to be 1
    expect(@instance.pop_scene).to be == @menu_scene
    expect(@instance.pop_scene).to be nil
  end

  it 'cannot push invalid scene' do
    expect{ @instance.push_scene(@instance) }.to raise_error ArgumentError
    expect{ @instance.push_scene(nil) }.to raise_error ArgumentError
  end

  it 'responds to button down event of uppermost scene' do
    expect { @instance.push_scene(@throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { @instance.button_down(Gosu::KbEscape) }.to raise_error(StandardError, 'button down!')
    expect { @instance.push_scene(@menu_scene) }.not_to raise_error
    expect { @instance.button_down(Gosu::KbEscape) }.not_to raise_error
  end

  it 'responds to button up event of uppermost scene' do
    expect { @instance.push_scene(@throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { @instance.button_up(Gosu::KbEscape) }.to raise_error(StandardError, 'button up!')
    expect { @instance.push_scene(@menu_scene) }.not_to raise_error
    expect { @instance.button_up(Gosu::KbEscape) }.not_to raise_error
  end

  it 'renders new scene after it is pushed' do
    expect { @instance.push_scene(@throwing_scene) }.to raise_error(StandardError, 'rendered!')
  end

  it 'renders previous scene after uppermost one is popped' do
    expect { @instance.push_scene(@throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { @instance.push_scene(@menu_scene) }.not_to raise_error
    expect { @instance.pop_scene }.to raise_error(StandardError, 'rendered!')
  end
end

require 'rspec'
require 'rspec/expectations'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::ImperiumMain do
  class SceneImpl
    include Engine::Scene

    attr_accessor :need_cursor

    def initialize
      self.need_cursor = false
    end

    def render_scene
    end

    def needs_cursor?
      self.need_cursor
    end
  end

  class ThrowingSceneImpl
    include Engine::Scene

    def render_scene
      raise StandardError.new 'rendered!'
    end

    def on_button_down(button_id, point)
      raise StandardError.new 'button down!'
    end

    def on_button_up(button_id, point)
      raise StandardError.new 'button up!'
    end

    def on_update(point)
      raise StandardError.new 'updated!'
    end
  end

  it 'has version number in its caption' do
    expect($window.caption).to include("#{Imperium::VERSION}")
  end

  it 'pushes and pops scene' do
    regular_scene = SceneImpl.new
    expect($window.pop_scene).to be nil
    expect($window.push_scene(regular_scene).size).to be 1
    expect($window.pop_scene).to be == regular_scene
    expect($window.pop_scene).to be nil
  end

  it 'cannot push invalid scene' do
    expect{ $window.push_scene($window) }.to raise_error ArgumentError
    expect{ $window.push_scene(nil) }.to raise_error ArgumentError
  end

  it 'responds to button down event of uppermost scene' do
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { $window.button_down(Gosu::KbEscape) }.to raise_error(StandardError, 'button down!')
    expect { $window.push_scene(regular_scene) }.not_to raise_error
    expect { $window.button_down(Gosu::KbEscape) }.not_to raise_error
  end

  it 'responds to button up event of uppermost scene' do
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { $window.button_up(Gosu::KbEscape) }.to raise_error(StandardError, 'button up!')
    expect { $window.push_scene(regular_scene) }.not_to raise_error
    expect { $window.button_up(Gosu::KbEscape) }.not_to raise_error
  end

  it 'renders new scene after it is pushed' do
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
  end

  it 'renders previous scene after uppermost one is popped' do
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { $window.push_scene(regular_scene) }.not_to raise_error
    expect { $window.pop_scene }.to raise_error(StandardError, 'rendered!')
  end

  it 'updates uppermost scene' do
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { $window.update }.to raise_error(StandardError, 'updated!')
  end

  it 'does not update bottom scenes' do
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { $window.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { $window.push_scene(regular_scene) }.not_to raise_error
    expect { $window.update }.not_to raise_error
  end

  it 'calculates whether cursor is needed using uppermost scene' do
    regular_scene = SceneImpl.new
    expect($window.needs_cursor?).to be false
    $window.push_scene(regular_scene)
    expect($window.needs_cursor?).to be false
    regular_scene.need_cursor = true
    expect($window.needs_cursor?).to be true
  end
end

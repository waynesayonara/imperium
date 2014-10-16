require 'rspec'
require 'rspec/expectations'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Engine::ImperiumMain do
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
    instance = Engine::ImperiumMain.new
    expect(instance.caption).to include("#{Engine::VERSION}")
  end

  it 'pushes and pops scene' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    expect(instance.pop_scene).to be nil
    expect(instance.push_scene(regular_scene).size).to be 1
    expect(instance.pop_scene).to be == regular_scene
    expect(instance.pop_scene).to be nil
  end

  it 'cannot push invalid scene' do
    instance = Engine::ImperiumMain.new
    expect{ instance.push_scene(instance) }.to raise_error ArgumentError
    expect{ instance.push_scene(nil) }.to raise_error ArgumentError
  end

  it 'responds to button down event of uppermost scene' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { instance.button_down(Gosu::KbEscape) }.to raise_error(StandardError, 'button down!')
    expect { instance.push_scene(regular_scene) }.not_to raise_error
    expect { instance.button_down(Gosu::KbEscape) }.not_to raise_error
  end

  it 'responds to button up event of uppermost scene' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { instance.button_up(Gosu::KbEscape) }.to raise_error(StandardError, 'button up!')
    expect { instance.push_scene(regular_scene) }.not_to raise_error
    expect { instance.button_up(Gosu::KbEscape) }.not_to raise_error
  end

  it 'renders new scene after it is pushed' do
    instance = Engine::ImperiumMain.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
  end

  it 'renders previous scene after uppermost one is popped' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { instance.push_scene(regular_scene) }.not_to raise_error
    expect { instance.pop_scene }.to raise_error(StandardError, 'rendered!')
  end

  it 'updates uppermost scene' do
    instance = Engine::ImperiumMain.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { instance.update }.to raise_error(StandardError, 'updated!')
  end

  it 'does not update bottom scenes' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    throwing_scene = ThrowingSceneImpl.new
    expect { instance.push_scene(throwing_scene) }.to raise_error(StandardError, 'rendered!')
    expect { instance.push_scene(regular_scene) }.not_to raise_error
    expect { instance.update }.not_to raise_error
  end

  it 'calculates whether cursor is needed using uppermost scene' do
    instance = Engine::ImperiumMain.new
    regular_scene = SceneImpl.new
    expect(instance.needs_cursor?).to be false
    instance.push_scene(regular_scene)
    expect(instance.needs_cursor?).to be false
    regular_scene.need_cursor = true
    expect(instance.needs_cursor?).to be true
  end
end

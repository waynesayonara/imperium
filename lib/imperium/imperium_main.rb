require_relative '../../lib/engine/ui/scenes/scene'
require 'rubygems'
require 'gosu'
require_relative '../../lib/engine/version'
require_relative '../../lib/engine/entity/entity'
require_relative '../../lib/engine/map/game_map'
require_relative '../../lib/engine/character/character'
require_relative '../../lib/engine/map/loader/tmx_map_loader'
require_relative '../../lib/engine/game/game_state'
require_relative '../../lib/engine/game/game_loader'
require_relative '../../lib/imperium/ui/scenes/implementations/game_scene'

module Imperium
  # Represents a single instance of game's main window.
  # Pushes and pops scenes, renders them and coordinates user input.
  class ImperiumMain < Gosu::Window
    DEFAULT_WINDOW_WIDTH = 1024
    DEFAULT_WINDOW_HEIGHT = 800

    def initialize
      super DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, fullscreen=false
      self.caption = "Imperium v.#{Engine::VERSION}"

      @scenes = []
    end

    public
    # renders window (uppermost scene)
    def draw
      if(!@scenes.empty?)
        @scenes[-1].render_scene
      end
    end

    # Pops uppermost scene and returns it
    def pop_scene
      scene = @scenes.last
      scene_popping(scene)
      result = @scenes.pop
      scene_popped(scene)
      result
    end

    # Pushes new scene to the uppermost position
    # and returns all current game scenes
    def push_scene(scene)
      if scene.nil? || !scene.is_a?(Engine::Scene)
        raise ArgumentError.new "Cannot push scene which is empty or not derived from #{Engine::Scene}"
      end
      scene_pushing(scene)
      result = @scenes.push(scene)
      scene_pushed(scene)
      result
    end

    # event trigger: fires after button is pressed
    def button_down(id)
      if(!@scenes.empty?)
        @scenes[-1].button_down(id, get_current_cursor_point)
      end
    end

    # event trigger: fires after button is released
    def button_up(id)
      if(!@scenes.empty?)
        @scenes[-1].button_up(id, get_current_cursor_point)
      end
    end

    # event method: is being trigger once every update_interval ms
    def update
      if(!@scenes.empty?)
        @scenes[-1].update(get_current_cursor_point)
      end
    end

    # determines whether window has to render mouse cursor
    def needs_cursor?
      if(!@scenes.empty?)
        return @scenes[-1].needs_cursor?
      end

      return false
    end

    private
    # event trigger: fires before scene is pushed to window
    def scene_pushing(scene)
    end

    # event trigger: fires after scene is pushed to window
    def scene_pushed(scene)
      draw
    end

    # event trigger: fires before scene is popped from window
    def scene_popping(scene)
    end

    # event trigger: fires after scene is popped from window
    def scene_popped(scene)
      draw
    end

    # calculates current cursor point
    def get_current_cursor_point
      x = [0, mouse_x.to_i].max
      y = [0, mouse_y.to_i].max
      return Engine::Point.new(x, y)
    end
  end
end

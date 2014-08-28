require_relative 'version'
require_relative '../../lib/imperium/ui/scenes/scene'
require 'rubygems'
require 'gosu'
require_relative 'version'
require_relative 'entity/npc'
require_relative 'map/game_map'
require_relative 'character/character'
require_relative 'map/loader/tmx_map_loader'
require_relative 'game/game_state'
require_relative 'game/game_loader'
require_relative '../../lib/imperium/ui/scenes/implementations/game_scene'

module Imperium
  class ImperiumMain < Gosu::Window
    DEFAULT_WINDOW_WIDTH = 1024
    DEFAULT_WINDOW_HEIGHT = 800

    def initialize
      super DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, fullscreen=false
      self.caption = "Imperium v.#{Imperium::VERSION}"

      @scenes = []
    end

    public
    def font
      @font
    end

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
      if scene.nil? || !scene.is_a?(Imperium::Scene)
        raise ArgumentError.new "Cannot push scene which is empty or not derived from #{Imperium::Scene}"
      end
      scene_pushing(scene)
      result = @scenes.push(scene)
      scene_pushed(scene)
      result
    end

    # Button press handler
    def button_down(id)
      if(!@scenes.empty?)
        @scenes[-1].button_down(id)
      end
    end

    # Button press handler
    def button_up(id)
      if(!@scenes.empty?)
        @scenes[-1].button_up(id)
      end
    end

    def update
      if(!@scenes.empty?)
        @scenes[-1].update
      end
    end

    def needs_cursor?
      if(!@scenes.empty?)
        return @scenes[-1].needs_cursor?
      end

      return false
    end

    private
    def scene_pushing(scene)
    end

    def scene_pushed(scene)
      draw
    end

    def scene_popping(scene)
    end

    def scene_popped(scene)
      draw
    end
  end
end

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

module Imperium
  class ImperiumMain < Gosu::Window
    DEFAULT_WINDOW_WIDTH = 640
    DEFAULT_WINDOW_HEIGHT = 480
    DEFAULT_MAP_SCROLLING_SPEED = 3

    def initialize
      super DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, fullscreen=false
      self.caption = "Imperium v.#{Imperium::VERSION}"
      @game = Game.load_game_from_map self, Map::TEST_PATH

      @scenes = []
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)

      #TODO: Implement Camera
      #Camera position
      @x = @y = 0
    end

    public
    def font
      @font
    end

    def current_map
      @game.get_current_map
    end

    def draw
      if(!@scenes.empty?)
        @scenes[-1].render_scene(self)
      end

      #TODO: Move to scene & camera rendering
      current_map.draw(@x, @y)
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
        @scenes[-1].button_down(id, self)
      end
    end

    # Button press handler
    def button_up(id)
      if(!@scenes.empty?)
        @scenes[-1].button_up(id, self)
      end
    end

    def update
      if(!@scenes.empty?)
        @scenes[-1].update(self)
      end

      #TODO: Move to scene & camera rendering
      @x -= DEFAULT_MAP_SCROLLING_SPEED if button_down?(Gosu::KbLeft) && @x > 0
      @x += DEFAULT_MAP_SCROLLING_SPEED if button_down?(Gosu::KbRight) && @x < current_map.width - DEFAULT_WINDOW_WIDTH
      @y -= DEFAULT_MAP_SCROLLING_SPEED if button_down?(Gosu::KbUp) && @y > 0
      @y += DEFAULT_MAP_SCROLLING_SPEED if button_down?(Gosu::KbDown) && @y < current_map.height - DEFAULT_WINDOW_HEIGHT
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

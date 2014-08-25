require_relative 'version'
require_relative '../../lib/imperium/ui/scenes/scene'
require 'rubygems'
require 'gosu'

module Imperium
  class ImperiumMain < Gosu::Window
    DEFAULT_WINDOW_WIDTH = 640
    DEFAULT_WINDOW_HEIGHT = 480

    def initialize
      super DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, fullscreen=false
      self.caption = "Imperium v.#{Imperium::VERSION}"

      @scenes = []
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    end

    public
    def font
      @font
    end

    def draw
      if(!@scenes.empty?)
        @scenes[-1].render_scene(self)
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

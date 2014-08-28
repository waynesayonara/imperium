require_relative '../../../../../lib/imperium'
require_relative '../../../../imperium/ui/data_models/game/game_scene_data_model'

module Imperium
  class GameScene
    include Imperium::Scene

    DEFAULT_MAP_SCROLLING_SPEED = 3

    def initialize(data_model)
      self.data_model_type = Imperium::DataModels::GameSceneDataModel
      self.data_model = Imperium::DataModels::GameSceneDataModel.new(data_model)
      @x = @y = 0
    end

    def current_map
      data_model.game_data.get_current_map
    end

    def get_char
      data_model.game_data.character
    end

    def render_scene
      data_model.game_data.render_map
      data_model.game_data.render_char
    end

    def update
      $window.caption = "Imperium v.#{Imperium::VERSION}. FPS: #{Gosu.fps}."

      x = y = 0
      x -= DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbLeft) && get_char.x > 0
      x += DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbRight) #&& @x < current_map.width
      y -= DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbUp) && get_char.y > 0
      y += DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbDown) #&& @y < current_map.height
      @data_model.game_data.character.move(x, y)
    end

    def button_down(id)
    end

    def button_up(id)
    end
  end

end

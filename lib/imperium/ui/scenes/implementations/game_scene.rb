require_relative '../../../../../lib/imperium'
require_relative '../../../../../lib/engine/ui/data_models/game/game_scene_data_model'

module Imperium
  class GameScene
    include Engine::Scene

    DEFAULT_MAP_SCROLLING_SPEED = 3

    def initialize(data_model)
      self.data_model_type = Engine::DataModels::GameSceneDataModel
      self.data_model = Engine::DataModels::GameSceneDataModel.new(data_model)
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

    def on_update(point)
      $window.caption = "Imperium v.#{Engine::VERSION}. FPS: #{Gosu.fps}."

      x = y = 0
      x -= DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbLeft) && get_char.x > 0
      x += DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbRight) #&& @x < current_map.width
      y -= DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbUp) && get_char.y > 0
      y += DEFAULT_MAP_SCROLLING_SPEED if $window.button_down?(Gosu::KbDown) #&& @y < current_map.height
      @data_model.game_data.character.move(x, y)
    end

    # Custom handler for button_up on the WHOLE scene
    # Can be overridden in derived classes
    def on_button_up(button_id, point)
      if(button_id == Gosu::KbEscape)
        $window.pop_scene
      end
    end
  end

end

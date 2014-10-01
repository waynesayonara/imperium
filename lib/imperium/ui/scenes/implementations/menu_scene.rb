require_relative '../../../../../lib/imperium'

module Imperium
  class MenuScene
    include Imperium::Scene

    @splash

    def initialize(data_model)
      #self.data_model_type = Imperium::DataModels::MenuSceneDataModel
      #self.data_model = data_model

      @splash = Gosu::Image.new($window, '../resources/menu/Imperium_splash_1024_800.png', false)
    end

    # this method will be called from main window
    # it describes how concrete scene impl
    # should be rendered on a screen
    def render_scene
      text = Gosu::Image.from_text($window, 'Press space to continue', 'Arial', 78)

      @splash.draw(0, 0, 0)
      text.draw(250, 500, 0)
    end

    def on_button_up(button_id, point)
      if(button_id == Gosu::KbSpace)
        $window.pop_scene
      end
    end
  end
end
